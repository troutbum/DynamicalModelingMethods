% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 3 - Question 7

% Question 7
% Vary lext over the range 1 to 7 and compute the temporal evolution of
% l?and LacY. For each simulation, store the final value of LacY.

% Run two sets of simulations: one in which the initial conditions are l=8,
% LacY=3, and a second in which the initial conditions are l=2, LacY=1.

% Generate a bifurcation diagram of how the final value of LacY varies as a
% function of lext. Plot the results of the two sets of simulations in
% different colors.

% Which of the following statements is correct? 
% A. For ? > 6 the system is bistable.
% B. When extracellular lactose is less than 1, the system is bistable.
% C. Changing the initial conditions of l and LacY can change the
% bifurcation points.
% D. When 2 < lext < 4 , the system is bistable.

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
   
lics = [8,2] ;       % lactose initial conditions
LacYics = [3,1] ;  % LacY initial conditions
tests = length(lics) ;

lext = [1:1:7] ;
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
        [colors(ii),'-'],'LineWidth',0.5)
    plot(time,squeeze(LacY_all(iii,ii,:)), ...
        [colors(ii),'-'],'LineWidth',3.2)
    else
      plot(time,squeeze(l_all(iii,ii,:)), ...
        [colors(ii),':'],'LineWidth',0.5)
          plot(time,squeeze(LacY_all(iii,ii,:)), ...
        [colors(ii),':'],'LineWidth',3.2)
    end % different values of lext
  end % different sets of initial conditions

end
xlabel('time (s)')
title('LacY (thick line) and lactose (thin line')
set(gca,'TickDir','Out')

% Plot Bifurcation Diagram
% Final value of LacY vs lext (external lactose)
figure
hold on
plot(lext,LacY_all(1,:,iterations),'g','LineWidth',2)
plot(lext,LacY_all(2,:,iterations),'r','LineWidth',2)
xlabel('External Lactose [lext]')
ylabel('LacY')
title('Bifurcation Diagram')
figurelegend{1} = ['initial conditions:  l=8 LacY=3']; 
figurelegend{2} = ['initial conditions:  l=2 LacY=1']; 
legend(figurelegend,'Location','Southeast') % create legend in bottom right
