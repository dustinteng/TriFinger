%Project TriFinger - Stepper
%UCSD 2021
%this code is meant to control stepper.

clc,clear,close all

speed = 10;
tSleep  = 1/speed/10; %the time sleep for for loop
function Stepper(arduino, thetaNow, thetaGoal,stepPin,dirPin)
a = arduino;

if (thetaGoal - thetaNow >0 )
    dval = 1;
else
    dval = 0;
end
    a.writeDigitalPin(dirPin,dval);
    a.writeDigitalPin(stepPin,1);
    
end
