-- Config to enable language files based on enabled mods.

local config = {
	{
		-- Neurotrauma Continued
		supportedlanguages = {"English", "Russian"}, -- which languages patch supports for this specific mod {"English","German","Russian"} etc
		IgnoreTargetModState = false, -- doesnt check for target mod being enabled. Still respects supported languages.
		workshopId = "3190189044", -- id of the mod being patched and which language files we disable, "" means nothing gets disabled
		loadpriority = 0, -- patches with higher priotiry would override ones with lower when enabled. works similiar to game modlist
		files = {	-- path to language files we want to use instead of originals, %Language% is automatically replaced with client language
				"%ModDir%/XML/Localization/%Language%/BaseNeurotraumaPages.xml", -- if files is empty (files = {}) then it would just disable mod language files
				}

	},

	{
		-- Cybernetics
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3324062208",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonCyberneticsEnhanced.xml"
				}
	},

	{
		-- Surgery Plus
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3478084070",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonSurgeryPlus.xml"
				} 
	},

	{
		-- Eyes
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3294574390",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonEyes.xml"
				} 
	},

	{
		-- Infections
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3286567141",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonInfections.xml"
				} 
	},

	{
		-- Grafting
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3534702008",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonGrafting.xml"
				} 
	},

	{
		-- Lobotomy
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3326291860",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonLobotomy.xml"
				} 
	},

	{
	-- Thermal
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3648890424",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonThermal.xml"
				}
	},

	{
	-- Airways
	 	supportedlanguages = {"English", "Russian"},
		IgnoreTargetModState = false,
	 	workshopId = "3271808177",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonAirways.xml"
				}
	},

	{
	-- Pharmacy
	 	supportedlanguages = {"English"},
		IgnoreTargetModState = false,
	 	workshopId = "3247838390",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonPharmacy.xml"
				}
	},
}

return config


	-- Example blank, you dont need to add localization for this
	-- {
	-- 	supportedlanguages = {"English"},
	-- 	IgnoreTargetModState = false,
	-- 	workshopId = "",
	-- 	loadpriority = 1,
	-- 	files = {
	-- 		"%ModDir%/XML/Localization/%Language%/dummy.xml"
	-- 		} 
	-- },