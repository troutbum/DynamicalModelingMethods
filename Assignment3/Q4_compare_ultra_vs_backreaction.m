% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 3 - Question 4

% Question 4 
% What if a system has both ultrasensitive autocatalytic
% feedback and a back reaction that becomes saturated? Is bistability in
% such a system likely to be less robust or more robust compared with a
% system that contains only one of these features? You do not have to
% explicitly simulate this condition, but you should be able to make an
% argument based on the shapes of the forward and backwards reaction rates.
% If you do choose to simulate this, it is probably easiest to modify the
% code so that it simulates several values of stimulus [S] but only single
% values of other parameters. Using the following parameter sets which
% statement is correct when comparing a system with ultrasensitive
% autocatalytic feedback loop, a system with linear feedback plus
% saturating back reaction and a system which has both of this conditions?
% (kminus = 5; ? = 0.5, kplus=0.5, kf=30, Kmf = 0.5, h = 4 ) 

% A.  Ultrasensitive autocatalytic feedback loop, linear feedback loop plus
% saturating back reaction, and a system with both of them show bistability
% in the same range of values of parameter S.

% B. Ultrasensitive autocatalytic feedback loop with a back reaction that
% becomes saturated shows bistability in a longer range of values of
% parameter S.

% C. Ultrasensitive autocatalytic feedback loop shows bistability in a longer
% range of values of parameter S.  (<<-- ANSWER)

% D. Linear feedback plus saturating back reaction shows bistability in a
% longer range of values of parameter S.

Astar = 0:0.01:1 ;
S = 0:0.2:10 ;
kminus = 5 ;
Kmb = 0.5 ;
kplus = 0.5 ;
kfs = 30 ;
Kmf = 0.5 ;
h = 4 ; % exponent

% ULTRASENSATIVE FEEDBACK
%
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

% iterate for varying increments of S
for i=1:length(S)
  %BR = kminus*(Astar./(Astar + Kmb(i))) ;  
  %FR = (kfs.*Astar).*(1-Astar) ;
  BR = kminus*Astar ;
  FR = (kplus*S(i)+kfs*(Astar.^h./(Astar.^h+Kmf^h))).*(1-Astar) ;
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
title('Ultrasensitive feedback, variable [S]')

figure(handle2)
set(gca,'TickDir','Out')
xlabel('Stimulus [S]')
ylabel('Steady-state [A*]/[A]')
title('Bifurcation Diagram - Ultrasensative Feedback')

%LINEAR FEEDBACK with BACK REACTION
%
% Plot Forward/Backward Rates vs Phosphorylation
figure
handle3 = gcf ;  % "get current figure"
hold on 
set(gca,'TickDir','Out')  % "get current axes"

% Plot Bifurcation Diagram (where BR=FR)
% Phosphorylation as a function of Kmb
figure
handle4 = gcf ;
hold on

% iterate for varying increments of S
for i=1:length(S)
  BR = kminus*(Astar/(Astar + Kmb)) ;  
  FR = (kplus*S(i) + kfs.*Astar).*(1-Astar) ;
  %BR = kminus*Astar ;
  %FR = (kplus*S(i)+kfs*(Astar.^h./(Astar.^h+Kmf^h))).*(1-Astar) ;
  figure(handle3)
  plot(Astar,FR,'b','LineWidth',2)
  plot(Astar,BR,'r','LineWidth',2)
  
  crossings = [] ;
  difference = FR-BR ;
  for iii=2:length(FR)
    if (sign(difference(iii)) ~= sign(difference(iii-1)))
      crossings = [crossings,iii] ;
    end
  end
  figure(handle4)
  plot(S(i),Astar(crossings),'bo')
  
end

% decorate plots
figure(handle3)
axis([0 1 0 max(FR)])
set(gca,'TickDir','Out')
xlabel('[A*]/[A]')
ylabel('Rates')
title('Linear feedback with Back Reaction, variable [S]')

figure(handle4)
set(gca,'TickDir','Out')
xlabel('Stimulus [S]')
ylabel('Steady-state [A*]/[A]')
title('Bifurcation Diagram - Linear Feedback with Back Reaction')

%ULTRASENSATIVE FEEDBACK with BACK REACTION
%
% Plot Forward/Backward Rates vs Phosphorylation
figure
handle5 = gcf ;  % "get current figure"
hold on 
set(gca,'TickDir','Out')  % "get current axes"

% Plot Bifurcation Diagram (where BR=FR)
% Phosphorylation as a function of Kmb
figure
handle6 = gcf ;
hold on

% iterate for varying increments of S
for i=1:length(S)
  BR = kminus*(Astar/(Astar + Kmb)) ;  
  %FR = (kplus*S(i) + kfs.*Astar).*(1-Astar) ;
  %BR = kminus*Astar ;
  FR = (kplus*S(i)+kfs*(Astar.^h./(Astar.^h+Kmf^h))).*(1-Astar) ;
  figure(handle5)
  plot(Astar,FR,'b','LineWidth',2)
  plot(Astar,BR,'r','LineWidth',2)
  
  crossings = [] ;
  difference = FR-BR ;
  for iii=2:length(FR)
    if (sign(difference(iii)) ~= sign(difference(iii-1)))
      crossings = [crossings,iii] ;
    end
  end
  figure(handle6)
  plot(S(i),Astar(crossings),'bo')
  
end

% decorate plots
figure(handle5)
axis([0 1 0 max(FR)])
set(gca,'TickDir','Out')
xlabel('[A*]/[A]')
ylabel('Rates')
title('Ultrasensative feedback with Back Reaction, variable [S]')

figure(handle6)
set(gca,'TickDir','Out')
xlabel('Stimulus [S]')
ylabel('Steady-state [A*]/[A]')
title('Bifurcation Diagram - Ultrasensative Feedback with Back Reaction')