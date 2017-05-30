indexes = {
    'SP500-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 350, 800;
%     'NASDAQ',       datetime('01-Jan-1950'), datetime('31-Dec-2016'), 450, 700;
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

surrogates_per_window = 10;

for i=1:length(indexes(:,1))
    path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/surrogate/mean/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[specmulti_window_surrogate] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index)),...
            '-',datestr(data.date(end_index))];
        
        fourier_spectrum_data = load([path, fourier_spectrum_file_name]);
        
        shuffled_spectrum_file_name = [indexes{i,1},'-shuffled-surrogate-mean-spectrum-',datestr(data.date(start_index)),...
            '-',datestr(data.date(end_index))];
        shuffled_surrogate_data = load([path, shuffled_spectrum_file_name]);
        
        specmulti(fourier_spectrum_data.MFDFA2, [path, fourier_spectrum_file_name], indexes{i,4}, indexes{i,5});
        specmulti(shuffled_surrogate_data.MFDFA2, [path, shuffled_spectrum_file_name], indexes{i,4}, indexes{i,5});
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        
    end
   
end