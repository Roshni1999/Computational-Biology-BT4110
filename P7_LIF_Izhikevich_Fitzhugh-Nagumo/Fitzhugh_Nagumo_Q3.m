%Fitzhugh Nagumo Neuron Model
%Run code section-wise to visualize results

%% Qa.

a= 0.5; b=0.1; r=0.1; I=1; V0 = 0.2; w0= 0.8;
[Va, wa, ta] = fitzhugh_nagumo(a, b, r, I, V0, w0);
figure(1)
plot(ta,Va, 'LineWidth',2);
hold on
plot(ta,wa, 'LineWidth',2);
legend('V(t)', 'w(t)')
ylabel('Voltage')
xlabel('time ')
title(' a= 0.5; b=0.1; r=0.1; I=1; V0 = 0.2; w0= 0.8;')

plot_nullcline(a, b, r, I, Va, wa)

%% Qb.

a= 0.5; b=0.1; r=0.1; I=0; V0 = 0.2; w0= 0.8;
[Vb, wb, tb] = fitzhugh_nagumo(a, b, r, I, V0, w0);
figure(2)
plot(tb,Vb, 'LineWidth',2);
hold on
plot(tb,wb, 'LineWidth',2);
legend('V(t)', 'w(t)')
ylabel('Voltage (mv)')
xlabel('time (ms)')
title('a= 0.5; b=0.1; r=0.1; I=0; V0 = 0.2; w0= 0.8;')

plot_nullcline(a, b, r, I, Vb, wb)

%% Qc.

a= 0.5; b=0.1; r=0.6; I=0.3; V0 = 0.4; w0= 0.6;
[Vc, wc, tc] = fitzhugh_nagumo(a, b, r, I, V0, w0);
figure(3)
plot(tc,Vc, 'LineWidth',2);
hold on
plot(tc,wc, 'LineWidth',2);
legend('V(t)', 'w(t)')
ylabel('Voltage (mv)')
xlabel('time (ms)')
title('a= 0.5; b=0.1; r=0.6; I=0.3; V0 = 0.4; w0= 0.6;')

plot_nullcline(a, b, r, I, Vc, wc)
%% Qd.

a= 0.5; b=0.01; r=0.8; I=0.02; V0 = 0.4; w0= 0.6;
[Vd, wd, td] = fitzhugh_nagumo(a, b, r, I, V0, w0);
figure(4)
plot(td,Vd, 'LineWidth',2);
hold on
plot(td,wd, 'LineWidth',2);
legend('V(t)', 'w(t)')
ylabel('Voltage (mv)')
xlabel('time (ms)')
title('a= 0.5; b=0.01; r=0.8; I=0.02; V0 = 0.4; w0= 0.6;')

plot_nullcline(a, b, r, I, Vd, wd)

%% Plot nullclines

function plot_nullcline(a, b, r, I, V, w)
%x= V y= w

y= -5:0.01 :5;
x= zeros(1, length(y));

for i= 1: length(y)
    x(i)= y(i)*r/b;   %dw/dt = 0
end
figure(5)
plot(x, y, 'b', 'LineWidth',2)
hold on

X= -5: 0.01: 5;
Y= zeros(1, length(X));

for i= 1: length(X)
    Y(i)= X(i)*(a-X(i))*(X(i)-1) + I ;
end

plot(X, Y, 'r','LineWidth',2)
hold on 

plot(V, w, 'k','LineWidth',2 )
xlim([-5 5])
ylim([-5 5])

%xlim([-2 2])
%ylim([-2 2])
xlabel('V')
ylabel('w')

end
%%

function [V, w, t] = fitzhugh_nagumo(a, b, r, I, V0, w0)
%Simulation Time
time = 100; %milliseconds
dt=0.001;
t=0:dt:time;

V = zeros(length(t),1);
w = zeros(length(t),1);
V(1)=V0; w(1)=w0;

% Integration using Euler Method
for i=1:length(t)-1
    dV = (V(i)*(a-V(i))*(V(i)-1) -w(i) + I) *dt ;
    V(i+1) = V(i) + dV;
    
    dw = (b*V(i) - r*w(i))*dt;
    w(i+1) = w(i) + dw;
end

end


%%
    


