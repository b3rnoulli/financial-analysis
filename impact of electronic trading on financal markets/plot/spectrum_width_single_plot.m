clear
clc


%nasdaq
index_name='NASDAQ';
indexes = {
       'AAPL', '01-Jan-1985', '31-Dec-2016', 'x';
       'MSFT', '01-Jan-1985', '31-Dec-2016', 'o';
       'CMCSA','01-Jan-1985', '31-Dec-2016', 's';
       'INTC', '01-Jan-1985', '31-Dec-2016', '*';
       'CSCO', '01-Jan-1985', '31-Dec-2016', '>';
       'AMGN', '01-Jan-1985', '31-Dec-2016', 'd';
       'WBA',  '01-Jan-1985', '31-Dec-2016', '^';
       'TXN',  '01-Jan-1985', '31-Dec-2016', 'v';
       'COST', '01-Jan-1985', '31-Dec-2016', 'p';
       'ADBE', '01-Jan-1985', '31-Dec-2016', 'h';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

save_figure = true;

f = figure('units','normalized','position',[.1 .1 .6 .6]);


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
%     date_points = datetime('01-Jan-1970');
    point_counter = 1;
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[spectrum_width_plotter] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        alpha_y(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:70),spectrum_data.MFDFA2.f(31:70));
        
        date_points(point_counter) = datenum(data.date(end_index));
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        point_counter = point_counter + 1;
    end
    
    plot(date_points,alpha_y,indexes{i,4},'MarkerSize',8, 'DisplayName',indexes{i,1});

    hold on;
    legend show
    
    ylim([0 .5]);
    xlim([date_points(1) date_points(end)]);
    
    ylabel('\Delta\alpha (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([0 0.7]);
    datetick('x','yyyy');
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',16)
    
    if save_figure == true
        savefig(f,[index_name,'-components-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]); 
        print(f,[index_name,'-components-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
    end
    
end