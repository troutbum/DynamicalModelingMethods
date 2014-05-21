% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 4

% Question 1
% Download the following Matlab files:
% 
% novak.m : Master program for solving Novak-Tyson model
% dydt_novak.m : Function that computes derivatives of Novak-Tyson state variables 
% novak_cyclin.m : Program to test different levels of cyclin
% 
% As noted in the lectures, one of the important results of the Novak-Tyson
% model was that unreplicated DNA slowed the oscillations of MPF and
% cyclin. 

% This had been seen experimentally, and the model predicted that
% the presence of unreplicated DNA changed the location of the bifurcation
% due to the positive feedback loop. This prediction was later confirmed.
% 
% In terms of biochemistry, unreplicated DNA has been shown to make Wee1
% more active, and make Cdc25 less active, for a given value of MPF. 

% In the Novak-Tyson simulations, this was achieved by introducing a new
% variable corresponding to the concentration of unreplicated DNA, and
% making the rate constants kb and kf depend on this concentration.

% Do this in your model to reproduce the oscillations with unreplicated DNA
% shown in the lecture notes. You do not have to exactly match what is
% shown in the lecture notes, but the oscillations in the presence of
% unreplicated DNA should be noticeably larger and slower.
% 
% Hint 1: You can choose whatever form you like for how kb and kf depend on
% DNA concentration, but your equations should be such that when DNA = 0,
% kb and kf are equal to their control values.
% 
% Which of the following statements is correct?
%
% A. k kb and Kf gets smaller in presence of unreplicated DNA.
% B. Both kb and kf gets bigger in presence of unreplicated DNA.
% C. kb gets bigger and kf gets smaller in the presence of unreplicated DNA.
% D. kb gets smaller and kf gets bigger in the presence of unreplicated DNA




%%% Novak-Tyson (1993) model of Xenopus cell cycle
%%% As described in Sible & Tyson (2007)
%%% Some parameters modified as noted
%

% My modifications to model to see effect of unreplicated DNA
% from article:
%
% Journal of Cell Science 106, 1153-1168 (1993)
% Numerical analysis of a comprehensive model of M-phase control in Xenopus
% oocyte extracts and intact embryos
% Bela Novak* and John J. Tyson?
%
% Use the changes:
%
%     kb = 0.1 + 0.1*(uDNA/256) ;
%     kf = 0.1 + 0.08*(uDNA/256) ;

uDNA = 300 ; % vary unreplicated DNA from 0 to 300 (see saved figures)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 1:  Define constants 

global k1 k3
k1 = 1 ;
k3 = 0.005 ;

global ka Ka kb Kb kc Kc kd Kd
global ke Ke kf Kf kg Kg kh Kh
ka = 0.02 ;
Ka = 0.1 ;
%kb = 0.1 ; % original value
kb = 0.1 + 0.1*(uDNA/256) ;
Kb = 1 ;
kc = 0.13 ;
Kc = 0.01 ;
kd = 0.13 ;
Kd = 1 ;
ke = 0.02 ;
Ke = 1 ;
%kf = 0.1 ;  % original value
kf = 0.1 + 0.08*(uDNA/256) ;
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
xlabel('Time [min]')
title('Novak-Tyson Cell Cycle Model')
figurelegend{1} = ['Cyclin Total']; 
figurelegend{2} = ['MPF']; 
legend(figurelegend,'Location','Southeast') % create legend in bottom right


figure(2)
hold on
plot(MPF,cyclin_tot,'g','LineWidth',2.25)
set(gca,'TickDir','Out')
xlabel('MPF')
ylabel('Cyclin Total')
