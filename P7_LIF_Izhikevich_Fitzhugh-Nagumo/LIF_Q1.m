% Leaky Integrate and fire neuron model
% 1. Implement LIF neuron model (with the following parameters R=10^6ohm,tau=1sec,theta=100) and plot the V as a function of time for I0 = 0.18×10?3 A.
% 2. Show that the model exhibits firing only when R*I0>theta and as I0 increases beyond R/theta, f increases indefinitely by plotting frequency vs Io characteristics.
% 3. With the inclusion of absolute refractory period (Tref=2sec), plot I0vs f relationship graph.

%%
%Tref = 0 (No refractory time)

%Membrane constants
tau= 1;          %tau = R*C
R = 10^6;        %Membrane resistance (ohm)
theta = 100;     %Threshold voltage
I0 = 0.18*10^-3; %Initial current (ampere)
V0 = 0;          %Initial Voltage set to 0 V

% Time 
dt = 0.001;        % Integration time step
t_total = 5;       % Total time
No_steps = round(t_total./dt);
time_points = linspace(0, t_total, No_steps + 1); % Time points

% Membrane potential integration using Euler Method
V = zeros(1, No_steps + 1);
V(1) = V0;
for i=1:No_steps
    dV = (1./tau).*(-V(i) + R.*I0).*dt;
    V(i+1) = V(i) + dV;
    if V(i+1) > theta
        V(i+1) = 0;
    end
end

figure(1)
plot(time_points, V, 'r', 'LineWidth',2);
xlabel('Time')
ylabel('Voltage')
title('Voltage vs time LIF model')

% V = R* I0 (1-exp(-t*tau)) : Obtained from integration
T = tau*log (R*I0/ (R*I0 - theta) ) % Time taken to reach this threshold voltage
f = 1/T %spike frequency is the reciprocal of T

%% Frequency vs I0 without inclusion of absolute refractory period

I0_val = 0: 0.00001: 1*10^-3;
f_val = zeros(length(I0_val), 1);

for i = 1: length(I0_val)
    T = tau*log (R*I0_val(i)/ (R*I0_val(i) - theta));
    f_val(i) = 1/T;
end

figure(2)
plot(I0_val, f_val, 'LineWidth',2)
xlabel('I0')
ylabel('f')
title('Frequency vs I0 without inclusion of absolute refractory period')

%% Frequency vs I0 with inclusion of absolute refractory period
Tref = 2; %Refractory period
I0_val = 0: 0.00001: 1*10^-3;
f_val = zeros(length(I0_val), 1);

for i = 1: length(I0_val)
    T = tau*log (R*I0_val(i)/ (R*I0_val(i) - theta)) + Tref;
    f_val(i) = 1/T;
end

figure(3)
plot(I0_val, f_val, 'LineWidth',2)
xlabel('I0')
ylabel('f')
title('Frequency vs I0 with inclusion of absolute refractory period Tref = 2sec')

%%





