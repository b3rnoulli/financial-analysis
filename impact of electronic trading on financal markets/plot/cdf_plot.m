indexes = {
    %     'SP500-removed',datetime('03-Jan-1950'), datetime('01-Jan-1987'), 'o-', 'r', 'S&P500 1950-1987';
    %     'SP500-removed',datetime('01-Jan-1987'), datetime('28-Dec-2016'), 'x-', 'b', 'S&P500 1987-2017';
%     'SP500-removed',datetime('01-Jan-1950'), datetime('28-Dec-2016'), '<-', 'r', 'S&P500 1950-2017';
%     'SP500',datetime('01-Jan-1950'), datetime('28-Dec-2016'), '^-', 'k', 'S&P500 1950-2017 (black monday included)';
    
    %     'NASDAQ-removed',datetime('03-Jan-1950'), datetime('01-Jan-1987'), 'o-', 'r', 'NASDAQ 1950-1987';
    %     'NASDAQ-removed',datetime('01-Jan-1987'), datetime('28-Dec-2016'), 'x-', 'b', 'NASDAQ 1987-2017';
%         'NASDAQ-removed',datetime('01-Jan-1950'), datetime('28-Dec-2016'), 'x-', 'r', 'NASDAQ 1950-2017';
%         'NASDAQ',datetime('01-Jan-1950'), datetime('28-Dec-2016'), '^-', 'k', 'NASDAQ 1950-2017 (black monday included)';
    
    %
    %     'DJIA',datetime('03-Jan-1950'), datetime('01-Jan-1987'), 'o-', 'r', 'DJIA 1950-1987';
    %     'DJIA',datetime('01-Jan-1987'), datetime('28-Dec-2016'), 'x-', 'b', 'DJIA 1987-2017';
    %     'DJIA',datetime('01-Jan-1950'), datetime('28-Dec-2016'), '^-', 'k', 'DJIA 1950-2017';
    
    %     '9-companies',datetime('03-Jan-1962'), datetime('01-Jan-1987'), 'o-', 'r', '9-companies 1962-1987';
    %     '9-companies',datetime('01-Jan-1987'), datetime('28-Dec-2016'), 'x-', 'b', '9-companies 1987-2017';
    %     '9-companies',datetime('01-Jan-1962'), datetime('28-Dec-2016'), '^-', 'k', '9-companies 1962-2017 - black monday included';
        '9-companies',datetime('01-Jan-1962'), datetime('28-Dec-2016'), '^-', 'k', '9-companies 1962-2017 - black monday included';
    
    %
    %     'NASDAQ',       datetime('03-Jan-1950'), datetime('29-Dec-2016'), 'o-', 'k', 'NASDAQ COMP 1950-2017';
    %     'DJIA',         datetime('03-Jan-1950'), datetime('29-Dec-2016'), 'x-', 'b', 'DJIA 1950-2017';
    };
save_figures = false;
write_to_file = false;

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
    
    
    returns = zscore(diff(log(data.close(find_index(data.date, indexes{i,2}):find_index(data.date, indexes{i,3})))));
    
    [~,x,y] = cdf_plotter(f, returns, indexes{i,6}, indexes{i,4},indexes{i,5}, [], plot_reference);
    
    if write_to_file == true
        fid = fopen([indexes{i,1},'-cdf-',datestr(indexes{i,2}),'-', datestr(indexes{i,3}),'.csv'], 'w') ;
        fprintf(fid,['x,','1-y\n']);
        fclose(fid);
        dlmwrite([indexes{i,1},'-cdf-',datestr(indexes{i,2}),'-', datestr(indexes{i,3}),'.csv'],[x, 1-y],'delimiter',',','-append');
    end
    
    hold on
    
end

legend show

if save_figures == true
    savefig(f,['cdf-',datestr(indexes{i,2}),'-', datestr(indexes{i,3})]);
    print(f,['cdf-',datestr(indexes{i,2}),'-', datestr(indexes{i,3})],'-depsc')
end