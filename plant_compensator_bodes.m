%Created for control systems compensation design assignment
clear all;
close all;

%section 6.2 measurements
freq  = [5,6,8,10,15,20,30,40,60,80,100,150,200,400,600,750,800,1000,1200,1500,2000,4000,5000];
gain  = [28.49203594,28.47630984,28.4457012,28.39724942,28.24549816,28.03959791,27.50138846,26.83639323,25.34022545,23.81802633,22.37664951,19.21806628,16.5883755,8.749094482,3.058645131,-0.433360732,-1.483444078,-5.264460174,-8.519112584,-12.70660146,-18.4488499,-33.9129755,-39.29336551];
phase = [-5.184,-6.912,-9.216,-12.96,-17.28,-21.888,-32.4,-40.896,-56.16,-65.8944,-74.88,-93.312,-104.256,-137.088,-154.656,-164.7,-167.04,-178.56,-183.168,-195.48,-205.2,-234.72,-239.4];

s=tf('s');

%plant transfer function (in radians)
plant = tf(26.95*(2*pi)^3*60*300*3000,[1,6720*pi,4392000*pi^2 ,432000000*pi^3 ]);

%lag compensator transfer function
lag_compensator = tf([4.545e-3, 1],[9.29*4.545e-3, 1]);
%lag amp gain
A = 4.709;

%lead compensator transfer function
lead_compensator = tf([0.15*4.109e-4, 0.15],[0.15*4.109e-4, 1]);
%lag amp gain
B = 4.73;

%lead-lag compensator transfer function
T1=1.848e-3;
T2=4.706e-4;
alpha =1/0.15;

lead_lag_compensator = ((1+s*T1)/(1+s*alpha*T1))*((1+s*T2)/(1+s*T2/alpha));

%lead-lag amp gain
C = 5.675;

opts = bodeoptions;
opts.FreqUnits = 'Hz';

figure(1);
hold on;

%% Plant RLD 
    rlocus(plant/26.95);
    title('Plant - Root locus diagram');
    grid on
    hold on;
    
%% Plant transfer function estimation
    bode(plant,opts);
    title('Plant transfer function estimation - Bode plot');
    grid on    
%% Plant measurements and transfer function estimation
    semilogx(freq,gain,'r-');
    bode(plant,opts);
    semilogx(freq,phase,'r-');
    title('Plant measurements and transfer function estimation - Bode plot');
    grid on
%% lag compensator design
    bode(lag_compensator,opts);
    title('Lag compensator design - Bode plot');
    grid on
%% lag compensated plant
    bode(lag_compensator*plant,opts);
    title('Lag compensated plant - Bode plot');
    grid on
%% lag compensated plant with gain
    bode(A*lag_compensator*plant,opts);
    grid on
    title('Lag compensated plant with gain - Bode plot');
%% lead compensator design
    bode(lead_compensator,opts);
    grid on    
    title('Lead compensator design - Bode plot');
%% lead compensated plant
    bode(lead_compensator*plant,opts);
    grid on
    title('Lead compensated plant - Bode plot');
%% lead compensated plant with gain
    bode(B*lead_compensator*plant,opts);
    grid on    
    title('Lead compensated plant with gain - Bode plot');
%% lead-lag compensator design
    bode(lead_lag_compensator,opts);
    grid on 
    title('Lead-lag compensator design - Bode plot');
%% lead-lag compensated plant
    bode(lead_lag_compensator*plant,opts);
    grid on
    title('Lead-lag compensated plant - Bode plot');
%% lead-lag compensated plant with gain
    bode(C*lead_lag_compensator*plant,opts);
    grid on
    title('Lead-lag compensated plant with gain - Bode plot');