-- Function to find all content pages within a large table and can handle sub-tables.
-- This way, we can have 'category' tables for easier sorting

-- Set the colour for mod names
NTGuide.DefaultModColour = "110, 154, 125, 255"
-- Give them a unique colour based on their workshop picture
-- Sure love Infections, Pharmacy and Airways having the same green!
NTGuide.ModColours = {
["NT: Airway Extension"] = "20, 60, 0, 255",
["NT: Cybernetics Enhanced"] = "84, 84, 97, 255",
["NT: Eyes"] = "215, 160, 0, 255",
["NT: Grafting"] = "165, 22, 166, 255",
["NT: Infections"] = "76, 112, 42, 255",
["NT: Lobotomy"] = "0, 175, 175, 255",
["NT: Surgery Plus"] = "97, 24, 33, 255",
["NT: Thermal"] = "3, 99, 138, 255",
}

function NTGuide.ScanForPage(page)
    -- All pages SHOULD be part of the NTGuide.ContentPages table. If something else somehow ends up here, skip it
    if type(page) ~= "table" then return end

    -- All content pages must have an ID; therefor, if we find an ID then this must be a content page we want to index
    if page.id then
        NTGuide.PagesByID[page.id] = page

        -- We don't want the main page in the search bar, and we only really care about the title (this will be shown to players), ID (to navigate), category (to sort pages with same types) and mod for sorting;
        if (page.id ~= "main_page" and page.id ~= "settings_page") and page.title then
            table.insert(NTGuide.SearchablePages, {name = page.title, id = page.id, category = page.category or "", mod = page.mod or ""})
        end
    end

    -- For each table in the larger ContentPagesTable, run the scan functionality above
    for _, v in pairs(page) do
        if type(v) == "table" then NTGuide.ScanForPage(v) end
    end
end

-- Sort these tables so we don't have to go over a gorbillion pages every time we try and search something
function NTGuide.IndexKnownPages(ContentPageTable)
    -- Get ALL pages within the NTGuide.ContentPages table and index them for fast access
    NTGuide.ScanForPage(ContentPageTable)

    -- Sort them alphabetically so order of input into the table doesn't matter + it looks better
    table.sort(NTGuide.SearchablePages, function(a, b) 
        return a.name:lower() < b.name:lower() 
    end)

    -- Give this indexed table back for use later
    return NTGuide.SearchablePages
end

-- Function to find a page if we know the ID
function NTGuide.GetPageByID(id)
    return NTGuide.PagesByID[id]
end

-- Shamelessly ripping of JEI here
-- Go over a search result, and if we use @ anywhere consider that the mod to filter for
function NTGuide.ParseSearch(text)
    local modtags = {}
    local searchtext = {}

    for word in text:gmatch("%S+") do
        if word:sub(1,1) == "@" then
            table.insert(modtags, word:sub(2):lower())
        else
            table.insert(searchtext, word:lower())
        end
    end

    return modtags, searchtext
end

-- Just a basic comparison function
function NTGuide.AreResultsEqual(resultsA, resultsB)
    if #resultsA ~= #resultsB then return false end
    for i = 1, #resultsA do
        if resultsA[i].id ~= resultsB[i].id then
            return false
        end
    end
    return true
end

-- Everything is indexed. Previously, we could only search for pages; as ThousandFields mentioned, this makes 'browsing' if you have nothing to do a lot harder.
-- Instead, we want to add an 'index' page that firstly automatically gets all known 'categories' of pages, then lists all pages under that category depending on which one is selected.
-- You could do this using the existing XML formatting, but that is messy and requires human effort. Instead, we make an amended 'page population' script to handle just the index pages.
function NTGuide.BuildCategoryIndexPage()
    local categories = {}

    -- Get all unique categories that we've already indexed
    for _, page in ipairs(NTGuide.SearchablePages) do
        if page.category ~= "" then
            categories[page.category] = true
        end
    end

    -- Convert them to a sorted list so order of acquisition doesnt matter
    local sortedCategories = {}
    for category, _ in pairs(categories) do
        table.insert(sortedCategories, category)
    end
    table.sort(sortedCategories)

    -- Create the category index page
    NTGuide.PagesByID["category_index"] = {
        id = "category_index",
        category = "index",
        title = NTGuide.Localize("ntg.title.category_index"),
        description = NTGuide.Localize("ntg.description.category_index"),
        navigation = {},
        categories = {}
    }

    -- Back to main menu button
    table.insert(
        NTGuide.PagesByID["category_index"].navigation,
        "[main_page] " .. NTGuide.Localize("ntg.index.backmain")
    )

    -- Add categories as clickable links
    for _, category in ipairs(sortedCategories) do
        local count = 0

        -- Count pages in this category and render them alongside the category in the clickable text
        for _, p in ipairs(NTGuide.SearchablePages) do
            if p.category == category then count = count + 1 end
        end

        table.insert(
            NTGuide.PagesByID["category_index"].categories, -- This is the subheader
            "[" .. "category_" .. category .. "] " ..
            NTGuide.Localize("ntg.category." .. category) .. -- This is the content of said subheader
            " (" .. tostring(count) .. ")"
        )
    end
end

-- Next up, we automatically make the pages that the category script above may redirect to; containing all pages assigned to that cateogory
-- For both of these functions, we don't need to worry that they'll show in the search results since all the indexing for that was already finished
function NTGuide.BuildPagesByCategory()
    local categorized = {}

    -- Group pages by their category
    for _, page in ipairs(NTGuide.SearchablePages) do
        if page.category ~= "" then
            categorized[page.category] = categorized[page.category] or {}
            table.insert(categorized[page.category], page)
        end
    end

    -- Now we have each page sorted into categories, sort them alphabetically and add them to their respective category page
    for category, pages in pairs(categorized) do
        table.sort(pages, function(a, b)
            return a.name:lower() < b.name:lower()
        end)

        -- Get the category we wanna yoink
        local pageID = "category_" .. category
        -- Auto create page data
        NTGuide.PagesByID[pageID] = {
            id = pageID,
            category = "index",
            title = NTGuide.Localize("ntg.category." .. category),
            description = NTGuide.Localize("ntg.description.category_page"),
            navigation = {}, -- Will hold the back inline button
            pages = {}, -- Will hold the links
        }

        -- Back button at the top to return to the categories screen, noi matter the category
        table.insert(NTGuide.PagesByID[pageID].navigation, "[category_index] " .. NTGuide.Localize("ntg.index.back"))

        -- Add all pages in the currently iterated category
        for _, page in ipairs(pages) do
            local SpecificPageInfo = NTGuide.GetPageByID(page.id)
            local PageNameToDisplay = page.name

            if SpecificPageInfo and SpecificPageInfo.mod and SpecificPageInfo.mod ~= "" then
                local modName = SpecificPageInfo.mod
                local modColour = NTGuide.DefaultModColour
                local useColours = NTGuide.GetSetting("NTG_DoColouredModOrigin")

                if useColours then
                    local modColourSetting = "NTG_ModColour_" .. modName:gsub("[^%w]", "")
                    local modColourTable = NTGuide.GetSetting(modColourSetting)
                    if modColourTable and #modColourTable > 0 then
                        modColour = table.concat(modColourTable, ",")
                    end
                else
                    modColour = NTGuide.ModColours[modName] or NTGuide.DefaultModColour
                end

                PageNameToDisplay = PageNameToDisplay .. " ‖color:" .. modColour .. "‖(" .. modName .. ")‖color:end‖"
            end

            table.insert(
                NTGuide.PagesByID[pageID].pages,
                "[" .. page.id .. "] " .. PageNameToDisplay
            )
        end
    end
end

-- Make the guide button appear in the top right
-- Currently activated via main.lua
-- Shamelessly ripped from EvilFactory's examples
function NTGuide.CreateGuideButton()
    NTGuide.Button = GUI.Button(GUI.RectTransform(Vector2(0.05, 0.05), NTGuide.Menu.frame.RectTransform, GUI.Anchor.TopRight), "Guide", GUI.Alignment.Center, "GUIButtonSmall")
    NTGuide.Button.OnClicked = function()
        NTGuide.Menu.menu.Visible = not NTGuide.Menu.menu.Visible
    end
end

function NTGuide.RemoveGuideButton()
    if NTGuide.Button then
        NTGuide.Button.Visible = false
    end
end

-- Get the value of one of the clientside settings in-guide
function NTGuide.GetSetting(key)
    local entry = NTGuideSettings.ConfigData[key]
    if not entry then return nil end

    if entry.value ~= nil then
        return entry.value
    else
        return entry.default
    end
end

-- Set the value of one of the clientside settings bla bla
function NTGuide.SetSetting(key, value)
    local entry = NTGuideSettings.ConfigData[key]
    if not entry then return end

    entry.value = value
end

function NTGuide.SwitchToLastPage()
    -- Remove settings_page from history if it somehow got there
    while #NTGuide.Menu.PageHistory > 0 and NTGuide.Menu.PageHistory[#NTGuide.Menu.PageHistory] == "settings_page" do
        table.remove(NTGuide.Menu.PageHistory, #NTGuide.Menu.PageHistory)
    end

    -- Only push current page if it’s not already the last in history and not settings_page
    local lastInHistory = NTGuide.Menu.PageHistory[#NTGuide.Menu.PageHistory]
    if NTGuide.CurrentPageID[1] ~= lastInHistory and NTGuide.CurrentPageID[1] ~= "settings_page" then
        table.insert(NTGuide.Menu.PageHistory, NTGuide.CurrentPageID[1])
    end

    -- Pop the last page from history if available
    local nextPageID
    if #NTGuide.Menu.PageHistory > 0 then
        nextPageID = table.remove(NTGuide.Menu.PageHistory, #NTGuide.Menu.PageHistory)
    else
        nextPageID = "main_page"
    end

    NTGuide.CurrentPageID = {nextPageID}
    NTGuide.PopulatePage(NTGmenuList, nextPageID)
end

-- This is retarded
-- There's a small delay between the automatic loading of our language file and the first localization grab
-- This means that it will just grab the non-localized information first and then the game loads english
-- Since we just return the original xml tag that builds that part of the page (which always starts with ntg) we just have it re-initialize all the ntg tags once more
-- If it happens twice tough shit thats probably a typo
NTGuide.Localize = function(xmlTag)
    local value = xmlTag
    -- Do another loop and fix up all ntg strings
    while string.match(value, "^ntg") do
        local newValue = TextManager.Get(value).Value
        -- If its the same after looping this is a fuckup, break the loop so it doesn't go insane
        if newValue == value then
            break
        end
        value = newValue
    end
    return value
end