clear
clc
% index name, start year, end year
% indexes = {
%     'HPQ'
%     'AA';
%     'AIG';
%     'AXP';
%     'C';
%     'CVX';
%     'DD';
%     'DIS';
%     'GE';
%     'GT';
%     'HON';
%     'HPQ';
%     'IBM';
%     'INTC';
%     'IP';
%     'JNJ';
%     'KO';
%     'MCD';
%     'MO';
%     'PG';
%     'PFE';
%     'UTX';
%     'WMT';
%     'XOM';
%     'UTX';
%     'NAV';
%     'MMM';
%     'BA';
%     'BAC';
% };


% indexes= {
%    '9-companies'
% };

indexes = {
    'DD';
    'GE';
    'AA';
    'IBM';
    'KO';
    'BA';
    'CAT';
    'DIS';
    'HPQ';
%     'DJIA';
%     'SP500-removed';
%     'NASDAQ-removed';
%     'NASDAQ-removed-20';
};

frame_size = 5000;
frame_step_size = 20;

parfor i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
%     data = load([indexes{i,1},'_1962_01_02__2017_07_10_ret']);
    data = load(indexes{i,1});
    mkdir([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/']);
    
    start_index = 1;
    end_index = start_index + frame_size;
    
    while end_index < length(data.returns)
        fprintf('[mfdfa_window_fixed_step] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index),'yyyy-mm-dd'), datestr(data.date(end_index),'yyyy-mm-dd'));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        MFDFA(data.returns(start_index:end_index), [path,spectrum_file_name]);
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
    end
end
