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
Le = params.Le;
E = params.E;
I = params.I;

Ke = E*I / Le * [12/Le^2   6/Le   -12/Le^2   6/Le;
                 6/Le      4        -6/Le      2;
                 -12/Le^2    -6/Le    12/Le^2    -6/Le;
                 6/Le      2        -6/Le      4;
                 ];

K_Total = defStiffnessMat(Ke, params);

activeNodes = 2:nodes-1;
activeDOF = 2*activeNodes(1)-1:2*activeNodes(end);
nodalLoads = getNodalLoads(params);

u = K_Total(activeDOF,activeDOF) \ nodalLoads(activeDOF);

u = [0; 0; u; 0; 0];

pointsNo = 100;
xi = linspace(-1,1,100)';
x = linspace(0,params.L,params.elementsNo*(pointsNo-1))';

H1 = 0.25 * (1-xi).^2 .* (2+xi);
H2 = 0.25 * (1-xi).^2 .* (xi+1);
H3 = 0.25 * (1+xi).^2 .* (2-xi);
H4 = 0.25 * (1+xi).^2 .* (xi-1);

H1_xi = 0.75 * (xi.^2-1);
H2_xi = 0.75 * xi.^2 - 0.5*xi - 0.25;
H3_xi = 0.75 - 0.75*xi.^2;
H4_xi = 0.75 * xi.^2 + 0.5*xi - 0.25;

wBeam = zeros(size(x,1),1);
thetaBeam = zeros(size(x,1),1);
for element = 1:params.elementsNo
    if element == 1
        wElement = H1*u(element) + H3*u(element+2) + ...
            params.Le/2 * (H2*u(element+1)+H4*u(element+3));
        thetaElement = 2/Le * (H1_xi*u(element) + H3_xi*u(element+2)) + ...
            H2_xi*u(element+1) + H4_xi*u(element+3);
        wBeam(1:pointsNo) = wElement(:);
        thetaBeam(1:pointsNo) = thetaElement(:);
    else
        ii = 2*element-1;
        wElement = H1*u(ii) + H3*u(ii+2) + ...
            params.Le/2 * (H2*u(ii+1)+H4*u(ii+3));
        thetaElement = 2/Le * (H1_xi*u(ii) + H3_xi*u(ii+2)) + ...
            H2_xi*u(ii+1) + H4_xi*u(ii+3);
        wBeam((element-1)*pointsNo:element*pointsNo-1) = wElement(:);
        thetaBeam((element-1)*pointsNo:element*pointsNo-1) = thetaElement(:);
    end
end

figure(1),plot(wBeam, 'LineWidth', 3, 'Color', 'b')
%plot(u(1:2:totalDOF), 'LineWidth', 3, 'Color', 'b')
figure(2),plot(thetaBeam, 'LineWidth', 3, 'Color', 'r')
%plot(u(2:2:totalDOF-2), 'LineWidth', 3, 'Color', 'b')

L_h_ratio = params.L/params.h;
nodeNo_in_the_middle = (params.elementsNo/2) + 1;
w_midpoint = u(2*nodeNo_in_the_middle-1);
theta_midpoint = u(2*nodeNo_in_the_middle);
end

