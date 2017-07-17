indexes = {
    'SP500-removed',datetime('03-Jan-1950'), datetime('01-Jan-1987'), 'o-', 'r', 'S&P500 1950-1987';
%     'SP500-removed',datetime('01-Jan-1987'), datetime('29-Dec-2016'), 'x-', 'b', 'S&P500 1987-2017';
%     'NASDAQ',       datetime('03-Jan-1950'), datetime('29-Dec-2016'), 'o-', 'k', 'NASDAQ COMP 1950-2017';
%     'DJIA',         datetime('03-Jan-1950'), datetime('29-Dec-2016'), 'x-', 'b', 'DJIA 1950-2017';
    };
save_figures = false;

f = figure('units','normalized','position',[.1 .1 .4 .5]);
f.PaperPositionMode = 'auto';
for i=1:1:length(indexes(:,1))
    data = load(indexes{i,1});
    fprintf('Plotting distribution for index %s from %s to %s \n',indexes{i,1}, datestr(indexes{i,2}), datestr(indexes{i,3}));
    
    if i ==2
        plot_reference = true;
    else
        plot_reference = false;
    end
    cdf_plotter(f, data.returns(find_index(data.date, indexes{i,2}), find_index(data.date, indexes{i,3})), indexes{i,6}, indexes{i,4},indexes{i,5}, [], plot_reference);
    hold on;
    cdf_plotter(f, data.returns(find_index(data.date, indexes{i,2}), find_index(data.date, indexes{i,3})), indexes{i,6}, indexes{i,4},indexes{i,5}, [], plot_reference);
    
    
end

legend show


if save_figures == true
    savefig(f,['cdf-',datestr(indexes{i,2}),'-', datestr(indexes{i,3})]);
    print(f,['cdf-',datestr(indexes{i,2}),'-', datestr(indexes{i,3})],'-depsc')
end