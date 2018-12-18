clear
clc

% index name, start year, end year
index_data = {
    'SP500', '01-Jan-1965', '01-Jan-1990'
    'DJIA',  '01-Jan-1965', '01-Jan-1990'
    'NDX',   '01-Jan-1965', '01-Jan-1990'
    'DAX',   '01-Jan-1965', '01-Jan-1990'
    'UKX',   '01-Jan-1965', '01-Jan-1990'
    'NKX',   '01-Jan-1965', '01-Jan-1990'
    
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'WEEK';

autosave = 0;
retry_enabled = 1;
retry = 1;

for i=1:length(index_data(:,1))
    path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\frame\'];
    data = load(index_data{i,1});
    log_return_rates = zscore(diff(log(data.price)));
    
    start_index = find_index(data,index_data{i,2});
    end_index = shift_index(data, start_index, frame_size, frame_size_type);
    
    while end_index < find_index(data,index_data{i,3})
        fprintf('specmulti_frame_fixed : Calculating spectrum for index %s date scope %s to %s \n using manually adjusted scales\n',...
            index_data{i,1},datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [index_data{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spec_data = load([spectrum_file_name,'_m2_wyniki.mat']);
        new_spectrum_file_name = [path, spectrum_file_name];
        
        specmulti_retryable(new_spectrum_file_name, retry_enabled, retry, autosave)

        start_index = shift_index(data, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data, end_index, frame_step_size, frame_step_type);
    end
end

