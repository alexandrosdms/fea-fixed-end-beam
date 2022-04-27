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

function [wBeam,thetaBeam,L_h_ratio, w_midpoint, theta_midpoint] = ...
    calculations(solFlag, params)
%CALCULATIONS All the necessary calculations for the assignment
%   Input:
%       solFlag         =   flag indicating which solution/solutions are desired
%   Output:
%       wBeam           =   Deflection values
%       thetaBeam       =   Rotation values
%       L_h_ratio       =   L/h ratio 
%       w_midpoint      =   deflection at x = L/2
%       theta_midpoint  =   rotation at x = L/2

nodes = params.nodes;
totalDOF = params.totalDOF;
Le = params.Le;

Ke = computeKe(solFlag, params);

K_Total = defStiffnessMat(Ke, solFlag, params);

activeNodes = 2:nodes-1; % Start and end of the beam are constrained
activeDOF = 2*activeNodes(1)-1:2*activeNodes(end); % for node we have 2 DOF
nodalLoads = getNodalLoads(params);

u = K_Total(activeDOF,activeDOF) \ nodalLoads(activeDOF);

u = [0; 0; u; 0; 0]; % Restore full vector of DOF

pointsNo = 100; % number of points in each element, for plotting purposes


[wBeam,thetaBeam] = compDiflRot(u,pointsNo,solFlag, params);


L_h_ratio = params.L/params.h;
nodeNo_in_the_middle = (params.elementsNo/2) + 1;
w_midpoint = u(2*nodeNo_in_the_middle-1);
theta_midpoint = u(2*nodeNo_in_the_middle);


end

