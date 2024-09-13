classdef bug < wl_experiment
    % no additional props (global vars are added to WL.var)
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % print stuff once when starting trial
        function report(WL)
            wl_printf('exp', 'TRIAL STARTING: %i \n', WL.TrialNumber);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function computeTrial(WL)
        % compute something for current trial
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function addToTrial(WL)
        % add variables to WL.Trial for saving
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function exitreport(WL)
        % print stuff on exit
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % wrapper to run without gui
        function go(WL) 
            delete('save.mat');
            WL.run('save_file', 'save', 'config_file', 'cfg')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function run(WL,varargin)
            try
                WL.GUI = wl_gui('save', 'config', '', varargin{:});
                if ~WL.initialise()
                    error('WL.initialise() failed.')
                end
                WL.Robot = WL.robot(WL.cfg.RobotName);
                WL.Hardware = wl_hardware(WL.Robot);
                if WL.Hardware.Start()
                    WL.main_loop();
                end
                WL.Hardware.Stop();
            catch msg
                wl_printf('error', '\nCatching error. Exit report:\n\n');
                try
                    WL.exitreport();
                catch trash
                    disp(trash);
                end
                WL.close(msg);
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function initialise_func(WL,varargin)

            WL.state_init('INIT', 'SETUP', 'TRIAL', 'EXIT', 'REST');
            WL.Timer.TrialDurationTimer = wl_timer;
            WL.var.report = true;

        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function display_func(WL,win)
            global GL
            Screen('BeginOpenGL',win)

            txt = sprintf('Trial %i', WL.TrialNumber);
            WL.draw_text(txt, [ 0 0 0 ], 'Scale', 1, 'Center', 0);

            Screen('EndOpenGL',win)
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function state_process_func(WL)

            switch WL.State.Current
                case WL.State.INIT
                    WL.state_next(WL.State.SETUP);
                case WL.State.SETUP
                    WL.trial_setup();
                    WL.computeTrial();
                    WL.var.report = true;
                    WL.Timer.TrialDurationTimer.Reset();
                    WL.trial_start();
                    WL.state_next(WL.State.TRIAL);
                case WL.State.TRIAL
                    if WL.var.report
                        WL.report();
                        WL.var.report = false;
                    end
                    if WL.Timer.TrialDurationTimer.GetTime() > WL.cfg.TrialDurationTime
                        WL.addToTrial();
                        WL.trial_stop();
                        WL.trial_save();
                        if WL.trial_next()
                            WL.state_next(WL.State.SETUP);
                        else
                            WL.state_next(WL.State.EXIT);
                        end
                    end
                case WL.State.EXIT
                    wl_printf('success', '\nAll good. Exit report:\n\n');
                    WL.exitreport();
                    WL.cfg.ExitFlag = true;
            end

        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function trial_start_func(WL)
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function miss_trial_func(WL,MissTrialType)
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function flip_func(WL)
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function keyboard_func(WL,keyname)          
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function idle_func(WL)
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
