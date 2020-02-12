clc, close, clear
format shortg
format compact
% fprintf('Steady Heat Conduction in a Large Plate\n')
% fprintf('analyzed for 3 and 4 nodes. \n')
% fprintf('\nThis will run two trials, \n')
% fprintf('one with 3 nodes and one with 4 nodes. \n')
% fprintf('You will be prompted for the necessary values. \n')
% fprintf('\nInput all values in SI units, which will include: \n')
% fprintf('length, L, thermal conductivity, k, \n')
% fprintf('three trial values for e_{gen}, \n')
% fprintf('heat transfer coefficient, h, \n')
% fprintf('and the temperature of the environment, T_{infinity}.\n')
% fprintf('The x=0 side of the plate is maintained at 0 deg C, T_0.\n')
% choice = input('\nWould you like to continue? (y/n)  ','s');
% if choice=='y'
% L = input('length, L=  ');
% k = input('thermal conductivity, k=  ');
% fprintf('\nthree trial values for e_{gen},... \n')
% e1(1)=input('the first value for e1_{gen}=   ');
% e1(2)=input('the second value for e2_{gen}=   ');
% e1(3)=input('the third value for e3_{gen}=   ');
% h =input('heat transfer coefficient, h=   ');
% T8= input('and the temperature of the environment, T_{infinity}=   ');

M=3; 
L=.04;
e1=[1,5,10].*1e6;
h=45; k=28; T8=30;
dx=L/(M-1);
for i=1:length(e1)
A = [ 2, -1 ; ...
    1 , -(1+h*dx/k) ];
B = [ e1(i)*dx^2/k ; ...
    -h*dx/k*T8-e1(i)*dx^2/(2*k)];
Temps(:,i)=[0;A\B];
end
fprintf('\nGraph 1 values\n')
Temperatures3nodes=Temps
x=dx*[0,1,2]'
subplot(2,1,1)
hold all;
Te1=plot(x,Temps(:,1),'o-');
Te2=plot(x,Temps(:,2),'o-');
Te3=plot(x,Temps(:,3),'o-');
grid, ylabel(['Temperature (' char(176) 'C)'])
title(sprintf('Temperature vs distance with %d nodes',M))
for i=1:3
    txt(i)=sprintf("e_{gen}=%d*10^6",e1(i)/1e6);
end
legend([Te3 Te2 Te1],txt(3),txt(2),txt(1),'Location','northwest');

clear Temps
M=4; 
% L=.04;
% e1=[1,5,10].*1e6;
% h=45; k=28; T8=30;
dx=L/(M-1);
for i=1:length(e1)
A = [  1 , -2 , 1 ;...
    -2 , 1 , 0 ;...
    0 , 1 , -(1+h*dx/k) ];
B = [ -e1(i)*dx^2/k ; ...
    -e1(i)*dx^2/k ;...
    -h*dx/k*T8-e1(i)*dx^2/(2*k)];
Temps(:,i)=[0;A\B];
end
fprintf('\nGraph 2 values\n')
Temperatures4nodes=Temps
x=dx*[0,1,2,3]'
subplot(2,1,2)
hold all;
Te1=plot(x,Temps(:,1),'o-');
Te2=plot(x,Temps(:,2),'o-');
Te3=plot(x,Temps(:,3),'o-');
grid, ylabel(['Temperature (' char(176) 'C)'])
xlabel('Distance (m)')
title(sprintf('Temperature vs distance with %d nodes',M))
legend([Te3 Te2 Te1],txt(3),txt(2),txt(1),'Location','northwest');

% else
%     fprintf('\nDone.\n\n')
% end

