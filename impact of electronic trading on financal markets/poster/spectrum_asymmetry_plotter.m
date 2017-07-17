clear
clc

% index name, start year, end year
indexes = {
    'SP500-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk';
%     'NASDAQ-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'o';
    %     'AAPL',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'BRKA',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'DIS',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'GE',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'INTC',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'IP',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'JPM',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'PG',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'PFE',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'T',              datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'TXN',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    %     'XOM',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok';
    };


frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

mean_width = 1;
save_figure= false;
    f = figure('units','normalized','position',[.1 .1 .8 .6]);


for i=1:length(indexes(:,1))
    path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    asymmetry =[];
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[spectrum_asymmetry_plotter] : Calculating asymmetry for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        asymmetry(point_counter) = spectrum_asymmetry(spectrum_data.MFDFA2.alfa(50), min(spectrum_data.MFDFA2.alfa(50:71)),...
            spectrum_data.MFDFA2.alfa(31:50));
        
        date_points(point_counter) = data.date(end_index);
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        point_counter = point_counter + 1;
    end
    plot(date_points, asymmetry,indexes{i,4},'MarkerSize',8);
    hold on;
    
    xlim([date_points(1) date_points(end)]);
    
    ylabel('A_{\alpha} (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([-1.1 1.1]);
    legend show
    
    if save_figure == true
        savefig(f,[indexes{i,1},'-spectrum-asymmetry-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]);
        print(f,[indexes{i,1},'-spectrum-asymmetry-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
        save([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/',indexes{i,1},'-spectrum-asymmetry.mat'],'date_points','asymmetry');
    end
    
end

xticklabels({'1950-1970','1955-1975','1960-1980','1965-1985','1970-1990','1975-1995','1980-2000','1985-2005','1990-2010','1995-2015'})

crash_1987 = datetime('19-Oct-1987');
crash_2008 = datetime('15-Sep-2008');

plot([crash_1987, crash_1987],[-1, 1],'--r','LineWidth',1.5);
plot([crash_2008, crash_2008],[-1, 1],'--r','LineWidth',1.5);

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',14);
legend('S&P500')
