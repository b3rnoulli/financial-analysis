function [ f ] = price_and_returns_plotter(price, x_axis_data, save_path, plot_title)

f = figure('rend','painters','pos',[10 10 1300 600]);

if ~exist('x_axis_data','var')
    subplot(2,1,1)
    plot(price);
    subplot(2,1,2);
    plot(zscore(diff(log)));
else
    subplot(2,1,1)
    plot(x_axis_data, price);
    subplot(2,1,2);
    plot(x_axis_data(2:end),zscore(diff(log(price)))); 
end

subplot(2,1,1)
xlabel('t', 'FontSize', 14);
ylabel('P(t)', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;
if exist('plot_title','var')
   title(plot_title, 'FontSize', 20) 
end

subplot(2,1,2)
xlabel('t', 'FontSize', 14);
ylabel('R(t)', 'FontSize', 14);
ax = gca;
ax.FontSize = 16;


if exist('save_path','var')
    print(f,save_path,'-dpng')
    savefig(f,save_path)
end

end
