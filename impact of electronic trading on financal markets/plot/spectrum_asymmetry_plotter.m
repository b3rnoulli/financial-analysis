clear
clc

% index name, start year, end year
indexes = {
    %     'SP500-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk';
    'NASDAQ-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok';
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
%     %     'GT',  datetime('01-Jan-1981'), datetime('31-Nov-1999'), 'ok', false;
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
% 
% indexes = {
%     'DJIA-reconstructed',  datetime('01-Jan-1981'), datetime('01-Jan-2017'), 'ok', false;
% };

% indexes = {
%     'DJIA',  datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok', false;
% };


frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

mean_width = 1;
save_figure= false;

for i=1:length(indexes(:,1))
    path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    f = figure('units','normalized','position',[.1 .1 .6 .6]);
    
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
    plot(date_points, asymmetry,'xk','MarkerSize',8,'DisplayName',indexes{i,1});
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
