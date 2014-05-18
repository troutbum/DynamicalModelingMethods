% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 3 - Question 5

% Question 5 
% We now implement a simple two-variable model of the E. coli
% lac operon. The differential equations governing this system are as
% follows:

% constants
beta = 1 ;
gamma = 1 ;
delta = 0.2
lzero = 4 ;
p = 4 ;
sigma = 1 ;

% l = intracellular lactose (independent variable)
l = 0:0.05:15 ;

% lext (external lactose) is the variable that can vary and potentially
% cause the bacteria to change states.
% Plot the nullclines of this model for lext=2.5.

lext = 2.5 ; 

% Because of the l^4 term appearing in the second equation, it is easiest
% to treat LacY as the dependent variable (ordinate) and l as the
% independent variable (abscissa).

% Nucline for lactose (dl/dt)
% Solve dl/dt=0 
% --> FR: LacY =(gamma*l)/(beta*lext) ;
%
% Nullcline for LacY (dLacY/dt)
% Solve dLacY/dt=0 
% --> BR: LacY =(delta + p*(l^4/(l^4 + l0^4)))/sigma

% Which of the following statements is correct?
%
% A. Nullclines intersect in three points which all of them are stable
% steady states.
% B. Above the LacY nullcline, LacY and  are increasing. 
% C. Nullclines intersect in three points which one of them is an unstable
% steady states.
% D. Nullclines intersect in two points which both of them are unstable
% steady states.



% Plot LacY vs l (intracellular lactose)
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
for i=1:length(lext)
  BR = (gamma.*l)/(beta*lext) ;
  FR = (delta + (p .* ((l.^4) ./ ((l.^4) + (lzero^4)))))./sigma
  figure(handle1)
  plot(l,FR,'b','LineWidth',2)
  plot(l,BR,'r','LineWidth',2)
  
  crossings = [] ;
  difference = FR-BR ;
  for iii=2:length(FR)
    if (sign(difference(iii)) ~= sign(difference(iii-1)))
      crossings = [crossings,iii] ;
    end
  end
  figure(handle2)
  plot(lext(i),l(crossings),'bo')
  
end

% decorate plots
figure(handle1)
axis([0 max(l) 0 max(FR)])
set(gca,'TickDir','Out')
xlabel('[LacY]')
ylabel('[lactose]')
title('Lac Operon Model for E. Coli')

figure(handle2)
set(gca,'TickDir','Out')
xlabel('Partially Saturated Back Reaction Coeff [Kmb]')
ylabel('Steady-state [A*]/[A]')
title('Bifurcation Diagram')