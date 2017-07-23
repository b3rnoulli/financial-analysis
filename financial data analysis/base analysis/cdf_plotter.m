function [f, x, y] = cdf_plotter(f, log_return_rates, name, symbol, color, figure_title, plot_reference)
fprintf('[cdf_plotter] Plotting pdf for %s \n', name);

[y,x] = ecdf(abs(log_return_rates));
loglog(x, 1-y, [symbol,color],'MarkerSize', 7, 'DisplayName', name);
xlim([0.2,100]);
ylim([10^-4,1]);
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


xlabel('r(t)', 'FontSize', 14);
ylabel('F(|r(t)|)', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;
fprintf('[cdf_plotter] Plotted correlation for %s \n', name);

end

