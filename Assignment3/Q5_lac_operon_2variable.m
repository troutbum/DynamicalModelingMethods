% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 3 - Question 5

% Question 5 
% We now implement a simple two-variable model of the E. coli
% lac operon. The differential equations governing this system are as
% follows:

beta = 1 ;
gamma = 1 ;
rho = 0.2
l0 = 4 ;
p = 4 ;
s = 1 ;
lext = 2.5 ; % external lactose

% The variable (lext), representing extracellular lactose, is the variable that
% can vary and potentially cause the bacteria to change states. Plot the
% nullclines of this model for lext=2.5. Because of the l^4 term appearing in
% the second equation, it is easiest to treat LacY as the dependent
% variable (ordinate) and l as the independent variable (abscissa). Which
% of the following statements is correct?


% Plot Forward/Backward Rates vs Phosphorylation
figure
handle1 = gcf ;  % "get current figure"
hold on 
set(gca,'TickDir','Out')  % "get current axes"

% Plot Bifurcation Diagram (where BR=FR)
% Phosphorylation as a function of Kmb
figure
handle2 = gcf ;
hold on

% iterate for varying increments of Kmb
for i=1:length(Kmb)
  BR = kminus*(Astar./(Astar + Kmb(i))) ;  
  FR = (kfs.*Astar).*(1-Astar) ;
  figure(handle1)
  plot(Astar,FR,'b','LineWidth',2)
  plot(Astar,BR,'r','LineWidth',2)
  
  crossings = [] ;
  difference = FR-BR ;
  for iii=2:length(FR)
    if (sign(difference(iii)) ~= sign(difference(iii-1)))
      crossings = [crossings,iii] ;
    end
  end
  figure(handle2)
  plot(Kmb(i),Astar(crossings),'bo')
  
end

% decorate plots
figure(handle1)
axis([0 1 0 max(FR)])
set(gca,'TickDir','Out')
xlabel('[A*]/[A]')
ylabel('Rates')

figure(handle2)
set(gca,'TickDir','Out')
xlabel('Partially Saturated Back Reaction Coeff [Kmb]')
ylabel('Steady-state [A*]/[A]')
title('Bifurcation Diagram')