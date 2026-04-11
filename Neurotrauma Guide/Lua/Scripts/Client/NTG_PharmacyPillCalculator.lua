-- Can this all be done better? Definitely.

local DisplayableIngredientsPopulated = false

local PillEffects

local IngredientCategories = {
    base = {},
    binder = {},
    filler = {},
    active = {},
    dye = {}
}

local selected = {
    base = nil,
    binder = nil,
    filler1 = nil,
    filler2 = nil,
    active1 = nil,
    active2 = nil,
    active3 = nil,
    dye1 = nil,
    dye2 = nil,
    dye3 = nil
}

local SideEffects = {
    psychosis = true,
    organdamage = true,
    cerebralhypoxia = true,
    chemaddiction = true,
    sepsis = true,
    burn = true,
    nausea = true,
    heartdamage = true,
    lungdamage = true,
    kidneydamage = true,
    liverdamage = true,
    coma = true,
}

local Variants = {
    antibloodloss1 = true,
    bloodpackominus = true,
    bloodpackoplus = true,
    bloodpackaminus = true,
    bloodpackaplus = true,
    bloodpackbminus = true,
    bloodpackbplus = true,
    bloodpackabminus = true,
    bloodpackabplus = true,
    bloodpackabcplus = true,
}

-- Function to fill the drop down menus with items from a table
local function PopulateDropdown(dropdown, list)
    dropdown.AddItem(NTGuide.Localize("ntg.pharmacy.nonetext"), nil)

    for _, item in ipairs(list) do
        dropdown.AddItem(item.name, item.id)
    end
end

-- Function to run pill math based on selected components
local function Recalculate()
    local components = {}

    local activeCount = 0

    -- Take selected components from dropdowns and save them to pass them along
    for _, id in pairs(selected) do
        if id then
            table.insert(components, id)
        end
    end

    -- Count the amount of active components
    for _, id in ipairs(components) do
        local item = NTP.PillData.items[id]
        if item and item.types and item.types[1] == "active" then
            activeCount = activeCount + 1
        end
    end
    
    -- Spoof the medical skill
    local skillText = NTGuide.textbox_SkillLevel.Text or ""
    local skill = tonumber(skillText) or 30

    -- Run the math based on current data
    local result = NTP.PillConfigFromItems(components, skill)

    local mainText = ""
    local sideText = ""
    local infoText = ""

    -- Change text for the general info
    infoText = infoText .. NTGuide.Localize("ntg.pharmacy.yieldstext") .. ": " .. tostring(HF.Round(result.yield, 2)) .. "\n"
    infoText = infoText .. NTGuide.Localize("ntg.pharmacy.capacitytext") .. ": " .. tostring(HF.Round(result.capacity, 2)) .. "\n"

    -- Warning if the amount of active ingredients exceed capacity
    if activeCount > result.capacity then
        infoText = infoText .. "\n‖color:red‖" .. NTGuide.Localize("ntg.pharmacy.capacitywarning") .. "‖end‖\n"
        infoText = infoText .. NTGuide.Localize("ntg.pharmacy.capacitytext") .. ": " .. result.capacity .. " | " .. NTGuide.Localize("ntg.pharmacy.activestext") ..": " .. activeCount .. "\n"
    end

    -- Change text for (side)effects
    -- TODO: effects are capped by capacity
    for fx, val in pairs(result.fx) do
        local displayVal = HF.Round(val, 2)
        local prefab = AfflictionPrefab.Prefabs[fx]
        local name = (prefab and prefab.Name ~= "") and prefab.Name or fx

        local line = tostring(name) .. ": " .. tostring(displayVal) .. "\n"

        if SideEffects[fx] then
            sideText = sideText .. line
        else
            mainText = mainText .. line
        end
    end

    -- Put text in the UI
    NTGuide.MainEffectsBlock.SetRichText(mainText)
    NTGuide.MainEffectsBlock.CalculateHeightFromText()

    NTGuide.SideEffectsBlock.SetRichText(sideText)
    NTGuide.SideEffectsBlock.CalculateHeightFromText()

    NTGuide.GeneralInfoBlock.SetRichText(infoText)
    NTGuide.GeneralInfoBlock.CalculateHeightFromText()

    -- Overlay the colour unto the pill preview based on the selected dyes
    if result.color then
        local r = result.color[1] or 255
        local g = result.color[2] or 255
        local b = result.color[3] or 255

        NTGuide.PillImage.Color = Color(r, g, b, 255)
    else
        NTGuide.PillImage.Color = Color(255, 255, 255, 255)
    end
end

local DisplayableIngredients = {}

local function IndexIngredients()

    -- Get all items + their type from Pharmacy's code
    for id, item in pairs(NTP.PillData.items) do
        if not Variants[id] then
            local type = item.types and item.types[1]
            -- Sort ID to type locally

            if type and IngredientCategories[type] then
                table.insert(IngredientCategories[type], id)
            end
        end
    end

    -- Use local data to construct the dropdown menus
    for category, SubCategory in pairs(IngredientCategories) do
        DisplayableIngredients[category] = {}
        for i, id in pairs(SubCategory) do
            local prefab = ItemPrefab.GetItemPrefab(id)
            local name = (prefab and prefab.Name ~= "") and prefab.Name or id
            table.insert(DisplayableIngredients[category], {id = id, name = name})
        end
    end
end


function NTGuide.BuildCalculatorPage(MenuList)

    -- Only make the ingredients list ONCE
    if not DisplayableIngredientsPopulated then
        IndexIngredients()
        DisplayableIngredientsPopulated = true
    end

    local textblock_PageDescription = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), NTGmenuList.Content.RectTransform),"", nil, nil, GUI.Alignment.Left, true)
    local TextToDisplayDescription = NTGuide.Localize("ntg.pharmacy.description")
    textblock_PageDescription.SetRichText(TextToDisplayDescription)
    textblock_PageDescription.CanBeFocused = false
    textblock_PageDescription.Wrap = true
    textblock_PageDescription.CalculateHeightFromText()

    -- Base ingredient stuff
    local textblock_PageSubheader1 = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), NTGmenuList.Content.RectTransform), NTGuide.Localize("ntg.pharmacyheader.baseingredients"), nil, GUI.GUIStyle.SubHeadingFont)
    textblock_PageSubheader1.TextAlignment = GUI.Alignment.Center
    textblock_PageSubheader1.CanBeFocused = false
    textblock_PageSubheader1.TextColor = Color(110,154,125,255)

    local row1 = GUI.LayoutGroup(GUI.RectTransform(Vector2(1, 0.05), NTGmenuList.Content.RectTransform),true,GUI.Anchor.CenterLeft)

    -- Active Ingredients
    local textblock_PageSubheader2 = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), NTGmenuList.Content.RectTransform), NTGuide.Localize("ntg.pharmacyheader.activeingredients"), nil, GUI.GUIStyle.SubHeadingFont)
    textblock_PageSubheader2.TextAlignment = GUI.Alignment.Center
    textblock_PageSubheader2.CanBeFocused = false
    textblock_PageSubheader2.TextColor = Color(110,154,125,255)

    local row2 = GUI.LayoutGroup(GUI.RectTransform(Vector2(1, 0.05), NTGmenuList.Content.RectTransform),true,GUI.Anchor.CenterLeft)

    -- Dyes
    local textblock_PageSubheader3 = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.08), NTGmenuList.Content.RectTransform), NTGuide.Localize("ntg.pharmacyheader.dyes"), nil, GUI.GUIStyle.SubHeadingFont)
    textblock_PageSubheader3.TextAlignment = GUI.Alignment.Center
    textblock_PageSubheader3.CanBeFocused = false
    textblock_PageSubheader3.TextColor = Color(110,154,125,255)

    local row3 = GUI.LayoutGroup(GUI.RectTransform(Vector2(1, 0.05), NTGmenuList.Content.RectTransform),true,GUI.Anchor.CenterLeft)

    -- Base
    local dropdownheight = #DisplayableIngredients.base
    local dropdown_IngredientBase = GUI.DropDown(GUI.RectTransform(Vector2(0.25, 1), row1.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.base"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientBase, DisplayableIngredients.base)
    
    dropdown_IngredientBase.OnSelected = function(guiComponent, object)
        selected.base = object
        Recalculate()
    end

    -- Binder
    dropdownheight = #DisplayableIngredients.binder
    local dropdown_IngredientBinder = GUI.DropDown(GUI.RectTransform(Vector2(0.25, 1), row1.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.binder"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientBinder, DisplayableIngredients.binder)

    dropdown_IngredientBinder.OnSelected = function(guiComponent, object)
        selected.binder = object
        Recalculate()
    end

    -- Filler 1
    dropdownheight = #DisplayableIngredients.filler
    local dropdown_IngredientFiller1 = GUI.DropDown(GUI.RectTransform(Vector2(0.25, 1), row1.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.filler"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientFiller1, DisplayableIngredients.filler)

    dropdown_IngredientFiller1.OnSelected = function(guiComponent, object)
        selected.filler1 = object
        Recalculate()
    end

    -- Filler 2
    dropdownheight = #DisplayableIngredients.filler
    local dropdown_IngredientFiller2 = GUI.DropDown(GUI.RectTransform(Vector2(0.25, 1), row1.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.filler"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientFiller2, DisplayableIngredients.filler)

    dropdown_IngredientFiller2.OnSelected = function(guiComponent, object)
        selected.filler2 = object
        Recalculate()
    end

    -- Active Ingredient 1
    dropdownheight = #DisplayableIngredients.active
    local dropdown_IngredientActive1 = GUI.DropDown(GUI.RectTransform(Vector2(0.30, 1), row2.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.active"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientActive1, DisplayableIngredients.active)

    dropdown_IngredientActive1.OnSelected = function(guiComponent, object)
        selected.active1 = object
        Recalculate()
    end

    -- Active Ingredient 2
    dropdownheight = #DisplayableIngredients.active
    local dropdown_IngredientActive2 = GUI.DropDown(GUI.RectTransform(Vector2(0.30, 1), row2.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.active"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientActive2, DisplayableIngredients.active)

    dropdown_IngredientActive2.OnSelected = function(guiComponent, object)
        selected.active2 = object
        Recalculate()
    end

    -- Active Ingredient 3
    dropdownheight = #DisplayableIngredients.active
    local dropdown_IngredientActive3 = GUI.DropDown(GUI.RectTransform(Vector2(0.30, 1), row2.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.active"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientActive3, DisplayableIngredients.active)

    dropdown_IngredientActive3.OnSelected = function(guiComponent, object)
        selected.active3 = object
        Recalculate()
    end

    NTGuide.textbox_SkillLevel = GUI.TextBox(GUI.RectTransform(Vector2(0.1, 0.5), row2.RectTransform), "30")
    NTGuide.textbox_SkillLevel.ToolTip = NTGuide.Localize("ntg.pharmacytooltip.medicalskill")

    NTGuide.textbox_SkillLevel.OnTextChangedDelegate = function()
        Recalculate()
    end


    -- Dye 1
    dropdownheight = #DisplayableIngredients.dye
    local dropdown_IngredientDye1 = GUI.DropDown(GUI.RectTransform(Vector2(0.33, 1), row3.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.dye"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientDye1, DisplayableIngredients.dye)

    dropdown_IngredientDye1.OnSelected = function(guiComponent, dye)
        selected.dye1 = dye
        Recalculate()
    end

    -- Dye 2
    local dropdown_IngredientDye2 = GUI.DropDown(GUI.RectTransform(Vector2(0.33, 1), row3.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.dye"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientDye2, DisplayableIngredients.dye)

    dropdown_IngredientDye2.OnSelected = function(guiComponent, dye)
        selected.dye2 = dye
        Recalculate()
    end

    -- Dye 3
    local dropdown_IngredientDye3 = GUI.DropDown(GUI.RectTransform(Vector2(0.33, 1), row3.RectTransform), NTGuide.Localize("ntg.pharmacydropdown.dye"), dropdownheight, nil, false)
    PopulateDropdown(dropdown_IngredientDye3, DisplayableIngredients.dye)

    dropdown_IngredientDye3.OnSelected = function(guiComponent, dye)
        selected.dye3 = dye
        Recalculate()
    end

    local row4 = GUI.LayoutGroup(GUI.RectTransform(Vector2(1, 0.08), NTGmenuList.Content.RectTransform), true, GUI.Anchor.TopLeft)

    -- MainEffect Header
    local textblock_MainEffectsHeader = GUI.TextBlock(GUI.RectTransform(Vector2(0.33, 1), row4.RectTransform), NTGuide.Localize("ntg.pharmacyheader.outputeffects"), nil, GUI.GUIStyle.SubHeadingFont)
    textblock_MainEffectsHeader.TextAlignment = GUI.Alignment.CenterLeft
    textblock_MainEffectsHeader.CanBeFocused = false
    textblock_MainEffectsHeader.TextColor = Color(110,154,125,255)

    local textblock_SideEffectsHeader = GUI.TextBlock(GUI.RectTransform(Vector2(0.33, 1), row4.RectTransform), NTGuide.Localize("ntg.pharmacyheader.outputsideeffects"), nil, GUI.GUIStyle.SubHeadingFont)
    textblock_SideEffectsHeader.TextAlignment = GUI.Alignment.CenterLeft
    textblock_SideEffectsHeader.CanBeFocused = false
    textblock_SideEffectsHeader.TextColor = Color(110,154,125,255)

    local textblock_GeneralInfoHeader = GUI.TextBlock(GUI.RectTransform(Vector2(0.34, 1), row4.RectTransform), NTGuide.Localize("ntg.pharmacyheader.outputgeneralinfo"), nil, GUI.GUIStyle.SubHeadingFont)
    textblock_GeneralInfoHeader.TextAlignment = GUI.Alignment.CenterLeft
    textblock_GeneralInfoHeader.CanBeFocused = false
    textblock_GeneralInfoHeader.TextColor = Color(110,154,125,255)


    local row5 = GUI.LayoutGroup(GUI.RectTransform(Vector2(1, 0.23), NTGmenuList.Content.RectTransform), true, GUI.Anchor.TopLeft)

    -- Main Effects
    NTGuide.MainEffectsBlock = GUI.TextBlock(GUI.RectTransform(Vector2(0.33,1), row5.RectTransform), "", nil, nil, GUI.Alignment.TopLeft, true)
    NTGuide.MainEffectsBlock.CanBeFocused = false
    NTGuide.MainEffectsBlock.Wrap = true

    -- Side Effects 
    NTGuide.SideEffectsBlock = GUI.TextBlock(GUI.RectTransform(Vector2(0.33,1), row5.RectTransform), "", nil, nil, GUI.Alignment.TopLeft, true)
    NTGuide.SideEffectsBlock.CanBeFocused = false
    NTGuide.SideEffectsBlock.Wrap = true

    -- The other stats (color, quantity etc.)
    NTGuide.GeneralInfoBlock = GUI.TextBlock(GUI.RectTransform(Vector2(0.34,1), row5.RectTransform), "", nil, nil, GUI.Alignment.TopLeft, true)
    NTGuide.GeneralInfoBlock.CanBeFocused = false
    NTGuide.GeneralInfoBlock.Wrap = true

    local sprite = ItemPrefab.GetItemPrefab("custompill_tablets").InventoryIcon
    NTGuide.PillImage = GUI.Image(GUI.RectTransform(Vector2(0.25, 1), NTGuide.GeneralInfoBlock.RectTransform, GUI.Anchor.TopRight), sprite)
    NTGuide.PillImage.CanBeFocused = false
end
