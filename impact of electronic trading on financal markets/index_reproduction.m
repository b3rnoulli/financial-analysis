index_name='DJIA-RR';
indexes = {
    'AA',  '01-Jan-1981', '02-Oct-2013','x',1;
    'AIG', '01-Jan-1984', '04-Aug-2008','o',1;
    'AXP', '01-Jan-1982', '31-Dec-2016','s',1;
    'C',   '01-Jan-1981', '02-Jul-2009','*',1;
    'CVX', '01-Jan-1985', '31-Dec-2016','>',1;
    'DD',  '01-Jan-1981', '31-Dec-2016','d',1;
    'DIS', '01-Jan-1991', '31-Dec-2016','^',1;
    'GE',  '01-Jan-1981', '31-Dec-2016','v',1;
    'GT',  '01-Jan-1981', '30-Nov-1999','p',1;  %nie lapie sie na okno
    'HON', '01-Jan-1981', '02-Jan-2003','h',1;
    'HPQ', '01-Jan-1981', '03-Sep-2013','x',1;
    'IBM', '01-Jan-1981', '31-Dec-2016','o',1;
    'INTC','01-Jan-1981', '31-Dec-2016','s',1;
    'IP',  '01-Jan-1981', '02-Apr-2004','*',1;
    'JNJ', '01-Jan-1981', '31-Dec-2016','>',1;
    'KO',  '01-Jan-1981', '31-Dec-2016','d',1;
    'MCD', '01-Jan-1981', '31-Dec-2016','^',1;
    'MO',  '01-Jan-1981', '31-Dec-2016','v',1;
    'PG',  '01-Jan-1981', '31-Dec-2016','p',1;
    'PFE', '02-Jan-1984', '31-Dec-2016','h',1;
    'UTX', '01-Jan-1981', '31-Dec-2016','x',1;
    'WMT', '01-Jan-1981', '31-Dec-2016','o',1;
    'XOM', '01-Jan-1981', '31-Dec-2016','s',1;
    'UTX', '01-Jan-1981', '31-Dec-2016','*',1;
    'NAV', '01-Jan-1981', '31-Dec-2016','>',1;
    'MMM', '01-Jan-1981', '31-Dec-2016','d',1;
    'BA',  '01-Jan-1981', '31-Dec-2016','^',1;
    'BAC', '01-Jan-1988', '31-Dec-2016','v',1;
};



dates = load('dates.mat');
date = dates.dates;
price = ones(1,length(date)).*1000;

for i=1:length(indexes)
    data_struct(i) = load([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/',indexes{i,1},'_1980_06_12__2017_06_16_ret.mat']);
end


for i=2:1:length(date)
    fprintf('Processing date %s \n',datestr(date(i)));
    price(i) = price(i-1);
    for j=1:1:length(indexes)
        if datetime(indexes{j,2}) < date(i) && datetime(indexes{j,3}) > date(i)
            price(i) = price(i) + data_struct(j).returns(i);
        end
    end
    
end



