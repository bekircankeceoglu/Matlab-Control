function x = myStateTransitionFcn(x,u)

% ornekleme zamani
dt = 0.01; 

M  = 1; %kg
c1 = 1; % N*s/m
c2 = 0.01; % N*s/m
c3 = 0.1; % N*s/m
c4 = 0.13; % N*s/m

x = x + [x(2); -(c1/M)*x(2)-(c2/M)*x(1)-(c3/M)*x(1)^3+(1+c4*x(1)^2)/M*u]*dt;
end


