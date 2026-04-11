-- Pill Calculator
NTGuide.ContentPages.Information.PharmacyPillCalculator = {
    mod = "NT: Pharmacy",
    id = "pharmacy_pill_calculator",
    category = "information",
    pillcalculator = true,
    title = NTGuide.Localize("ntg.title.pharmacy_pill_calculator"), 
}

-- Pharmacy Settings
local ModSettings = {
	NTG_Settings_NTPharmacy = { 
        type = "category",
        name = NTGuide.Localize("ntg.categoryname.pharmacy"),
    },

	NTG_ModColour_NTPharmacy = { 
		type = "string",
		name = NTGuide.Localize("ntg.settingname.modcolourpharmacy"),
		default = {"97", "24", "33"},
		style = "R,G,B",
		boxsize = 0.05,
        isColour = true,
        reset = false,
	},
}


for key, entry in pairs(ModSettings) do
    NTGuideSettings.ConfigData[key] = entry
end