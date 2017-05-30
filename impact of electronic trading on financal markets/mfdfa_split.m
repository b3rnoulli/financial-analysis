indexes = {
    'SP500-removed',datetime('01-Jan-1950'),  datetime('01-Jan-1987'), datetime('1-Jan-2017');
    'NASDAQ',       datetime('01-Jan-1950'),  datetime('01-Jan-1987'), datetime('1-Jan-2017')
    };

data_base_path = '/Users/b3rnoulli/Development/Matlab workspace/empirical data/';
for i=1:1:length(indexes(:,1))
    data = load([data_base_path,indexes{i,1},'/',indexes{i,1},'.mat']);
    log_return_rates = zscore(diff(log(data.close)));
    
    start_index = find_index(data.date,indexes{i,2});
    split_index = find_index(data.date,indexes{i,3});
    end_index = find_index(data.date, indexes{i,4});
    
    path = [data_base_path, indexes{i,1},'/'];
    % 1950 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index)),...
        '-', datestr(data.date(end_index))];
    MFDFA(log_return_rates(start_index:end_index), [path, 'spectrum/', spectrum_file_name]);
    
    % 1950 - 1987
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index)),...
        '-', datestr(data.date(split_index))];
    MFDFA(log_return_rates(start_index:split_index), [path, 'spectrum/', spectrum_file_name]);
    
    % 1987 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(split_index)),...
        '-', datestr(data.date(end_index))];
    MFDFA(log_return_rates(split_index:end_index), [path, 'spectrum/', spectrum_file_name]);
end