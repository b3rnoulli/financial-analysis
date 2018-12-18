clear
clc

index_data = {
    'SP500', 1950, 1987;
    'DJIA',  1950, 1987;
    'NDX',   1950, 1987;
    'DAX',   1959, 1987;
    'NKX',   1950, 1987;
    };


for i=1:1:length(index_data)
    data = load(index_data{i,1});
    path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\plots\'];
    split_index = find(year(data.date)> index_data{i,3}-1,1);
    start_index = find(year(data.date)> index_data{i,2}-1,1);
    f = figure;
    spectrum_file_name = [index_data{i,1},'_spectrum_',num2str(year(data.date(start_index))),'_',num2str(year(data.date(split_index)))];
    load([spectrum_file_name,'_surrogate_m2_wyniki.mat']);
    plot(MFDFA2.alfa(31:70),MFDFA2.f(31:70), 'o-','MarkerSize',10,'MarkerSize',7,'MarkerFaceColor',[0    0.4470    0.7410],'LineWidth',2,'DisplayName',[index_data{i,1},' ',num2str(index_data{i,2}),' - ',num2str(index_data{i,3})]);
    hold on
    
    spectrum_file_name = [index_data{i,1},'_spectrum_',num2str(year(data.date(split_index))),'_',num2str(year(data.date(end)))];
    load([spectrum_file_name,'_surrogate_m2_wyniki.mat']);
    plot(MFDFA2.alfa(31:70),MFDFA2.f(31:70), '^-r','MarkerSize',7,'MarkerFaceColor','r','LineWidth',2,'DisplayName',[index_data{i,1},' ',num2str(index_data{i,3}),' - 2016']);
    
    spectrum_file_name = [index_data{i,1},'_spectrum_',num2str(year(data.date(start_index))),'_',num2str(2016)];
%     load([spectrum_file_name,'_shuffled_surrogate_m2_wyniki.mat']);
load('sp surrogate shuffled.mat');
plot(MFDFA2.alfa(31:70),MFDFA2.f(31:70), 'x-k','MarkerSize',10,'MarkerSize',10,'MarkerFaceColor','k','LineWidth',2,'DisplayName',[index_data{i,1},' ',num2str(index_data{i,2}),' - 2016']);
    
    legend show
    xlim([0 1]);
    ylim([0.1 1.05]);
    xlim([0 1]);
    ylim([0 1.05]);
    ylabel('f(\alpha)','FontSize', 12, 'FontWeight','bold');
    xlabel('\alpha','FontSize', 12, 'FontWeight','bold');
    hold off
    
    saveas(f,[path,index_data{i,1},' - spectrum surrogates'],'fig');    
    saveas(f,[path,index_data{i,1},' - spectrum surrogates'],'png');

end



