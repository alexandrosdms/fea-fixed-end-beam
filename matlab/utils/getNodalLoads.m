function nodalLoads = getNodalLoads(load, beamLength, elementsNo)
%NODALFORCES Compute equivalent loads at the nodes
%   Detailed explanation goes here

R_A         = 0; % Reaction force at A
M_A         = 0; % Reaction force at B
R_B         = 0; % Reaction Moment at A
M_B         = 0; % Reaction Moment at B

% Replacing Load at the middle with static equiv at the adjacent nodes
equivLoad1  = 0;
equivLoad2  = 0;
equivMom1   = 0;
equivMom2   = 0;

nodalLoads = zeros(1,2 * (elementsNo+1));

Le = beamLength/elementsNo;

i = 1;
while (i * Le/L < 1)
    if i == 1
        nodalLoads(1,i:i+1) = [R_A M_A]';
    elseif (i*Le < beamLength/2 && (i+1)*Le > beamLength/2)
        nodalLoads(1,i:i+1) = [equivLoad1 equivMom1]';
        nodalLoads(1,i+2:i+3) = [equivLoad2 equivMom2]';
        i = i + 3;
    elseif ((i+1)*Le > beamLength)
        nodalLoads(1,i:i+1) = [R_B M_B]';
    else
        nodalLoads(1,i:i+1) = [0 0]';
    end  
end

