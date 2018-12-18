indexes = {
%     'SP500-removed',datetime('01-Jan-1950'),  datetime('01-Jan-1987'), datetime('1-Jan-2017');
%     'NASDAQ-removed',       datetime('01-Jan-1950'),  datetime('01-Jan-1987'), datetime('1-Jan-2017')
%     'DJIA',       datetime('01-Jan-1950'),  datetime('01-Jan-1987'), datetime('1-Jan-2017');
%     'NDX',       datetime('01-Oct-1985'),  datetime('01-Jan-1987'), datetime('1-Jan-2017');
%     'IXIC',       datetime('01-Jan-1971'),  datetime('01-Jan-1987'), datetime('1-Jan-2017');
    '9-companies',       datetime('01-Jan-1962'),  datetime('01-Jan-1987'), datetime('1-Jan-2017');
    };

data_base_path = '/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/';
for i=1:1:length(indexes(:,1))
    data = load([data_base_path,indexes{i,1},'/',indexes{i,1},'.mat']);
    log_return_rates = zscore(diff(log(data.close)));
    
    start_index = find_index(data.date,indexes{i,2});
    split_index = find_index(data.date,indexes{i,3});
    end_index = find_index(data.date, indexes{i,4});
    
    path = [data_base_path, indexes{i,1},'/'];
    % 1950 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-', datestr(data.date(end_index),'yyyy-mm-dd')];
    MFDFA(log_return_rates(start_index:end_index), [path, 'spectrum/', spectrum_file_name]);
    
    % 1950 - 1987
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-', datestr(data.date(split_index),'yyyy-mm-dd')];
    MFDFA(log_return_rates(start_index:split_index), [path, 'spectrum/', spectrum_file_name]);
    
    % 1987 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(split_index),'yyyy-mm-dd'),...
        '-', datestr(data.date(end_index),'yyyy-mm-dd')];
    MFDFA(log_return_rates(split_index:end_index), [path, 'spectrum/', spectrum_file_name]);
end