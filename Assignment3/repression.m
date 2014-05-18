colors = repmat('krgbmc',1,300) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1:  Define constants 

k0r = 0 ;
k1r = 0.25 ;
k2r = 0.1 ;
k3r = 0.5 ;

k1e = 1 ;
k2e = 0.2 ;
Km1e = 0.05 ;
Km2e = 0.05 ;
Etot = 1 ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2:  Define parameters that will be varied 
   
Rics = [0.5,30] ;
tests = length(Rics) ;
S = [2,6,12] ;
trials = length(S) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 3:  Define time step, simulation time, initialize matrices 
dt    = 5e-3 ; % s 
tlast = 50.000 ;  % s
iterations = fix(tlast/dt) ;
time = dt*(0:iterations-1) ;
%%%%%

R_all = zeros(tests,trials,iterations) ;
R_last = zeros(tests,trials) ;

figure
hold on 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 4:  Run for different ICs, values of S 
for iii=1:tests % different initial conditions
    
  for ii=1:trials % different values of S
     
    R = Rics(iii) ;
    E = 0.02 ;
  
    for i = 1:iterations

      R_all(iii,ii,i) = R ;
      dR = k0r + k1r*S(ii) - (k2r + k3r*E)*R ;
      dE = -k2e*R*E/(Km2e + E) + k1e*(Etot - E)/(Km1e + Etot - E) ;
      R = R + dt*dR ;
      E = E + dt*dE ;
   
    end % of this time step
    R_last(iii,ii) = R ;
    if (iii==1)
      plot(time,squeeze(R_all(iii,ii,:)), ...
        [colors(ii),'-'],'LineWidth',2.2)
    else
      plot(time,squeeze(R_all(iii,ii,:)), ...
        [colors(ii),':'],'LineWidth',2.2)
    end % different values of S
  end % different sets of initial conditions

end
xlabel('time (s)')
ylabel('[R] (uM)')
set(gca,'TickDir','Out')

