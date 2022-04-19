addpath('data');
load step_15_1ms.txt
load step_20_1ms.txt
load step_30_1ms.txt
load step_70_1ms.txt
load step_80_1ms.txt

close all;
sampling_time = 1e-3;
windowSize = 9;

step_15_1ms_ma = ma(step_15_1ms, windowSize);
step_20_1ms_ma = ma(step_20_1ms, windowSize);
step_30_1ms_ma = ma(step_30_1ms, windowSize);
step_70_1ms_ma = ma(step_70_1ms, windowSize);
step_80_1ms_ma = ma(step_80_1ms, windowSize);

t = 0:sampling_time:(size(step_15_1ms_ma, 1)-1)*sampling_time;
plot(t, step_15_1ms_ma); hold on;
t = 0:sampling_time:(size(step_20_1ms_ma, 1)-1)*sampling_time;
plot(t, step_20_1ms_ma); hold on;
t = 0:sampling_time:(size(step_30_1ms_ma, 1)-1)*sampling_time;
plot(t, step_30_1ms_ma); hold on;
t = 0:sampling_time:(size(step_70_1ms_ma, 1)-1)*sampling_time;
plot(t, step_70_1ms_ma); hold on;
t = 0:sampling_time:(size(step_80_1ms_ma, 1)-1)*sampling_time;
plot(t, step_80_1ms_ma); hold on;

% %% Manually fit - Transfer function
t = 0:sampling_time:0.6;

% PWM = 0.7
PWM = 0.7;
K = 280;
T2 = 0.0001;
T = 0.027;
Delay = 0.02;

x = [K, T2, T, Delay];
y = func(PWM, x, t);

plot(t, y)

% PWM = 0.3
K = 546;
T2 = 0.00005;
T = 0.06;
PWM = 0.3;

x = [K, T2, T, Delay];
y = func(PWM, x, t);
plot(t, y)


% PWM = 0.2
K = 680;
T2 = 0.00005;
T = 0.1;
PWM = 0.2;

x = [K, T2, T, Delay];
y = func(PWM, x, t);
plot(t, y)

% PWM = 0.15
K = 810;
T2 = 0.0002;
T = 0.16;
PWM = 0.15;

x = [K, T2, T, Delay];
y = func(PWM, x, t);
plot(t, y)

%% Transfer function definition
x_collected = [];

% K, T2, T, Delay
x0 = [200, 0, 0.02, 0.01];

lb = [150 0      0    0];
ub = [300 0.002  0.05 0.05];
% [x,resnorm, ~, exitflag,output] = lsqcurvefit(F, x0, xdata, ydata, lb, ub);
[x, resnorm] = fit(0.7, step_70_1ms_ma, x0, sampling_time, lb, ub);

%% Multiple data
[x1, resnorm1] = fit(0.15, step_15_1ms_ma, x0, sampling_time, lb, ub);
[x2, resnorm2] = fit(0.2, step_20_1ms_ma,  x0, sampling_time, lb, ub);
[x3, resnorm3] = fit(0.3, step_30_1ms_ma,  x0, sampling_time, lb, ub);
[x4, resnorm4] = fit(0.7, step_70_1ms_ma,  x0, sampling_time, lb, ub);
[x5, resnorm5] = fit(0.8, step_80_1ms_ma,  x0, sampling_time, lb, ub);

xs = [x1;x2;x3;x4;x5];
%%
function y = func(pwm, x, t) 
    K = x(1); T2 = x(2); T = x(3); Delay = x(4);
    sys = tf(K*pwm,[T2 T 1], 'OutputDelay', Delay);
    [y, ~] = step(sys, t);
end

function [x, resnorm] = fit(pwm, x, x0, sampling_time, lb, ub)
    xdata = 0:sampling_time:(size(x, 1)-1)*sampling_time;
    ydata = x;
    F = @(x, t) (func(pwm, x, t));
    [x,resnorm, ~, exitflag,output] = lsqcurvefit(F, x0, xdata, ydata, lb, ub);
end

