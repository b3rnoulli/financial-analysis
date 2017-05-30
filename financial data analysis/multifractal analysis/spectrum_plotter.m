function [ p ] = spectrum_plotter(f, alpha, f_alpha, symbol, color, display_name, figure_title)
fprintf('[spectrum_plotter] Plotting spectrum for %s \n', display_name);

p = plot(alpha,f_alpha, [symbol],'Color',color,'MarkerFaceColor',color,'MarkerSize',12,'DisplayName', display_name);
hold on;

if exist('figure_title','var')
    title(figure_title);
end
xlabel('\alpha', 'FontSize', 14);
ylabel('f(\alpha)', 'FontSize', 14);
xlim([0 1]);
ylim([0 1.05]);
ax = gca;
ax.FontSize = 16;
fprintf('[spectrum_plotter] Plotted spectrum for %s \n', display_name);
end

