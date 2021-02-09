function [theta] = Inverse_Kinematic(xf,yf,zf)
%Find the motor angles for TriFinger with xyz input
%   xf = final x coordinate
%   yf = final y coordinate
%   zf = final z coordinate

%% SETUP

% convert to the negative xyz plane
xf = -xf;
yf = -yf;
zf = -zf;

% motor initial angle (TBD)
initialMotor1Angle = 0;
initialMotor2Angle = 0;
initialMotor3Angle = 0;

% define length of arm 1 and 2
lengthDiagonalArm = 16;
lengthFingerTip = 13;

%% CONVERT TO 2D

% create coordinate of the x-yz plane
yFinalIn2D = -sqrt(yf^2+zf^2);
xFinalIn2D = xf;

% inverse kinematics math
thetaMotor1 = atan(yf/zf);
thetaMotor2 = pi-acos((lengthDiagonalArm^2+lengthFingerTip^2-xFinalIn2D^2-yFinalIn2D^2)/2/lengthDiagonalArm/lengthFingerTip);
thetaMotor3 = atan(yFinalIn2D/xFinalIn2D)+atan(lengthFingerTip*sin(thetaMotor2)/(lengthDiagonalArm+lengthFingerTip*cos(thetaMotor2)));

%% Define Function Return

theta(1) = thetaMotor1;
theta(2) = pi-thetaMotor3;
theta(3) = pi-thetaMotor2;

end

