-- Function to check if the guide hotkey was hit
function NTGuide.IsHotkeyHit()
    local hotkey = NTGuide.GetSetting("NTG_SelectedHotkey")
    if not hotkey then return false end

    local hit = false

    if Keys[hotkey] ~= nil then
        hit = PlayerInput.KeyHit(Keys[hotkey])
    end

    return hit
end

-- Hook.Add("keyUpdate", "test", function(keyargs)
--     if not NTGuide.IsHotkeyHit() then return end

--     GUI.AddMessage("Yippie!", Color(210,200,154))
-- end)

-- Really gotta expand this :33333