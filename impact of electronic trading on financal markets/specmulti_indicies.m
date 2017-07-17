
%nasdaq
% indexes = {
%        'AAPL', '02-Jan-1985', '03-Jan-2017';
%        'ADBE', '15-Sep-1986', '03-Jan-2017';
%        'AMGN', '01-Dec-1988', '03-Jan-2017';
%        'CMCSA','08-Jul-1988', '03-Jan-2017';
%        'COST', '10-Jul-1986', '03-Jan-2017';
%        'CSCO', '08-Jul-1988', '03-Jan-2017';
%        'MSFT', '03-Jan-1990', '29-Dec-2016';
%        'INTC', '02-Jan-1985', '29-Dec-2016';
%        'WBA',  '02-Jul-1985', '03-Jan-2017';
%        'TXN',  '02-Jan-1985', '29-Dec-2016';
%     };

%DJIA
indexes = {
    'AA',  '02-Jan-1981', '03-Jan-2017';
    'AIG', '02-Jan-1981', '03-Jan-2017';
    'AXP', '02-Jan-1981', '03-Jan-2017';
    'C',   '02-Jan-1981', '03-Jan-2017';
    'CVX', '02-Jan-1981', '03-Jan-2017';
    'DD',  '02-Jan-1981', '03-Jan-2017';
    'DIS', '02-Jan-1981', '03-Jan-2017';
    'GE',  '02-Jan-1981', '03-Jan-2017';
    'GT',  '02-Jan-1981', '03-Jan-2017';
    'HON', '02-Jan-1981', '03-Jan-2017';
    'HPQ', '02-Jan-1981', '03-Jan-2017';
    'IBM', '02-Jan-1981', '03-Jan-2017';
    'INTC','02-Jan-1981', '03-Jan-2017';
    'IP',  '02-Jan-1981', '03-Jan-2017';
    'JNJ', '02-Jan-1981', '03-Jan-2017';
    'KO',  '02-Jan-1981', '03-Jan-2017';
    'MCD', '02-Jan-1981', '03-Jan-2017';
    'MO',  '02-Jan-1981', '03-Jan-2017';
    'PG',  '02-Jan-1981', '03-Jan-2017';
    'PFE', '02-Jan-1981', '03-Jan-2017';
    'UTX', '02-Jan-1981', '03-Jan-2017';
    'WMT', '02-Jan-1981', '03-Jan-2017';
    'XOM', '02-Jan-1981', '03-Jan-2017';
    'UTX', '02-Jan-1981', '03-Jan-2017';
    'NAV', '02-Jan-1981', '03-Jan-2017';
    'MMM', '02-Jan-1981', '03-Jan-2017';
    'BA',  '02-Jan-1981', '03-Jan-2017';
    'BAC', '02-Jan-1981', '03-Jan-2017';
};

data_base_path = [get_root_path(),'/financial-analysis/empirical data/'];
for i=1:length(indexes)
    path = [data_base_path, indexes{i,1},'/'];
    
    spectrum_file_name = [indexes{i,1},'-RR-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name,'.mat']);
    
    specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
    
end