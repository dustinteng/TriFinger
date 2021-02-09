%% CONVERT TO 2D
function [xl1,yl1,xAdd,yAdd,xf2,yf2]=plot_2d(xf,yf,zf)
% define length of arm 1 and 2
lengthDiagonalArm = 16;
lengthFingerTip = 13;
l1 = lengthDiagonalArm;
l2 = lengthFingerTip;

% create coordinate of the x-yz plane
yf2 = -sqrt(yf^2+zf^2);
xf2 = xf;

% inverse kinematics math
theta2 = pi-acos((l1^2+l2^2-xf2^2-yf2^2)/2/l1/l2);
theta1 = atan(yf2/xf2)+atan(l2*sin(theta2)/(l1+l2*cos(theta2)));

%find end points of the arms
[xl1,yl1] = pol2cart(pi+theta1,-l1);
[xl2,yl2] = pol2cart(pi-theta2+theta1,-l2);

xAdd = -xl2-xl1;
yAdd = -yl2-yl1;

xl1 = -xl1;
yl1 = -yl1;

% % plot in x-yz plane
% figure(2)
% plot(0,0,'o',xf2,yf2,'*','LineWidth',4)
% hold on
% plot([0,xl1],[0,yl1],'r','LineWidth',4)
% plot([xl1,xAdd],[yl1,yAdd],'b','LineWidth',4)
% hold off
% grid on
% grid minor
% title("Diagonal & Tip Arm Reference Plane - XZ'")
% ylabel("Z' axis ")
% xlabel("X' axis ")