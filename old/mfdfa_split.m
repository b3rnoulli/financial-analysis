        
index_data = {
    'SP500_removed', '01-Jan-1950', '01-Jan-1987', '01-Jan-2016';
%     'DJIA',  '01-Jan-1950', '01-Jan-1987', '01-Jan-2016';
%     'NDX',   '01-Jan-1950', '01-Jan-1987', '01-Jan-2016';
%     'DAX',   '01-Jan-1960', '01-Jan-1987', '01-Jan-2016';
%     'UKX',   '01-Jan-1955', '01-Jan-1987', '01-Jan-2016';
%     'NKX',   '01-Jan-1955', '01-Jan-1987', '01-Jan-2016';
    };

parfor i=1:length(index_data(:,1))
    path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\frame\'];
    data = load(index_data{i,1});
    log_return_rates = zscore(diff(log(data.price)));
    
    start_index = find_index(data,index_data{i,2});
    end_index = shift_index(data, start_index, frame_size, frame_size_type);
    
    
end


