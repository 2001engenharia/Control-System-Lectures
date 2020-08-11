% This code shows the plane's response to longitudinal movement of a
% aircraft when it is disturbed by external forces
% Wind, changes in atmospheric conditions or pilots commands.

% References
% M. V. Cook, Flight Dynamics Principles: A Linear Systems Approach to
% Aircraft Stability and Control.

%% Open Loop
s = tf('s');

% Long period
H_long = 1/(s^2 + 0.017*s + 0.002);    
disp('Poles and damping Long period')
pole(H_long)
damp(H_long)
disp('------------------------------------------------------------------')

% Short period
H_short = 1/(s^2 + 1.74*s + 29.49); 
disp('Poles and damping Short period')
pole(H_short)
damp(H_short)
disp('------------------------------------------------------------------')

% TF from the rest of the aircraft 
G1 = -20.6*(s + 0.013)*(s + 0.62); 

% TF from pitch for disturbance in elevator
aircraft = G1 * H_long * H_short;

figure(1), clf
subplot(3,1,1)
impulse(aircraft)
title('Longitudinal moviment in elevator')
axis([0 700 -5 5])

subplot(3,1,2)
impulse(H_long)
title('Phugoid moviment due an disturbance in elevator')

subplot(3,1,3)
impulse(H_short)
title('Short moviment due an disturbance in elevator')

%% Closed Loop
K = 0.03;
airplane_long_Closed_Loop = feedback(K*aircraft,1);

figure(2), clf
y_closed = step(airplane_long_Closed_Loop);
plot(y_closed, 'linew',3)
hold on
y_open = step(aircraft);
plot(y_open, 'linew',3)
legend('Closed Loop','Open Loop')