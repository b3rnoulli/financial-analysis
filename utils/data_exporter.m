symbols = {
    'AAPL'
    'HON'
    'DD'
    'GE'
    'GT'
    'NAV'
    'IP'
    'PG'
    'CVX'
    'XOM'
    'UTX'
    'AA'
    'MMM'
    'IBM'
    'MERC'
    'AXP'
    'MO'
    'MCD'
    'KO'
    'BA'
    'CAT'
    'DIS'
    'JPM'
    'JNJ'
    'HPQ'
    'C'
    'WMT'
    'INTC'
    'HD'
    'MSFT'
    'AIG'
    'PFE'
    'VZ'
    'BAC'
    'TRV'
    'CSCO'
    'GS'
    'V'
    'UNH'
    'NKE'
    };


% dates
load([get_root_path(),'/financial-analysis/empirical data/DD/DD.mat']);
dates = date;

% write symbol, dates
fprintf('date')
fid = fopen('close.csv', 'w') ;
fprintf(fid,'date');
for i=1:length(symbols)
    fprintf(fid,[',',symbols{i}]);
end
fprintf(fid,'\n');
for i=1:length(symbols)
    data_struct(i) = load([get_root_path(),'/financial-analysis/empirical data/',symbols{i},'/',symbols{i},'.mat']);
end

for j=1:1:length(dates)
    fprintf('Writing %s data \n', datestr(dates(j),'yyyy-mm-dd'));
    fprintf(fid,datestr(dates(j),'yyyy-mm-dd'));  
    for i=1:length(symbols)
        fprintf(' %s ', symbols{i})
        dd = datefind(dates(j),data_struct(i).date);
        if isempty(dd)
            fprintf(fid,', '); 
        else
            fprintf(fid,[', ',num2str(data_struct(i).close(dd))]); 
        end 
            
    end
    fprintf(fid,'\n');
    fprintf('\n');
end
