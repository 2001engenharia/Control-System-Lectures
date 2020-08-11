
% Time vector
% Time is 'negative' here only for curiosity
t = (-1:0.01:3)';

% Impulse
impulse_input = t==0;
figure(1), clf
subplot(3,1,1)
plot(t,impulse_input,'g','linew',3)
title('Impulse Input')

% Step
step_input = t>=0;
subplot(3,1,2)
plot(t,step_input,'m','linew', 3)
title('Step Input')
hold on

% Ramp Input
ramp = t.*step_input;
subplot(3,1,3)
plot(t,ramp,'r', 'linew', 3)
title('Ramp Input')

%%
% Example DC Motor
% Dynamical system with differents inputs
% Reference Feedback Control of Dynamic Systems, Gene F. Franklin
Jm = 0.01;  % [kg.m^2]
b = 0.001;  % [N.m.s]
Kt = 1;     % [Adimensional]
Ke = 1;     % [Adimensional]
Ra = 10;    % [Ohms]
La = 1;     % [H]

s = tf('s');    % Laplace variable (s = jw)

% Motor DC transfer function
G = Kt / ( s*((Jm*s + b)*(La*s + Ra) + Kt*Ke) );

% Poles
disp('The poles are: ')
pole(G)

% Zeros 
disp('The zeros are: ')
if(isempty(zero(G)))
    disp('Does not have zeros')
else
    zero(G)
end

figure(2), clf
pzmap(G)

%% Motor response
t = (0:0.01:3)';
impulse_input = t==0;
step_input = t>=0;
ramp = t.*step_input;

% Impulse
figure(3), clf
plot(t,impulse_input,'g','linew',3)
hold on
y_imp = impulse(G, t(end));
plot(y_imp,'linew',3)
title('Motor DC response from Impulse input')
legend('Input','Output')

% Step 
figure(4), clf
plot(t,step_input,'g', 'linew', 3)
hold on
y_step = step(G, t(end));
plot(y_step,'linew',3)
title('Motor DC response from Step input')
legend('Input','Output')

% Ramp
figure(5), clf
[Y, T] = lsim(G, ramp, t);
plot(t,ramp,'r', 'linew', 3)
hold on
plot(T,Y,'linew',3)
title('Motor DC response from Ramp input')
legend('Input','Output')

% Senoidal input
sin_input = 0.5 * sin(pi*t);  % 1Hz
figure(6), clf
plot(t,sin_input, 'linew', 3)
hold on
[Y,T,X] = lsim(G, sin_input, t);  % System response
plot(T,Y,'linew',3)
title('Motor DC response from Senoidal input')
legend('Input','Output')
