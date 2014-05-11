% Dynamical Modeling Methods for Systems Biology
% April 2014
% Assignment 2 Part 1 & 2
% Array computations for simple data analysis


% % Use Euler's method to integrate simple one variable ODE
% % Use program as template for more interesting models

% % Note:  produces slightly different output compared with 
% % example shown in class.  Different values of b, dt, tlast

% Vin = 0.36 ;  % default parameters (Vin = 0.36)
% k1 = 0.02 ;
% kp = 6 ;
% Km = 13 ;     % use 13 for oscillation

% Vin = 0.3 ; % default parameters for damped osc
% k1 = 0.02 ; % Question 6
% kp = 6 ;
% Km = 18 ;

Vin = 0.36 ; 
k1 = 0.02 ;
kp = 6 ;
Km = 13 ;     % vary in Question 9

colors = repmat('krgbmc',1,300) ;
 
dt    = 0.2 ; % value to match Question 2 answers
tlast = 1000 ; % s
 
iterations = round(tlast/dt) ; 
xall = zeros(iterations,1) ;
yall = zeros(iterations,1) ;

ATP = 4 ;
G = 3 ;

x = ATP ;
y = G ;
for i = 1:iterations 
  xall(i) = x ;
  yall(i) = y ;
  dxdt = (2*k1*y*x) - ((kp*x)/(x + Km)) ;
  dydt = Vin - (k1*y*x) ;
  x = x + dxdt*dt ;    
  y = y + dydt*dt ;  
end % of this time step

time = dt*(0:iterations-1)' ;
figure
hold on
plot(time,xall,colors(2))
plot(time,yall,colors(3))
title('d[ATP]/dt & d[G]/dt vs time')
figurelegend{1} = ['d[ATP]/dt']; 
figurelegend{2} = ['d[G]/dt'];
legend(figurelegend,'Location','Southeast') % create legend in bottom right

figure
plot(xall,yall)
title('2D Phase Plane')
ylabel('[Glucose]');
xlabel('[ATP]');
