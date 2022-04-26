function [L_h_ratio, w_midpoint, theta_midpoint] = calculations(solFlag)
%CALCULATIONS Summary of this function goes here
%   Input:
%       solFlag         =   flag indicating which solution/solutions are desired
%   Output:
%       L_h_ratio       =   L/h ratio 
%       w_midpoint      =   deflection at x = L/2
%       theta_midpoint  =   rotation at x = L/2

params = getBeamParams;
nodes = params.nodes;
elementDOF = 2;
totalDOF = nodes*elementDOF;

Ke = params.E * params.I / params.Le * [12/Le^2   6/Le^2   -12/Le^2   6/Le;
                                        6/Le      4        -6/Le      2;
                                        -12/Le    -6/Le    12/Le^2    -6/Le;
                                        6/Le      2        -6/Le      4;
                                        ];

K_Total = defStiffnessMat(Ke, params);

activeNodes = 2:nodes-1;
activeDOF = 2*activeNodes(1)-1:2*activeNodes(end);
nodalLoads = getNodalLoads(params);

w_theta = nodalLoads(activeDOF) \ K_Total(activeDOF);



end

