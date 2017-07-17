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
};

indexes = {
   '9-companies' %34 400
};

parfor i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/'];
    data = load([indexes{i,1},'_1962_01_02__2017_07_10_ret']);
    start_index = 1;
    end_index = length(data.returns);
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
    MFDFA(data.returns(start_index:end_index), [path,spectrum_file_name]);
end