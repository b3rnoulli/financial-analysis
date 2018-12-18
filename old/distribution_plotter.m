clear
clc
index_data = {
    'SP500', '01-Jan-1950';
    'DJIA',  '01-Jan-1950';
    'NDX',   '01-Jan-1950';
    'DAX',   '01-Jan-1960';
    'UKX',   '01-Jan-1955';
    'NKX',   '01-Jan-1955';
    };

split_date = '01-Jan-1987';

f = figure;
for i=1:1:length(index_data)
    path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\plots\'];
    data = load(index_data{i,1});
    
    start_index = find_index(data,index_data{i,2});
    split_index = find_index(data,split_date);
    
    fprintf('Plotting distribution for index %s from %s to %s \n', index_data{i,1},index_data{i,2},split_date);
    
    
    [y,x] = ecdf(abs(zscore(diff(log(data.price(start_index:split_index))))));
    loglog(x, 1-y,'o-','MarkerSize',5,'DisplayName',[index_data{i},' ',num2str(year(data.date(start_index))),'-',num2str(year(data.date(split_index)))]);
    hold on
    
    [y,x] = ecdf(abs(zscore(diff(log(data.price(split_index:end))))));
    loglog(x, 1-y,'^-r','MarkerSize',5,'DisplayName',[index_data{i},' ',num2str(year(data.date(split_index))),'-',num2str(year(data.date(end)))]);
    
    [y,x] = ecdf(abs(zscore(diff(log(data.price(start_index:end))))));
    loglog(x, 1-y,'x-k','MarkerSize',5,'DisplayName',[index_data{i},' ',num2str(year(data.date(start_index))),'-',num2str(year(data.date(end)))]);
    
    xx = 2:0.1:10;
    x_3 = xx.^(-3);
    loglog(xx, x_3,'k','DisplayName','x^{-3}');
    
    random_values = normrnd(0,1,[1000000,1]);
    [y,x] = ecdf(abs(random_values));
    loglog(x, 1-y,'--k','DisplayName','normal distribution');
    
    
    legend show
    xlim([0.2,100]);
    ylim([10^-4,1]);
    legend show
    title([index_data{i,1},' - distribution'])
    ylabel('1-F(|r_{t}|)','FontSize', 12, 'FontWeight','bold');
    xlabel('|r_{t}|','FontSize', 12, 'FontWeight','bold');
    hold off
    saveas(f,[path,index_data{i,1},'_distribution'],'png');
    saveas(f,[path,index_data{i,1},'_distribution'],'fig');
    
end