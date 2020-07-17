% Example 1 - Cruise Control
%         ___________ 
%        |           |            x'
%    Bx' |           |    u     ----->
%  <-----|           |--------> 
%        |           |
%        |___________|
%        ooooooooooooo
%%

m = 1000; % kg
B = 50;   % N.s/m
u = 500;  % N

nun = [ 1/m ];
den = [1  B/m];

G = tf(nun,den);

% Plot
figure(1), clf
step(u*G)
ylabel('Velocity (m/s)')
title('Cruise Control')

%% Example 2 - Pendulum

t = 0:0.02:10;  % vector of times for output, 0 to 10 at 0.02
m = 1;          % kg
L = 1;          % m
g = 9.81;       % m/s^2
angle = 5;      % degree
s = tf('s');    % s (Laplace variable)

% TF
H = ( 1 / (m*L^2) ) / (s^2 + g/L);
y = step(H,t);      
angle_rad = deg2rad(angle);

% Plot
figure(2), clf
plot(t, angle_rad*y)
xlabel('Time (s)')
ylabel('Pendulum Angle')
title('Pendulum')