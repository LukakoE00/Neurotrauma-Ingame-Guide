-- Neurotrauma: Lobotomy Additions
-- Items
-- Orbitoclast (Med60)
NTGuide.ContentPages.Items.Orbitoclast = {
    mod = "NT: Lobotomy",
    id = "orbitoclast",
    category = "items",
    title = NTGuide.Localize("ntg.title.orbitoclast"), 
    description = NTGuide.Localize("ntg.description.orbitoclast"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.orbitoclast")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.orbitoclast")},
    seealso = {NTGuide.Localize("ntg.seealso.orbitoclast")},
}

-- Surgical Hammer (Med60)
NTGuide.ContentPages.Items.SurgicalHammer = {
    mod = "NT: Lobotomy",
    id = "surgical_hammer",
    category = "items",
    title = NTGuide.Localize("ntg.title.surgical_hammer"), 
    description = NTGuide.Localize("ntg.description.surgical_hammer"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.surgical_hammer")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.surgical_hammer")},
    seealso = {NTGuide.Localize("ntg.seealso.surgical_hammer")},
}

-- Nerve Generators / Cerebral regenerative compound (Med50)
NTGuide.ContentPages.Items.NerveGenerators = {
    mod = "NT: Lobotomy",
    id = "nerve_generators",
    category = "items",
    title = NTGuide.Localize("ntg.title.nerve_generators"), 
    description = NTGuide.Localize("ntg.description.nerve_generators"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.nerve_generators")},
    seealso = {NTGuide.Localize("ntg.seealso.nerve_generators")},
}

-- Procedures
-- Transorbital Lobotomy
NTGuide.ContentPages.SurgicalProcedures.TransorbitalLobotomy = {
    mod = "NT: Lobotomy",
    id = "transorbital_lobotomy",
    category = "procedures",
    title = NTGuide.Localize("ntg.title.transorbital_lobotomy"), 
    description = NTGuide.Localize("ntg.description.transorbital_lobotomy"),
    steps = {NTGuide.Localize("ntg.steps.transorbital_lobotomy")},
    seealso = {NTGuide.Localize("ntg.seealso.transorbital_lobotomy")},
}

-- Ethanol Lobotomy
NTGuide.ContentPages.SurgicalProcedures.EthanolLobotomy = {
    mod = "NT: Lobotomy",
    id = "ethanol_lobotomy",
    category = "procedures",
    title = NTGuide.Localize("ntg.title.ethanol_lobotomy"), 
    description = NTGuide.Localize("ntg.description.ethanol_lobotomy"),
    steps = {NTGuide.Localize("ntg.steps.ethanol_lobotomy")},
    seealso = {NTGuide.Localize("ntg.seealso.ethanol_lobotomy")},
}

-- Cerebral Regeneration Surgery
NTGuide.ContentPages.SurgicalProcedures.CerebralRegenerationSurgery = {
    mod = "NT: Lobotomy",
    id = "cerebral_regeneration_procedure",
    category = "procedures",
    title = NTGuide.Localize("ntg.title.cerebral_regeneration_procedure"), 
    description = NTGuide.Localize("ntg.description.cerebral_regeneration_procedure"),
    steps = {NTGuide.Localize("ntg.steps.cerebral_regeneration_procedure")},
    seealso = {NTGuide.Localize("ntg.seealso.cerebral_regeneration_procedure")},
}

-- Results
-- Lobotomy Effects
NTGuide.ContentPages.Information.LobotomyEffects = {
    mod = "NT: Lobotomy",
    id = "lobotomy_effects",
    category = "information",
    title = NTGuide.Localize("ntg.title.lobotomy_effects"), 
    description = NTGuide.Localize("ntg.description.lobotomy_effects"),
    lobopositiveeffects = {NTGuide.Localize("ntg.lobopositiveeffects.lobotomy_effects")},
    lobonegativeeffects = {NTGuide.Localize("ntg.lobonegativeeffects.lobotomy_effects")},
    seealso = {NTGuide.Localize("ntg.seealso.lobotomy_effects")},
}

-- Lobotomy Settings
local ModSettings = {
	NTG_Settings_NTLobotomy = { 
        type = "category",
        name =  NTGuide.Localize("ntg.categoryname.lobotomy"),
    },

	NTG_ModColour_NTLobotomy = { 
		type = "string",
		name =  NTGuide.Localize("ntg.settingname.modcolourlobotomy"),
		default = {"0", "175", "175"},
		style = "R,G,B",
		boxsize = 0.05,
        isColour = true,
        reset = false,
	},
}

for key, entry in pairs(ModSettings) do
    NTGuideSettings.ConfigData[key] = entry
end