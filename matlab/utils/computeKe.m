function Ke = computeKe(solFlag,params)
%COMPUTEKE Return Values for Element Stiffness Matrix
%   All Types of FE are considered

nodes = params.nodes;
totalDOF = params.totalDOF;
Le = params.Le;
E = params.E;
I = params.I;
A = params.area;
G = params.G;

Ke.Euler = E*I / Le * [12/Le^2    6/Le     -12/Le^2   6/Le;
                       6/Le       4        -6/Le      2;
                       -12/Le^2   -6/Le    12/Le^2    -6/Le;
                       6/Le       2        -6/Le      4;
                 ];

Ke.ShearFull = [G*A/Le      -G*A/2              -G*A/Le     -G*A/2
                -G*A/2      G*A*Le/3+E*I/Le     G*A/2       G*A*Le/6-E*I/Le
                -G*A/Le     G*A/2               G*A/Le      G*A/2
                -G*A/2      G*A*Le/6-E*I/Le     G*A/2       G*A*Le/3+E*I/Le ];

Ke.ShearReduced = [G*A/Le      -G*A/2              -G*A/Le     -G*A/2
                -G*A/2      G*A*Le/4+E*I/Le     G*A/2       G*A*Le/4-E*I/Le
                -G*A/Le     G*A/2               G*A/Le      G*A/2
                -G*A/2      G*A*Le/4-E*I/Le     G*A/2       G*A*Le/4+E*I/Le ];

end

