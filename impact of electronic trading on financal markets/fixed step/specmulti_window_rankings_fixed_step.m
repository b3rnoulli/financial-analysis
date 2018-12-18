clear
clc
indexes = {
%     'SP500-removed',           datetime('01-Jan-1950'), datetime('31-Dec-2017'), 34,400;
    'NASDAQ-removed',        datetime('01-Jan-1950'), datetime('31-Dec-2017'), 34,230;
%      '9-companies',       datetime('01-Jan-1950'), datetime('31-Dec-2016'), 34, 400;
    };

frame_size = 5000;
frame_step_size = 20;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/mean/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index = frame_size;

    while end_index < length(data.returns)      
        fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-rankings-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path, spectrum_file_name]);
        specmulti(spectrum_data.MFDFA2, [path, spectrum_file_name], indexes{i,4}, indexes{i,5});

        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
    end
end