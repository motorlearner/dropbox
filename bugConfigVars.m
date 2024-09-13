classdef bugConfigVars < bug
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function go(WL) 
            delete('save.mat');
            WL.run('save_file', 'save', 'config_file', 'cfgConfigVars')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function exitreport(WL)
            disp('WL.Trial:');
            disp(rmfield(WL.Trial, setdiff(fieldnames(WL.Trial), WL.cfg.varnames)));
            disp('WL.cfg.TrialData_Single:');
            disp(WL.cfg.TrialData_Single(:, {WL.cfg.varnames{:}}));
            disp('WL.TrialData:');
            disp(WL.TrialData(:, WL.cfg.varnames));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end