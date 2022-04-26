function nodalLoads = getNodalLoads(params)
%NODALFORCES Compute equivalent loads at the nodes
%   Detailed explanation goes here

load = params.load_Pz;
beamLength = params.L;
elementsNo = params.elementsNo;

R_A         = 5; % Reaction force at A
M_A         = 5; % Reaction force at B
R_B         = 5; % Reaction Moment at A
M_B         = 5; % Reaction Moment at B

% Replacing Load at the middle with static equiv at the adjacent nodes
equivLoad1  = 1;
equivLoad2  = 1;
equivMom1   = 1;
equivMom2   = 1;

nodalLoads = zeros(1,2 * (elementsNo+1));

Le = beamLength/elementsNo;

i = 1;
node = 1;
L = params.L;

while node <= elementsNo + 1
    if node == 1
        nodalLoads(1,i:i+1) = [R_A M_A];
        node = node + 1;
        i = i + 2;
    elseif mod(elementsNo,2) == 0 && node == (elementsNo/2) + 1
        nodalLoads(1,i:i+1) = nodalLoads(1,i:i+1) + [load 0];
        node = node + 1;
        i = i + 2;
    elseif (node*Le < beamLength/2 && (node+1)*Le > beamLength/2)
        nodalLoads(1,i:i+1) = nodalLoads(1,i:i+1) + [equivLoad1 equivMom1];
        nodalLoads(1,i+2:i+3) = nodalLoads(1,i+2:i+3) + [equivLoad2 equivMom2];
        node = node + 2;
        i = i + 4;
    elseif node == elementsNo + 1
        disp('node 5')
        nodalLoads(1,i:i+1) = nodalLoads(1,i:i+1) + [R_B M_B];
        node = node + 1;
        i = i + 2;
    else
        nodalLoads(1,i:i+1) = nodalLoads(1,i:i+1) + [0 0];
        node = node + 1;
        i = i + 2;
    end  
end

nodalLoads = nodalLoads';
end

