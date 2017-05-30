clear
clc

% index name, start year, end year
index_data = {
    'SP500', '01-Jan-1950', '31-Dec-2015';
    'DJIA',  '01-Jan-1950', '31-Dec-2015';
    'NDX',   '01-Jan-1950', '31-Dec-2015';
    'DAX',   '01-Jan-1960', '31-Dec-2015';
    'UKX',   '01-Jan-1955', '31-Dec-2015';
    'NKX',   '01-Jan-1955', '31-Dec-2015';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'YEAR';


for i=1:length(index_data(:,1))
    data = load(index_data{i,1});
    log_return_rates = zscore(diff(log(data.price)));
    
    start_index = find_index(data,index_data{i,2});
    end_index = shift_index(data, start_index, frame_size, frame_size_type);
    
    while end_index < find_index(data,index_data{i,3})
        new_path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\frame\'];
        spectrum_file_name = [index_data{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        old_file_path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\archive\frames\'];
        old_file_name = [index_data{i,1},'_spectrum_',num2str(year(data.date(start_index))),...
            '_',num2str(year(data.date(end_index))),'_m2_wyniki'];
        load([old_file_path,old_file_name,'.mat']);

        fprintf('file_transformer : Transforming file %s to %s', old_file_name, [spectrum_file_name,'m2_wyniki']);
        
        save([new_path,spectrum_file_name,'_m2_wyniki'],'MFDFA2');
        start_index = shift_index(data, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data, end_index, frame_step_size, frame_step_type);
    end
    
    
end