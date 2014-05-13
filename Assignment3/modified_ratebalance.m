% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 3

% Rate-balance plots
% 
% 3) partially saturated back reaction
% variable [Kmb]
%

% Question 2
% Bistability can be produced with ultrasensitive feedback as in the
% example. It is not possible with linear feedback and a first order
% reverse rate. However, bistability can be produced if linear
% autocatalytic feedback is combined with a "back reaction" that becomes
% partially saturated when the level of product (A* in this case)
% increases.
% 
% Consider the linear feedback plus saturating back reaction:
% 
% 
% 
% Modify ratebalance.m to simulate this condition. You can assume that the
% stimulus S is zero. Use the following constants: kminus = 5; = 0.1,
% kplus=2, kf=30.
% 
% Test several different values of  and determine which values of  produce
% bistability. You will have to determine the "interesting" range of
% values to examine. Plot your results as a bifurcation diagram:  on the
% abscissa, steady-state values of [A*] on the ordinate. Lines 61-69 in the
% program are written to be able to accommodate the situation in which one
% or multiple steady-states are possible.
% 
% Which of the following statements is correct about  and bistability in
% this system? (Assume: kminus = 5, kplus=2, kf=30, S=1) 
% A.  The only condition in which bistability present is when Kmb >1. 
% B.  When  Kmb >0.1 bistability is present. 
% <<C>>.  When Kmb >3 , there is no bistability in the system. 
% D.  There is no bistability in the system when 0.1 > Kmb  .

Astar = 0:0.01:1 ;
S = 1;
kplus = 2 ;
kfs = 30 ;
kminus = 5 ;
%Kmb = 0:0.2:4 ; % back reaction
Kmb = 1 ; % back reaction

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

% Question 3
% In the above case assume that  is fixed and equals to 1 , which of the
% following statements is correct? (kminus = 5, kplus=2, kf=30) (Remeber
% that S can not be a negative number)
% A.  The system shows bistability when S>1.
% <<B>>.  The system is always mono-stable regardless of value of S.
% C.  The system shows bistability when 0.1<S<1 .
% D.  The system shows bistability when S>3.


Astar = 0:0.01:1 ;
S = 0:0.25:5;
kplus = 2 ;
kfs = 30 ;
kminus = 5 ;
Kmb = 1 ; % back reaction is fixed

% Plot Forward/Backward Rates vs Phosphorylation
figure
handle1 = gcf ;  % "get current figure"
hold on 
set(gca,'TickDir','Out')  % "get current axes"

% Plot Bifurcation Diagram (where BR=FR)
% Phosphorylation as a function of S
figure
handle2 = gcf ;
hold on

% iterate for varying increments of Kmb
for i=1:length(S)
  BR = kminus*(Astar./(Astar + Kmb)) ;  
  FR = (kplus.*S(i) + kfs.*Astar).*(1-Astar) ;
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
  plot(S(i),Astar(crossings),'bo')
  
end

% decorate plots
figure(handle1)
axis([0 1 0 max(FR)])
set(gca,'TickDir','Out')
xlabel('[A*]/[A]')
ylabel('Rates')

figure(handle2)
set(gca,'TickDir','Out')
xlabel('Stimulus [S]')
ylabel('Steady-state [A*]/[A]')

