clear
clc

% index name, start date, split date, scale bottom, scale top
index_data = {
    'SP500', '01-Jan-1950', '01-Jan-1987', '01-Jan-2016', 29, 230;
    'DJIA',  '01-Jan-1950', '01-Jan-1987', '01-Jan-2016', 30, 300;
    'NDX',   '01-Jan-1950', '01-Jan-1987', '01-Jan-2016', 30, 208;
    'DAX',   '01-Jan-1960', '01-Jan-1987', '01-Jan-2016', 29, 200;
    'UKX',   '01-Jan-1955', '01-Jan-1987', '01-Jan-2016', 29, 240;
    'NKX',   '01-Jan-1955', '01-Jan-1987', '01-Jan-2016', 36, 225;
    };

f = figure;
for i=1:1:length(index_data)
    data = load(index_data{i,1});
    
    start_index = find_index(data,index_data{i,2});
    split_index = find_index(data,index_data{i,3});
    end_index = find_index(data,index_data{i,4});
    
    f = figure('units','normalized','position',[.1 .1 .6 .6]);
    f.PaperPositionMode = 'auto';
    
    spectrum_file_name = [index_data{i,1},'-spectrum-',...
        num2str(year(data.date(start_index))),'-',num2str(year(data.date(split_index)))];
    load([spectrum_file_name,'_m2_wyniki.mat']);
    plot(MFDFA2.alfa(31:70),MFDFA2.f(31:70), 'o-','MarkerSize',20,'DisplayName',[num2str(year(data.date(start_index))),'-',num2str(year(data.date(split_index)))]);
    hold on;
    
    spectrum_file_name = [index_data{i,1},'-spectrum-',...
        num2str(year(data.date(split_index))),'-',num2str(year(data.date(end)))];
    load([spectrum_file_name,'_m2_wyniki.mat']);
    plot(MFDFA2.alfa(31:70),MFDFA2.f(31:70), '^-r','MarkerSize',20,'DisplayName',[num2str(year(data.date(split_index))),'-',num2str(year(data.date(end_index)))]);

    spectrum_file_name = [index_data{i,1},'-spectrum-',...
        num2str(year(data.date(start_index))),'-',num2str(year(data.date(end)))];
    load([spectrum_file_name,'_m2_wyniki.mat']);
    plot(MFDFA2.alfa(31:70),MFDFA2.f(31:70), 'x-k','MarkerSize',20,'DisplayName',[num2str(year(data.date(start_index))),'-',num2str(year(data.date(end_index)))]);
   
    title([index_data{i,1}])
    legend show
    xlim([0 1]);
    ylim([0 1.05]);
    hold off
    ylabel('f(\alpha)','FontSize', 14, 'FontWeight','bold');
    xlabel('\alpha','FontSize', 14, 'FontWeight','bold');
    saveas(f,[path,index_data{i,1},' - spectrum splitted'],'png');

end