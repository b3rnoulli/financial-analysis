indexes = {
    'SP500-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 29, 230;
    'NASDAQ',       datetime('01-Jan-1950'), datetime('31-Dec-2016'), 30, 208;
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
        fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index)),...
            '-',datestr(data.date(end_index))];
        
        spectrum_data = load([path, spectrum_file_name]);
        specmulti(spectrum_data.MFDFA2, [path, spectrum_file_name], indexes{i,4}, indexes{i,5});

        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
    end
end