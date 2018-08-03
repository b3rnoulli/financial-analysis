function [f, x, y] = cdf_plotter(f, log_return_rates, name, symbol, color, figure_title, plot_reference)
fprintf('[cdf_plotter] Plotting pdf for %s \n', name);

[y,x] = ecdf(abs(log_return_rates));
loglog(x, 1-y, [symbol,color],'MarkerSize', 7, 'DisplayName', name);

hold on;

if exist('figure_title','var')
    title(figure_title);
end

if exist('plot_reference','var') && plot_reference == true
    x_reference = 2.5:0.1:10;
    plot(x_reference, x_reference.^-3,'-k','DisplayName','x^{-3}');
    
    random_values = randn([1 100000]);
    [y_rand,x_rand] = ecdf(abs(random_values));
    loglog(x_rand, 1-y_rand,'--k','DisplayName','N(0,1)')
    
end

xlabel('n', 'FontSize', 14);
ylabel('F(n)', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;
fprintf('[cdf_plotter] Plotted pdf for %s \n', name);
xlim([0.2,100]);
ylim([10^-6,1]);
end

