%{
Author: Bekircan Keceoglu
-Q:2_2
- autonomous system simulation w/ simulink
%}

ounce = 0.1;
wn0    = 5;

Awn0 = [0 1; -(wn0^2) -2*wn0*ounce];
%Bwn0 = [0; 0];
Gwn0 = [0; wn0^2];
Cwn0 = [1 0; 0 1];
Dwn0 = [0; 0];

% filter 1
wn1    = 0.5;

Awn1 = [0 1; -(wn1^2) -2*wn1*ounce];
%Bwn1 = [0; 0];
Gwn1 = [0; wn1^2];
Cwn1 = [1 0; 0 1];
Dwn1 = [0; 0];

% filter 2
wn2    = 10;

Awn2 = [0 1; -(wn2^2) -2*wn2*ounce];
%Bwn2 = [0; 0];
Gwn2 = [0; wn2^2];
Cwn2 = [1 0; 0 1];
Dwn2 = [0; 0];

% filter 3
wn3    = 25;

Awn3 = [0 1; -(wn3^2) -2*wn3*ounce];
%Bwn3 = [0; 0];
Gwn3 = [0; wn3^2];
Cwn3 = [1 0; 0 1];
Dwn3 = [0; 0];

% noise
t = 0:0.001:5;
var = 0.001;
noise = var * randn(1,numel(t));
w = noise;
v = var*randn(2,numel(t));

Q = eye(1);
R = eye(2, 2);

w = [t' w'];
v = [t' v'];

sim('Simulink',5)
subplot(2,2,1)
plot(t, x.Data(:,1),t, xKF1.Data(:,1),t, xKF2.Data(:,1),t, xKF3.Data(:,1),'LineWidth',2)
ylabel('x1')
xlabel('t(s)')
legend('x1','x1_K_F_1','x1_K_F_2','x1_K_F_3')
xlim([0 5])
ylim([-2 3])
grid

subplot(2,2,2)
plot(t, x.Data(:,1),t, xKF.Data(:,1),'LineWidth',2)
ylabel('x1')
xlabel('t(s)')
legend('x1','x1_K_F')
xlim([0 5])
ylim([-2 3])
grid

subplot(2,2,3)
plot(t, x.Data(:,2),t, xKF1.Data(:,2),t, xKF2.Data(:,2),t, xKF3.Data(:,2),'LineWidth',2)
ylabel('x2')
xlabel('t(s)')
legend('x2','x2_K_F_1','x2_K_F_2','x2_K_F_3')
xlim([0 5])
ylim([-10 10])
grid

subplot(2,2,4)
plot(t, x.Data(:,2),t, xKF.Data(:,2),'LineWidth',2)
ylabel('x2')
xlabel('t(s)')
legend('x2','x2_K_F')
xlim([0 5])
ylim([-10 10])
grid