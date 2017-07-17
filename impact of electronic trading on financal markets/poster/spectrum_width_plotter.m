clear
clc

% index name, start year, end year, symbol, plot surrogates
% indexes = {
%     'SP500-removed',  datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk', true;
%     'NASDAQ-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok', true;
%     'AAPL',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'BRKA',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'DIS',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'GE',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'INTC',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'IP',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'JPM',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'PG',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'PFE',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'T',              datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'TXN',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'XOM',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     };


indexes = {
    'SP500-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok', true;
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

save_figure = false;


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    f = figure('units','normalized','position',[.1 .1 .8 .6]);
    
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    alpha_y =[];
    alpha_fourier_surrogate = [];
    alpha_shuffled_surrogate = [];
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[spectrum_width_plotter] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        alpha_y(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:70),spectrum_data.MFDFA2.f(31:70));
        
        if indexes{i,5}
            fourier_surrogate_mean_spectrum = load([path,'/surrogate/mean/',indexes{i,1},'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
                '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
            alpha_y_fourier_surrogate(point_counter) = spectrum_width(fourier_surrogate_mean_spectrum.MFDFA2.alfa(31:70), fourier_surrogate_mean_spectrum.MFDFA2.f(31:70));
            
            shuffled_surrogate_mean_spectrum = load([path,'/surrogate/mean/',indexes{i,1},'-shuffled-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
                '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
            alpha_y_shuffled_surrogate(point_counter) = spectrum_width(shuffled_surrogate_mean_spectrum.MFDFA2.alfa(31:70), shuffled_surrogate_mean_spectrum.MFDFA2.f(31:70));
            
            
            rankings_surrogate_mean_spectrum = load([path,'/surrogate/mean/',indexes{i,1},'-rankings-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
                '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
            alpha_y_rankings_surrogate(point_counter) =spectrum_width(rankings_surrogate_mean_spectrum.MFDFA2.alfa(31:70), rankings_surrogate_mean_spectrum.MFDFA2.f(31:70));
        end
        
        date_points(point_counter) = data.date(end_index);
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        point_counter = point_counter + 1;
    end
    plot(date_points,alpha_y,'xk','MarkerSize',8);
    hold on;
    if indexes{i,5}
        %         plot(date_points, alpha_y_fourier_surrogate,'or','MarkerSize',8);
        plot(date_points, alpha_y_rankings_surrogate, '*', 'MarkerSize',8);
    end
    
    legend show
    
    %     plot(date_points, alpha_y_shuffled_surrogate,'^g','MarkerSize',8);
    x_left = datenum(data.date(shift_index(data.date, find_index(data.date, indexes{i,2}), frame_size, frame_size_type)))-100;
    x_right = datenum(indexes{i,3});
    y_left = 0.1;
    y_right = 0.1;
    p = patch([1 x_right x_right 1],[-0.1 -0.1 y_left y_right ],[0.62 0.62 0.62]);
    set(p,'FaceAlpha',0.5);
    
    ylim([0 .5]);
    xlim([date_points(1) date_points(end)]);
    
    ylabel('\Delta\alpha (t)','FontSize', 16);
    xlabel('t [year]','FontSize', 16);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',16);
    ylim([0 0.7]);
    
    if save_figure == true
        savefig(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]);
        print(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
        save([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/',indexes{i,1},'-spectrum-width.mat'],'date_points','alpha_y');
    end
    
    xticklabels({'1950-1970','1955-1975','1960-1980','1965-1985','1970-1990','1975-1995','1980-2000','1985-2005','1990-2010','1995-2015'})
    
    crash_1987 = datetime('19-Oct-1987');
    crash_2008 = datetime('15-Sep-2008');
    
    plot([crash_1987, crash_1987],[0.15, 0.55],'--r','LineWidth',1.5);
    plot([crash_2008, crash_2008],[0.15, 0.55],'--r','LineWidth',1.5);
    
    legend('S&P500','Gauss distributed returns')
end


