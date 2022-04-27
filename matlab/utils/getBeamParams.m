% Alexandros Dimas
% Department of Mechanical Enginnering & Aeronautics
% University of Patras
% Applied Mechanics Laboratory
% Finite Element Method II
% Lab Assignment 1
% Spring 2022
%
% This the main routine of the code. The necessary plots are produced
% only for option 4 [All] of the prompt message.

function params = getBeamParams(solFlag, in_elementsNo, in_L_h)

%GETBEAMPARAMS Returns initialized Beam Parameters
%   Output params is a structure with fields:
%       E           =   Young Modulus in [Pa]
%       ni          =   Poisson Ratio
%       G           =   Shear Modulus in [Pa]
%       L           =   Beam Length in [m]
%       angleA      =   angle for the crossection as defined in the handout
%       C           =   scale constant defined in the handout
%       elementsNo  =   The number of elements used
%       elementType =   The type of the element used
%       load_Pz     =   The applied force at the midpoint in [N]
%       I           =   Moment of inertia for the cross section around bending
%                       axis in [m^4]



%% Material Properties
E        = 67.1e9;
ni       = 0.315;
G        = E / 2*(ni+1);

%% Geometric Properties

if nargin ==1
    L_h = 100;
    elementsNo = 20;
elseif nargin == 2
    L_h = 100;
    elementsNo = in_elementsNo;
elseif nargin == 3
    elementsNo = in_elementsNo;
    L_h = in_L_h;
end

if solFlag ~= 4
    mode = input("Do you want to enter values manually [Y/n]?","s");
    if isempty(mode) || mode == lower('y') || mode == lower("yes")
        test_mode = true;
    elseif mode == lower('n') || mode == lower("no")
        test_mode = false;
    end
end

if solFlag ~= 4 && test_mode
        L 				= input("Enter Length of the beam in meters: ");
        L_h             = input("Enter L/h ratio: ");
        getAng          = input ("Enter value of angle alpha in degrees: ");
        C 				= input("Enter value for scale constant C: ");
        elementsNo      = input("Enter numbers of Elements used: ");
        load_Pz         = input("Enter load Value with the appropriate sign: ");
%         ElementType 		= input("Enter element type: ", "s");
        h                = L / L_h;
        angleA           = getAng * pi/180;

else
    L 				 = 2.9;
    h                = L / L_h;
    getAng           = 20;
    angleA           = getAng * pi/180;
    C 				 = 1.2;
    load_Pz          = -38.46*C;
end

%% Calculated
area    = h^2 * (angleA/2 - sin(angleA/2)*cos(angleA/2));
y_bar   = 3*h/2 * ((sin(angleA/2))^3 / (angleA/2 - sin(angleA/2)*cos(angleA/2)));
I_y     = h^4/4 * (angleA/2 - sin(angleA/2)*cos(angleA/2) ...
                                        + 2*(sin(angleA/2))^3*cos(angleA/2));
I       = I_y + area*y_bar^2;
%% FEM Associated
nodeDOF         = 2;
nodes           = elementsNo + 1;
totalDOF        = nodes*nodeDOF;
Le              = L/elementsNo;

%% Geometric Properties


% if userMode && sol == 1
%     ElementType = "Euler";
% elseif userMode && sol == 2
%     ElementType = "Shear Full";
% elseif userMode && sol == 3
%     ElementType = "Shear Reduced";
% elseif (userMode && sol == 4) || assignMode
%     ElemetType = ["Euler"; "Shear Full"; "Shear Reduced";];

%% Output
params.E                = E;
params.G                = G;
params.L                = L;
params.h                = h;
params.angleA           = angleA;
params.C 				= C;
params.elementsNo       = elementsNo;
params.load_Pz          = load_Pz;
params.nodes            = nodes;
params.totalDOF         = totalDOF;
params.area             = area;
params.I                = I;
params.Le               = Le;
end

