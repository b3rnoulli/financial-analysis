indexes = {
    'SP500-removed',datetime('03-Jan-1950'),  datetime('02-Jan-1987'), datetime('29-Dec-2016'), 23, 169;
    'NASDAQ',       datetime('03-Jan-1950'),  datetime('02-Jan-1987'), datetime('29-Dec-2016'), 23, 168
    };

auto_scale_adjust = false;

data_base_path = '/Users/b3rnoulli/Development/Matlab workspace/empirical data/';
for i=1:1:length(indexes(:,1))
    path = [data_base_path, indexes{i,1},'/'];
    
    % 1950 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2}),...
        '-', datestr(indexes{i,4})];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name,'.mat']);
    
    if auto_scale_adjust == false
        specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
    else
        specmulti(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name], indexes{i,5}, indexes{i,6});
    end
    
    % 1950 - 1987
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2}),...
        '-', datestr(indexes{i,3})];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name]);
    
    if auto_scale_adjust == false
        specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
    else
        specmulti(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name], indexes{i,5}, indexes{i,6});
    end
    
    % 1987 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,3}),...
        '-', datestr(indexes{i,4})];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name]);
    
    if auto_scale_adjust == false
        specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
    else
        specmulti(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name], indexes{i,5}, indexes{i,6});
    end
end