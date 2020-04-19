%{
Author: Bekircan Keceoglu
Soru2_Matlab Linearization
%}
% linear analysis tool results
A = [-1 -0.01; 1 0];
B = [1; 0];
C = [0 1];
D = [0];

% create state-space model
sys = ss(A,B,C,D);
% linearized system impulse response
figure
impulse(sys);
title('Sistem Durtu Cevabi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
% linearized system step response
figure
step(sys);
title('Sistem Basamak Cevabi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid

% square wave
T = 5;
t = linspace(0,5*T,1000);
u = square(2*pi*1/T*t)';
% system response
y = lsim(sys, u ,t);

figure
subplot(2,1,1)
plot(t,u);
title('Kare Dalga Giris')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(2,1,2)
plot(t,y);
title('Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid

% create integrated system
sysTum = ss(A, [B B], C, [D D]);
% kalman filter parameters
Q = 1; R= 1;
%create kalman filter
Kest1 = kalman(sysTum,Q,R); 
% kalman filter response
figure
est1 = lsim(Kest1,[u y],t);
subplot(2,1,1)
plot(t,y)
title('Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(2,1,2)
plot(t,est1(:,1))
title('Kalman Filtresi Tahmini(Q = 1, R = 1)')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid

% add noise
u_noisy = u + 0.1*randn(size(u));
y_noisy = y + 0.1*randn(size(y));
% kalman filter response
figure
est1 = lsim(Kest1,[u_noisy y_noisy],t);
subplot(3,1,1)
plot(t,y)
title('Gürültüsuz Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(3,1,2)
plot(t,y_noisy)
title('Gürültülü Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(3,1,3)
plot(t,est1(:,1))
title('Kalman Filtresi Tahmini(Q = 1, R = 1)')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid

% different kalman parameters
% kalman filter parameters
Q = 10; R= 0.1;
%create kalman filter
Kest2 = kalman(sysTum,Q,R); 
% kalman filter response
figure
est2 = lsim(Kest2,[u y],t);
subplot(2,1,1)
plot(t,y)
title('Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(2,1,2)
plot(t,est2(:,1))
title('Kalman Filtresi Tahmini(Q = 10, R = 0.1)')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid

% add noise
u_noisy = u + 0.1*randn(size(u));
y_noisy = y + 0.1*randn(size(y));
% kalman filter response
figure
est2 = lsim(Kest2,[u_noisy y_noisy],t);
subplot(3,1,1)
plot(t,y)
title('Gürültüsuz Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(3,1,2)
plot(t,y_noisy)
title('Gürültülü Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(3,1,3)
plot(t,est2(:,1))
title('Kalman Filtresi Tahmini(Q = 10, R = 0.1)')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid

% different kalman parameters
% kalman filter parameters
Q = 0.1; R= 10;
%create kalman filter
Kest3 = kalman(sysTum,Q,R); 
% kalman filter response
figure
est3 = lsim(Kest3,[u y],t);
subplot(2,1,1)
plot(t,y)
title('Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(2,1,2)
plot(t,est3(:,1))
title('Kalman Filtresi Tahmini(Q = 0.1, R = 10)')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid

% add noise
u_noisy = u + 0.1*randn(size(u));
y_noisy = y + 0.1*randn(size(y));
% kalman filter response
figure
est3 = lsim(Kest3,[u_noisy y_noisy],t);
subplot(3,1,1)
plot(t,y)
title('Gürültüsuz Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(3,1,2)
plot(t,y_noisy)
title('Gürültülü Sistem Cikisi')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
subplot(3,1,3)
plot(t,est3(:,1))
title('Kalman Filtresi Tahmini(Q = 0.1, R = 10)')
xlabel('Zaman(sn)')
ylabel('Genlik')
grid
