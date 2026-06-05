-- Config to enable language files based on enabled mods.

local config = {
	{
		-- Neurotrauma Continued
		supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
		workshopId = "3190189044",
		loadpriority = 0,
		files = {
				"%ModDir%/XML/Localization/%Language%/BaseNeurotraumaPages.xml",
				}
	},
	{
		-- Cybernetics
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3324062208",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonCyberneticsEnhanced.xml"
				}
	},
	{
		-- Surgery Plus
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3478084070",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonSurgeryPlus.xml"
				} 
	},
	{
		-- Eyes
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3294574390",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonEyes.xml"
				} 
	},
	{
		-- Infections
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3286567141",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonInfections.xml"
				} 
	},
	{
		-- Grafting
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3534702008",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonGrafting.xml"
				} 
	},
	{
		-- Lobotomy
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3326291860",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonLobotomy.xml"
				} 
	},
	{
	-- Thermal
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3648890424",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonThermal.xml"
				}
	},
	{
	-- Airways
	 	supportedlanguages = {"English", "Russian", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3271808177",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonAirways.xml"
				}
	},
	{
	-- Pharmacy
	 	supportedlanguages = {"English", "Simplified Chinese"},
		IgnoreTargetModState = false,
	 	workshopId = "3247838390",
	 	loadpriority = 0,
	 	files = {
				"%ModDir%/XML/Localization/%Language%/AddonPharmacy.xml"
				}
	},
}

return config
