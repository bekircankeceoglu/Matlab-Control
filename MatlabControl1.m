% Bekircan Keceoglu
%% Transfer Function Representation
% some system
num = [2 6];    % nominator
den = [1 5 9 5];% denominator

G = tf(num,den) % transfer function

% more strict way
s =  tf('s')  % lablace variable
G = (2*s+6)/(s^3+5*s^2+9*s+5) % transfer function

%% Other useful TF functions
% get num and den from tf function
[num, den] = tfdata(G)

z = zero(G) % find zeros
p = pole(G) % find poles

pzmap(G); % sign zeros and poles 
grid;

%% TF ZPK Repsesentation
z = -3; % zeros
P = [-1 -2+j -2-j]; % poles
k = 2; % gain

H = zpk(z,p,k)

%% State space representation
A = [0 1; -5 -2];
B = [0 ; 3];
C = [1 0];
D = 0;

P = ss(A,B,C,D) % state space representation

[A,B,C,D] = ssdata(P) % get A,B,C,D variable

P2 = tf(P) % tf representation
P3 = zpk(P) % zpk representation
P4 = ss(P3) % state space representation

%% System Response Graphics
s = tf('s')
G = (8*s^2+18*s+32)/(s^3+6*s^2+14*s+24)

impulse(G); % system impulse response

[y,t] = impulse(G); % get output values
plot(t,y)

%% General Input Response
s = tf('s')
G = (8*s^2+18*s+32)/(s^3+6*s^2+14*s+24)

t = linspace(0,5,1000); % 0 to 5 seconds
u = t; % input
lsim(G,u,t);

figure
u = sin(2*pi*10*t);
lsim(G,u,t);

%% Input Response of State Space Form System
A = [0 1; -5 -2];
B = [0; 3];
C = [1 0];
D = 0;

P = ss(A,B,C,D);
impulse(P); % impulse response

figure
step(P); % step response

%% Frequency Response
s = tf('s');
G = (8*s^2+18*s+32)/(s^3+6*s^2+14*s+24);
bode(G)
grid;

%% System Nyquist Response
s = tf('s');
G = (8*s^2+18*s+32)/(s^3+6*s^2+14*s+24);
nyquist(G);
grid;

%% System Stablity
s = tf('s')
G = (s+6)/(s^2+4*s+8)/(s-2)
isstable(G) % not stable
pole(G)
step(G)

rlocus(tf(G)) % root locus graph
[K, p] = rlocfind(G);

% Close loop system
GCL = feedback(K*G,1)

isstable(GCL)
pole(GCL)
impulse(GCL)
figure
step(GCL)