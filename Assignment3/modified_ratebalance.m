% % Rate-balance plots
% % 
% % 3) partially saturated back, variable [Kmb]
% % 

Astar = 0:0.01:1 ;
% S = 0:0.02:0.5 ;
S = 0;
kplus = 2 ;
kfs = 30 ;
%Kmf = 0.5 ;
kminus = 5 ;
% h = 4 ; % exponent
Kmb = 0:0.01:0.25 ; % back reaction

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

