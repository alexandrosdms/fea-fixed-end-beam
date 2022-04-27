function nodalLoads = getNodalLoads(params)
%NODALFORCES Compute load vector for solution
%   Attention must be paid in that this function works only for and even number
%   of elements, where there's a node in the middle of the beam, where the load
%   is applied.

load = params.load_Pz;
beamLength = params.L;
elementsNo = params.elementsNo;

nodalLoads = zeros(1,2 * (elementsNo+1));

Le = beamLength/elementsNo;

i = 1;
node = 1;
L = params.L;

while node <= elementsNo + 1
    if node == 1
        node = node + 1;
        i = i + 2;
        continue;
    elseif mod(elementsNo,2) == 0 && node == (elementsNo/2) + 1
        nodalLoads(1,i:i+1) = nodalLoads(1,i:i+1) + [load 0];
        node = node + 1;
        i = i + 2;
    elseif node == elementsNo + 1
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

