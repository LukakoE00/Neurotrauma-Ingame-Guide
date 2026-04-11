-- Neurotrauma: Surgery Plus Additions
-- Surgical Infection
NTGuide.ContentPages.Afflictions_Blood.SurgicalInfection = {
    mod = "NT: Surgery Plus",
    id = "surgical_infection", 
    category = "mechanics",
    title = NTGuide.Localize("ntg.title.surgical_infection"), 
    description = NTGuide.Localize("ntg.description.surgical_infection"), 
    effects = {NTGuide.Localize("ntg.effects.surgical_infection")},
    seealso = {NTGuide.Localize("ntg.seealso.surgical_infection")},
}
-- Surgical Drapes
NTGuide.ContentPages.Items.SurgicalDrapes = {
    mod = "NT: Surgery Plus",
    id = "surgical_drapes", 
    category = "items",
    title = NTGuide.Localize("ntg.title.surgical_drapes"), 
    description = NTGuide.Localize("ntg.description.surgical_drapes"), 
    effects = {NTGuide.Localize("ntg.effects.surgical_drapes")},
    seealso = {NTGuide.Localize("ntg.seealso.surgical_drapes")},
}
-- Surgical Mask
NTGuide.ContentPages.Items.SurgicalMask = {
    mod = "NT: Surgery Plus",
    id = "surgical_mask", 
    category = "items",
    title = NTGuide.Localize("ntg.title.surgical_mask"), 
    description = NTGuide.Localize("ntg.description.surgical_mask"), 
    effects = {NTGuide.Localize("ntg.effects.surgical_mask")},
    seealso = {NTGuide.Localize("ntg.seealso.surgical_mask")},
}
-- Surgeon Clothes
NTGuide.ContentPages.Items.SurgeonClothes = {
    mod = "NT: Surgery Plus",
    id = "surgeon_clothes", 
    category = "items",
    title = NTGuide.Localize("ntg.title.surgeon_clothes"), 
    description = NTGuide.Localize("ntg.description.surgeon_clothes"), 
    effects = {NTGuide.Localize("ntg.effects.surgeon_clothes")},
    seealso = {NTGuide.Localize("ntg.seealso.surgeon_clothes")},
}
-- Mannitol Plus
NTGuide.ContentPages.Items.MannitolPlus = {
    mod = "NT: Surgery Plus",
    id = "mannitol_plus", 
    category = "items",
    title = NTGuide.Localize("ntg.title.mannitol_plus"), 
    description = NTGuide.Localize("ntg.description.mannitol_plus"), 
    effects = {NTGuide.Localize("ntg.effects.mannitol_plus")},
    seealso = {NTGuide.Localize("ntg.seealso.mannitol_plus")},
}
-- Experimental Treatment
NTGuide.ContentPages.Items.ExperimentalTreatment = {
    mod = "NT: Surgery Plus",
    id = "experimental_treatment", 
    category = "items",
    title = NTGuide.Localize("ntg.title.experimental_treatment"), 
    description = NTGuide.Localize("ntg.description.experimental_treatment"), 
    positiveeffects = {NTGuide.Localize("ntg.positiveeffects.experimental_treatment")},
    negativeeffects = {NTGuide.Localize("ntg.negativeeffects.experimental_treatment")},
    seealso = {NTGuide.Localize("ntg.seealso.experimental_treatment")},
}
-- Triage Card(s)
NTGuide.ContentPages.Items.TriageCard = {
    mod = "NT: Surgery Plus",
    id = "triage_card", 
    category = "items",
    title = NTGuide.Localize("ntg.title.triage_card"), 
    description = NTGuide.Localize("ntg.description.triage_card"), 
}
-- Brain Jar
NTGuide.ContentPages.Items.BrainJar = {
    mod = "NT: Surgery Plus",
    id = "brain_jar", 
    category = "items",
    title = NTGuide.Localize("ntg.title.brain_jar"), 
    description = NTGuide.Localize("ntg.description.brain_jar"), 
}
-- Artificial Brain
NTGuide.ContentPages.Items.ArtificialBrain = {
    mod = "NT: Surgery Plus",
    id = "artificial_brain", 
    category = "items",
    title = NTGuide.Localize("ntg.title.artificial_brain"), 
    description = NTGuide.Localize("ntg.description.artificial_brain"), 
}
-- Medical Misconduct
NTGuide.ContentPages.Items.MedicalMisconduct = {
    mod = "NT: Surgery Plus",
    id = "medical_misconduct", 
    category = "items",
    title = NTGuide.Localize("ntg.title.medical_misconduct"), 
    description = NTGuide.Localize("ntg.description.medical_misconduct"), 
}

-- Surgery Plus Settings
local ModSettings = {
	NTG_Settings_NTSurgeryPlus = { 
        type = "category",
        name = NTGuide.Localize("ntg.categoryname.surgeryplus"),
    },

	NTG_ModColour_NTSurgeryPlus = { 
		type = "string",
		name = NTGuide.Localize("ntg.settingname.modcoloursurgeryplus"),
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