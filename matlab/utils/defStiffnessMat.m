function [K_Total] = defStiffnessMat(Ke, solFlag, params)
%DEFINESTIFFNESSMATRIX Computes Stiffness Matrix for the whole structure
%   Detailed explanation goes here

elementsNo = params.elementsNo;
totalDOF = params.totalDOF;
K_Total.Euler = zeros(totalDOF);
K_Total.ShearFull = zeros(totalDOF);
K_Total.ShearReduced = zeros(totalDOF);

if solFlag == 1 || solFlag == 2 || solFlag == 3
    if solFlag == 1
        Ke = Ke.Euler;
        K_Total = zeros(totalDOF);
    elseif solFlag == 2
        Ke = Ke.ShearFull;
        K_Total = zeros(totalDOF);
    elseif solFlag == 3
        Ke = Ke.ShearReduced;
        K_Total = zeros(totalDOF);
    end
    for element = 1:elementsNo
        if element == 1
            row = 1; column = 1;
        else
            row = row + 2; column = column + 2;
        end
        K_Total(row:row+3,column:column+3) = ...
            K_Total(row:row+3,column:column+3) + Ke(:,:);
    end

else
    for element = 1:elementsNo
        if element == 1
            row = 1; column = 1;
        else
            row = row + 2; column = column + 2;
        end
        K_Total.Euler(row:row+3,column:column+3) = ...
            K_Total.Euler(row:row+3,column:column+3) + Ke.Euler(:,:);
    end
    for element = 1:elementsNo
        if element == 1
            row = 1; column = 1;
        else
            row = row + 2; column = column + 2;
        end
        K_Total.ShearFull(row:row+3,column:column+3) = ...
            K_Total.ShearFull(row:row+3,column:column+3) + Ke.ShearFull(:,:);
    end
    for element = 1:elementsNo
        if element == 1
            row = 1; column = 1;
        else
            row = row + 2; column = column + 2;
        end
            K_Total.ShearReduced(row:row+3,column:column+3) = ...
                K_Total.ShearReduced(row:row+3,column:column+3) + Ke.ShearReduced(:,:);

    end
end

end

