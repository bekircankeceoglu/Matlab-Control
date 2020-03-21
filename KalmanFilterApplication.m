% Bekircan Keceoglu
% Linear system controller design (DC Motor)
R = 2;    % resistance
L = 0.5;  % inductance
Km = 0.1; % armature const.
Kb = 0.1; % emk const.
Kf = 0.2; % friction const.
J = 0.02; % inertia moment

% State space
Am = [-R/L -Kb/L; Km/J -Kf/J];
Bm = [1/L; 0];
Cm = [0 1];
Dm = 0;
G = ss(Am, Bm, Cm, Dm)

T = 5; % square wave period
t = linspace(0,5*T,1000); % time vector
u = square(2*pi*1/T*t)'; % square wave

y = lsim(G,u,t); % system square wave response

plot(t,u,t,y,'LineWidth',1.5); % plot wave and response
ylim([-1.2 1.2]); 
legend('Input','Output'); 
xlabel('t (s)'); 

% Create kalman filter for integrated system
sysTum = ss(Am,[Bm Bm],Cm,[Dm Dm]);

Q = 1; R = 1; % kalman parameters
Kest1 = kalman(sysTum,Q,R) % desing kalman filter
figure
lsim(Kest1,[u y],t);  % kalman filter response

%% Noisy input and ouput
u2 = u + 0.1*randn(size(u)); % 0.1 amplitude noise added
y2 = y + 0.1*randn(size(u)); % 0.1 amplitude noise added
figure
lsim(Kest1,[u2 y2],t); % kalman filter response

%% Clean Ouput, Noisy Output, Kalman Estimation
figure; 

yest = lsim(Kest1,[u2 y2],t); % kalman filter response
subplot(3,1,1); 
plot(t,y); % clean output
subplot(3,1,2); 
plot(t,y2); % noisy output
subplot(3,1,3); 
plot(t,yest(:,1)); % kalman estimation