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
    
    fprintf('correlation_plotter : Plotting correlations for index %s from %s to %s \n', index_data{i,1},index_data{i,2},split_date);
    
    acf = xcov(abs(zscore(diff(log(data.price(start_index:split_index))))),'coeff');
    acf(1:length(zscore(diff(log(data.price(start_index:split_index)))))-1)=[];
    loglog(acf,'o-','DisplayName',[index_data{i,1},' ',num2str(year(data.date(start_index))),'-',num2str(year(data.date(split_index)))]);
    hold on
    
    acf = xcov(abs(zscore(diff(log(data.price(split_index:end))))),'coeff');
    acf(1:length(zscore(diff(log(data.price(split_index:end)))))-1)=[];
    loglog(acf,'^-r','DisplayName',[index_data{i,1},' ',num2str(year(data.date(split_index))),'-',num2str(year(data.date(end)))]);
    
    acf = xcov(abs(zscore(diff(log(data.price(start_index:end))))),'coeff');
    acf(1:length(zscore(diff(log(data.price((start_index:end))))))-1)=[];
    loglog(acf,'x-k','DisplayName',[index_data{i,1},' ',num2str(year(data.date(start_index))),'-',num2str(year(data.date(end)))]);
    
    xlim([0, 10^3]);
    ylim([10^-3, 1]);
    legend show
    
    title([index_data{i,1},' - volatility correlation'])
    ylabel('R(\tau)','FontSize', 12, 'FontWeight','bold');
    xlabel('\tau','FontSize', 12, 'FontWeight','bold');
    hold off
    saveas(f,[path,index_data{i,1},' - volatility correlation'],'png');
    saveas(f,[path,index_data{i,1},' - volatility correlation'],'fig');
    
end

