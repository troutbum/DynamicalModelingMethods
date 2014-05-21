% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 4

% Question 5 
% With which of the following concentration of total Cdc25, the
% concentration of total cyclin needs to activate MPF is lower?

% A. Total Cdc25=5
% B. Total Cdc25=2
% C. Total Cdc25=8
% D. Total Cdc25=15

%%% Novak-Tyson (1993) model of Xenopus cell cycle
%%% As described in Sible & Tyson (2007)
%%% Some parameters modified as noted
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 1:  Define constants 

global k1 k3
k1 = 0 ;    % turn off synthesis
% k1 = 1 ;  % original value
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
v2_1 = 0 ; % turn off degradation k2 = f(v2_1, v2_2)
v2_2 = 0 ;
% v2_1 = 0.005 ;  % original value
% v2_2 = 0.25 ;   % original value
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
cdc25_total = 15 ;   % vary this amount to answer question
wee1_total = 1 ;
IE_total = 1 ;
APC_total = 1 ;
PPase = 1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 2:  Define simulation time 

tlast = 1500 ; % min

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 3:  Initial conditions 

cyclinvalues = 1:1:24 ;

for i=1:length(cyclinvalues) 

cyclin = cyclinvalues(i) ;
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
statevar_i = statevars(end,:) ;

MPF = statevars(:,2) ;
MPF_end(i) = MPF(end) ;

end

figure
plot(cyclinvalues,MPF_end,'bo')
set(gca,'TickDir','Out')
xlabel('Total [cyclin]')
ylabel('[MPF]')
