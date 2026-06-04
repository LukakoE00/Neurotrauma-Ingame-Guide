NTingameguide = {}

-- Ydrec if you're reading this I'm sorry for violating your beautiful code but if I don't comment what things do my sleep deprived ass is gonna forget what the hell is happening

-- Initialise the rawconfig file; we dont need a path to find it since it's in the same folder
local rawconfig = require("rawconfig")

local config = {
    Name = "ntguide", --Internal name, used for rawconfig.Configs.Name
    Label = "ntguide.modname", --String displayed in menus, can be localization tag
    Entries = {
        Enabled = {
            name = "ntguide.cfg.enabled", --String displayed in menus, can be localization tag
            default = true,
            type = "bool",
            description = "ntguide.cfg.enableddescription", --String displayed in tooltip, can be localization tag
            enforcment = rawconfig.Enforcment.Client,
        },
        Shared = {
            name = "ntguide.cfg.shared", --String displayed in menus, can be localization tag
            default = true,
            type = "bool",
            description = "ntguide.cfg.shareddescription", --String displayed in tooltip, can be localization tag
            enforcment = rawconfig.Enforcment.Server,
        },
    },
}

-- Add and load our config from the get-go
config = rawconfig.addConfig(config)
config:LoadConfig()

-- Declare 'pkg' as a variable that other functions can use as a reference point, since;
local pkg

-- We can set pkg to be NTIG!
-- For every enabled package, do:
-- tbh i didnt even know you could do this i thought it was ' for index, value in ipairs(table) do' etc.
for package in ContentPackageManager.EnabledPackages.All do
    -- Get the path of the package we're looking at right now
    local path = tostring(package.Dir)
    -- Hey! We know this path, that's ours :33
    if path == NTGuide.Path or string.gsub(path,"\\","/") == NTGuide.Path then
        -- Set pkg to be the NTIG content package
        pkg = package
        -- Stop this loop; why check other packages when we have what we want?
        break
    end
end

-- Not even gonna pretend I know what this does :barodev:
-- I THINK it allows access to modlists and enables/disables force-downloading our selected 'pkg'
if SERVER and CSActive then

    LuaUserData.RegisterType("System.Collections.Immutable.ImmutableArray`1[[Barotrauma.ContentPackage,DedicatedServer]]")
    LuaUserData.RegisterType("System.Collections.Immutable.ImmutableArray`1+Builder[[Barotrauma.ContentPackage,DedicatedServer]]")

    BindingFlags = LuaUserData.CreateEnumTable("System.Reflection.BindingFlags")

    LuaUserData.RegisterType("System.Type")
    LuaUserData.RegisterType("System.Reflection.FieldInfo")

    LuaUserData.RegisterType("Barotrauma.Networking.ModSender")
    ModSender = LuaUserData.CreateStatic('Barotrauma.Networking.ModSender')
    LuaUserData.RegisterType("Barotrauma.SaveUtil")
    SaveUtil = LuaUserData.CreateStatic('Barotrauma.SaveUtil')
    LuaUserData.RegisterType("Barotrauma.Steam.SteamManager")
    SteamManager = LuaUserData.CreateStatic('Barotrauma.Steam.SteamManager')
    LuaUserData.RegisterType("Steamworks.SteamServer")
    SteamServer = LuaUserData.CreateStatic('Steamworks.SteamServer')

    LuaUserData.RegisterType("Barotrauma.Networking.ServerPeer`1")
    LuaUserData.RegisterType("Barotrauma.Networking.LidgrenServerPeer")
    LuaUserData.RegisterType("Barotrauma.Networking.P2PServerPeer")


    HasMultiplayerSyncedContent_fieldinfo = LuaUserData.GetType('Barotrauma.ContentPackage').GetField("<HasMultiplayerSyncedContent>k__BackingField", bit32.bor(BindingFlags.Instance, BindingFlags.NonPublic))

    if Game.IsDedicated then
        contentPackages_fieldinfo = LuaUserData.GetType('Barotrauma.Networking.LidgrenServerPeer').BaseType.GetField("contentPackages", bit32.bor(BindingFlags.Instance, BindingFlags.NonPublic))
    else
        contentPackages_fieldinfo = LuaUserData.GetType('Barotrauma.Networking.P2PServerPeer').BaseType.GetField("contentPackages", bit32.bor(BindingFlags.Instance, BindingFlags.NonPublic))
    end

    function NTingameguide.AddToPublicModlist()
        HasMultiplayerSyncedContent_fieldinfo.SetValue(pkg, true)
        
        --Game.Server.ModSender.CompressMod(pkg)
        SaveUtil.CompressDirectory(pkg.Dir, ModSender.GetCompressedModPath(pkg))

        

        contentpackagestmp = contentPackages_fieldinfo.GetValue(Game.Server.serverPeer).ToBuilder()

        contentpackagestmp.Add(pkg)

        contentPackages_fieldinfo.SetValue(Game.Server.serverPeer, contentpackagestmp.ToImmutable())

        SteamServer.ClearKeys()

        SteamManager.RefreshServerDetails(Game.Server)
    end

    function NTingameguide.RemoveFromPublicModlist()

        HasMultiplayerSyncedContent_fieldinfo.SetValue(pkg, false)

        SaveUtil.DeleteIfExists(ModSender.GetCompressedModPath(pkg))

        contentpackagestmp = contentPackages_fieldinfo.GetValue(Game.Server.serverPeer).ToBuilder()

        contentpackagestmp.Remove(pkg)

        contentPackages_fieldinfo.SetValue(Game.Server.serverPeer, contentpackagestmp.ToImmutable())

        SteamServer.ClearKeys()

        SteamManager.RefreshServerDetails(Game.Server)
    end
end

config.SaveConfig = function()
    if CLIENT then
        if config:Get("Enabled",true) then
            EnableNTGuide()
        else
            DisableNTGuide()
        end
    end

    if SERVER then
        if config:Get("Shared",false) and not pkg.HasMultiplayerSyncedContent then
            NTingameguide.AddToPublicModlist()
        elseif config:Get("Shared",false) == false and pkg.HasMultiplayerSyncedContent then
            NTingameguide.RemoveFromPublicModlist()
        end
    end

    rawconfig.util.SaveConfig(config)
end

if SERVER then return end

--======================================================================================================================================================================================================

-- All of this next stuff is gonna be CLIENTSIDE baby!
-- This is where we have the GUI code (somewhere right now its fucked) since the server doesnt need it
-- The server side code (currently just the diagnostic tool overrides) is loaded in the autorun file

-- Get the modconfig file; just like before, same folder yada yada
local modconfig = require("modconfig")
local TextFile = LuaUserData.CreateStatic("Barotrauma.TextFile", true)

-- Will hold all the textfiles we wanna do things with later
local FileList = {}

LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.GameSettings"], "currentConfig")
local ClientLanguage = tostring(GameSettings.currentConfig.Language)
local prev_language = ClientLanguage

LuaUserData.MakeFieldAccessible(Descriptors['Barotrauma.ContentPackageManager+EnabledPackages'], 'regular')
-- LuaUserData.MakeMethodAccessible(Descriptors['Barotrauma.ContentPackageManager+EnabledPackages'], 'SortContent')
LuaUserData.RegisterType("System.Collections.Generic.List`1[[Barotrauma.RegularPackage,Barotrauma]]")

LuaUserData.RegisterType("System.Collections.Immutable.ImmutableList`1[[Barotrauma.TextPack,Barotrauma]]")
LuaUserData.RegisterType("System.Collections.Immutable.ImmutableList`1+Builder[[Barotrauma.TextPack,Barotrauma]]")

LuaUserData.RegisterType("System.Collections.Concurrent.ConcurrentDictionary`2[[Barotrauma.LanguageIdentifier,Barotrauma],[System.Collections.Immutable.ImmutableList`1[[Barotrauma.TextPack,Barotrauma]],System.Collections.Immutable]]")

-- Used by ONLY the EnablesTextFileS function
-- Returns a boolean
function EnableTextFile(file, workshopId)
    local targetPackage
    local targetFile

    -- If this gets no ID to work with, we default to pkg; i.e. we're looking at NTIG
    if workshopId == nil or workshopId == "" then
        targetPackage = pkg
    else
        -- For every package do:
        for package in ContentPackageManager.AllPackages do
            -- If that package is the same as our passed workshopID, set targetPackage to that package
            if tostring(package.UgcId) == workshopId then
                targetPackage = package
                break -- Again, no need to continue the loop if we're done
            end
        end
    end

    -- If a workshop ID is given and we've iterated every package installed and we STILL have no target then something is wrong;
    -- Most likely the mod just isnt installed (or we've fucked the ID in the config)
    if targetPackage == nil then
        print("Could not find package to enable with workshop id ", workshopId)
        return false -- Don't do the code after this and output false
    end

    -- We have a workshop mod and we're checking their files, but we cannot actually find what we're looking for. Not good!
    -- Most likely a typo in the file name if this happens
    if File.Exists(targetPackage.Dir .. "/" .. file) == false then
        -- Fallback: try loading from the guide mod itself (pkg)
        if pkg and File.Exists(pkg.Dir .. "/" .. file) then
            targetPackage = pkg
        else
            print("Could not find file " .. file .. " in " .. targetPackage.name)
            return false
        end
    end

    -- If we've found the file, turn it into a TextFile so it can be used by the game!
    targetFile = TextFile(targetPackage, ContentPath.FromRaw(targetPackage, targetPackage.Dir .. "/" .. file))

    -- If that somehow fucks up, just return false again for safety
    if targetFile == nil then
        print("Could not find file " .. file .. " in " .. targetPackage.name)
        return false
    end

    -- EVERYTHING GOOD SO FAR? Look at the file and put it into a table so we know all the text files we've automatically enabled.
    -- This means we can just unload/reload those later if we need to
    targetFile.LoadFile()
    table.insert(FileList, targetFile)

    --print("Enabled " .. targetFile.Path.Value .. " in package ", targetPackage.name)
    --print(targetFile.ContentPackage.Name)

    -- Finally, return true so EnableTextFileS can keep going
    return true
end

-- Should text files be enabled?
function EnableTextFiles(files, language)
    -- This is being done for all supported languages
    -- If no language is passed, default to the client's selected language
    if not language then language = ClientLanguage end
    -- For each localization file we have in the modconfig, do:
    for file in files do
        -- Remove ModDir from the directory in ModConfig
        file = StripModDir(file)
        -- Take that directory given, swap "%Language%" with the language currently passed
        -- i.e. if we had "German" as client language we'd turn XML/Localization/%Language%/BaseNeurotraumaPages.xml into XML/Localization/German/BaseNeurotraumaPages.xml
        file = string.gsub(file, "%%Language%%", language)

        -- Now we have a directory where that file SHOULD be. Send it over to the function above and see if that is TRUE or FALSE.
        if not EnableTextFile(file) then
            return false -- If false, then return false.
        end
    end

    -- My brother this is the TRUEST shit I've ever heard
    return true
end

-- Déjà vú
-- Let's disable a text package; we need the workshopID and the language name, i.e. "German"
function DisableTextPackage(workshopId, language)
    local targetPackage
    -- Get the language file name by just adding .xml to the end; i.e. "German.xml" found 
    local languageTrimmed = string.sub(language, 2) .. ".xml"
    -- Same as before; attempt to find the content package that holds our given workshopID
    for package in ContentPackageManager.EnabledPackages.All do
        if tostring(package.UgcId) == workshopId then
            targetPackage = package
            break -- Stop loop once happy
        end
    end

    -- If targetPackage was kept empty since we failed above, throw an error;
    -- Could happen if you uninstalled a mod while we're relying on it
    if targetPackage == nil then
        print("Could not find package to disable with workshop id ", workshopId)
        return -- Stop the DisableTextPackage function 
    end

    -- If we're still here, then targetPackage holds something. 
    -- Look over its content and do;
    for file in targetPackage.Files do
        -- Safety check!
        -- Are we looking at a TextFile object that ends with "language.xml" (like that German.xml we said before!)?
        -- If so, unload it (which will prevent it from showing up in-game)
        if LuaUserData.IsTargetType(file, "Barotrauma.TextFile") and string.endsWith(file.Path.Value, languageTrimmed) then
            file.UnloadFile()
            --print("Disabled " .. file.Path.Value .. " in package ", workshopId)
            break -- We're done here, stop looking over files
        end
    end
end

-- We check if the list of supported language in the relevant table for the mod we care about has the language that's currently active
function ClientHasSupportedLanguage(supportedlanguages)
    local value = false
    for language in supportedlanguages do
        if language == ClientLanguage then
            value = true
            break -- If we have the client's language supported, set value to true and stop going over the supported languages
        end
    end
    return value -- Returns default (false) if the earlier check didn't do anything or true if it did
end

-- We check if a specific mod is enabled via their workshopID
-- This is used to only load relevant data; it's a waste of resources to load Cybernetics text data if cybernetics isn't enabled, for example
function NTGuide.IsModEnabled(workshopId)
    local value = false
    -- If no ID is given or it's nothing, return false and stop this function
    if workshopId == nil or workshopId == "" then
        return false
    end
    -- If we have an ID, check if it's within the EnabledPackages table.
    for package in ContentPackageManager.EnabledPackages.All do
        if tostring(package.UgcId) == workshopId then
            value = true -- If so, return true and leave
            break
        end
    end
    return value -- Otherwise, return the default of false
end

-- Pretty self explanatory I hope (even for me!)
function IsFirstHigherPriority(a, b)
    if a.loadpriority > b.loadpriority then
        return true
    else
        return false
    end
end

-- Instead of using an ID to check if a content package is enabled, use their name instead
function GetPackageByName(name)
    for package in ContentPackageManager.EnabledPackages.All do
        if package.Name == name then
            return package
        end
    end

    return nil
end

-- Use an ID to get a content package from the enabled ones
function GetPackageById(id)
    for package in ContentPackageManager.EnabledPackages.All do
        if tostring(package.UgcId) == id then
            return package
        end
    end
end

-- Load the actual thing
function LoadPatches()
    -- Determine load order
    table.sort(modconfig, IsFirstHigherPriority)

    -- For every entry in the Modconfigs file do:
    for _, patch in pairs(modconfig) do
        local files = {}
        local modname = ""

        -- Do we even want to load the text?
        -- Either because the mod is enabled or because we're overriding the check
        if patch.IgnoreTargetModState or NTGuide.IsModEnabled(patch.workshopId) then
            -- Like before, go over all the supported languages and throw them at EnableTextFileS
            for language in patch.supportedlanguages do
                --DisableTextPackage(patch.workshopId, language)
                -- modname = GetPackageById(patch.workshopId).name

                if not EnableTextFiles(patch.files, language) then
                    print("Errors enabling NTIG files")
                    break -- Stop what we're doing once we find nothing for this language
                end
            end
        end
    end

    --For whatever reason content specific Sort isnt static method and i dont want to be sorting all the content in game
    --ContentPackageManager.EnabledPackages.SortContent()
    --if FileList[1] then FileList[1].Sort() end

    -- Continue below if we actually have something to load (as dictated by EnableTextFileS)
    if FileList[1] then
        local textpacks = TextManager.TextPacks[GameSettings.CurrentConfig.Language].ToBuilder()
        local firstindex = 0
        local targetindex = 0

        for i = 0, textpacks.Count-1, 1 do
            if textpacks[i].ContentFile.ContentPackage.Name ~= "Vanilla" then
                targetindex = i
                break
            end
        end

        for i = textpacks.Count-1, 0, -1 do
            if textpacks[i].ContentFile.ContentPackage ~= pkg then
                firstindex = i+1
                break
            end
        end

        local range = textpacks.GetRange(firstindex, textpacks.Count-firstindex)

        -- for pack in range do
        --     print(pack.ContentFile.Path)
        -- end

        for i=textpacks.Count-1, firstindex, -1 do
            textpacks.RemoveAt(i)
        end
        
        textpacks.InsertRange(targetindex, range)
        textpacks = textpacks.ToImmutable()

        TextManager.TextPacks.TryUpdate(GameSettings.CurrentConfig.Language, textpacks,  TextManager.TextPacks[GameSettings.CurrentConfig.Language])
    end
end

-- Used to get the mod directory based on the path given in the Modconfig
function StripModDir(filepath)
    local div = string.find(filepath, "%%[/\\]" )
    if div == nil then
        filepath = filepath
    else
        --moddir = string.sub(filepath, 1, div)
        filepath = string.sub(filepath, div+2)
    end
    return filepath
end

function UnloadPatches()
    for file in FileList  do
        --print("Unloading ", file.Path.Value)
        file.UnloadFile()
    end
    FileList = {}
end

function ReloadModsLocalization()
    for package in ContentPackageManager.EnabledPackages.All do
        for _, patch in pairs(modconfig) do
            if tostring(package.UgcId) == patch.workshopId then
                for file in package.Files do
                    if LuaUserData.IsTargetType(file, "Barotrauma.TextFile") then
                        file.LoadFile()
                        --print("Reenabled " .. file.Path.Value .. " in package ", workshopId)
                    end
                end
                break
            end
        end
    end
end


function LanguageChanged()
    ClientLanguage = tostring(GameSettings.currentConfig.Language)
    if ClientLanguage ~= prev_language then
        prev_language = ClientLanguage
        return true
    end
    return false
end

function ReloadNTGuide()
    if pkg == nil then
        print("Package not found.")
        return
    end

    UnloadPatches()

    ClientLanguage = tostring(GameSettings.currentConfig.Language)
    modconfig = {}
    modconfig = dofile(NTGuide.Path .. "/Lua/modconfig.lua")
    LoadPatches()
end

function EnableNTGuide()
    if pkg == nil then
        print("Package not found.")
        return
    end

    ClientLanguage = tostring(GameSettings.currentConfig.Language)
    modconfig = {}
    modconfig = dofile(NTGuide.Path .. "/Lua/modconfig.lua")
    LoadPatches()

    -- Hacky integration of NTID code.
    -- It works :barodev:
    -- You'll always reload lua before going into a server / singleplayer; you generally remove mods on the main menu. Therefor, this should work
    if CLIENT then
        dofile(NTGuide.Path .. "/Lua/Scripts/Client/NTG_Helperfunctions.lua")
        dofile(NTGuide.Path .. "/Lua/Scripts/Client/NTG_SettingsPageContent.lua") -- Content for the Settings Menu
        dofile(NTGuide.Path .. "/Lua/Scripts/Client/NTG_SettingsPageConstruction.lua") -- Scripts for the settings menu

        dofile(NTGuide.Path .. "/Lua/Scripts/Client/ContentPages/Neurotrauma.lua") -- Base Neurotrauma Content Pages

        local modsToLoad = {
            ["3324062208"] = "Cybernetics.lua",
            ["3478084070"] = "SurgeryPlus.lua",
            ["3294574390"] = "Eyes.lua",
            ["3286567141"] = "Infections.lua",
            ["3534702008"] = "Grafting.lua",
            ["3326291860"] = "Lobotomy.lua",
            ["3648890424"] = "Thermal.lua",
            ["3271808177"] = "Airways.lua",
            ["3247838390"] = "Pharmacy.lua",
        }

        for workshopId, scriptName in pairs(modsToLoad) do
            if NTGuide.IsModEnabled(workshopId) then
                dofile(NTGuide.Path .. "/Lua/Scripts/Client/ContentPages/Addons/" .. scriptName) -- Content Pages for each addon
                if workshopId == "3247838390" then
                    dofile(NTGuide.Path .. "/Lua/Scripts/Client/NTG_PharmacyPillCalculator.lua") -- Pill Calculator
                end
            end
        end

        dofile(NTGuide.Path .. "/Lua/Scripts/Client/NTG_HotkeyUsage.lua") -- debug
        dofile(NTGuide.Path .. "/Lua/Scripts/Client/NTG_PageConstruction.lua") -- Construction code
        dofile(NTGuide.Path .. "/Lua/Scripts/Client/NTG_Chatlink.lua") -- Clientside code to interface with chat linking
    end

    NTGuide.CreateGuideButton()
end

function DisableNTGuide()
    if pkg == nil then
        print("Package not found.")
        return
    end

    UnloadPatches()
    NTGuide.RemoveGuideButton()
    --ReloadModsLocalization()
end

Hook.Add("stop", "NTGuideCleanUp", function ()
    UnloadPatches()
    --ReloadModsLocalization()
end)

Game.AddCommand("reloadNTGuide", "Reloads NT Guide pages.", function()
    ReloadNTGuide()
    print("NTGuide reloaded.")
end, GetValidArguments)

if not pkg then
    print("NT Guide couldn't find its own folder to load texts, report to mod author")
    return
end

ContentPackageManager.EnabledPackages.regular.Remove(pkg)
ContentPackageManager.EnabledPackages.regular.Insert(0, pkg)

if config:Get("Enabled",true) then
    EnableNTGuide()
else
    DisableNTGuide()
end
--ContentPackageManager.ReloadContentPackage(pkg)

Game.AddCommand("ntguide_debug", "Shows various debug info", function()
    print("###TEST1###")
    for pack in TextManager.TextPacks[GameSettings.CurrentConfig.Language] do print(pack.ContentFile.Path) end
    print("\n###TEST2###")
    for k, v in pairs(modconfig) do 
        print(k, " > ", v) 
        for k1, v1 in pairs(v) do 
            print(k1, " >> ", v1)
            if type(v1) == "table" then
                for k2, v2 in pairs(v1) do
                    print(k2, " >>> ", v2)
                end
            end
       end 
    end
end, GetValidArguments)
