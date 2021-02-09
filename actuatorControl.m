%Project TriFinger MATLAB Controlling ARDUINO V3
%UCSD 2021
%this code is meant to control a single arm at the same time

clc,clear,close all

%creating arduino object
ard = arduino('COM6','Mega2560','Libraries','Servo');
%change max and min pulse to change the actual angle,
%change max and min according to your the servo that you use!
s = servo(ard,'D9','MaxPulseDuration',2.3e-3,'MinPulseDuration',0.7e-3);
%whileloop true
go = true;
%text sleep
ReadTime = 1;
%setting up a variable for the angle now
lastAngle = 90;
%iteration number
n = 40;
%speed, do not change tSleep if you don't know what you are doing
speed = 10;
tSleep  = 1/speed/10; %the time sleep for for loop



