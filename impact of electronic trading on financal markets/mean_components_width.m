clear
clc

index_name='NASDAQ';
global_start = datenum(datetime('01-Jan-2001'));
global_end = datenum(datetime('31-Dec-2016'));
% indexes = {
%     'AAPL', '01-Jan-1985', '31-Dec-2016', 'x', 11.81;
%     'MSFT', '01-Jan-1985', '31-Dec-2016', 'o', 8.21;
%     'CMCSA','01-Jan-1985', '31-Dec-2016', 's', 2.91;
%     'INTC', '01-Jan-1985', '31-Dec-2016', '*', 2.55;
%     'CSCO', '01-Jan-1985', '31-Dec-2016', '>', 2.37;
%     'AMGN', '01-Jan-1985', '31-Dec-2016', 'd', 1.83;
%     'WBA',  '01-Jan-1985', '31-Dec-2016', '^', 1.32;
%     'TXN',  '01-Jan-1985', '31-Dec-2016', 'v', 1.22;
%     'COST', '01-Jan-1985', '31-Dec-2016', 'p', 1.20;
%     'ADBE', '01-Jan-1985', '31-Dec-2016', 'h', 1.03;
%     };

%DJIA

index_name='DJIA-RR';
indexes = {
    'AA',  '01-Jan-1981', '02-Oct-2013','x',1;
    'AIG', '01-Jan-1984', '04-Aug-2008','o',1;
    'AXP', '01-Jan-1982', '31-Dec-2016','s',1;
    'C',   '01-Jan-1981', '02-Jul-2009','*',1;
    'CVX', '01-Jan-1985', '31-Dec-2016','>',1;
    'DD',  '01-Jan-1981', '31-Dec-2016','d',1;
    'DIS', '01-Jan-1991', '31-Dec-2016','^',1;
    'GE',  '01-Jan-1981', '31-Dec-2016','v',1;
%     'GT',  '01-Jan-1981', '31-Nov-1999','p',1;  nie lapie sie na okno
    'HON', '01-Jan-1981', '02-Jan-2003','h',1;
    'HPQ', '01-Jan-1981', '03-Sep-2013','x',1;
    'IBM', '01-Jan-1981', '31-Dec-2016','o',1;
    'INTC','01-Jan-1981', '31-Dec-2016','s',1;
    'IP',  '01-Jan-1981', '02-Apr-2004','*',1;
    'JNJ', '01-Jan-1981', '31-Dec-2016','>',1;
    'KO',  '01-Jan-1981', '31-Dec-2016','d',1;
    'MCD', '01-Jan-1981', '31-Dec-2016','^',1;
    'MO',  '01-Jan-1981', '31-Dec-2016','v',1;
    'PG',  '01-Jan-1981', '31-Dec-2016','p',1;
    'PFE', '02-Jan-1984', '31-Dec-2016','h',1;
    'UTX', '01-Jan-1981', '31-Dec-2016','x',1;
    'WMT', '01-Jan-1981', '31-Dec-2016','o',1;
    'XOM', '01-Jan-1981', '31-Dec-2016','s',1;
    'UTX', '01-Jan-1981', '31-Dec-2016','*',1;
    'NAV', '01-Jan-1981', '31-Dec-2016','>',1;
    'MMM', '01-Jan-1981', '31-Dec-2016','d',1;
    'BA',  '01-Jan-1981', '31-Dec-2016','^',1;
    'BAC', '01-Jan-1988', '31-Dec-2016','v',1;
};
frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

components = struct;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
        
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    alpha_y =[];
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[spectrum_width_plotter] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-RR-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        components(i).alpha_y(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:70),spectrum_data.MFDFA2.f(31:70));
        components(i).a_y(point_counter) = spectrum_asymmetry(spectrum_data.MFDFA2.alfa(50), min(spectrum_data.MFDFA2.alfa(50:71)),...
            spectrum_data.MFDFA2.alfa(31:50));
        components(i).date_x(point_counter) = datenum(data.date(end_index));
        point_counter = point_counter +1;
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
    end
end


mean_components = struct;

date_counter = 1;
while global_start <= global_end
    
    current_datenum = datenum(global_start);
    mean_components(date_counter).date = current_datenum;
    for i=1:length(indexes(:,1))
        [current_year, current_month, ~] = datevec(datenum(current_datenum));
        for j=1:length(components(i).date_x)
            [yy, mm, ~] = datevec(components(i).date_x(j));
            if current_year == yy && current_month == mm
                 mean_components(date_counter).width(i) = components(i).alpha_y(j);
                 mean_components(date_counter).asymmetry(i) = components(i).a_y(j);
                 mean_components(date_counter).weights(i) = cell2mat(indexes(i,5));
                 break;
            end
        end 
    end
    
    mean_components(date_counter).mean_weighted_width = nanmean(mean_components(date_counter).width*mean_components(date_counter).weights',2)./sum(mean_components(date_counter).weights);
    mean_components(date_counter).mean_weighted_asymmetry = nanmean(mean_components(date_counter).asymmetry*mean_components(date_counter).weights',2)./sum(mean_components(date_counter).weights);
    
    for i=1:length(mean_components(date_counter).width)
        if mean_components(date_counter).width(i) == 0
           mean_components(date_counter).width(i)=NaN; 
           mean_components(date_counter).asymmetry(i)=NaN; 
        end
        
    end
    mean_components(date_counter).mean_width = nanmean(mean_components(date_counter).width);
    mean_components(date_counter).mean_asymmetry = nanmean(mean_components(date_counter).asymmetry);

    global_start = addtodate(global_start,1,'month');
    date_counter = date_counter +1;
end

save([index_name,'-components-mean-width-asymmetry','.mat'],'mean_components');




