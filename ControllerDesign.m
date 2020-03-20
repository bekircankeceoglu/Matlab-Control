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

tf(G) % tf representation
impulse(G); % impulse response
figure
step(G); % step response

%% P Control
KpList = linspace(1,30,10); % create 10 gain for p control
figure
for i = 1:length(KpList)
    Kp = KpList(i);
    sysCL = feedback(Kp*G,1); % feedback control
    step(sysCL,2); % step response for 2s
    legendList{i} = ['Kp = ',num2str(Kp)];
    hold all;
end
hold off;
legend(legendList);

%% PI Control
s = tf('s')
KpList = linspace(1,30,6); % create 6 gain for p control
KiList = linspace(1,30,6); % create 6 gain for i control
figure
for i = 1:length(KpList)
    for j = 1:length(KiList)
        Kp = KpList(i);
        Ki = KiList(j);
        C = Kp+Ki/s;
        sysCL = feedback(C*G,1);
        subplot(3,2,j);
        step(sysCL,5);
        title(['Kp=', num2str(Kp) ,' Ki=', num2str(Ki)]);
    end
end


