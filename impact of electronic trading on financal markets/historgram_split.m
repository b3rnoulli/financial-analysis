indexes = {
    'SP500-removed',datetime('03-Jan-1950'),datetime('02-Jan-1987'), datetime('29-Dec-2016'), '^-', 'r', 'S&P500 1950-2017';
    };

f = figure('units','normalized','position',[.1 .1 .4 .5]);
f.PaperPositionMode = 'auto';
for i=1:1:length(indexes(:,1))
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    split_index = find_index(data.date,indexes{i,3});
    end_index = find_index(data.date,indexes{i,4});
    
    
    [a,~] = find(data.returns(start_index:split_index)>-0.5 & ...
        data.returns(start_index:split_index)<0.5);
    [b,~] = find(data.returns(split_index:end_index-1)>-0.5 & ...
        data.returns(split_index:end_index-1)<0.5);
    fprintf('Standaryzacja po ca³ej serii. Przed %s po %s \n', ...
        num2str(length(a)./length(data.returns(start_index:split_index))),...
        num2str(length(b)./length(data.returns(split_index:end_index-1))));
    
    
    [a,~] = find(zscore(diff(log(data.close(start_index:split_index))))>-0.5 & ...
        zscore(diff(log(data.close(start_index:split_index))))<0.5);
    [b,~] = find(zscore(diff(log(data.close(split_index:end_index-1))))>-0.5 & ...
        zscore(diff(log(data.close(split_index:end_index-1))))<0.5);
    fprintf('Standaryzacja w poszczególnych okresach ca³ej serii. Przed %s po %s \n',...
        num2str(length(a)./length(zscore(diff(log(data.close(start_index:split_index)))))),...
        num2str(length(b)./length(zscore(diff(log(data.close(split_index:end_index-1)))))));
    
    edges = [-10 -10:0.5:10 10];
    %     [N,edges,bin] = histcounts(returns(start_index:split_index),edges,'DisplayName','before');
    h=histogram(zscore(diff(log(data.close(start_index:split_index)))),edges,'DisplayName','before');
    %     h=histogram(data.returns(start_index:split_index),edges,'DisplayName','before');
    %     h.Normalization = 'probability';
    hold on;
    
    h=histogram(zscore(diff(log(data.close(split_index:end_index)))),edges,'DisplayName','after');
    %     h=histogram(data.returns(split_index:end_index-1),edges,'DisplayName','after');
    h.Normalization = 'probability';
    
    
    legend show;
    hold off;
end





