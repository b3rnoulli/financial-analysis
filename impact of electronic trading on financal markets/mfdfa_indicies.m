clear
clc
% %nasdaq
% indexes = {
%        'AAPL', '01-Jan-1985', '31-Dec-2016';
%        'ADBE', '14-Sep-1986', '31-Dec-2016';
%        'AMGN', '30-Nov-1988', '31-Dec-2016';
%        'CMCSA','07-Jul-1988', '31-Dec-2016';
%        'COST', '09-Jul-1986', '31-Dec-2016';
%        'CSCO', '07-Jul-1988', '31-Dec-2016';
%        'MSFT', '02-Jan-1990', '31-Dec-2016';
%        'INTC', '02-Jan-1985', '31-Dec-2016';
%        'WBA',  '01-Jul-1985', '31-Dec-2016';
%        'TXN',  '02-Jan-1985', '31-Dec-2016';
%     };
%DJIA
indexes = {
    'AA',  '01-Jan-1981', '31-Dec-2016';
    'AIG', '01-Jan-1981', '31-Dec-2016';
    'AXP', '01-Jan-1981', '31-Dec-2016';
    'C',   '01-Jan-1981', '31-Dec-2016';
    'CVX', '01-Jan-1981', '31-Dec-2016';
    'DD',  '01-Jan-1981', '31-Dec-2016';
    'DIS', '01-Jan-1981', '31-Dec-2016';
    'GE',  '01-Jan-1981', '31-Dec-2016';
    'GT',  '01-Jan-1981', '31-Dec-2016';
    'HON', '01-Jan-1981', '31-Dec-2016';
    'HPQ', '01-Jan-1981', '31-Dec-2016';
    'IBM', '01-Jan-1981', '31-Dec-2016';
    'INTC','01-Jan-1981', '31-Dec-2016';
    'IP',  '01-Jan-1981', '31-Dec-2016';
    'JNJ', '01-Jan-1981', '31-Dec-2016';
    'KO',  '01-Jan-1981', '31-Dec-2016';
    'MCD', '01-Jan-1981', '31-Dec-2016';
    'MO',  '01-Jan-1981', '31-Dec-2016';
    'PG',  '01-Jan-1981', '31-Dec-2016';
    'PFE', '01-Jan-1981', '31-Dec-2016';
    'UTX', '01-Jan-1981', '31-Dec-2016';
    'WMT', '01-Jan-1981', '31-Dec-2016';
    'XOM', '01-Jan-1981', '31-Dec-2016';
    'UTX', '01-Jan-1981', '31-Dec-2016';
    'NAV', '01-Jan-1981', '31-Dec-2016';
    'MMM', '01-Jan-1981', '31-Dec-2016';
    'BA',  '01-Jan-1981', '31-Dec-2016';
    'BAC', '01-Jan-1981', '31-Dec-2016';
    };

data_base_path = [get_root_path(),'/financial-analysis/empirical data/'];
for i=1:1:length(indexes(:,1))
    data = load([data_base_path,indexes{i,1},'/',indexes{i,1},'_1980_06_12__2017_06_16_ret.mat']);
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = find_index(data.date,indexes{i,3});
    path = [data_base_path, indexes{i,1},'/'];

    if end_index > length(data.returns)
        end_index = length(data.returns);
    end
    
    spectrum_file_name = [indexes{i,1},'-RR-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-', datestr(data.date(end_index),'yyyy-mm-dd')];
    MFDFA(data.returns(start_index:end_index), [path, 'spectrum/', spectrum_file_name]);
    
    
end