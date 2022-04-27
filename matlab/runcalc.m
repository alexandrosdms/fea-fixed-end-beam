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

welcome_prompt = sprintf(['**** \t\tFinite Element Methods II - MEAD - University of Patras \t****',...
                            '\n**** \t\tAlexandros Dimas - 1054531 - Spring 2022 \t\t\t****',...
                            '\n\n** Instuctions:',...
                            '\n* If you want to produce a solution for the problem according to the ',...
                            'specifications required in the assignment writeup, ',...
                            'choose "1", "2" or "3".',...
                            '\n* If you want to produce the plots required choose "4".']);
         
prompt_sol = sprintf(['\n\nWhat is the desired solution?',...
                      '\nEuler\t\t: 1', ...
                      '\nShear Full\t: 2', ...
                      '\nShear Reduced\t: 3', ...
                      '\nAll\t\t: 4'...
                      '\n\nEnter your Option ~> ']);

disp(welcome_prompt);
while true
    prompt_sol;
    sol = input(prompt_sol);
    if sol == 1 || sol == 2 || sol == 3 || sol == 4
        break;
    else
        fprintf('\nERROR: %d is not a viable choice, try again.\n', sol);
    end
end

if sol ~= 4
    params = getBeamParams(sol);
    [~,~,L_h_ratio, w_midpoint, theta_midpoint] = calculations(sol, params);
else
    % Erotima 1
    ii = 14;
    fig_1 = figure;
    elementsNo = [8 24 144];
    for i = 1:size(elementsNo,2)
        params = getBeamParams(sol, elementsNo(i));
        [wEuler, thetaEuler,~,~,~] = calculations(1, params);
        [wSF, thetaSF,~,~,~] = calculations(2, params);
        [wSR, thetaSR,~,~,~] = calculations(3, params);

        x = 0:size(wEuler,2)-1;
        xaxis = x/x(end) * params.L;

        subplot(2,3,i),plot(xaxis, wEuler, xaxis, wSF, xaxis, wSR, ...
                                'LineWidth', 2.5)
        xlabel('x [m]', 'FontSize', ii)
        xlim([0 2.9])
        ylabel('w [m]', 'FontSize', ii)
        title(sprintf('Double Fixed Beam Elements = %d', elementsNo(i)))
        legend('Euler','Shear Full','Shear Reduced')
        set(gca,'Linewidth',1.5)
        grid on

        subplot(2,3,i+3),plot(xaxis, thetaEuler, xaxis, thetaSF, xaxis, thetaSR, ...
                                'LineWidth', 2.5)
        xlabel('x [m]', 'Interpreter', 'tex', 'FontSize', ii)
        xlim([0 2.9])
        ylabel('\theta or \beta_x [rad]', 'Interpreter', 'tex', 'FontSize', ii)
        title(sprintf('Double Fixed Beam Elements = %d', elementsNo(i)))
        legend('Euler','Shear Full','Shear Reduced')
        set(gca,'Linewidth',1.5)
        grid on
    end

    % Erotima 2
    elementsNo = 8;
    L_h_values = 2:5:160;
    w_tab = zeros(size(L_h_values,2), 3);
    for i = 1:size(L_h_values,2)
        params = getBeamParams(sol, elementsNo, L_h_values(i));
        [~,~,~, w_midpoint_euler, ~] = calculations(1, params);
        [~,~,~, w_midpoint_full, ~] = calculations(2, params);
        [~,~,~, w_midpoint_reduced, ~] = calculations(3, params);
        
        w_tab(i,:) = [w_midpoint_euler w_midpoint_full w_midpoint_reduced];
    end
    
    % Erotima 3
    fig_2 = figure;
    subplot(4,2,[3,5]), plot(L_h_values, w_tab(:,1), L_h_values, w_tab(:,2), ...
                    L_h_values,w_tab(:,3), 'LineWidth', 2.5)
    xlabel('L/h', 'Interpreter', 'tex', 'FontSize', ii)
    ylabel('Middle Node Deflection w [m]', 'Interpreter', 'tex', 'FontSize', ii)
    title(sprintf('Doble fixed beam, %d Elements', elementsNo))
    xlim([L_h_values(1) L_h_values(end)])
    legend('Euler','Shear Full','Shear Reduced')
    set(gca,'Linewidth',1.5)
    grid on



    w_tab_norm = w_tab ./ w_tab(:,1);
    subplot(4,2,[4,6]), plot(L_h_values, w_tab_norm(:,1), L_h_values, w_tab_norm(:,2), ...
                    L_h_values,w_tab_norm(:,3), 'LineWidth', 2.5)
    xlabel('L/h', 'Interpreter', 'tex', 'FontSize', ii)
    ylabel('Normalized Middle Node Deflection w/w_e', 'Interpreter', 'tex', 'FontSize', ii)
    title(sprintf('Doble fixed beam, %d Elements', elementsNo))
    xlim([L_h_values(1) L_h_values(end)])
    legend('Euler','Shear Full','Shear Reduced')
    set(gca,'Linewidth',1.5)
    grid on
end
