% The transfer function between the elevator and altitude of the Boeing 747 aircraft
% Approximated
%
%        h(s)            30 (s - 6)
%    ------------ =  ------------------
%     delta(s)_e      s(s^2 + 4s + 13)


wn = sqrt(13);           % rad/s
zeta = 2/wn;             % 2*zeta*wn = 4
u = -1;                  % u = delta_e
s = tf('s');             % Laplace variable

% TF Boeing 747 aircraft
% Open Loop
G = u*30*(s - 6) / (s^3 + 4*s^2 + 13*s);

% Impulse response
y_open = impulse(G);

tr = 1.8 / wn;
ts = 4.6 /( zeta*wn );
Mp = exp(-(zeta / sqrt(1 - zeta^2))*pi);

disp('Poles and Damping:')
pole(G)
damp(G)
disp('------------------------------------------------------------------')
stepinfo(G)

%% Closed Loop
K = 0.063;
G2 = feedback(K*G,1);
y_closed = impulse(G2);
disp('Poles and Damping:')
pole(G2)
damp(G2)

figure(1), clf
plot(y_open,'linew',3)
hold on
plot(y_closed,'linew',3)
legend('Open Loop','Closed Loop')
grid on

% Time Domain Specification
stepinfo(G2)

%% Zeros influence 
% Change the poles = change the natural frequency and damping
% But if we changed the zeros?
H1 =  30*(s + 6) / (s*(s^2 + 4*s + 13));   
H2 =  30*(s + 2) / (s*(s^2 + 4*s + 13));   
H3 = -30*(s - 6) / (s*(s^2 + 4*s + 13));

% Plot
figure(2), clf
y_H1 = impulse(H1);
plot(y_H1, 'linew',3)
hold on
y_H2 = impulse(H2);
plot(y_H2, 'linew',3)
hold on
y_H3 = impulse(H3);
plot(y_H3, 'linew',3)
grid on
legend('Zero = -6','Zero = -2','Zero = 6')

% Zeros com parte real negativa interferem no sobressinal.
% Zeros with real part negative change the overshoot
% Zeros with real part positive causes a delay in the system

