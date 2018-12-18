function data_importer(table, symbol)

date = table2array(table(:,1));
open = table2array(table(:,2));
highest = table2array(table(:,3));
lowest = table2array(table(:,4));
close = table2array(table(:,5));
volume = table2array(table(:,7));

save([symbol,'.mat'],'date','open','close','highest','lowest','volume');

end

