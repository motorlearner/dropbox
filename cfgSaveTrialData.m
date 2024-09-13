function cfgConfigVars(WL, ~)
    WL.overide_cfg_defaults();
    
    WL.cfg.MouseFlag = true;
    WL.cfg.SmallScreen = true;
    WL.cfg.SmallScreenScale = 0.6;
    WL.cfg.TrialDurationTime = 0.5;
    nTrials = 2;
    
    DummyBlock.Trial.DummyVar = 1:nTrials;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Make WL.cfg.tosave subfields cell arrays of length nTrials.
    % On trial i, WL.Trial.Subfield = WL.cfg.tosave.Subfield{i} will be
    % written, and WL.trial_save will be called in an attempt to save the
    % data to WL.TrialData.

    % Comment out to try specific ones.

    % homogeneous types and sizes --- works
    WL.cfg.tosave.Scal = { 1, 2 };
    WL.cfg.tosave.Vec  = { 1:2, 2:3 };
    WL.cfg.tosave.Mat  = { ones(2,2), ones(3,3) };
    
    % heterogeneous sizes with scalars or vectors --- does not work 
    % WL.cfg.tosave.ScalVec = { 1, [1,2] };
    WL.cfg.tosave.VecVec  = { 1:2, 1:3 };

    % heterogeneous sizes for matrices --- works (bc they are in { })
    WL.cfg.tosave.MatMat = { ones(2,2), ones(3,3) };

    % heterogeneous types --- does not work
    % WL.cfg.tosave.ScalCell = { 1, {1}};

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    WL.TrialData = parse_tree(WL.parse_trials(DummyBlock));
end