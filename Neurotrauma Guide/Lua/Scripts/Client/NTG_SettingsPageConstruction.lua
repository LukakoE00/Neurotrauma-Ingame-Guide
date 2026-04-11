-- Function to make the settings page auto-build based on given 'settings' information, akin to the Neurotrauma Config.
-- Since this is all client-side, we can store it locally in-guide and not worry

-- From NT: Config
local function CommaStringToTable(str)
	local tbl = {}

	for word in string.gmatch(str, "([^,]+)") do
		table.insert(tbl, word)
	end

	return tbl
end

function NTGuide.BuildSettingsPage(MenuList)
    local list = NTGmenuList

    for key, entry in pairs(NTGuideSettings.ConfigData) do

        -- CATEGORY (header)
        if entry.type == "category" then
            local SettingsElement_Category = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.09), list.Content.RectTransform), entry.name, Color(110,154,125,255), GUI.GUIStyle.SubHeadingFont, GUI.Alignment.BottomCenter)
            SettingsElement_Category.CanBeFocused = false

        -- FLOAT
        elseif entry.type == "float" then
            local min, max = entry.range[1], entry.range[2]

            local SettingsElement_Float = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.05), list.Content.RectTransform), entry.name .. " (" .. min .. "-" .. max .. ")", Color(210,200,154,255), nil, GUI.Alignment.Center)
            SettingsElement_Float.CanBeFocused = false

            local input = GUI.NumberInput(GUI.RectTransform(Vector2(1, 0.06), list.Content.RectTransform), NumberType.Float)

            input.MinValueFloat = min
            input.MaxValueFloat = max
            input.FloatValue = entry.default or 0

            input.OnValueChanged = function ()
                entry.value = input.FloatValue
            end

        -- BOOL
        elseif entry.type == "bool" then

            local rect = GUI.RectTransform(Vector2(1, 0.06), list.Content.RectTransform)
            local toggle = GUI.TickBox(rect, entry.name)

            if entry.description then
                toggle.ToolTip = entry.description
            end

            if entry.value == nil then
                entry.value = entry.default or false
            end

            toggle.Selected = entry.value

            toggle.OnSelected = function()
                entry.value = toggle.Selected
            end

        -- STRING
        elseif entry.type == "string" then
            if entry.name == nil then return end
            local style = ""
            local exampleColour = Color(210,200,154,255)

            if entry.style ~= nil then
                style = " (" .. entry.style .. ")"
            end

            local rect = GUI.RectTransform(Vector2(1, 0.05), list.Content.RectTransform)
            local textBlock = GUI.TextBlock(rect, entry.name .. style, exampleColour, nil, GUI.Alignment.CenterLeft, true)
            textBlock.CanBeFocused = false
            if entry.description then
                textBlock.ToolTip = entry.description
            end

            if entry.value == nil then
                entry.value = entry.default or {""}
            end

            local inputRect = GUI.RectTransform(Vector2(0.2, 0.05), list.Content.RectTransform)
            local displayValue

            if type(entry.value) == "table" then
                displayValue = table.concat(entry.value, ",")
            else
                displayValue = tostring(entry.value)
            end

            local stringInput = GUI.TextBox(inputRect, displayValue, nil, nil, GUI.Alignment.CenterLeft, false, "GUITextBox", nil, false, true)
            stringInput.HoverColor = Color(0,0,0,0)

            if entry.reset then
                local resetButton = GUI.Button(GUI.RectTransform(Vector2(0.05, 1), rect, GUI.Anchor.CenterRight), GUI.Alignment.Center, nil, Color(0,0,0,255))
                local resetButtonStyle = GUI.Image(GUI.RectTransform(Vector2(1, 1), resetButton.RectTransform), "GUIButtonRefresh")
                resetButtonStyle.ToolTip = "Reset to default"
            end

            local dynamicTextBlock
            if entry.isColour then
                local textblockRect = GUI.RectTransform(Vector2(1, 0.05), list.Content.RectTransform)
                dynamicTextBlock = GUI.TextBlock(textblockRect, "Mod-of-Origin Colour Example", exampleColour, nil, GUI.Alignment.Center, true)
                dynamicTextBlock.CanBeFocused = false
            end

            local function UpdateColour()
                local modColourTable = entry.value

                if modColourTable and #modColourTable == 3 then
                    local r = tonumber(modColourTable[1]) or 255
                    local g = tonumber(modColourTable[2]) or 255
                    local b = tonumber(modColourTable[3]) or 255
                    dynamicTextBlock.TextColor = Color(r, g, b, 255)
                else
                    dynamicTextBlock.TextColor = Color(exampleColour)
                end
            end

            if resetButton then
                resetButton.OnClicked = function()
                    entry.value = entry.default
                    stringInput.Text = table.concat(entry.default, ",")
                    if entry.isColour and dynamicTextBlock then
                        UpdateColour()
                    end
                end
            end

            -- For settings that are NOT the hotkey, we just update in real time (since thats only colour rn)
            stringInput.OnTextChangedDelegate = function()
                if key ~= "NTG_SelectedHotkey" then
                    entry.value = CommaStringToTable(stringInput.Text)
                    if entry.isColour then
                        UpdateColour()
                    end
                end
            end

            -- For the hotkey, update only on Enter press
            -- TODO: Mouse buttons. Maybe also numpad? IDK
            stringInput.OnEnterPressed = function()
                -- Are we actually looking at the hotkey setting?
                if key == "NTG_SelectedHotkey" then

                    -- Pull setting input text
                    local basic_input = tostring(stringInput.Text or "")

                    -- Actually had to crack open documentation for this one :wilted_flower:
                    -- We throw the current input value into Keys and either it works or it errors and throws nil
                    -- Doing it in a Pcall prevents the error from showing in-game and allows us to act properly if some bullshit is input
                    -- I.e. 'jfviedrie' is not a valid Key, checked_hotkey would return nil and thus that input shouldnt be used
                    local hotkeycheck, checked_hotkey = pcall(function() return Keys[basic_input] end)

                    -- No error? Awesome! We will now update the hotkey!
                    if hotkeycheck and checked_hotkey ~= nil then
                        NTGuide.SetSetting("NTG_SelectedHotkey", basic_input)
                        GUI.AddMessage(NTGuide.Localize("ntg.settinghotkey.changesuccess") .. " " .. basic_input, Color(210,200,154))
                    else
                    -- An error! It's so over.. reset to N and throw an error to the player
                        NTGuide.SetSetting("NTG_SelectedHotkey", "N")
                        stringInput.Text = "N"
                        GUI.AddMessage(NTGuide.Localize("ntg.settinghotkey.changefailed"), Color(255,200,154,255))
                    end
                end
            end

            -- First-time colour update for good measure
            if entry.isColour then UpdateColour() end
        end
    end
end