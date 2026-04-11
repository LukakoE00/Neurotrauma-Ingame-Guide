-- Allow changes to the wrappedText variable 
LuaUserData.MakeFieldAccessible(Descriptors['Barotrauma.GUITextBlock'], 'wrappedText')

NTGuide.Menu = NTGuide.Menu or {}
NTGuide.Menu.PageHistory = NTGuide.Menu.PageHistory or {}

NTGuide.CurrentPageID = {}
NTGuide.SearchablePages = {}
NTGuide.PagesByID = {}

-- Function to update the search results when the search bar gets used
NTGuide.Menu.lastFilteredResults = NTGuide.Menu.lastFilteredResults or {}

local function UpdateSearchResults()
    NTGuide.Menu.previousSearchText = NTGuide.Menu.previousSearchText or ""

    -- Determine what the actual search is
    local searchText = NTGuide.Menu.searchBox.Text:lower()

   -- If the search bar is empty, go back to the last page in history
     if searchText == "" then
        NTGuide.Menu.previousSearchText = ""
        NTGuide.SwitchToLastPage()
        return
    end
    -- If no change, do nothing
    if searchText == NTGuide.Menu.previousSearchText then return end
    -- If change, adjust accordingly
    NTGuide.Menu.previousSearchText = searchText

    local modtags, searchtext = NTGuide.ParseSearch(searchText)

    -- Add what we're looking for to table to use later
    local filteredResults = {}
    for _, page in ipairs(NTGuide.IndexedContentPages) do
        local name = page.name:lower()
        local mod = page.mod:gsub("^NT:%s*", ""):lower()
        local matches = true

        for _, modtags in ipairs(modtags) do
            if not mod:find(modtags) then
                matches = false
                break
            end
        end

        if matches then
            for _, keyword in ipairs(searchtext) do
                if not name:find(keyword) then
                    matches = false
                    break
                end
            end
        end

        if matches then
            table.insert(filteredResults, page)
        end
    end

    -- Only rebuild if filteredResults actually changed
    local simpleFiltered = {}
    for i = 1, #filteredResults do
        simpleFiltered[i] = {id = filteredResults[i].id}
    end

    if NTGuide.AreResultsEqual(simpleFiltered, NTGuide.Menu.lastFilteredResults) then
        return
    else
        NTGuide.Menu.lastFilteredResults = simpleFiltered
    end

    -- Clear everything before re-doing it
    NTGmenuList.Content:ClearChildren()

    -- Throw an 'error' if the results yield nothing
    if #filteredResults == 0 then
        local textblock_NoSearchResults = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), NTGmenuList.Content.RectTransform), NTGuide.Localize("ntg.pagefounderror"))
        return
    end
    
    -- Sort results alphabetically; first the category, then the names
    table.sort(filteredResults, function(a, b)
        if a.category ~= b.category then return a.category < b.category end
        return a.name:lower() < b.name:lower()
    end)

    local currentCategory = ""

    -- Subdivide search output into categories to reduce vomit of text when searching
    local i = 1
    while i <= #filteredResults do
        local page = filteredResults[i]

        -- Display a category header for easier readability
        if page.category ~= currentCategory then
            currentCategory = page.category

            local textblock_PageCategory = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.07), NTGmenuList.Content.RectTransform),"---  " .. NTGuide.Localize("ntg.category." .. currentCategory) .. "  ---", nil, GUI.GUIStyle.SubHeadingFont)
            textblock_PageCategory.TextAlignment = GUI.Alignment.Center
            textblock_PageCategory.CanBeFocused = false
            textblock_PageCategory.TextColor = Color(110, 154, 125, 255)
        end

        -- Create a row for up to 2 items within the same category
        local row = GUI.LayoutGroup(GUI.RectTransform(Vector2(1, 0.05), NTGmenuList.Content.RectTransform),true,GUI.Anchor.TopLeft)
        row.Stretch = true

        -- Take that row and add our buttons
        -- If we have only 1 button left to add, just leave it on its own
        for j = 0, 1 do
            local currentIndex = i + j
            local currentPage = filteredResults[currentIndex]

            -- Once we're done with our items, get the hell out of this loop and go over the items in the next category
            if not currentPage or currentPage.category ~= currentCategory then
                break
            end

            -- Actual button building + making them look nice!
            local SpecificPageInfo = NTGuide.GetPageByID(currentPage.id)
            local SearchResultToDisplay = currentPage.name
            local AmendedTextColour = "210,200,154,255"

            -- Get the basic string, tack onto this if settings require it so
            SearchResultToDisplay = "‖color:" .. AmendedTextColour .. "‖" .. SearchResultToDisplay .. "‖color:end‖"

            -- Show mod-of-origin if enabled
            local showMod = NTGuide.GetSetting("NTG_DoModOrigin")
            local useColours = NTGuide.GetSetting("NTG_DoColouredModOrigin")

            if showMod and SpecificPageInfo and SpecificPageInfo.mod and SpecificPageInfo.mod ~= "" then
                local modName = SpecificPageInfo.mod
                local modColour = NTGuide.DefaultModColour

                -- If colored mods are enabled, get the user's custom color setting
                if useColours then
                    -- Remove what we don't need so we get our setting to use
                    local modColourSetting = "NTG_ModColour_" .. modName:gsub("[^%w]", "")
                    local modColourTable = NTGuide.GetSetting(modColourSetting)
                    -- Pull R,G,B from the table
                    if modColourTable and #modColourTable > 0 then
                        modColour = table.concat(modColourTable, ",")
                    end
                end

                -- Add that colour to display
                SearchResultToDisplay = SearchResultToDisplay .. " ‖color:" .. modColour .. "‖(" .. modName .. ")‖color:end‖"
            end

            local button_SearchResult = GUI.Button(GUI.RectTransform(Vector2(0.5, 1), row.RectTransform), SearchResultToDisplay, GUI.Alignment.CenterLeft, "GUIButtonSmall")

            button_SearchResult.Color = Color(0,0,0,0)
            button_SearchResult.HoverColor = Color(50,50,50,255)
            button_SearchResult.PressedColor = Color(0,0,0,0)

            -- Forgot buttons have built-in text blocks..
            button_SearchResult.TextBlock.Wrap = true

            button_SearchResult.OnClicked = function()
                NTGuide.CurrentPageID = {currentPage.id}
                NTGuide.Menu.searchBox.Text = ""
                NTGuide.PopulatePage(NTGmenuList, currentPage.id)
            end
        end

        -- Move index forward by however many buttons we've done and do it again!
        if i + 1 <= #filteredResults and filteredResults[i + 1].category == currentCategory then
            i = i + 2
        else
            i = i + 1
        end
    end
end

-- Modular page construction, semi-inspired by the NT Config
function NTGuide.PopulatePage(NTGmenuList, pageID)
    -- Table to enable proper wrapping of textblocks + scale button accordingly
    NTGuide.Menu.ActiveTextBlocks = {}

    -- Get the page we're supposed to build + prevent faulty ID from causing issues
    local page = NTGuide.GetPageByID(pageID)
    if not page then return end

    -- If we're trying to use the settings page, run the settings building script instead of trying to constructing the page normally
    if page.settings then
        NTGmenuList.Content:ClearChildren()
        NTGuide.Menu.titleBlock.SetRichText(page.title)

        NTGuide.BuildSettingsPage(NTGmenuList)
        return
    end

    -- Same as before, but for the pill calculator instead. Doing this automatically would just be a headache
    if page.pillcalculator then
        NTGmenuList.Content:ClearChildren()
        NTGuide.Menu.titleBlock.SetRichText(page.title)

        NTGuide.BuildCalculatorPage(NTGmenuList)
        return
    end

    -- KILL!! the currently created page
    NTGmenuList.Content:ClearChildren()
    NTGuide.Menu.ActiveTextBlocks = {} -- Empty the text blocks (we will give new ones)

    -- Change the title to the new page
    NTGuide.Menu.titleBlock.SetRichText(page.title)

    -- Change the description likewise
    local textblock_PageDescription = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0), NTGmenuList.Content.RectTransform),"", nil, nil, GUI.Alignment.Left, true)
    -- Prevent hovering / clicking on text from showing that bleak background color change
    local TextToDisplayDescription = "\n" .. page.description
    textblock_PageDescription.SetRichText(TextToDisplayDescription)
    textblock_PageDescription.CanBeFocused = false
    textblock_PageDescription.Wrap = true
    textblock_PageDescription.CalculateHeightFromText()

    -- Build the sections (that are not already made / not supposed to be shown) dynamically
    for section, value in pairs(page) do
        if type(value) == "table" and section ~= "id" and section ~= "title" and section ~= "description" and section ~= "category" then

            -- Auto-generates subheaders based on localization data
            local textblock_PageSubheader = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), NTGmenuList.Content.RectTransform), "———  " .. NTGuide.Localize("ntg.section." .. section) .. ":  ———", nil, GUI.GUIStyle.SubHeadingFont)
            -- Make it look nice
            textblock_PageSubheader.TextAlignment = GUI.Alignment.Center
            textblock_PageSubheader.CanBeFocused = false
            textblock_PageSubheader.TextColor = Color(110,154,125,255)

            -- OK hear me out
            -- First, take the localized string from the XML file then use [brackets] to determine *where* we must link to, be sure to clean up the string so we don't fumble because of an extra space or whatever
            -- In case we want multiple buttons linking to multiple pages, seperate them with a ' | ' vertical bar
            -- Take whatever is after the [ID] and use that as the text to be overlayed on top of the button, i.e. 'Internal Bleeding (50% or more)
            -- In case we have text that does not have an ID, render it regardless just without the button; pages like Cardiac Arrest refer to 'CPR' which leads nowhere, for example
            for _, localizedString in ipairs(value) do
                for part in tostring(localizedString):gmatch("([^|]+)") do
                    local trimmedString = part:match("^%s*(.-)%s*$")
                    
                    if trimmedString and trimmedString ~= "" then
                        local id, LinkButtonDescription = trimmedString:match("^%[(.-)%]%s*(.-)%s*$")
                        
                        if id and LinkButtonDescription then
                            if NTGuide.GetPageByID(id) then
                                -- Whatever. Go my buttons.
                                -- Create a textblock that can wrap and hold text (since button text doesn't wrap easily)
                                local textblock_LinkButtonHolder = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0), NTGmenuList.Content.RectTransform), "", nil, nil, GUI.Alignment.TopLeft)
                                -- Fetch the description we should 'overlay' on the button that sends us to another page
                                local TextToDisplayButton = "• " .. LinkButtonDescription
                                textblock_LinkButtonHolder.SetRichText(TextToDisplayButton)
                                textblock_LinkButtonHolder.Wrap = true
                                -- Remove the background colour when hovering over a textblock. We cannot have CanBeFocused set to false (or HoverTextColor would break) so we just make it transparent
                                textblock_LinkButtonHolder.HoverColor = Color(0,0,0,0)
                                -- Make the text have a unique colour + change when hovered, to make sure people see it can be clicked on
                                textblock_LinkButtonHolder.TextColor = Color(226,208,116,255)
                                textblock_LinkButtonHolder.HoverTextColor = Color(119,212,190,255)
                                -- Put the textblocks into a table to force-update their height (or text will bleed across one another)
                                table.insert(NTGuide.Menu.ActiveTextBlocks, textblock_LinkButtonHolder)

                                -- Create the actual button that links pages together. Vector(1,1) so it's the same size as the textblock (though this needs to be force updated)
                                -- todo: actually force update it :333
                                local button_LinkToPage = GUI.Button(GUI.RectTransform(Vector2(1, 1), textblock_LinkButtonHolder.RectTransform), "", GUI.Alignment.Center, "GUIButtonSmall")
                                -- Set all colours to transparent so it looks like you're clicking the text
                                button_LinkToPage.Color = Color(0,0,0,0)
                                button_LinkToPage.HoverColor = Color(0,0,0,0)
                                button_LinkToPage.PressedColor = Color(0,0,0,0)

                                -- If the button is clicked, change the 'page' we are at and just refresh the page + push it to history
                                button_LinkToPage.OnClicked = function()
                                        if NTGuide.CurrentPageID[1] ~= NTGuide.Menu.PageHistory[#NTGuide.Menu.PageHistory] then
                                            table.insert(NTGuide.Menu.PageHistory, NTGuide.CurrentPageID[1])
                                        end

                                        if #NTGuide.Menu.PageHistory > 20 then table.remove(NTGuide.Menu.PageHistory, 1) end

                                        NTGuide.CurrentPageID = {id}
                                        -- Rebuild the page once we know the target
                                        NTGuide.PopulatePage(NTGmenuList, id)
                                end
                            end
                        else
                            -- If the XML Localization doesn't find an ID to link to, the text that we want to display is not part of a button
                            local textblock_PlainText = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0), NTGmenuList.Content.RectTransform),"")
                            textblock_PlainText.SetRichText("• " .. trimmedString)
                            textblock_PlainText.Wrap = true
                            -- Prevents the clicking on textboxes that change the background. Ugly.
                            textblock_PlainText.CanBeFocused = false
                            table.insert(NTGuide.Menu.ActiveTextBlocks, textblock_PlainText)
                        end

                        -- Once we have all the textblocks with buttons that we want to show ready, force them to update their height to prevent text bleed
                        for _, textblock in ipairs(NTGuide.Menu.ActiveTextBlocks) do
                                textblock.CalculateHeightFromText()
                        end
                    end
                end
            end
        end
    end
end

-- The actual GUI window / menu; the idea is identical to the Neurotrauma Config look
NTGuide.Menu.BasicList = function()
    -- Screen-wide frame [L0 / Invisible]
    NTGuide.Menu.frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
    NTGuide.Menu.frame.CanBeFocused = false

    -- Menu-background put into the frame [L1 / Invisible]
    NTGuide.Menu.menu = GUI.Frame(GUI.RectTransform(Vector2(1 + 0.2 / GUI.xScale, 1 + 0.3), NTGuide.Menu.frame.RectTransform, GUI.Anchor.Center), nil)
    NTGuide.Menu.menu.Visible = false
    NTGuide.Menu.menu.CanBeFocused = false

    -- Menu-background (Green) [L1 / Visible]
    local menuContent = GUI.Frame(GUI.RectTransform(Vector2(0.35, 0.6), NTGuide.Menu.menu.RectTransform, GUI.Anchor.Center))
    local dragHandle = GUI.DragHandle(GUI.RectTransform(Vector2(1,1), menuContent.RectTransform, GUI.Anchor.Center), menuContent.RectTransform, nil)

    -- Main Layout [L2 / Invisible]
    local mainGuideLayout = GUI.LayoutGroup(GUI.RectTransform(Vector2(0.95, 0.95), menuContent.RectTransform, GUI.Anchor.Center, GUI.Pivot.Center), false)

    -- Cosmetic background [L2 / Visible]
    local guideBackground = GUI.Frame(GUI.RectTransform(Vector2(1, 0.99), mainGuideLayout.RectTransform, GUI.Anchor.Center), "InnerFrame")

    -- Layout to handle text stuff [L3 / Invisible]
    local innerGuideLayout = GUI.LayoutGroup(GUI.RectTransform(Vector2(0.95, 0.95), guideBackground.RectTransform, GUI.Anchor.TopCenter), false)

    -- Title at the top of the page
    NTGuide.Menu.titleBlock = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.07), innerGuideLayout.RectTransform), " ", nil, GUI.GUIStyle.LargeFont)
    NTGuide.Menu.titleBlock.TextAlignment = GUI.Alignment.Center

    -- Search box, below title
    NTGuide.Menu.searchBox = GUI.TextBox(GUI.RectTransform(Vector2(1, 0.04), innerGuideLayout.RectTransform, GUI.Anchor.TopCenter), "")

    -- menuList, handling all the sections of the page; headers, description, buttons etc.
    NTGmenuList = GUI.ListBox(GUI.RectTransform(Vector2(1, 0.88), innerGuideLayout.RectTransform, GUI.Anchor.TopCenter))
    NTGmenuList.RectTransform.AbsoluteOffset = Point(0, 10)

    local buttonRow = GUI.LayoutGroup(GUI.RectTransform(Vector2(1, 0.1), innerGuideLayout.RectTransform), true)
    buttonRow.RelativeSpacing = 0.4

    -- Main Page Button
    local mainpageButton = GUI.Button(GUI.RectTransform(Vector2(0.3, 0.05), buttonRow.RectTransform), NTGuide.Localize("ntg.button.mainpage"))
    mainpageButton.OnClicked = function()
        NTGuide.CurrentPageID = {"main_page"}
        NTGuide.PopulatePage(NTGmenuList, "main_page")
    end

    -- Back button at the bottom of the page
    local backButton = GUI.Button(GUI.RectTransform(Vector2(0.3, 0.05), buttonRow.RectTransform), NTGuide.Localize("ntg.button.back"))
    backButton.OnClicked = function()
        -- Is there somewhere to go back to?
        -- If so, remove that page from history and return to it
        if #NTGuide.Menu.PageHistory > 0 then
            local lastPageID = table.remove(NTGuide.Menu.PageHistory)
            NTGuide.CurrentPageID = {lastPageID}
            NTGuide.PopulatePage(NTGmenuList, lastPageID)
        else
            -- Otherwise, just default to the main page
            NTGuide.CurrentPageID = {"main_page"}
            NTGuide.PopulatePage(NTGmenuList, "main_page")
        end
    end

    -- "Open settings" button. Cogwheel UI style akin to the basegame
    local ToggleSettingsButton = GUI.Button(GUI.RectTransform(Vector2(0.05, 0.5), NTGuide.Menu.titleBlock.RectTransform, GUI.Anchor.CenterLeft), GUI.Alignment.Center, nil, Color(0,0,0,0))
    local ToggleSettingsButtonStyle = GUI.Image(GUI.RectTransform(Vector2(1, 1), ToggleSettingsButton.RectTransform), "GUIButtonSettings")
    ToggleSettingsButtonStyle.ToolTip = NTGuide.Localize("ntg.button.tooltip.togglesettings")
    local SettingsPageActive = false

    -- Open the settings menu if its closed, close it if it's open.
    -- Also ensure that you get sent back to the page your were just on when toggling it
    ToggleSettingsButton.OnClicked = function()
        local currentPage = NTGuide.CurrentPageID[1]

        if currentPage == "settings_page" then
            -- If already on settings, go back to last page
            NTGuide.SwitchToLastPage()
        else
            -- Push current page to history only if it's not already last
            local lastInHistory = NTGuide.Menu.PageHistory[#NTGuide.Menu.PageHistory]
            if currentPage ~= lastInHistory then
                table.insert(NTGuide.Menu.PageHistory, currentPage)
            end

            -- Now, open settings!
            NTGuide.CurrentPageID = {"settings_page"}
            NTGuide.PopulatePage(NTGmenuList, "settings_page")
        end
    end

    -- "Close Guide" button. Just a cross like you would see on most programs
    local CloseGuideButton = GUI.Button(GUI.RectTransform(Vector2(0.05, 0.5), NTGuide.Menu.titleBlock.RectTransform, GUI.Anchor.CenterRight), GUI.Alignment.Center, nil, Color(0,0,0,0))
    local CloseGuideButtonStyle = GUI.Image(GUI.RectTransform(Vector2(1, 1), CloseGuideButton.RectTransform), "GUICancelButton")
    CloseGuideButtonStyle.Color = Color(180,50,50,255)
    CloseGuideButtonStyle.ToolTip = NTGuide.Localize("ntg.button.tooltip.closeguide")

    CloseGuideButton.OnClicked = function()
        NTGuide.Menu.menu.Visible = false
    end

    -- If the searchbar changes, re-do all the search bar code
    NTGuide.Menu.searchBox.OnTextChangedDelegate = function()
        -- Ensure the settings page properly 'toggles'
        if SettingsPageActive then
            SettingsPageActive = false
        end

        UpdateSearchResults()
    end

    -- On first initialization, open the main page
    NTGuide.PopulatePage(NTGmenuList, "main_page")
    return NTGmenuList
end

-- Make it actually appear on initialization
-- This HAS to be able to be done better :wilted_flower:
local Indexed = "false"

function NTGuide.ConstructUI()
    if Indexed == "false" then
        NTGuide.IndexedContentPages = NTGuide.IndexKnownPages(NTGuide.ContentPages)

        -- Build index pages
        NTGuide.BuildCategoryIndexPage()
        NTGuide.BuildPagesByCategory()

        Indexed = "true"
    end
    NTGuide.Menu.BasicList()
end

NTGuide.ConstructUI()

-- Hooks to allow updates
Hook.Patch("Barotrauma.SubEditorScreen", "AddToGUIUpdateList", function()
    NTGuide.Menu.frame.AddToGUIUpdateList()
end)

Hook.Patch("Barotrauma.GameScreen", "AddToGUIUpdateList", function()
    NTGuide.Menu.frame.AddToGUIUpdateList()
end)

Hook.Patch("Barotrauma.GUI", "TogglePauseMenu", {}, function(instance, ptable)
    if not GUI.PauseMenuOpen and NTGuide.Menu.menu.Visible then
        NTGuide.Menu.menu.Visible = false
        ptable.PreventExecution = true
    end
end, Hook.HookMethodType.Before)
