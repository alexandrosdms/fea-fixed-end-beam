function [L_h_ratio, w_midpoint, theta_midpoint] = calculations(solFlag, params)
%CALCULATIONS All the necessary calculations for the assignment
%   Input:
%       solFlag         =   flag indicating which solution/solutions are desired
%   Output:
%       L_h_ratio       =   L/h ratio 
%       w_midpoint      =   deflection at x = L/2
%       theta_midpoint  =   rotation at x = L/2

params = getBeamParams;
nodes = params.nodes;
totalDOF = params.totalDOF;

Ke = params.E * params.I / params.Le * [12/Le^2   6/Le^2   -12/Le^2   6/Le;
                                        6/Le      4        -6/Le      2;
                                        -12/Le    -6/Le    12/Le^2    -6/Le;
                                        6/Le      2        -6/Le      4;
                                        ];

K_Total = defStiffnessMat(Ke, params);

activeNodes = 2:nodes-1;
activeDOF = 2*activeNodes(1)-1:2*activeNodes(end);
nodalLoads = getNodalLoads(params);

u = nodalLoads(activeDOF) \ K_Total(activeDOF);

u = [0; 0; u; 0; 0];

pointsNo = 100;
xi = linspace(-1,1,100);
x = linspace(0,params.beamLength,params,params.elementsNo*(pointsNo-1))

H1 = 0.25 * (1-xi).^2 * (2+xi);
H2 = 0.25 * (1-xi).^2 * (xi+1);
H3 = 0.25 * (1+xi).^2 * (2-xi);
H4 = 0.25 * (1+xi).^2 * (1-xi);

for element = 1:params.elementsNo
    wElement = H1*u(element) + H3*u(element+2) + ...
        params.Le * (H2*u(element+1)+H4*u(element+3));

    if element == 1
        wBeam(1:pointsNo) = wElement(:);
    else
        wBeam((element-1)*pointsNo:element*pointsNo) = wElement(:);
    end
end

end

