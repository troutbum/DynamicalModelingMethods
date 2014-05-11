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

% Vin = 0.36 ; 
k1 = 0.02 ;
kp = 6 ;
Km = 13 ;

colors = repmat('krgbmc',1,300) ;
 
dt    = 0.05 ;
tlast = 2000 ; % s
 
iterations = round(tlast/dt) ; 
xall = zeros(iterations,1) ;    % d[ATP]/dt
yall = zeros(iterations,1) ;    % d[Glucose]/dt

delay = round(iterations/2) ;   % filter initial 1/2 of results
xallsteady = zeros(iterations-delay,1) ;
yallsteady = zeros(iterations-delay,1) ;

Vstart = 0.1 ;                  % create min/max vectors
Vstop = 1.6 ;
Vstep = 0.01 ;
Viterations = round((Vstop-Vstart)/Vstep) ;
ymins = zeros(Viterations, 1) ;
ymaxs = zeros(Viterations, 1) ;
xmins = zeros(Viterations, 1) ;
xmaxs = zeros(Viterations, 1) ;

ATP = 4 ;
G = 3 ;

x = ATP ;
y = G ;

l = 1
for Vin = Vstart: Vstep: Vstop
 
    for i = 1:iterations 
        xall(i) = x ;
        yall(i) = y ;
        dxdt = (2*k1*y*x) - ((kp*x)/(x + Km)) ;
        dydt = Vin - (k1*y*x) ;
        x = x + dxdt*dt ;    
        y = y + dydt*dt ;  
    end % of this time step  
    

    j = 1;
    for k = delay:iterations
        xallsteady(j) = xall(k) ;
        yallsteady(j) = yall(k) ;
        j = j + 1 ;
    end
    
    xmins(l) = min(xallsteady) ;
    xmaxs(l) = max(xallsteady) ;
    ymins(l) = min(yallsteady) ;
    ymaxs(l) = max(yallsteady) ;
    l = l + 1 ;
    
end

Vins = Vstep*(0:Viterations)' ;
%Vins = (0.1: 0.1: 1.6) ;

figure
hold on
scatter(Vins, xmaxs)
scatter(Vins, xmins)
title('ATP min/max vs Vin')
xlabel('[Vin]');

figure
hold on
scatter(Vins, ymaxs)
scatter(Vins, ymins)
title('Glucose min/max vs Vin')
xlabel('[Vin]');


% time = dt*(0:iterations-1)' ;
% figure
% hold on
% plot(time,xall,colors(2))
% plot(time,yall,colors(3))
% title('d[ATP]/dt & d[G]/dt vs time')
% figurelegend{1} = ['d[ATP]/dt']; 
% figurelegend{2} = ['d[G]/dt'];
% legend(figurelegend,'Location','Southeast') % create legend in bottom right
% 
% figure
% plot(xall,yall)
% title('2D Phase Plane')
% ylabel('[Glucose]');
% xlabel('[ATP]');
