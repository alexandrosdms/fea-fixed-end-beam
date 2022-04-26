function [L_h_ratio, w_midpoint, theta_midpoint] = calculations(solFlag)
%CALCULATIONS Summary of this function goes here
%   Input:
%       solFlag         =   flag indicating which solution/solutions are desired
%   Output:
%       L_h_ratio       =   L/h ratio 
%       w_midpoint      =   deflection at x = L/2
%       theta_midpoint  =   rotation at x = L/2

params = getBeamParams;
Ke = params.E * params.I / params.Le * [12/Le^2   6/Le^2   -12/Le^2   6/Le;
                                        6/Le      4        -6/Le      2;
                                        -12/Le    -6/Le    12/Le^2    -6/Le;
                                        6/Le      2        -6/Le      4;
                                        ];

K_Total = defStiffnessMat(Ke, params);
nodalLoads = getNodalLoads(params);

w_theta = nodalLoads/K_Total;



end

