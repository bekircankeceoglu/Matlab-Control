%{
Author: Bekircan Keceoglu
-Q:2_1
- autonomous system simulation
%}

x0 = [1;10];
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
t = 0:0.01:5;
var = 0.001;
noise = var * randn(1,numel(t));
w = noise;
v = var*randn(2,numel(t));

% system model
sys_wn0 = ss(Awn0, Gwn0, Cwn0, Dwn0);
[y0,t0,x0] = lsim(sys_wn0,w,t,x0);
y0_wNoise  = y0 + v';

subplot(2,1,1)
plot(t,w,t,y0,'LineWidth',2)
xlabel('t(s)')
legend('w','y')
grid
subplot(2,1,2)
plot(t,y0,t,y0_wNoise,'LineWidth',2)
xlabel('t(s)')
legend('y','y_n_o_i_s_y')
grid

% kalman filters applied
Q = eye(1);
R = eye(2, 2);

% filter 1 estimation
sys_wn1 = ss(Awn1, Gwn1, Cwn1, Dwn1);
kest_ft1 = kalman(sys_wn1,Q,R);
[ykf1,t1,x1] = lsim(kest_ft1,y0_wNoise,t);
% kalman filter 1 error
eKF1 = (ykf1(:,1) - y0_wNoise(:,1)).^2 + (ykf1(:,2) - y0_wNoise(:,2)).^2;

% filter 2 estimation
sys_wn2 = ss(Awn2, Gwn2, Cwn2, Dwn2);
kest_ft2 = kalman(sys_wn2,Q,R);
[ykf2,t2,x2] = lsim(kest_ft2,y0_wNoise,t);
% kalman filter 2 error
eKF2 = (ykf2(:,1) - y0_wNoise(:,1)).^2 + (ykf2(:,2) - y0_wNoise(:,2)).^2;

% filter 3 estimation
sys_wn3 = ss(Awn3, Gwn3, Cwn3, Dwn3);
kest_ft3 = kalman(sys_wn3,Q,R);
[ykf3,t3,x3] = lsim(kest_ft3,y0_wNoise,t);
% kalman filter 3 error
eKF3 = (ykf3(:,1) - y0_wNoise(:,1)).^2 + (ykf3(:,2) - y0_wNoise(:,2)).^2;

% decision maker: chooses instant min error  
allEstimations = [eKF1, eKF2, eKF3];
i = 1;
% find min kalman error and set its state 
while i  <= length(allEstimations)
    if min(allEstimations(i,:)) == eKF1(i:1)
        % choose out as kf1 out
        kf(i,1) = x1(i,1);
        kf(i,2) = x1(i,2);
    elseif min(allEstimations(i,:)) == eKF2(i:1)
        % choose out as kf2 out
        kf(i,1) = x2(i,1);
        kf(i,2) = x2(i,2);
    elseif min(allEstimations(i,:)) == eKF3(i:1)
        % choose out as kf3 out
        kf(i,1) = x3(i,1);
        kf(i,2) = x3(i,2);
    end
    i = i+1;
end

figure
subplot(2,2,1)
plot(t,x0(:,1),t,x1(:,1),t,x2(:,1),t,x3(:,1),'LineWidth',2)
ylabel('x1')
xlabel('t(s)')
legend('x1','x1_K_F_1','x1_K_F_2','x1_K_F_3')
xlim([0 5])
ylim([-2 3])
grid

subplot(2,2,2)
plot(t,x0(:,1),t,kf(:,1),'LineWidth',2)
ylabel('x1')
xlabel('t(s)')
legend('x1','x1_K_F')
xlim([0 5])
ylim([-2 3])
grid

subplot(2,2,3)
plot(t,x0(:,2),t,x1(:,2),t,x2(:,2),t,x3(:,2),'LineWidth',2)
ylabel('x2')
xlabel('t(s)')
legend('x2','x2_K_F_1','x2_K_F_2','x2_K_F_3')
xlim([0 5])
ylim([-10 10])
grid

subplot(2,2,4)
plot(t,x0(:,2),t,kf(:,2),'LineWidth',2)
ylabel('x2')
xlabel('t(s)')
legend('x2','x2_K_F')
xlim([0 5])
ylim([-10 10])
grid