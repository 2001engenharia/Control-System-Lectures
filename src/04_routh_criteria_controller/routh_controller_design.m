%% Proportional Controller
K = 150;

% Laplace variable
s = tf('s');
% System TF
G = (s + 1)/( s*(s - 1)*(s + 6) );
% Final TF with the controller K
H = K*G/(1 + K*G);

% Step response
y = step(H);
plot(y, 'linew', 3)

%% PI- Proportional-Integral Controller
% Controller PI
% Gains
Ki = 10;
Kp = Ki/3 - 1;
% Laplace variable
s = tf('s');

% System TF
G = 1/((s + 1)*(s + 2));

% PI Controller K
K = Kp + Ki/s;

% Final TF with the controller K
H = K*G/(1 + K*G);

% Step response and plot
y = step(H);
plot(y, 'linew', 3)
