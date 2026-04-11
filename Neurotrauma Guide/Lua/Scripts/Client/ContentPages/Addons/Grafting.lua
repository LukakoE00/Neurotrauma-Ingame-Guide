-- Neurotrauma: Grafting Additions

-- Tools
-- DNA Litigation Enhancer (Med50)
NTGuide.ContentPages.Items.DNALitigationEnhancer = {
    mod = "NT: Grafting",
    id = "dna_litigation_enhancer",
    category = "items",
    title = NTGuide.Localize("ntg.title.dna_litigation_enhancer"), 
    description = NTGuide.Localize("ntg.description.dna_litigation_enhancer"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.dna_litigation_enhancer")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.dna_litigation_enhancer")},
    effects = {NTGuide.Localize("ntg.effects.dna_litigation_enhancer")},
}

-- DNA Splicer (Med50)
NTGuide.ContentPages.Items.DNASplicer = {
    mod = "NT: Grafting",
    id = "dna_splicer",
    category = "items",
    title = NTGuide.Localize("ntg.title.dna_splicer"), 
    description = NTGuide.Localize("ntg.description.dna_splicer"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.dna_splicer")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.dna_splicer")},
    effects = {NTGuide.Localize("ntg.effects.dna_splicer")},
}

-- Alien Scalpel (Med30)
NTGuide.ContentPages.Items.AlienScalpel = {
    mod = "NT: Grafting",
    id = "alien_scalpel",
    category = "items",
    title = NTGuide.Localize("ntg.title.alien_scalpel"), 
    description = NTGuide.Localize("ntg.description.alien_scalpel"),
    applicationsuccess = {NTGuide.Localize("ntg.applicationsuccess.alien_scalpel")},
    applicationfailed = {NTGuide.Localize("ntg.applicationfailed.alien_scalpel")},
}

-- Alien Incubator
NTGuide.ContentPages.Items.AlienIncubator = {
    mod = "NT: Grafting",
    id = "alien_incubator",
    category = "items",
    title = NTGuide.Localize("ntg.title.alien_incubator"), 
    description = NTGuide.Localize("ntg.description.alien_incubator"),
    seealso = {NTGuide.Localize("ntg.seealso.alien_incubator")},
}

-- Stem Cells
NTGuide.ContentPages.Items.StemCells = {
    mod = "NT: Grafting",
    id = "stem_cells",
    category = "items",
    title = NTGuide.Localize("ntg.title.stem_cells"), 
    description = NTGuide.Localize("ntg.description.stem_cells"),
    seealso = {NTGuide.Localize("ntg.seealso.stem_cells")},
}

-- Procedures 
-- Crawler Tail Grafting
NTGuide.ContentPages.SurgicalProcedures.CrawlerTailGrafting = {
    mod = "NT: Grafting",
    id = "crawler_tail_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.crawler_tail_grafting"), 
    description = NTGuide.Localize("ntg.description.crawler_tail_grafting"),
    steps = {NTGuide.Localize("ntg.steps.crawler_tail_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.crawler_tail_grafting")},
}

-- Crawler Lungs Grafting
NTGuide.ContentPages.SurgicalProcedures.CrawlerLungGrafting = {
    mod = "NT: Grafting",
    id = "crawler_lung_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.crawler_lung_grafting"), 
    description = NTGuide.Localize("ntg.description.crawler_lung_grafting"),
    steps = {NTGuide.Localize("ntg.steps.crawler_lung_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.crawler_lung_grafting")},
}


-- -- Fractal Guardian Eye Grafting // NT EYES ENABLED
-- NTGuide.ContentPages.SurgicalProcedures.FractalEyeGrafting = {
--     id = "fractal_eye_grafting",
--     category = "grafting",
--     title = NTGuide.Localize("ntg.title.fractal_eye_grafting_nte"), 
--     description = NTGuide.Localize("ntg.description.fractal_eye_grafting_nte"),
-- }

    -- Fractal Guardian Eye Grafting // NT EYES DISABLED
NTGuide.ContentPages.SurgicalProcedures.FractalEyeGrafting = {
    mod = "NT: Grafting",
    id = "fractal_eye_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.fractal_eye_grafting"), 
    description = NTGuide.Localize("ntg.description.fractal_eye_grafting"),
    steps = {NTGuide.Localize("ntg.steps.fractal_eye_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.fractal_eye_grafting")},
}

-- Husk Arm Grafting
NTGuide.ContentPages.SurgicalProcedures.HuskArmGrafting = {
    mod = "NT: Grafting",
    id = "husk_arm_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.husk_arm_grafting"), 
    description = NTGuide.Localize("ntg.description.husk_arm_grafting"),
    steps = {NTGuide.Localize("ntg.steps.husk_arm_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.husk_arm_grafting")},
}

-- Husk Heart Grafting
NTGuide.ContentPages.SurgicalProcedures.HuskHeartGrafting = {
    mod = "NT: Grafting",
    id = "husk_heart_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.husk_heart_grafting"), 
    description = NTGuide.Localize("ntg.description.husk_heart_grafting"),
    steps = {NTGuide.Localize("ntg.steps.husk_heart_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.husk_heart_grafting")},
}

-- Mantis Liver Grafting
NTGuide.ContentPages.SurgicalProcedures.MantisLiverGrafting = {
    mod = "NT: Grafting",
    id = "mantis_liver_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.mantis_liver_grafting"), 
    description = NTGuide.Localize("ntg.description.mantis_liver_grafting"),
    steps = {NTGuide.Localize("ntg.steps.mantis_liver_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.mantis_liver_grafting")},
}

-- Mudraptor Lungs Grafting
NTGuide.ContentPages.SurgicalProcedures.MudraptorLungsGrafting = {
    mod = "NT: Grafting",
    id = "mudraptor_lungs_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.mudraptor_lungs_grafting"), 
    description = NTGuide.Localize("ntg.description.mudraptor_lungs_grafting"),
    steps = {NTGuide.Localize("ntg.steps.mudraptor_lungs_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.mudraptor_lungs_grafting")},
}

-- Mudraptor Head Grafting
NTGuide.ContentPages.SurgicalProcedures.MudraptorHeadGrafting = {
    mod = "NT: Grafting",
    id = "mudraptor_head_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.mudraptor_head_grafting"), 
    description = NTGuide.Localize("ntg.description.mudraptor_head_grafting"),
    steps = {NTGuide.Localize("ntg.steps.mudraptor_head_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.mudraptor_head_grafting")},
}

-- Broodmother Liver Grafting
NTGuide.ContentPages.SurgicalProcedures.BroodmotherLiverGrafting = {
    mod = "NT: Grafting",
    id = "broodmother_liver_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.broodmother_liver_grafting"), 
    description = NTGuide.Localize("ntg.description.broodmother_liver_grafting"),
    steps = {NTGuide.Localize("ntg.steps.broodmother_liver_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.broodmother_liver_grafting")},
}

-- Tiger Thresher Jaw Grafting
NTGuide.ContentPages.SurgicalProcedures.TigerThresherJawGrafting = {
    mod = "NT: Grafting",
    id = "tthresher_jaw_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.tthresher_jaw_grafting"), 
    description = NTGuide.Localize("ntg.description.tthresher_jaw_grafting"),
    steps = {NTGuide.Localize("ntg.steps.tthresher_jaw_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.tthresher_jaw_grafting")},
}

-- Tiger Thresher Tail Grafting
NTGuide.ContentPages.SurgicalProcedures.TigerThresherTailGrafting = {
    mod = "NT: Grafting",
    id = "tthresher_tail_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.tthresher_tail_grafting"), 
    description = NTGuide.Localize("ntg.description.tthresher_tail_grafting"),
    steps = {NTGuide.Localize("ntg.steps.tthresher_tail_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.tthresher_tail_grafting")},
}

-- Bone Thresher Jaw Grafting
NTGuide.ContentPages.SurgicalProcedures.BoneThresherJawGrafting = {
    mod = "NT: Grafting",
    id = "bthresher_tail_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.bthresher_tail_grafting"), 
    description = NTGuide.Localize("ntg.description.bthresher_tail_grafting"),
    steps = {NTGuide.Localize("ntg.steps.bthresher_tail_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.bthresher_tail_grafting")},
}

-- Hammerhead Skin Grafting
NTGuide.ContentPages.SurgicalProcedures.HammerheadSkinGrafting = {
    mod = "NT: Grafting",
    id = "hammerhead_skin_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.hammerhead_skin_grafting"), 
    description = NTGuide.Localize("ntg.description.hammerhead_skin_grafting"),
    steps = {NTGuide.Localize("ntg.steps.hammerhead_skin_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.hammerhead_skin_grafting")},
}

-- Hammerhead Limb Grafting
NTGuide.ContentPages.SurgicalProcedures.HammerheadLimbGrafting = {
    mod = "NT: Grafting",
    id = "hammerhead_limb_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.hammerhead_limb_grafting"), 
    description = NTGuide.Localize("ntg.description.hammerhead_limb_grafting"),
    steps = {NTGuide.Localize("ntg.steps.hammerhead_limb_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.hammerhead_limb_grafting")},
}

-- Moloch Shell Grafting
NTGuide.ContentPages.SurgicalProcedures.MolochShellGrafting = {
    mod = "NT: Grafting",
    id = "moloch_shell_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.moloch_shell_grafting"), 
    description = NTGuide.Localize("ntg.description.moloch_shell_grafting"),
    steps = {NTGuide.Localize("ntg.steps.moloch_shell_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.moloch_shell_grafting")},
}

-- Viperling Liver Grafting
NTGuide.ContentPages.SurgicalProcedures.ViperlingLiverGrafting = {
    mod = "NT: Grafting",
    id = "viperling_liver_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.viperling_liver_grafting"), 
    description = NTGuide.Localize("ntg.description.viperling_liver_grafting"),
    steps = {NTGuide.Localize("ntg.steps.viperling_liver_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.viperling_liver_grafting")},
}


-- -- Watcher Eye Grafting // NT EYES ENABLED
-- NTGuide.ContentPages.SurgicalProcedures.WatcherEyeGrafting = {
--     id = "watcher_eye_grafting",
--     category = "grafting",
--     title = NTGuide.Localize("ntg.title.watcher_eye_grafting_nte"), 
--     description = NTGuide.Localize("ntg.description.watcher_eye_grafting_nte"),
-- }

-- Watcher Eye Grafting // NT EYES DISABLED
NTGuide.ContentPages.SurgicalProcedures.WatcherEyeGrafting = {
    mod = "NT: Grafting",
    id = "watcher_eye_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.watcher_eye_grafting"), 
    description = NTGuide.Localize("ntg.description.watcher_eye_grafting"),
    steps = {NTGuide.Localize("ntg.steps.watcher_eye_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.watcher_eye_grafting")},
}


-- Charybdis Jaw Grafting
NTGuide.ContentPages.SurgicalProcedures.CharybdisJawGrafting = {
    mod = "NT: Grafting",
    id = "charybdis_jaw_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.charybdis_jaw_grafting"), 
    description = NTGuide.Localize("ntg.description.charybdis_jaw_grafting"),
    steps = {NTGuide.Localize("ntg.steps.charybdis_jaw_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.charybdis_jaw_grafting")},
}

-- Latcher Heart Grafting
NTGuide.ContentPages.SurgicalProcedures.LatcherHeartGrafting = {
    mod = "NT: Grafting",
    id = "latcher_heart_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.latcher_heart_grafting"), 
    description = NTGuide.Localize("ntg.description.latcher_heart_grafting"),
    steps = {NTGuide.Localize("ntg.steps.latcher_heart_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.latcher_heart_grafting")},
}

-- Latcher Tongue Grafting
NTGuide.ContentPages.SurgicalProcedures.LatcherTongueGrafting = {
    mod = "NT: Grafting",
    id = "latcher_tongue_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.latcher_tongue_grafting"), 
    description = NTGuide.Localize("ntg.description.latcher_tongue_grafting"),
    steps = {NTGuide.Localize("ntg.steps.latcher_tongue_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.latcher_tongue_grafting")},
}

-- Endworm Skin Graft
NTGuide.ContentPages.SurgicalProcedures.EndwormSkinGrafting = {
    mod = "NT: Grafting",
    id = "endworm_skin_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.endworm_skin_grafting"), 
    description = NTGuide.Localize("ntg.description.endworm_skin_grafting"),
    steps = {NTGuide.Localize("ntg.steps.endworm_skin_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.endworm_skin_grafting")},
}

-- Orangeboy Tail Grafting
NTGuide.ContentPages.SurgicalProcedures.OrangeboyTailGrafting = {
    mod = "NT: Grafting",
    id = "orangeboy_tail_grafting",
    category = "grafting",
    title = NTGuide.Localize("ntg.title.orangeboy_tail_grafting"), 
    description = NTGuide.Localize("ntg.description.orangeboy_tail_grafting"),
    steps = {NTGuide.Localize("ntg.steps.orangeboy_tail_grafting")},
    seealso = {NTGuide.Localize("ntg.seealso.orangeboy_tail_grafting")},
}

-- General Information

-- Obtaining Graft Transplants
NTGuide.ContentPages.Information.ObtainingGraftingTransplants = {
    mod = "NT: Grafting",
    id = "information_obtaining_grafting_transplants",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_obtaining_grafting_transplants"), 
    description = NTGuide.Localize("ntg.description.information_obtaining_grafting_transplants"),
    seealso = {NTGuide.Localize("ntg.seealso.information_obtaining_grafting_transplants")},
}

-- Repairing Cracked Moloch Shell
NTGuide.ContentPages.Information.RepairingMolochShell = {
    mod = "NT: Grafting",
    id = "information_repairing_moloch_shell",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_repairing_moloch_shell"), 
    description = NTGuide.Localize("ntg.description.information_repairing_moloch_shell"),
    seealso = {NTGuide.Localize("ntg.seealso.information_repairing_moloch_shell")},
}

-- Aiming Latcher Tongue
NTGuide.ContentPages.Information.AimLatcherTongue = {
    mod = "NT: Grafting",
    id = "information_aim_latcher_tongue",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_aim_latcher_tongue"), 
    description = NTGuide.Localize("ntg.description.information_aim_latcher_tongue"),
    seealso = {NTGuide.Localize("ntg.seealso.information_aim_latcher_tongue")},
}

-- Removing Grafting Limit
NTGuide.ContentPages.Information.RemoveGraftingLimit = {
    mod = "NT: Grafting",
    id = "information_remove_grafting_limit",
    category = "information",
    title = NTGuide.Localize("ntg.title.information_remove_grafting_limit"), 
    description = NTGuide.Localize("ntg.description.information_remove_grafting_limit"),
}

-- Grafting Settings
local ModSettings = {
	NTG_Settings_NTGrafting = { 
        type = "category",
        name = NTGuide.Localize("ntg.categoryname.grafting"),
    },

	NTG_ModColour_NTGrafting = { 
		type = "string",
		name = NTGuide.Localize("ntg.settingname.modcolourgrafting"),
		default = {"165", "22", "166"},
		style = "R,G,B",
		boxsize = 0.05,
        isColour = true,
        reset = false,
	},
}

for key, entry in pairs(ModSettings) do
    NTGuideSettings.ConfigData[key] = entry
end