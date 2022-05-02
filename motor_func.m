function y = motor_func(pwm, x, t) 
    K = x(1); T = x(2);
    sat_level = x(3); curv_level = x(4);
    sat_pwm = sat_level*tanh(curv_level*pwm);
    sys = tf(K*sat_pwm,[T 1]);
    [y, ~] = step(sys, t);
end


