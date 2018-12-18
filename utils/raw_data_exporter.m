symbols = {
    'SP500-removed';
    'NASDAQ-removed';
    'DJIA';
    '9-companies';
    };


for i=1:1:length(symbols)
    
    data = load(symbols{i});
    
    fid = fopen([symbols{i},'.csv'], 'w') ;
    fprintf(fid,['date,','price,','returns\n']);
    
    for j=1:1:length(data.date)
        if j<length(data.returns)
            fprintf(fid,[datestr(data.date(j),'dd-mm-yyyy'),',',num2str(data.close(j)),',',num2str(data.returns(j)),'\n']);
        else
            fprintf(fid,[datestr(data.date(j),'dd-mm-yyyy'),',',num2str(data.close(j)),'\n']);
        end
    end
    
    fclose(fid);
    
end