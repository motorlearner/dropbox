function config(WL, ~)
    WL.overide_cfg_defaults();
    
    WL.cfg.MouseFlag = true;
    WL.cfg.SmallScreen = true;
    WL.cfg.SmallScreenScale = 0.6;
    WL.cfg.TrialDurationTime = 0.5;
    nTrials = 2;
    
    DummyBlock.Trial.DummyVar = 1:nTrials;

    WL.TrialData = parse_tree(WL.parse_trials(DummyBlock));
end