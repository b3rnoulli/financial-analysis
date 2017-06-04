% index name, start year, end year
indexes = {
       'AAPL', '01-Jan-1985', '31-Dec-2016';
       'BRKA', '01-Jan-1985', '31-Dec-2016';
       'DIS', '01-Jan-1985', '31-Dec-2016';
       'GE', '01-Jan-1985', '31-Dec-2016';
       'INTC', '01-Jan-1985', '31-Dec-2016';
       'IP', '01-Jan-1985', '31-Dec-2016';
       'JPM', '01-Jan-1985', '31-Dec-2016';
       'PFE', '01-Jan-1985', '31-Dec-2016';
       'PG', '01-Jan-1985', '31-Dec-2016';
       'T', '01-Jan-1985', '31-Dec-2016';
       'TXN', '01-Jan-1985', '31-Dec-2016';
       'XOM', '01-Jan-1985', '31-Dec-2016';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);

    while end_index < find_index(data.date,indexes{i,3})        
        fprintf('[mfdfa_windows_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index),'yyyy-mm-dd'), datestr(data.date(end_index),'yyyy-mm-dd'));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        MFDFA(data.returns(start_index:end_index), [path,spectrum_file_name]);
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
    end
end
