clear
clc
% index name, start year, end year
indexes = {
%     'HPQ', 34, 400;
%     'AA',  34, 400;
%     'AIG', 34, 400;
%     'AXP', 34, 400;
%     'C',   34, 400;
%     'CVX', 34, 400;
%     'DD',  34, 400;
%     'DIS', 34, 400;
%     'GE',  34, 400;
%     'GT',  34, 400;
%     'HON', 34, 400;
%     'HPQ', 34, 400;
%     'IBM', 34, 400;
%     'INTC',34, 400;
%     'IP',  34, 400;
%     'JNJ', 34, 400;
%     'KO',  34, 400;
%     'MCD', 34, 400;
%     'MO',  34, 400;
%     'PG',  34, 400;
%     'PFE', 34, 400;
%     'UTX', 34, 400;
%     'WMT', 34, 400;
%     'XOM', 34, 400;
%     'UTX', 34, 400;
%     'NAV', 34, 400;
%     'MMM', 34, 400;
%     'BA',  34, 400;
%     'BAC', 34, 400;
%         '9-companies', 34, 350;
%        'NASDAQ-removed' 35, 450;
%        'NASDAQ-removed-20' 35, 450;
%        'SP500-removed' 35, 450;
    };

indexes = {
    'DD' , 34, 400;
    'GE' , 34, 400;
    'AA' , 34, 400;
    'IBM', 34, 400;
    'KO' , 34, 400;you
    'BA' , 34, 400;
    'CAT', 34, 400;
    'DIS', 34, 400;
    'HPQ', 34, 400;
%     '9-companies', 34, 400;
};

frame_size = 5000;
frame_step_size = 20;

parfor i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load([indexes{i,1}]);
    mkdir([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/']);
%     8372
    start_index = 1;
    end_index = start_index + frame_size;
    
    while end_index < length(data.returns)
        fprintf('[mfdfa_window_fixed_step] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index),'yyyy-mm-dd'), datestr(data.date(end_index),'yyyy-mm-dd'));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path,spectrum_file_name]);
        specmulti(spectrum_data.MFDFA2, [path, spectrum_file_name], indexes{i,2}, indexes{i,3});
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
    end
end
