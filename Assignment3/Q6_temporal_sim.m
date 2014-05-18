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
delta = 0.2
lzero = 4 ;
p = 4 ;
sigma = 1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2:  Define parameters that will be varied 
   
Rics = [0.5,30] ;
tests = length(Rics) ;
S = [2,6,12] ;
trials = length(S) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 3:  Define time step, simulation time, initialize matrices 
dt    = 5e-3 ; % s 
tlast = 50.000 ;  % s
iterations = fix(tlast/dt) ;
time = dt*(0:iterations-1) ;
%%%%%

R_all = zeros(tests,trials,iterations) ;
R_last = zeros(tests,trials) ;

figure
hold on 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 4:  Run for different ICs, values of S 
for iii=1:tests % different initial conditions
    
  for ii=1:trials % different values of S
     
    R = Rics(iii) ;
    E = 0.02 ;
  
    for i = 1:iterations

      R_all(iii,ii,i) = R ;
      dR = k0r + k1r*S(ii) - (k2r + k3r*E)*R ;
      dE = -k2e*R*E/(Km2e + E) + k1e*(Etot - E)/(Km1e + Etot - E) ;
      R = R + dt*dR ;
      E = E + dt*dE ;
   
    end % of this time step
    R_last(iii,ii) = R ;
    if (iii==1)
      plot(time,squeeze(R_all(iii,ii,:)), ...
        [colors(ii),'-'],'LineWidth',2.2)
    else
      plot(time,squeeze(R_all(iii,ii,:)), ...
        [colors(ii),':'],'LineWidth',2.2)
    end % different values of S
  end % different sets of initial conditions

end
xlabel('time (s)')
ylabel('[R] (uM)')
set(gca,'TickDir','Out')

