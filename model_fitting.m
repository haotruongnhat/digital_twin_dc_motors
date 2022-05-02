% addpath('data');
% load step_15_1ms.txt
% load step_20_1ms.txt
% load step_30_1ms.txt
% load step_70_1ms.txt
% load step_80_1ms.txt

data_dir = "data_2";
addpath(data_dir)
files = dir(data_dir + '\*.txt') ;   % you are in the folder of files 
load('data1_20.txt');
load('data2_20.txt');
load('data_15.txt');
load('data_25.txt');
load('data_30.txt');
load('data_40.txt');
load('data_50.txt');
load('data_70.txt');
load('data_80.txt');

%%
close all;
sampling_time = 1e-3;
windowSize = 5;

data_15_ma = ma(data_15, windowSize);
data1_20_ma = ma(data1_20, windowSize);
data2_20_ma = ma(data2_20, windowSize);
data_25_ma = ma(data_25, windowSize);
data_30_ma = ma(data_30, windowSize);
data_40_ma = ma(data_40, windowSize);
data_50_ma = ma(data_50, windowSize);
data_70_ma = ma(data_70, windowSize);
data_80_ma = ma(data_80, windowSize);
%Cut off
end_sample = 5000;
data_15 = data_15(1:end_sample);
data1_20 = data1_20(1:end_sample);
data_30 = data_30(1:end_sample);
data_40 = data_40(1:end_sample);
data_50 = data_50(1:end_sample);
data_70 = data_70(1:end_sample);
data_80 = data_80(1:end_sample);

% clf(1);
% plot_func(1, data_15, sampling_time)
% plot_func(1, data1_20, sampling_time)
% plot_func(1, data_30, sampling_time)
% plot_func(1, data_40, sampling_time)
% plot_func(1, data_50, sampling_time)
plot_func(1, data_70, sampling_time, 'r')
plot_func(1, data_80, sampling_time, 'b')
% legend('DT = 0.7', 'DT = 0.8')
%%
% %% Manually fit - Transfer function
% t = 0:sampling_time:5-sampling_time;
% 
% K = 630*0.3; T = 0.03; curv = 4;
% 
% x = [K, T, curv];
% 
% PWM = 0.15; y = motor_func(PWM, x, t); %plot(t, y)
% PWM = 0.2; y = motor_func(PWM, x, t); %plot(t, y)
% PWM = 0.4; y = motor_func(PWM, x, t); %plot(t, y)
% 
% plot_func(8, data_15, sampling_time, 'r')
% plot_func(9, data1_20, sampling_time, 'r')
% plot_func(10, data_40, sampling_time, 'r')
% plot_func(11, data_50, sampling_time, 'r')
% plot_func(12, data_70, sampling_time, 'r')
% plot_func(13, data_80, sampling_time, 'r')


% legend('Real0.15','Real0.2','Real0.4','Sim0.15','Sim0.2','Sim0.4')
% % 
% % 
% PWM = 0.4;
% K = 630;
% T2 = 0.0001;
% T = 0.03;
% 
% x = [K, T2, T];
% y = motor_func(PWM, x, t);
% plot(t, y)
% 
% % PWM = 0.15
% K = 810;
% T2 = 0.0002;
% T = 0.16;
% PWM = 0.15;
% 
% x = [K, T2, T, Delay];
% y = func(PWM, x, t);
% plot(t, y)

%% Transfer function definition
x_collected = [];

% K, T2, T, Sat, Curv
x0 = [200, 0.02, 4];
 
lb = [0   0    0];
ub = [800 0.05 8];

%% Multiple data
[x1, resnorm1] = fit(0.15, data_15, x0, sampling_time, lb, ub);
[x2, resnorm2] = fit(0.2, data1_20,  x0, sampling_time, lb, ub);
[x3, resnorm3] = fit(0.4, data_40,  x0, sampling_time, lb, ub);
[x4, resnorm4] = fit(0.5, data_50,  x0, sampling_time, lb, ub);
[x5, resnorm5] = fit(0.7, data_70,  x0, sampling_time, lb, ub);
[x6, resnorm6] = fit(0.8, data_80,  x0, sampling_time, lb, ub);

xs = [x1;x2;x3;x4;x5];
x_final = mean(xs);
MSE = [];

plot_func(2, data_15, sampling_time, 'r')
PWM = 0.15; y = motor_func(PWM, x_final, t); %plot(t, y, 'b','LineWidth', 3); hold on;
plot_func(2, y, sampling_time, 'b')
% legend("Real data", "Simulated data")
title("DT=" + num2str(PWM))
MSE = [MSE, immse(y, data_15)];

plot_func(3, data1_20, sampling_time, 'r')
PWM = 0.2; y = motor_func(PWM, x_final, t); %plot(t, y, 'b','LineWidth', 3)
plot_func(3, y, sampling_time, 'b')
% legend("Real data", "Simulated data")
title("DT=" + num2str(PWM))
MSE = [MSE, immse(y, data1_20)];

plot_func(4, data_40, sampling_time, 'r')
PWM = 0.4; y = motor_func(PWM, x_final, t); %plot(t, y, 'b', 'LineWidth', 3)
plot_func(4, y, sampling_time, 'b')
% legend("Real data", "Simulated data")
title("DT=" + num2str(PWM))
MSE = [MSE, immse(y, data_40)];

plot_func(5, data_50, sampling_time, 'r')
PWM = 0.5; y = motor_func(PWM, x_final, t); %plot(t, y, 'b','LineWidth', 3)
plot_func(5, y, sampling_time, 'b')
% legend("Real data", "Simulated data")
title("DT=" + num2str(PWM))
MSE = [MSE, immse(y, data_50)];

plot_func(6, data_70, sampling_time, 'r')
PWM = 0.7; y = motor_func(PWM, x_final, t); %plot(t, y, 'b','LineWidth', 3)
plot_func(6, y, sampling_time, 'b')
% legend("Real data", "Simulated data")
title("DT=" + num2str(PWM))
MSE = [MSE, immse(y, data_70)];

plot_func(7, data_80, sampling_time, 'r')
PWM = 0.8; y = motor_func(PWM, x_final, t); %plot(t, y, 'b','LineWidth', 3)
plot_func(7, y, sampling_time, 'b')
% legend("Real data", "Simulated data")   
title("DT=" + num2str(PWM))
MSE = [MSE, immse(y, data_80)];
autoArrangeFigures()

saveImageFigures('output')

%%

function [x, resnorm] = fit(pwm, x, x0, sampling_time, lb, ub)
    xdata = 0 : sampling_time:(size(x, 1)-1)*sampling_time;
    ydata = x;
    F = @(x, t) (motor_func(pwm, x, t));
    [x,resnorm, ~, exitflag,output] = lsqcurvefit(F, x0, xdata, ydata, lb, ub);
end

