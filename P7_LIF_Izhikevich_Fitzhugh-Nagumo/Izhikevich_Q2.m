%% Izhikevich neuron model
%Implement Izhikevich model using the given equations and simulate the tonic bursting 
%and plot the voltage response v(t) wrt time taking v0=-70,u0=b*v0 for approximately 300 secs 
%for the given parameter values.
%a=0.02, b=0.2, c=-65, d=6, I=0 for 0<=t<10 and I=14 for 10<=t<300

%Constants
a=0.02; b=0.2; c= -65; d=6;
v0= -70; u0= b*v0;

% Time 
dt = 0.01;        % Integration time step
t_total = 300;     % Total time
No_steps = round(t_total./dt);
time_points = linspace(0, t_total, No_steps + 1); % Time points for update

% Current 
t_Iend = 300;     %Stop current at t_Iend
t_Istart = 10;    %Start current at t_Istart
Istart_count = round(t_Istart./dt);
Ifinish_count = round(t_Iend./dt);
Iin = zeros(1, No_steps + 1);
Iin(Istart_count:Ifinish_count) = 14; %Constant current injected I0

% Integration using Euler Method
v = zeros(1, No_steps + 1);
u = zeros(1, No_steps + 1);

v(1) = v0;
u(1) = u0;
for i=1:No_steps
    dv = (Iin(i) + 0.04*(v(i)^2) + 5*v(i) + 140 - u(i)).*dt;
    du = a.*(b*v(i) - u(i)).*dt;
    
    v(i+1) = v(i) + dv;
    u(i+1) = u(i) + du;
    
    if v(i+1) > 1
        v(i+1) = c;
        u(i+1) = u(i) +d;
    end
end

subplot(2,1,1)
plot(time_points, v, 'r', 'LineWidth',2);
ylabel('Voltage')
xlabel('time')
title('Tonic spiking')

subplot(2,1,2)
plot(time_points, Iin, 'b', 'LineWidth',2);
ylabel('Current')
xlabel('time')

