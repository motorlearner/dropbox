classdef bugSaveTrialData < bug
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function go(WL) 
            delete('save.mat');
            WL.run('save_file', 'save', 'config_file', 'cfgSaveTrialData')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function exitreport(WL)
            fnames = fieldnames(WL.cfg.tosave);
            disp('WL.Trial:');
            disp(rmfield(WL.Trial, setdiff(fieldnames(WL.Trial), fnames)));
            disp('WL.cfg.TrialData_Single:');
            disp(WL.cfg.TrialData_Single(:, fnames));
            disp('WL.TrialData:');
            disp(WL.TrialData(:, fnames))
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function addToTrial(WL)
        varnames = fieldnames(WL.cfg.tosave);
        for i=1:numel(varnames)
            name = varnames{i};
            WL.Trial.(name) = WL.cfg.tosave.(name){WL.TrialNumber};
        end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end
end