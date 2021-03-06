clear
clc
indexes = {
    'NASDAQ-removed',        datetime('01-Jan-1950'), datetime('31-Dec-2016'), 450, 800;
    '9-companies',       datetime('01-Jan-1950'), datetime('31-Dec-2016'),  450, 800;
    };

frame_size = 5000;
frame_step_size = 20;


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/mean/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index = frame_size;
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[specmulti_window_surrogate] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        fourier_spectrum_data = load([path, fourier_spectrum_file_name]);
        
%         shuffled_spectrum_file_name = [indexes{i,1},'-shuffled-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%             '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%         shuffled_surrogate_data = load([path, shuffled_spectrum_file_name]);
        
        specmulti(fourier_spectrum_data.MFDFA2, [path, fourier_spectrum_file_name], indexes{i,4}, indexes{i,5});
%         specmulti(shuffled_surrogate_data.MFDFA2, [path, shuffled_spectrum_file_name], indexes{i,4}, indexes{i,5});
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        
    end
   
end