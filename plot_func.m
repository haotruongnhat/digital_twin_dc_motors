function plot_func(figure_id, arr, sampling_time, color)
    figure(figure_id)
    t = 0:sampling_time:(size(arr, 1)-1)*sampling_time;
    plot(t, arr, color,'LineWidth', 2); hold on; grid on;
    ylim([0 250])
    xlabel('time')
    ylabel('omega')
end

