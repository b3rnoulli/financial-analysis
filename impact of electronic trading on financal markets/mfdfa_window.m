% index name, start year, end year
indexes = {
       'SP500-removed', '01-Jan-1950', '31-Dec-2016';
       'NASDAQ',        '01-Jan-1950', '31-Dec-2016';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

for i=1:length(indexes(:,1))
    path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);

    while end_index < find_index(data.date,indexes{i,3})        
        fprintf('[mfdfa_windows_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index)),...
            '-',datestr(data.date(end_index))];
        
        MFDFA(data.returns(start_index:end_index), [path,spectrum_file_name]);
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
    end
end
