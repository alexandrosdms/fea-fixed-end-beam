function [K_Total] = defStiffnessMat(Ke, params)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

elementsNo = params.elementsNo;
% elementsNo = 4;

totalDOF = params.totalDOF;
K_Total = zeros(totalDOF);

for element = 1:elementsNo
    if element == 1
        row = 1; column = 1;
    else
        row = row + 2; column = column + 2;
    end
    K_Total(row:row+3,column:column+3) = ...
        K_Total(row:row+3,column:column+3) + Ke(:,:);
    
end
end

