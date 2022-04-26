% Alexandros Dimas
% Department of Mechanical Enginnering & Aeronautics
% University of Patras
% Applied Mechanics Laboratory
% Finite Element Method II
% Lab Assignment 1
% Spring 2022
%
% This the main routine of the code. The necessary plots are produced
% only for option 4 [All] of the prompt message.

clc, clear, close all

addpath('utils')

prompt_sol = sprintf(['What is the desired solution?',...
                      '\nEuler\t\t: 1', ...
                      '\nShear Full\t: 2', ...
                      '\nShear Reduced\t: 3', ...
                      '\nAll\t\t: 4'...
                      '\n\nEnter your Option ~> ']);

params = getBeamParams;

while true
    prompt_sol;
    sol = input(prompt_sol);
    if sol == 1 || sol == 2 || sol == 3 || sol == 4
        break;
    else
        fprintf('\nERROR: %d is not a viable choice, try again.\n', sol);
    end
end        


[L_h_ratio, w_midpoint, theta_midpoint] = calculations(sol, params)
