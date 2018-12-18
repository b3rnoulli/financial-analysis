symbols = {
    'HPQ'
    'AA';
    'AIG';
    'AXP';
    'C';
    'CVX';
    'DD';
    'DIS';
    'GE';
    'GT';
    'HON';
    'HPQ';
    'IBM';
    'INTC';
    'IP';
    'JNJ';
    'KO';
    'MCD';
    'MO';
    'PG';
    'PFE';
    'UTX';
    'WMT';
    'XOM';
    'UTX';
    'NAV';
    'MMM';
    'BA';
    'BAC';
};


date = load('dates.mat');
date = date.dates;

for i=1:1:length(symbols)
    path = [get_root_path(),'/financial-analysis/empirical data/',symbols{i,1},'/'];
    data_table = load([symbols{i,1},'_1970_01_02__2017_06_16_ret.dat']);
    returns = data_table;
    save([path,symbols{i,1},'_1980_06_12__2017_06_16_ret.mat'],'date','returns');
  
    
end