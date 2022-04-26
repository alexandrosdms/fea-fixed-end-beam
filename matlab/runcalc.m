clc, clear, close all

addpath('utils')

% params = getBeamParams;
prompt_mode = sprintf(['Chose Mode for the Calculations:',...
                        '\nUser Mode :\t\t1',...
                        '\nAssignment Mode: \t2',...
                        '\n\nEnter your Option ~> ']);

prompt_sol = sprintf(['What is the desired solution?',...
                      '\nEuler\t\t: 1', ...
                      '\nShear Full\t: 2', ...
                      '\nShear Reduced\t: 3', ...
                      '\nAll\t\t: 4'...
                      '\n\nEnter your Option ~> ']);

persistent userMode, assignMode, sol;
while true
    prompt_mode;
    mode = input(prompt_mode);
    if mode == 1
        userMode = true;
        assignMode = false;
        fprintf('\nEntering User Mode...\n');
        while true
        prompt_sol;
        sol = input(prompt_sol);
        if sol == 1 || sol == 2 || sol == 3 || sol == 4
            break;
        else
            fprintf('\nERROR: %d is not a viable choice, try again.\n', sol);
        end
        end
        break;
    elseif mode == 2
        assignMode = true;
        userMode = false;
        fprintf('\nEntering Assignment Mode...\n');
        break;
    else
        fprintf('\nERROR: %d is not a viable choice, try again\n', mode);
    end

end
        


[L_h_ratio, w_midpoint, theta_midpoint] = calculations(sol)


