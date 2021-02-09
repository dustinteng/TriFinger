function [xplot1b,yplot1b,zplot1b,xplot2b,yplot2b,zplot2b,n,angleMotor1,angleMotor2,angleMotor3]=Plot_Simulation(xf,yf,zf,theta)
% motor initial angle (TBD)
initialMotor1Angle = 0;
initialMotor2Angle = 0;
initialMotor3Angle = 0;

% define length of arm 1 and 2
lengthDiagonalArm = 16;
lengthFingerTip = 13;

%% Plot Animation

xf = -xf;
yf = -yf;
zf = -zf;
n = 100;

angleMotor1 = linspace(initialMotor1Angle,theta(1),n);
angleMotor2 = linspace(initialMotor2Angle,theta(2),n);
angleMotor3 = linspace(initialMotor3Angle,theta(3),n);
    
for t = 1:n
%     figure(1)
% 
%     plot3(0,0,0,'o','LineWidth',2)
%     hold on
%     plot3(xf,yf,zf,'*','LineWidth',2)
%     plot3([0,-xf],[0,0],[0,0],'-','LineWidth',6)

    % Forward Kinematics
    xplot1 = lengthDiagonalArm*cos(angleMotor2(t));
    zplot1 = -lengthDiagonalArm*sin(angleMotor2(t));

    xplot2 = xplot1+lengthFingerTip*sin(angleMotor2(t)-angleMotor3(t)-pi/2);
    zplot2 = zplot1+lengthFingerTip*cos(angleMotor2(t)-angleMotor3(t)-pi/2);
    
    xplot1b(t) = xplot1;
    yplot1b(t) = zplot1*sin(angleMotor1(t));
    zplot1b(t) = zplot1*cos(angleMotor1(t));
    
    
    xplot2b(t) = xplot2;
    yplot2b(t) = zplot2*sin(angleMotor1(t));
    zplot2b(t) = zplot2*cos(angleMotor1(t));
    
    
%     plot3([0,xplot1b],[0,yplot1b],[0,zplot1b],'r','LineWidth',4)
%     plot3([xplot1b,xplot2b],[yplot1b,yplot2b],[zplot1b,zplot2b],'b','LineWidth',2)
    
%     hold off
%     
%     grid on
%     grid minor
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
%     
%     axis([-25 25 -15 0 -20 0])
    
end
end