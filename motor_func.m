function y = motor_func(pwm, x, t) 
    K = x(1); T = x(2); curv_level = x(3);
    sat_gain = K*tanh(curv_level*pwm);
    sys = tf(sat_gain,[T 1]);
    [y, ~] = step(sys, t);
end


