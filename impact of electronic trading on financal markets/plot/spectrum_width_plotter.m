clear
clc

% index name, start year, end year, symbol, plot surrogates
indexes = {
%     'SP500-removed',  datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk', true;
%     'NASDAQ-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk', true;
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
    };


% DJIA - RR
% indexes = {
%     'AA',  datetime('01-Jan-1981'), datetime('02-Oct-2013'), 'ok', false;
%     'AIG', datetime('01-Jan-1984'), datetime('04-Aug-2008'), 'ok', false;
%     'AXP', datetime('01-Jan-1982'), datetime('31-Dec-2016'), 'ok', false;
%     'C',   datetime('01-Jan-1981'), datetime('02-Jul-2009'), 'ok', false;
%     'CVX', datetime('01-Jan-1985'), datetime('31-Dec-2016'), 'ok', false;
%     'DD',  datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'DIS', datetime('01-Jan-1991'), datetime('31-Dec-2016'), 'ok', false;
%     'GE',  datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
% %     'GT',  datetime('01-Jan-1981'), datetime('31-Nov-1999'), 'ok', false;
%     'HON', datetime('01-Jan-1981'), datetime('02-Jan-2003'), 'ok', false;
%     'HPQ', datetime('01-Jan-1981'), datetime('03-Sep-2013'), 'ok', false;
%     'IBM', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'INTC',datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'IP',  datetime('01-Jan-1981'), datetime('02-Apr-2004'), 'ok', false;
%     'JNJ', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'KO',  datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'MCD', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'MO',  datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'PG',  datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'PFE', datetime('01-Jan-1984'), datetime('31-Dec-2016'), 'ok', false;
%     'UTX', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'WMT', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'XOM', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'UTX', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'NAV', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'MMM', datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'BA',  datetime('01-Jan-1981'), datetime('31-Dec-2016'), 'ok', false;
%     'BAC', datetime('01-Jan-1988'), datetime('31-Dec-2016'), 'ok', false;
%     };


indexes = {
    'SP500-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok', true;
    };

% indexes = {
%     'DJIA',  datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk', false;
%     'NDX',  datetime('01-Jan-1986'), datetime('01-Jan-2017'), '>b', false;
%     'IXIC',  datetime('01-Jan-1972'), datetime('01-Jan-2017'), 'or', false;
%     'NASDAQ-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk', false;  
% };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

save_figure = false;

    f = figure('units','normalized','position',[.1 .1 .6 .6]);

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    
    
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
    plot(date_points,alpha_y,indexes{i,4},'MarkerSize',8, 'DisplayName',indexes{i,1});
    hold on;
    if indexes{i,5}
        plot(date_points, alpha_y_fourier_surrogate,'or','MarkerSize',8, 'DisplayName','Fourier Surrogate');
        plot(date_points, alpha_y_rankings_surrogate, '*b', 'MarkerSize',8, 'DisplayName','Rankings Surrogate');
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
    
    ylabel('\Delta\alpha (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([0 0.7]);
    
    if save_figure == true
        savefig(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]);
        print(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
        save([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/',indexes{i,1},'-spectrum-width.mat'],'date_points','alpha_y');
    end
    
    
end
