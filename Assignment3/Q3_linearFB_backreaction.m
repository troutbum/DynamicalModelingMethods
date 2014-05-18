% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 3 - Question 3

% Rate-balance plots
% 
% 3) partially saturated back reaction
% variable [Kmb]
%

% Question 3
% In the above case assume that Kmb is fixed and equals to 1 , which of the
% following statements is correct? (kminus = 5, kplus=2, kf=30) (Remeber
% that S can not be a negative number)

% A.  The system shows bistability when S>1.
% B.  <<--ANSWER The system is always mono-stable regardless of value of S.
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
title('Bifurcation Diagram')
