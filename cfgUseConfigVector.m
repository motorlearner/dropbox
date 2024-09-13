function cfgUseConfigVector(WL, ~)
    WL.overide_cfg_defaults();
    
    WL.cfg.SmallScreenScale = 0.6;
    WL.cfg.TrialDurationTime = 1;
    nTrials = 2;
    
    DummyBlock.Trial.DummyVar = 1:nTrials;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    DummyBlock.Trial.RowVector = { (1:3),  (1:3)  };
    DummyBlock.Trial.ColVector = { (1:3)', (1:3)' };

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    WL.TrialData = parse_tree(WL.parse_trials(DummyBlock));
end

% Note this assumes that wl_trial_save:103 reads
%       WL.cfg.TrialData_Single.(fn{k}){1} = shiftdim(tmp)';
% i.e. vectors are assigned back to cell. With that:
% 
% Due to wl_trial_setup:28-39, row vectors are converted to column vectors.
% Then in wl_trial_save:103, the combination of shiftdim + transpose
% ensures that vectors are row vectors. This seems confusing:
% 
% In my config vars, I may associated two dimensions with different things,
% e.g. if I have have N targets then a 3xN matrix could hold the position
% vectors (each naturally a column vector), and a 1xN matrix/rowvector
% could hold the sizes...i.e. to loop over targets, I'd always loop over
% columns. 
% 
% Currently, this would not be possible because everything 1xN is converted
% to Nx1 when loading the trial data. Later, everything Nx1 is converted to
% 1xN for writing to WL.TrialData (less problematic but still unexpected
% IMO). Is there a good reason for this? I'd prefer just preserving
% dimensions throughout.