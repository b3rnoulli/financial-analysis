symbols = {'BRKA','DIS','GE','INTC','IP','JPM','PFE','PG','T','TXN','XOM'};

cut_date = datetime('01-Jan-1985');
end_date = datetime('01-Jan-2017');

for i=1:length(symbols)
    load(symbols{i})
    cut_index = find_index(date,cut_date);
    end_index = find_index(date,end_date);
    cut_index = cut_index - 1;
    date(end_index:end) = [];
    date(1:cut_index) = [];
    
    close(end_index:end) = [];
    close(1:cut_index) = [];
    open(end_index:end) = [];
    open(1:cut_index) = [];
    volume(end_index:end) = [];
    volume(1:cut_index) = [];
    lowest(end_index:end) = [];
    lowest(1:cut_index) = [];
    heighest(end_index:end) = [];
    heighest(1:cut_index) = [];
    highest= heighest;
    returns = zscore(diff(log(close)));
    black_monday_crash_index = find_index(date,'19-Oct-1987');
    returns(black_monday_crash_index-2) = [];
    save([symbols{i},'.mat'],'date','open','close','highest','lowest','volume','returns')
  
end