function params = getBeamParams
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
%       nodalLoads  =   A [1 X 2 * (elementsNo+1)] vector representing the
%                       loads corresponding to each degree of freedom

%% Material Properties
params.E        = 67.1e9;
params.ni       = 0.315;
params.G        = params.E / 2*(params.ni+1);

%% Geometric Properties
% params.L 				= input("Enter Length of the beam in meters: ");
% params.h              = input("Enter Radius of Arc in meters : ");
% getAng                  = input ("Enter value of angle alpha in degrees:");
% params.angleA           = getAng * pi/180;
% params.C 				= input("Enter value for scale constant C: ");
% params.elementsNo = input("Enter numbers of Elements used: ");
% params.elementType 		= input("Enter element type: ", "s");
% params.load_Pz  = input("Enter load Value with the appropriate sign: ");

params.L 				= 2.9;
params.h                = 2.9 * 100;
getAng                  = 20;
params.angleA           = getAng * pi/180;
params.C 				= 1.2;
params.elementsNo = 4;
params.load_Pz  = -38.46*params.C;

% Calculating Moment of Inertia
params.I        = 0.001;

% FEM Associated
nodeDOF = 2;
params.nodes = params.elementsNo + 1;
params.totalDOF = params.nodes*nodeDOF;
params.Le = params.L/params.elementsNo;

%% Geometric Properties


% if userMode && sol == 1
%     params.elementType = "Euler";
% elseif userMode && sol == 2
%     params.elementType = "Shear Full";
% elseif userMode && sol == 3
%     params.elementType = "Shear Reduced";
% elseif (userMode && sol == 4) || assignMode
%     params.elemetType = ["Euler"; "Shear Full"; "Shear Reduced";];

end

