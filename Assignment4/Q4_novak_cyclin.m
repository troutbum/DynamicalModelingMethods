% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 4

% Question 4
% For this question, you will reproduce part of the bifurcation plot of
% versus [MPF] that was shown in the notes. The file novak_cyclin.m runs
% simulations over a range of different initial cyclin levels. For each
% simulation, the program keeps and stores the final value of MPF
% concentration in the variable MPF_end. 

% When all the simulations are finished, the script generates a plot of
% initial [cyclin] versus final [MPF]. 

% However, these results are nonsense. This is because the program computes
% cyclin synthesis and degradation whereas the bifurcation diagram was
% generated at fixed cyclin concentrations, e.g. both synthesis and
% degradation were inhibited.
% 
% Alter the program so that cyclin synthesis and degradation are inhibited.
% This will require altering some of the global parameters defined at the
% top of the script.
% 
% Which of the following parameters are needed to be changed to inhibit
% synthesis and degradation of cyclin?
% A.  k1 and k3
% B.  v2_1, v2_2, k1
% C.  k1, k3, v2_1, v2_2
% D.  k1

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
cdc25_total = 15 ;
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
