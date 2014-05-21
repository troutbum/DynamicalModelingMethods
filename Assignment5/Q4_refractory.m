% Dynamical Modeling Methods for Systems Biology
% Mar 2014
% Assignment 5

% Question 4
% Now let's consider the simulation of the refractory period shown in the
% lectures. Expand the script hh.m to simulate this experiment, and
% determine the duration of the refractory period for a 1 ms depolarizing
% stimulus with amplitude of -10. Thus your code will need to simulate an
% initial stimulus to induce an action potential, then a second stimulus
% that may or may not induce an action potential, depending on when it is
% delivered. Some hints on how to modify the code to achieve this:
% 
% a. First change the initial duration to 1 ms, and the initial stimulus
% amplitude to -10.
% 
% b. The program already contains a for loop, which covers the 3 intervals
% of the simulation (more on these intervals below). You will need to
% enclose this within a second for loop, covering the different intervals
% between the two stimuli. An appropriate range to test is from 5 to 20 ms.
% Since the existing loop is defined for i=1:simints, the outer loop will
% have to be for a different variable.
% 
% c. Right now the code defines an initial delay called stimdelay, and
% variables called stim_start and stim_end that depend on the delay and the
% stimulus duration. Your new program will need to include variables
% defining two such stimuli. Remember that each time you test a different
% interval between stimuli, the first stim_start and stim_end will stay the
% same, but the second stim_start and stim_end will change.
% 
% d. Currently the code divides time into 3 intervals: (1) before the
% stimulus, (2) during the stimulus, (3) after the stimulus. Now you need
% to divide time into 5 intervals, and figure out how to define these
% appropriately with respect to the first and second stimuli. Also, the
% variable simints defines the number of intervals, and this will need to
% be changed.
% 
% e. Once you correctly define the five intervals (i.e. intervals(1,:)
% through intervals(5,:)), you will need to correctly define the 5 values
% of Istim.
% 
% f. When your program is looping through many different intervals, there
% is no need to pop up a new figure containing 4 subplots each time. Better
% to pop up a single figure, use the hold on command, and superimpose the
% different voltage traces. You can use the command
% 
% colors = repmat('krgmbc',1,500)
% 
% if you want to plot results in a particular repeating order of different
% colors.
% 
% Applying the second stimulus within which of the following time intervals
% can not induce an action potential? (Second stimulus has the same
% strength and duration as the first one: 1 ms depolarizing stimulus with
% amplitude of -10. For this case assume that the first stimulus is applied
% after 1 ms, initial delay or stimdelay=1)
%
% A. 8 < t < 19
% B. 7 < t < 11
% C. 13 < t < 20
% D. 6 < t < 21


% %% Hodgkin-Huxley model
%    
%    t                   time                    ms
%    V                   membrane potantial      mV
%    INa,IK,Il,Iion      ionic current           uA/cm2
%    Cm                  capacitance             uF/cm2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Step 1:  Define all constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Physical constants
global F R T RTF 
F = 96.5;                   % Faraday constant, coulombs/mmol
R = 8.314;                  % gas constant, J/K
T_celsius = 6.3;            % Temperature in celsius
T = 273 + T_celsius ;       % absolute temperature, K 

RTF = R*T/F ;

% default concentrations for squid axon in sea water - mmol/l
global Nao Ko Nai Ki 
Nao = 491 ;
Ko = 20 ;
Nai = 50 ;
Ki = 400 ;

% Cell constant
global Cm 
Cm = 1 ;                            % membrane capacitance, uF/cm^2;

% Maximum channel conductances -- mS/cm^2
global GNa GK Gl ENa EK El 
GNa = 120;
GK = 36;
Gl = 0.3;

% Nernst potentials -- mV
ENa = RTF*log(Nao/Nai);
EK = RTF*log(Ko/Ki);
El =  -49;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Step 2:  Define simulation and stimulus parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tend =  50 ;              % end of simulation, ms

stimdelay = 1 ;
stimdur = 1 ;
stim_amp = -10 ;

stim_start = stimdelay ;
stim_end = stimdelay + stimdur ;

% % % Intervals defined as follows
% % % 1) t=0 zero to beginning of stimulus
% % % 2) beginning to end of stimulus
% % % 3) end of stimulus to end of simulation
simints = 3 ;

intervals(1,:) = [0,stim_start] ;
intervals(2,:) = [stim_start,stim_end] ;
intervals(3,:) = [stim_end,tend] ;

Istim(1) = 0 ;
Istim(2) = stim_amp ;
Istim(3) = 0 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Step 3:  Set initial conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V = -60 ;
m = 0 ;
h = 0.6 ;
n = 0.3 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Step 4:  Loop through and solve model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statevar_i = [V,m,h,n] ;

% % Simulate 60 seconds at rest before stimulus applied
[post,posstatevars] = ode15s(@dydt_hh,[0,60000],statevar_i,[],0) ;
statevar_i = posstatevars(end,:) ;

t = 0 ;
statevars = statevar_i ;
for i=1:simints
  [post,posstatevars] = ode15s(@dydt_hh,intervals(i,:),statevar_i,[],Istim(i)) ;
  t = [t;post(2:end)] ;
  statevars = [statevars;posstatevars(2:end,:)] ;
  statevar_i = posstatevars(end,:) ;
end

outputcell = num2cell(statevars,1) ;

[V,m,h,n] = deal(outputcell{:}) ;

gNa = GNa*m.^3.*h;
INa = gNa.*(V-ENa);

gK = GK*n.^4; 
IK = gK.*(V-EK);

Il = Gl*(V-El) ;
Iion = INa + IK + Il ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Step 5:  Plot or write output to files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
subplot(2,2,1)
plot(t,V)
set(gca,'TickDir','Out')
xlabel('time (ms)')
ylabel('V_m (mV)')

subplot(2,2,2)
hold on
plot(t,INa,'b')
plot(t,IK,'r')
plot(t,Il,'g')
set(gca,'TickDir','Out')
legend('I_N_a','I_K','I_L')
xlabel('time (ms)')
ylabel('Ionic current')
hold off

subplot(2,2,3)
hold on
plot(t,gNa,'b')
plot(t,gK,'r')
set(gca,'TickDir','Out')
legend('g_N_a','g_K')
xlabel('time (ms)')
ylabel('Conductances')

subplot(2,2,4)
hold on
plot(t,m,'b')
plot(t,h,'r')
plot(t,n,'g')
set(gca,'TickDir','Out')
legend('m','h','n')
xlabel('time (ms)')
ylabel('Gating variables')


