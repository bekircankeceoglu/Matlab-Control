%{
Author: Bekircan Keceoglu
Soru1_Matlab
%}

% initial value of displacement and velocity
init=[0 0];
% force
F=10;

[t,x_out] = ode45(@(t,x) mass_spring_eq(F,x), [0 10], init);

figure()
plot(t,x_out(:,1))
grid;
xlabel('Zaman(sn)')
ylabel('Konum')
title('Konum-Zaman Grafigi')

figure()
plot(t,x_out(:,2))
grid;
xlabel('Zaman(sn)')
ylabel('Hýz')
title('Hýz-Zaman Grafigi')

%% different initial values

% initial value of displacement and velocity
init=[0 5];
% force
F=10;

[t,x_out] = ode45(@(t,x) mass_spring_eq(F,x), [0 10], init);

figure()
plot(t,x_out(:,1))
grid;
xlabel('Zaman(sn)')
ylabel('Konum')
title('Konum-Zaman Grafigi')

figure()
plot(t,x_out(:,2))
grid;
xlabel('Zaman(sn)')
ylabel('Hýz')
title('Hýz-Zaman Grafigi')


function o = mass_spring_eq(u,x)
M  = 1; %kg
c1 = 1;
c2 = 0.01;
c3 = 0.1;
c4 = 0.13;

o = [0;0];
o(1) = x(2);
o(2) = -(c1/M)*x(2)-(c2/M)*x(1)-(c3/M)*x(1)^3+(1+c4*x(1)^2)/M*u;

end