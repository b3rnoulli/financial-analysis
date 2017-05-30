function [f] = correlation_plotter(f, log_return_rates, name, symbol, figure_title)
fprintf('[correlation_plotter] Plotting correlation for %s \n', name);
acf = autocorr(abs(log_return_rates),length(log_return_rates)-1);

loglog(acf,symbol,'DisplayName',name);
hold on;

if exist('figure_title','var')
    title(figure_title);
end
xlabel('\tau(t)', 'FontSize', 14);
ylabel('C_{\tau}(t)', 'FontSize', 14);
xlim([1 length(log_return_rates)+2000]);
ylim([10^-5 1]);
ax = gca;
ax.FontSize = 16;
fprintf('[correlation_plotter] Plotted correlation for %s \n', name);
end

