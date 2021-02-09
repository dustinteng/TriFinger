%Project TriFinger MATLAB Controlling ARDUINO V2
%UCSD 2021
% this code connects matlab to arduino and able to control servo with
% different speed.
% a little tweak of code also can lets us to use feedback

%MATLAB Code for Serial Communication between Arduino and MATLAB
clc,clear,close all

%close previous opened connection
% b = instrfind();
% fclose(b);

%creating arduino object
ard = arduino('COM6','Mega2560','Libraries','Servo');

%change max and min pulse to change the actual angle,
%change max and min according to your the servo that you use!
s = servo(ard,'D9','MaxPulseDuration',2.3e-3,'MinPulseDuration',0.7e-3);
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
while go
    clc;
    menu = input('(1) for inputting angle \n(2) for inputting angle change \n(0) close application \nwhich option do you want to choose? ');
    while menu == 1
        clc;
        fprintf("current angle is: " + string(lastAngle) + " degree \n");
        angleNow= input('if you want to go back to the main menu input "" \ninput angle from 0 to 180? ');
        
        if(isstring(angleNow))
            menu = 0;
            
        elseif (angleNow<0 || angleNow>180)
            clc;
            fprintf("please input value ranging between 0 to 180! \nnothing changed. \n");
            pause(ReadTime);
        else
            NormLA = mapfun(lastAngle,0,180,0,1); %normalized lastAngle
            NormAN = mapfun(angleNow,0,180,0,1); %normalized angleNow
            lastAngle = angleNow;
            angleArray = linspace(NormLA, NormAN, n);
            %use sleep to control the speed
            for i = 2:n 
                writePosition(s,angleArray(i));
                pause(tSleep);
            end
        end
    end
    
    while menu == 2
        clc;
        fprintf("current angle is: " + string(lastAngle) + " degree \n");
        dAngle= input('if you want to go back to the main menu input "" \ninput changing angle? ');
        if isstring(dAngle)
            menu = 0;
            pause(tSleep);
        else
            curAngle = lastAngle + dAngle;
            if (curAngle<0 || curAngle>180)
                clc;
                fprintf("The total angle is out of range, please enter something else \nnothing changed. \n");
                pause(ReadTime);
            else
                NormLA = mapfun(lastAngle,0,180,0,1); %normalized lastAngle
                NormCA = mapfun(curAngle,0,180,0,1); %normalized angleNow
                lastAngle = curAngle; %later changed with the feedback
                angleArray = linspace(NormLA, NormCA, n);
                %use sleep to control the speed
                for i = 2:n 
                    writePosition(s,angleArray(i));
                    pause(tSleep);
                end
            end
            
        end
    end
    
    while menu == 0
        go = false;
        clc;
        fprintf("Thank You, Bye \n");
        pause(ReadTime);
        clc;
        break
    end
end