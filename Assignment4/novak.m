%%% Novak-Tyson (1993) model of Xenopus cell cycle
%%% As described in Sible & Tyson (2007)
%%% Some parameters modified as noted
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 1:  Define constants 

global k1 k3
k1 = 1 ;
k3 = 0.005 ;

global ka Ka kb Kb kc Kc kd Kd
global ke Ke kf Kf kg Kg kh Kh
ka = 0.02 ;
Ka = 0.1 ;
kb = 0.1 ;
Kb = 1 ;
kc = 0.13 ;
Kc = 0.01 ;
kd = 0.13 ;
Kd = 1 ;
ke = 0.02 ;
Ke = 1 ;
kf = 0.1 ;
Kf = 1 ;
kg = 0.02 ;
Kg = 0.01 ;
kh = 0.15 ;
Kh = 0.01 ;

global v2_1 v2_2 v25_1 v25_2 vwee_1 vwee_2
v2_1 = 0.005 ;
v2_2 = 0.25 ;
% % These modified to increase bistability range
% v25_1 = 0.017 ;
% v25_2 = 0.17 ;
v25_1 = 0.5*0.017 ;
v25_2 = 0.5*0.17 ;
vwee_1 = 0.01 ;
vwee_2 = 1 ;

global CDK_total cdc25_total wee1_total IE_total APC_total PPase
CDK_total = 100 ;
% % This modified to increase bistability range
% cdc25_total = 1 ;
cdc25_total = 5 ;
wee1_total = 1 ;
IE_total = 1 ;
APC_total = 1 ;
PPase = 1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 2:  Define simulation time 

tlast = 1500 ; % min

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 3:  Initial conditions 

cyclin = 0 ;
MPF = 0 ;
preMPF = 0 ;
cdc25P = 0 ;
wee1P = 0 ;
IEP = 1 ;
APC = 1 ;

statevar_i = [cyclin,MPF,preMPF,cdc25P,wee1P,IEP,APC] ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 4:  Run it!

[time,statevars] = ode15s(@dydt_novak,[0,tlast],statevar_i) ;

cyclin = statevars(:,1) ;
MPF = statevars(:,2) ;
preMPF = statevars(:,3) ;
cdc25P = statevars(:,4) ;
wee1P = statevars(:,5) ;
IEP = statevars(:,6) ;
APC = statevars(:,7) ;

cyclin_tot = cyclin + MPF + preMPF ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 5:  Plot/save results

% % Note:  this implementation only plots stable limit cycles
% % This ignores initial condition-dependent effects
dices = find(time > 1000) ;
time = time(dices) - time(dices(1)) ;
cyclin_tot = cyclin_tot(dices) ;
MPF = MPF(dices) ;

figure
hold on
plot(time,cyclin_tot,'k','LineWidth',2.25) 
plot(time,MPF,'r','LineWidth',2.25) 
% plot(time,preMPF,'r')
% plot(time,cdc25P,'g')
% plot(time,wee1P,'m')
% plot(time,IEP,'c')
% plot(time,APC,'c')
set(gca,'TickDir','Out')

figure(2)
hold on
plot(MPF,cyclin_tot,'g','LineWidth',2.25)
set(gca,'TickDir','Out')
