function [wBeam,thetaBeam] = compDiflRot(u, pointsNo, solFlag, params)
%COMPDIFLROT Computes deflection and rotation of the beam
%   Detailed explanation goes here

Le = params.Le;
xi = linspace(-1,1,100)';
x = linspace(0,params.L,params.elementsNo*(pointsNo-1))';

if solFlag == 1
    H1 = 0.25 * (1-xi).^2 .* (2+xi);
    H2 = 0.25 * (1-xi).^2 .* (xi+1);
    H3 = 0.25 * (1+xi).^2 .* (2-xi);
    H4 = 0.25 * (1+xi).^2 .* (xi-1);

    H1_xi = 0.75 * (xi.^2-1);
    H2_xi = 0.75 * xi.^2 - 0.5*xi - 0.25;
    H3_xi = 0.75 - 0.75*xi.^2;
    H4_xi = 0.75 * xi.^2 + 0.5*xi - 0.25;

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
else
    N1 = 0.5*(1-xi);
    N2 = 0.5*(1+xi);
    wBeam = zeros(size(x,1),1);
    thetaBeam = zeros(size(x,1),1);
    for element = 1:params.elementsNo
        if element == 1
            wElement = N1*u(element) + N2*u(element+2);
            thetaElement = -N1*u(element+1) - N2*u(element+3);
            wBeam(1:pointsNo) = wElement(:);
            thetaBeam(1:pointsNo) = thetaElement(:);
        else
            ii = 2*element-1;
            wElement = N1*u(ii) + N2*u(ii+2);
            thetaElement = -N1*u(ii+1) - N2*u(ii+3);
            wBeam((element-1)*pointsNo:element*pointsNo-1) = wElement(:);
            thetaBeam((element-1)*pointsNo:element*pointsNo-1) = thetaElement(:);
        end
    end
end

end
