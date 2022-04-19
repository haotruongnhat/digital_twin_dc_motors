addpath('data');
load step_15_1ms.txt
load step_20_1ms.txt
load step_30_1ms.txt
load step_70_1ms.txt
load step_80_1ms.txt

close all;

windowSize = 11;
%% Step 15 percent
[steps, ~] = size(step_15_1ms);

t = 0:0.001:(steps-1)*0.001;
plot(step_15_1ms)

hold on;

step_15_1ms_ma = ma(step_15_1ms, windowSize);
plot(step_15_1ms_ma)

%% Step 20 percent
[steps, ~] = size(step_20_1ms);

t = 0:0.001:(steps-1)*0.001;
plot(step_20_1ms)

step_20_1ms_ma = ma(step_20_1ms, windowSize);
plot(step_20_1ms_ma)
%% Step 30 percent
[steps, ~] = size(step_30_1ms);

t = 0:0.001:(steps-1)*0.001;
plot(step_30_1ms)

step_30_1ms_ma = ma(step_30_1ms, windowSize);
plot(step_30_1ms_ma)
%% Step 70 percent
[steps, ~] = size(step_70_1ms);

t = 0:0.001:(steps-1)*0.001;
plot(step_70_1ms)
step_70_1ms_ma = ma(step_70_1ms, windowSize);
plot(step_70_1ms_ma)
%% Step 80 percent
[steps, ~] = size(step_80_1ms);

t = 0:0.001:(steps-1)*0.001;
plot(step_80_1ms)
step_80_1ms_ma = ma(step_80_1ms, windowSize);
plot(step_80_1ms_ma)

