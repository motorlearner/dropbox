function cfgConfigVars(WL, ~)
    WL.overide_cfg_defaults();
    
    WL.cfg.MouseFlag = true;
    WL.cfg.SmallScreen = true;
    WL.cfg.SmallScreenScale = 0.6;
    WL.cfg.TrialDurationTime = 0.5;
    nTrials = 2;

    k = 2;
    
    DummyBlock.Trial.DummyVar = 1:nTrials;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % scalar
    DummyBlock.Trial.ScalarVar1 = [ 1, 2 ];           % works
    WL.cfg.ScalarVar2 = { 1, 2 };                     % works
    DummyBlock.Trial.Index.ScalarVar2 = 1:nTrials;    
    
    % vector
    % DummyBlock.Trial.VectorVar1 = { 1:k, 1:k };       % error
    % WL.cfg.VectorVar2 = { 1:k, 1:k };                 % error
    % DummyBlock.Trial.Index.VectorVar2 = 1:nTrials;
    
    % matrix
    DummyBlock.Trial.MatrixVar1 = { zeros(k,k), zeros(k,k) }; % works
    WL.cfg.MatrixVar2 = { zeros(k,k), zeros(k,k) };           % works              
    DummyBlock.Trial.Index.MatrixVar2 = 1:nTrials;

    % struct
    for i=1:nTrials
        Wl.cfg.StructVar{i}.StructScalarVar = i;
        WL.cfg.StructVar{i}.StructVectorVar = ones(1,2) * i;
        WL.cfg.StructVar{i}.StructMatrixVar = ones(2,2) * i;
    end
    DummyBlock.Trial.Index.StructVar = 1:nTrials;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    directVars = fieldnames(DummyBlock.Trial)';
    indexVars  = fieldnames(DummyBlock.Trial.Index)';
    structVars = {};
    if isfield(WL.cfg, 'StructVar')
        structVars = fieldnames(WL.cfg.StructVar{1})';
    end
    varnames = [ directVars, indexVars, structVars ]; 
    WL.cfg.varnames = setdiff(varnames, {'DummyVar', 'Index', 'StructVar'}, 'stable');

    A = WL.parse_trials(DummyBlock);
    WL.TrialData = parse_tree(A);
end













