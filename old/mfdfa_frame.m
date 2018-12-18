clear
clc

% index name, start year, end year
index_data = {
       'SP500_removed', '01-Jan-1963', '31-Dec-1993';

%     'XAUUSD', '01-Jan-1980', '31-Dec-2015';
%     'CL', '01-Jan-1985', '31-Dec-2015';
%     'EURUSD', '01-Jan-1950', '31-Dec-2015';
%     'SP500', '01-Jan-1950', '31-Dec-2015';
%     'DJIA',  '01-Jan-1950', '31-Dec-2015';
%     'NDX',   '01-Jan-1950', '31-Dec-2015';
%     'DAX',   '01-Jan-1960', '31-Dec-2015';
%     'UKX',   '01-Jan-1955', '31-Dec-2015';
%     'NKX',   '01-Jan-1955', '31-Dec-2015';
    };

% index_data = {
%     'SP500', '01-Jan-1965', '01-Jan-1990';
%     'DJIA',  '01-Jan-1965', '01-Jan-1990';
%     'NDX',   '01-Jan-1965', '01-Jan-1990';
%     'DAX',   '01-Jan-1965', '01-Jan-1990';
%     'UKX',   '01-Jan-1965', '01-Jan-1990';
%     'NKX',   '01-Jan-1965', '01-Jan-1990';
%     };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'WEEK';

for i=1:length(index_data(:,1))
    path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\frame\'];
    data = load(index_data{i,1});
    log_return_rates = zscore(diff(log(data.price)));
    
    start_index = find_index(data,index_data{i,2});
    end_index = shift_index(data, start_index, frame_size, frame_size_type);

    while end_index < find_index(data,index_data{i,3})        
        fprintf('mfdfa_frame : Calculating MFDFA for index %s date scope %s to %s\n', index_data{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [index_data{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        MFDFA(log_return_rates(start_index :end_index), [path,spectrum_file_name]);
        start_index = shift_index(data, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data, end_index, frame_step_size, frame_step_type);
    end
end

