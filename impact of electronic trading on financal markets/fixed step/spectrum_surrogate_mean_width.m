% srednia po szerokosciach

clear
clc
indexes = {
        'SP500-removed',           datetime('01-Jan-1950'), datetime('31-Dec-2017'), 34,400;
%     'NASDAQ-removed',        datetime('01-Jan-1950'), datetime('31-Dec-2017'), 34,230;
    %      '9-companies',       datetime('01-Jan-1950'), datetime('31-Dec-2016'), 34, 400;
    };

frame_size = 5000;
frame_step_size = 20;
surrogate_count = 100;

mean_width = [];
mean_width_std = [];
for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate-fixed-step/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index = frame_size;
    
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    while end_index < length(data.returns)
        fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path, spectrum_file_name,'.mat']);
        for j=1:1:surrogate_count
            width(j) = spectrum_width(spectrum_data(j).alfa(31:70), spectrum_data(j).f(31:70));
        end
        mean_width(point_counter) = mean(width);
        mean_width_std(point_counter) = std(width);
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        point_counter=point_counter+1;
    end
end