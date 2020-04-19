%{
Author: Bekircan Keceoglu
-Q:1 
- Find b value that makes system stable
%}
%% BOLUM 1
s = tf('s');
b = 0.001;
bmin = b;
bmax = 0;
while b < 15
    % Plant
    P = 1 / (0.2*s - 1);
    % Controller
    C = (15*s + 1)/(b*s);

    % Close loop system
    GCL = feedback(C*P,1);
    
    if isstable(GCL) == 1
        bmax = b;
    end
    b = b + 0.01;
    
end
bmax

%% BOLUM 2
% 100 b values between bmin-max
bdivided = linspace(bmin, bmax, 100);


for i=1:100
    % Plant
    P = 1 / (0.2*s - 1);
    % Controller
    C = (15*s + 1)/(bdivided(i)*s);

    % Close loop system
    GCL = feedback(C*P,1);
    
    poles = pole(GCL);
    critic_pole(i) = getCritic(poles);
 
    [Gm, Pm]= margin(C*P);
    plot_gm(i) = Gm; 
    plot_pm(i) = Pm; 
end

subplot(3,1,1)
plot(bdivided,critic_pole)
ylabel('CRITIC POLE')
xlabel('B')
grid
subplot(3,1,2)
plot(bdivided,plot_gm)
ylabel('GM')
xlabel('B')
grid
subplot(3,1,3)
plot(bdivided,plot_pm)
ylabel('PM')
xlabel('B')
grid

function crit = getCritic(poles)
    crit = real(poles(1));

    for i=1:length(poles)

        realPart = real(poles(i));  
        if realPart > crit
            crit = realPart;
           
        end
    end
end

