% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 3 - Question 6

% Modify the program repression.m so that this model now simulates the
% temporal evolution of l and LacY. To reach steady-state, a total
% simulation time of 20 seconds is reasonable, and the solution converges
% with a time step of 0.01 if Euler's method is used.
%
% For lext= 2.5, plot the time evolution of LacY and l for the following
% initial conditions:
% 
% 1)  l=8, LacY=3;
% 2)  l=3, LacY=1.3;
% 3)  l=3, LacY=1.2;
% 4)  l=2, LacY=1;
% 
% Which of the following statements is correct?
% A. Initial values of LacY and  determine if they will reach their lower
% or higher stable steady state levels.
% B. Changing the initial condition of LacY and can remove the bistability
% from the system.
% C. l has always lower stable steady state levels compared to LacY.
% D. LacY has two stable steady states and l has one stable steady state.


colors = repmat('krgbmc',1,300) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1:  Define constants 

beta = 1 ;
gamma = 1 ;
delta = 0.2 ;
lzero = 4 ;
p = 4 ;
sigma = 1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2:  Define parameters that will be varied 
   
lics = [8,3,3,2] ;       % lactose initial conditions
LacYics = [3,1.3,1.2,1] ;  % LacY initial conditions
tests = length(lics) ;

lext = [2.5] ;
trials = length(lext) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 3:  Define time step, simulation time, initialize matrices 
dt    = 1e-2 ; % s 
tlast = 20.000 ;  % s
iterations = fix(tlast/dt) ;
time = dt*(0:iterations-1) ;
%%%%%

l_all = zeros(tests,trials,iterations) ;
l_last = zeros(tests,trials) ;
LacY_all = zeros(tests,trials,iterations) ;
LacY_last = zeros(tests,trials) ;

figure
hold on 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 4:  Run for different ICs, values of lext
for iii=1:tests % different initial conditions
    
  for ii=1:trials % different values of lext

     l = lics(iii) ;
     LacY = LacYics(iii) ;
    
    for i = 1:iterations

      l_all(iii,ii,i) = l ;
      LacY_all(iii,ii,i) = LacY ;
      dl = (beta*lext(ii)*LacY) - (gamma*l) ;
      dLacY = delta + (p*(l^4/((l^4)+lzero^4))) - sigma*LacY ;
      l = l + dt*dl ;
      LacY = LacY + dt*dLacY ;
   
    end % of this time step
    
    l_last(iii,ii) = l ;
    LacY_last(iii,ii) = LacY ;
    
    if (iii==1)
        
    plot(time,squeeze(l_all(iii,ii,:)), ...
        [colors(iii),'-'],'LineWidth',0.5)
    plot(time,squeeze(LacY_all(iii,ii,:)), ...
        [colors(iii),'-'],'LineWidth',3.2)
    else
      plot(time,squeeze(l_all(iii,ii,:)), ...
        [colors(iii),':'],'LineWidth',0.5)
          plot(time,squeeze(LacY_all(iii,ii,:)), ...
        [colors(iii),':'],'LineWidth',3.2)
    end % different values of lext
  end % different sets of initial conditions

end
xlabel('time (s)')
title('LacY (thick line) and lactose (thin line')
set(gca,'TickDir','Out')

