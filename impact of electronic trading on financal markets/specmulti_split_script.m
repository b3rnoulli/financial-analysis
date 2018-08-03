indexes = {
%      'SP500-removed',datetime('03-Jan-1950'),  datetime('02-Jan-1987'), datetime('29-Dec-2016'),  23, 169;
%      'NASDAQ-removed',datetime('03-Jan-1950'),  datetime('02-Jan-1987'), datetime('29-Dec-2016'), 23, 168;
%      'DJIA',datetime('03-Jan-1950'),  datetime('02-Jan-1987'), datetime('03-Jan-2017'), 35, 450;
%        'IXIC',datetime('05-Feb-1971'),  datetime('02-Jan-1987'), datetime('03-Jan-2017'), 35, 450;
    };

auto_scale_adjust = false;

data_base_path = [get_root_path(),'/financial-analysis/empirical data/'];
for i=1:1:length(indexes(:,1))
    path = [data_base_path, indexes{i,1},'/'];
    
    % 1950 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name,'.mat']);
    
    if auto_scale_adjust == false
        specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
    else
        specmulti(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name], indexes{i,5}, indexes{i,6});
    end
    
    % 1950 - 1987
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name]);
    
    if auto_scale_adjust == false
        specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
    else
        specmulti(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name], indexes{i,5}, indexes{i,6});
    end
    
    % 1987 - 2017
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,3},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name]);
    
    if auto_scale_adjust == false
        specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
    else
        specmulti(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name], indexes{i,5}, indexes{i,6});
    end
end