classdef bugUseConfigVector < bug
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function go(WL) 
            delete('save.mat');
            WL.run('save_file', 'save', 'config_file', 'cfgUseConfigVector')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function exitreport(WL)
            disp(WL.TrialData(:, {'RowVector', 'ColVector'}));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function computeTrial(WL)
            disp(WL.Trial.RowVector); 
            disp(WL.Trial.ColVector);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    end
end