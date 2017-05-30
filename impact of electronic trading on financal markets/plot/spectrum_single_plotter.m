indexes = {
    'SP500-removed',datetime('03-Jan-1950'), datetime('29-Dec-2016'), '^-', 'r', 'S&P500 1950-2017';
    'NASDAQ',       datetime('03-Jan-1950'), datetime('29-Dec-2016'), 'o-', 'k', 'NASDAQ COMP 1950-2017'
    };

save_figures = true;

for i=1:1:length(indexes(:,1))
    f = figure('units','normalized','position',[.1 .1 .4 .5]);
    f.PaperPositionMode = 'auto';
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2}),...
        '-', datestr(indexes{i,3})];
    spectrum_data = load([spectrum_file_name,'.mat']);
    
    p = spectrum_plotter(f, spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70), indexes{i,4}, indexes{i,5}, indexes{i,6});
    set(p,'linewidth',3);
    legend show
    
    axes('Position',[.51 .17 .35 .35])
    box on
    fq_plotter(f, spectrum_data.MFDFA2.Scale(1:end), spectrum_data.MFDFA2.Fq(1:end,31:70), '-k')
    xlabh = get(gca,'XLabel');
    set(xlabh,'Position',get(xlabh,'Position') + [0 .1 0]);
    ylabh = get(gca,'YLabel');
    set(ylabh,'Position',get(ylabh,'Position') + [2 0 1]);
    set(gca,'TickLength',[0.03 1]);
    hold off
    
    if save_figures == true
        savefig(f,[indexes{i,1},'-spectrum-',datestr(indexes{i,2}),'-', datestr(indexes{i,3})]); 
        print(f,[indexes{i,1},'-spectrum-',datestr(indexes{i,2}),'-', datestr(indexes{i,3})],'-depsc')
    end
    
end