-- Neurotrauma: Infections Additions 
-- Information Pages
-- How the new infections work
NTGuide.ContentPages.Information.InfectionChanges = {
    mod = "NT: Infections",
    id = "information_infection_changes",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_infection_changes"), 
    description = NTGuide.Localize("ntg.description.information_infection_changes"),
    seealso = {NTGuide.Localize("ntg.seealso.information_infection_changes")},
}

-- Fighting off infections
NTGuide.ContentPages.Information.FightingInfections = {
    mod = "NT: Infections",
    id = "information_fighting_infections",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_fighting_infections"), 
    description = NTGuide.Localize("ntg.description.information_fighting_infections"),
    seealso = {NTGuide.Localize("ntg.seealso.information_fighting_infections")},
}

-- Using Antibiotics
NTGuide.ContentPages.Information.UsingAntibiotics = {
    mod = "NT: Infections",
    id = "information_using_antibiotics",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_using_antibiotics"), 
    description = NTGuide.Localize("ntg.description.information_using_antibiotics"),
    seealso = {NTGuide.Localize("ntg.seealso.information_using_antibiotics")},
}

-- Diagnosing Bacterial Infections
NTGuide.ContentPages.Information.DiagnosingBacterialInfections = {
    mod = "NT: Infections",
    id = "information_diagnosing_bacteria",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_diagnosing_bacteria"), 
    description = NTGuide.Localize("ntg.description.information_diagnosing_bacteria"),
    seealso = {NTGuide.Localize("ntg.seealso.information_diagnosing_bacteria")},
}


    -- Communicable diseases (NTSP)
    NTGuide.ContentPages.Information.DiagnosingViralInfections = {
        mod = "NT: Infections",
        id = "information_diagnosing_viruses",
        category = "information",
        title = NTGuide.Localize("ntg.title.information_diagnosing_viruses_ntsp"), 
        description = NTGuide.Localize("ntg.description.information_diagnosing_viruses_ntsp"),
        seealso = {NTGuide.Localize("ntg.seealso.information_diagnosing_viruses_ntsp")},
    }

    -- -- Communicable diseases (No NTSP)
    -- NTGuide.ContentPages.Information.DiagnosingViralInfections = {
    --     id = "information_diagnosing_viruses",
    --     category = "information",
    --     title = NTGuide.Localize("ntg.title.information_diagnosing_viruses"), 
    --     description = NTGuide.Localize("ntg.description.information_diagnosing_viruses"),
    --     seealso = {NTGuide.Localize("ntg.seealso.information_diagnosing_viruses")},
    -- }


-- Vaccines
NTGuide.ContentPages.Information.VaccinesInformation = {
    mod = "NT: Infections",
    id = "information_vaccines",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_vaccines"), 
    description = NTGuide.Localize("ntg.description.information_vaccines"),
    seealso = {NTGuide.Localize("ntg.seealso.information_vaccines")},
}

-- UPDATE ABX

-- Bacterial Infections
-- Streptococcal Infection
NTGuide.ContentPages.Afflictions_AnyBodypart.StreptococcalInfection = {
    mod = "NT: Infections",
    id = "streptococcal_infection",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.streptococcal_infection"), 
    description = NTGuide.Localize("ntg.description.streptococcal_infection"),
    susceptible = {NTGuide.Localize("ntg.susceptible.streptococcal_infection")},
    effects = {NTGuide.Localize("ntg.effects.streptococcal_infection")},
    seealso = {NTGuide.Localize("ntg.seealso.streptococcal_infection")},
}

-- Staphylococcal Infection
NTGuide.ContentPages.Afflictions_AnyBodypart.StaphylococcalInfection = {
    mod = "NT: Infections",
    id = "staphylococcal_infection",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.staphylococcal_infection"), 
    description = NTGuide.Localize("ntg.description.staphylococcal_infection"),
    susceptible = {NTGuide.Localize("ntg.susceptible.staphylococcal_infection")},
    effects = {NTGuide.Localize("ntg.effects.staphylococcal_infection")},
    seealso = {NTGuide.Localize("ntg.seealso.staphylococcal_infection")},
}

-- MRSA Infection
NTGuide.ContentPages.Afflictions_AnyBodypart.MRSAInfection = {
    mod = "NT: Infections",
    id = "mrsa_infection",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.mrsa_infection"), 
    description = NTGuide.Localize("ntg.description.mrsa_infection"),
    requirements = {NTGuide.Localize("ntg.requirements.mrsa_infection")},
    susceptible = {NTGuide.Localize("ntg.susceptible.mrsa_infection")},
    effects = {NTGuide.Localize("ntg.effects.mrsa_infection")},
    seealso = {NTGuide.Localize("ntg.seealso.mrsa_infection")},
}

-- Pseudomonas Infection
NTGuide.ContentPages.Afflictions_AnyBodypart.PseudomonasInfection = {
    mod = "NT: Infections",
    id = "pseudomonas_infection",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.pseudomonas_infection"), 
    description = NTGuide.Localize("ntg.description.pseudomonas_infection"),
    susceptible = {NTGuide.Localize("ntg.susceptible.pseudomonas_infection")},
    effects = {NTGuide.Localize("ntg.effects.pseudomonas_infection")},
    seealso = {NTGuide.Localize("ntg.seealso.pseudomonas_infection")},
}

-- Provobacter Infection
NTGuide.ContentPages.Afflictions_AnyBodypart.ProvobacterInfection = {
    mod = "NT: Infections",
    id = "provobacter_infection",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.provobacter_infection"), 
    description = NTGuide.Localize("ntg.description.provobacter_infection"),
    susceptible = {NTGuide.Localize("ntg.susceptible.provobacter_infection")},
    effects = {NTGuide.Localize("ntg.effects.provobacter_infection")},
    seealso = {NTGuide.Localize("ntg.seealso.provobacter_infection")},
}

-- Aeroganella Infection
NTGuide.ContentPages.Afflictions_AnyBodypart.AeroganellaInfection = {
    mod = "NT: Infections",
    id = "aeroganella_infection",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.aeroganella_infection"), 
    description = NTGuide.Localize("ntg.description.aeroganella_infection"),
    susceptible = {NTGuide.Localize("ntg.susceptible.aeroganella_infection")},
    effects = {NTGuide.Localize("ntg.effects.aeroganella_infection")},
    seealso = {NTGuide.Localize("ntg.seealso.aeroganella_infection")},
}

-- Antibiotics
-- Unasyn
NTGuide.ContentPages.Items.Unasyn = {
    mod = "NT: Infections",
    id = "unasyn",
    category = "items",
    title = NTGuide.Localize("ntg.title.unasyn"), 
    description = NTGuide.Localize("ntg.description.unasyn"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.unasyn")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.unasyn")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.unasyn")},
    seealso = {NTGuide.Localize("ntg.seealso.unasyn")},
}

-- Augmentin
NTGuide.ContentPages.Items.Augmentin = {
    mod = "NT: Infections",
    id = "augmentin",
    category = "items",
    title = NTGuide.Localize("ntg.title.augmentin"), 
    description = NTGuide.Localize("ntg.description.augmentin"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.augmentin")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.augmentin")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.augmentin")},
    seealso = {NTGuide.Localize("ntg.seealso.augmentin")},
}

-- Vancomycin
NTGuide.ContentPages.Items.Vancomycin = {
    mod = "NT: Infections",
    id = "vancomycin",
    category = "items",
    title = NTGuide.Localize("ntg.title.vancomycin"), 
    description = NTGuide.Localize("ntg.description.vancomycin"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.vancomycin")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.vancomycin")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.vancomycin")},
    seealso = {NTGuide.Localize("ntg.seealso.vancomycin")},
}

-- Gentamicin
NTGuide.ContentPages.Items.Gentamicin = {
    mod = "NT: Infections",
    id = "gentamicin",
    category = "items",
    title = NTGuide.Localize("ntg.title.gentamicin"), 
    description = NTGuide.Localize("ntg.description.gentamicin"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.gentamicin")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.gentamicin")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.gentamicin")},
    seealso = {NTGuide.Localize("ntg.seealso.gentamicin")},
}

-- Co-trimoxazole
NTGuide.ContentPages.Items.Cotrimoxazole = {
    mod = "NT: Infections",
    id = "cotrimoxazole",
    category = "items",
    title = NTGuide.Localize("ntg.title.cotrimoxazole"), 
    description = NTGuide.Localize("ntg.description.cotrimoxazole"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.cotrimoxazole")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.cotrimoxazole")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.cotrimoxazole")},
    seealso = {NTGuide.Localize("ntg.seealso.cotrimoxazole")},
}

-- Primaxin
NTGuide.ContentPages.Items.Primaxin = {
    mod = "NT: Infections",
    id = "primaxin",
    category = "items",
    title = NTGuide.Localize("ntg.title.primaxin"), 
    description = NTGuide.Localize("ntg.description.primaxin"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.primaxin")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.primaxin")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.primaxin")},
    seealso = {NTGuide.Localize("ntg.seealso.primaxin")},
}

-- Ceftazidime
NTGuide.ContentPages.Items.Ceftazidime = {
    mod = "NT: Infections",
    id = "ceftazidime",
    category = "items",
    title = NTGuide.Localize("ntg.title.ceftazidime"), 
    description = NTGuide.Localize("ntg.description.ceftazidime"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.ceftazidime")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.ceftazidime")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.ceftazidime")},
    seealso = {NTGuide.Localize("ntg.seealso.ceftazidime")},
}

-- Tools 
-- Sampler Tool
NTGuide.ContentPages.Items.SamplerTool = {
    mod = "NT: Infections",
    id = "sampler_tool",
    category = "items",
    title = NTGuide.Localize("ntg.title.sampler_tool"), 
    description = NTGuide.Localize("ntg.description.sampler_tool"),
    seealso = {NTGuide.Localize("ntg.seealso.sampler_tool")},
}

-- Culture Tube
NTGuide.ContentPages.Items.CultureTube = {
    mod = "NT: Infections",
    id = "culture_tube",
    category = "items",
    title = NTGuide.Localize("ntg.title.culture_tube"), 
    description = NTGuide.Localize("ntg.description.culture_tube"),
    seealso = {NTGuide.Localize("ntg.seealso.culture_tube")},
}

-- Viral Transport Medium
NTGuide.ContentPages.Items.ViralTransportMedium = {
    mod = "NT: Infections",
    id = "viral_transport_medium",
    category = "items",
    title = NTGuide.Localize("ntg.title.viral_transport_medium"), 
    description = NTGuide.Localize("ntg.description.viral_transport_medium"),
    seealso = {NTGuide.Localize("ntg.seealso.viral_transport_medium")},
}

-- Sample Analyzer
NTGuide.ContentPages.Items.SampleAnalyzer = {
    mod = "NT: Infections",
    id = "sample_analyzer",
    category = "items",
    title = NTGuide.Localize("ntg.title.sample_analyzer"), 
    description = NTGuide.Localize("ntg.description.sample_analyzer"),
    seealso = {NTGuide.Localize("ntg.seealso.sample_analyzer")},
}

-- Symptoms
-- Purulent Drainage
NTGuide.ContentPages.Afflictions_AnyBodypart.PurulentDrainage = {
    mod = "NT: Infections",
    id = "purulent_drainage",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.purulent_drainage"), 
    description = NTGuide.Localize("ntg.description.purulent_drainage"),
    requirements = {NTGuide.Localize("ntg.requirements.purulent_drainage")},
    possiblecauses = {NTGuide.Localize("ntg.possiblecauses.purulent_drainage")},
    seealso = {NTGuide.Localize("ntg.seealso.purulent_drainage")},
}

-- Abscess
NTGuide.ContentPages.Afflictions_AnyBodypart.Abscess = {
    mod = "NT: Infections",
    id = "abscess",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.abscess"), 
    description = NTGuide.Localize("ntg.description.abscess"),
    requirements = {NTGuide.Localize("ntg.requirements.abscess")},
    possiblecauses = {NTGuide.Localize("ntg.possiblecauses.abscess")},
    seealso = {NTGuide.Localize("ntg.seealso.abscess")},
}

-- Inflammation [BASE OVERRIDE, ADDENDUM: NT Infections]
NTGuide.ContentPages.Symptoms.Inflammation = {
    mod = "NT: Infections",
    id = "inflammation", 
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.inflammation_infc"), 
    description = NTGuide.Localize("ntg.description.inflammation_infc"), 
    causes = {NTGuide.Localize("ntg.causes.inflammation_infc")},
    treatments = {NTGuide.Localize("ntg.treatments.inflammation_infc")},
}

-- Diseases
-- Necrotizing Fasciitis
NTGuide.ContentPages.Afflictions_AnyBodypart.NectrotizingFasciitis = {
    mod = "NT: Infections",
    id = "necrotizing_fasciitis",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.necrotizing_fasciitis"), 
    description = NTGuide.Localize("ntg.description.necrotizing_fasciitis"),
    requirements = {NTGuide.Localize("ntg.requirements.necrotizing_fasciitis")},
    treatments = {NTGuide.Localize("ntg.treatments.necrotizing_fasciitis")},
    effects = {NTGuide.Localize("ntg.effects.necrotizing_fasciitis")},
}

-- Pneumonia
NTGuide.ContentPages.Afflictions_Lungs.Pneumonia = {
    mod = "NT: Infections",
    id = "pneumonia",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.pneumonia"), 
    description = NTGuide.Localize("ntg.description.pneumonia"),
    requirements = {NTGuide.Localize("ntg.requirements.pneumonia")},
    treatments = {NTGuide.Localize("ntg.treatments.pneumonia")},
    effects = {NTGuide.Localize("ntg.effects.pneumonia")},
}

-- Viral Infections
-- Europan Cough
NTGuide.ContentPages.Afflictions_HeadORBrain.EuropanCough = {
    mod = "NT: Infections",
    id = "europan_cough",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.europan_cough"), 
    description = NTGuide.Localize("ntg.description.europan_cough"),
    susceptible = {NTGuide.Localize("ntg.susceptible.europan_cough")},
    treatments = {NTGuide.Localize("ntg.treatments.europan_cough")},
    effects = {NTGuide.Localize("ntg.effects.europan_cough")},
    seealso = {NTGuide.Localize("ntg.seealso.europan_cough")},
}

-- Influenza
NTGuide.ContentPages.Afflictions_HeadORBrain.Influenza = {
    mod = "NT: Infections",
    id = "influenza",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.influenza"), 
    description = NTGuide.Localize("ntg.description.influenza"),
    susceptible = {NTGuide.Localize("ntg.susceptible.influenza")},
    treatments = {NTGuide.Localize("ntg.treatments.influenza")},
    effects = {NTGuide.Localize("ntg.effects.influenza")},
    seealso = {NTGuide.Localize("ntg.seealso.influenza")},
}

-- Common Cold
NTGuide.ContentPages.Afflictions_HeadORBrain.CommonCold = {
    mod = "NT: Infections",
    id = "common_cold",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.common_cold"), 
    description = NTGuide.Localize("ntg.description.common_cold"),
    susceptible = {NTGuide.Localize("ntg.susceptible.common_cold")},
    effects = {NTGuide.Localize("ntg.effects.common_cold")},
    treatments = {NTGuide.Localize("ntg.treatments.common_cold")},
    seealso = {NTGuide.Localize("ntg.seealso.common_cold")},
}

-- Effects
-- Methicillin-resistance risk
NTGuide.ContentPages.Afflictions_Torso.MethicillinResistanceRisk = {
    mod = "NT: Infections",
    id = "methicillin_resistance_risk",
    category = "afflictions",
    title = NTGuide.Localize("ntg.title.methicillin_resistance_risk"), 
    description = NTGuide.Localize("ntg.description.methicillin_resistance_risk"),
    causes = {NTGuide.Localize("ntg.causes.methicillin_resistance_risk")},
    effects = {NTGuide.Localize("ntg.effects.methicillin_resistance_risk")},
    treatments = {NTGuide.Localize("ntg.treatments.methicillin_resistance_risk")},
}

-- Procedures
-- Debridement
NTGuide.ContentPages.SurgicalProcedures.Debridement = {
    mod = "NT: Infections",
    id = "debridement",
    category = "procedures",
    title = NTGuide.Localize("ntg.title.debridement"), 
    description = NTGuide.Localize("ntg.description.debridement"),
    steps = {NTGuide.Localize("ntg.steps.debridement")},
    seealso = {NTGuide.Localize("ntg.seealso.debridement")},
}

-- Sample Collection
NTGuide.ContentPages.SurgicalProcedures.SampleCollection = {
    mod = "NT: Infections",
    id = "sample_collection",
    category = "procedures",
    title = NTGuide.Localize("ntg.title.sample_collection"), 
    description = NTGuide.Localize("ntg.description.sample_collection"),
    stepsbacterial = {NTGuide.Localize("ntg.stepsbacterial.sample_collection")},
    stepsviral = {NTGuide.Localize("ntg.stepsviral.sample_collection")},
    seealso = {NTGuide.Localize("ntg.seealso.sample_collection")},
}

-- Other Items
-- Vaccines (Items)
NTGuide.ContentPages.Items.Vaccines = {
    mod = "NT: Infections",
    id = "vaccines",
    category = "items",
    title = NTGuide.Localize("ntg.title.vaccines"), 
    description = NTGuide.Localize("ntg.description.vaccines"),
    seealso = {NTGuide.Localize("ntg.seealso.vaccines")},
}

-- Weaponized Bacteria
NTGuide.ContentPages.Items.WeaponizedBacteria = {
    mod = "NT: Infections",
    id = "weaponized_bacteria",
    category = "items",
    title = NTGuide.Localize("ntg.title.weaponized_bacteria"), 
    description = NTGuide.Localize("ntg.description.weaponized_bacteria"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.weaponized_bacteria")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.weaponized_bacteria")},
    seealso = {NTGuide.Localize("ntg.seealso.weaponized_bacteria")},
}

-- Remdesivir
NTGuide.ContentPages.Items.Remdesivir = {
    mod = "NT: Infections",
    id = "remdesivir",
    category = "items",
    title = NTGuide.Localize("ntg.title.remdesivir"), 
    description = NTGuide.Localize("ntg.description.remdesivir"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.remdesivir")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.remdesivir")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.remdesivir")},
}

-- Dextromethorphan
NTGuide.ContentPages.Items.Dextromethorphan = {
    mod = "NT: Infections",
    id = "dextromethorphan",
    category = "items",
    title = NTGuide.Localize("ntg.title.dextromethorphan"), 
    description = NTGuide.Localize("ntg.description.dextromethorphan"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.dextromethorphan")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.dextromethorphan")},
    effects = {NTGuide.Localize("ntg.effects.dextromethorphan")},
}

-- Zinc Supplements
NTGuide.ContentPages.Items.ZincSupplements = {
    mod = "NT: Infections",
    id = "zinc_supplements",
    category = "items",
    title = NTGuide.Localize("ntg.title.zinc_supplements"), 
    description = NTGuide.Localize("ntg.description.zinc_supplements"),
    effectiveness = {NTGuide.Localize("ntg.effectiveness.zinc_supplements")},
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.zinc_supplements")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.zinc_supplements")},
    effects = {NTGuide.Localize("ntg.effects.zinc_supplements")},
}

-- Hydrocortisone / Corticosteroids
NTGuide.ContentPages.Items.Corticosteroids = {
    mod = "NT: Infections",
    id = "corticosteroids",
    category = "items",
    title = NTGuide.Localize("ntg.title.corticosteroids"), 
    description = NTGuide.Localize("ntg.description.corticosteroids"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.corticosteroids")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.corticosteroids")},
    effects = {NTGuide.Localize("ntg.effects.corticosteroids")},
}

-- Infections Settings
local ModSettings = {
	NTG_Settings_NTInfections = { 
        type = "category",
        name = NTGuide.Localize("ntg.categoryname.infections"),
    },

	NTG_ModColour_NTInfections = { 
		type = "string",
		name = NTGuide.Localize("ntg.settingname.modcolourinfections"),
		default = {"76", "112", "42"},
		style = "R,G,B",
		boxsize = 0.05,
        isColour = true,
        reset = false,
	},
}

for key, entry in pairs(ModSettings) do
    NTGuideSettings.ConfigData[key] = entry
end