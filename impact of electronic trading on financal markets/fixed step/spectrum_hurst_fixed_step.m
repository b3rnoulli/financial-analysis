clear
clc

indexes = {
%     'SP500-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok', true;
%     'DJIA',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok', true;
%     '9-companies',datetime('01-Jan-1950'), datetime('29-Dec-2016'), 'ok', true;
    'NASDAQ-removed',datetime('01-Jan-1950'), datetime('29-Dec-2016'), 'ok', true;
    };

frame_size = 5000;
frame_step_size = 20;

save_figure = true;
save_data=false;


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    f = figure('units','normalized','position',[.1 .1 .6 .6]);
    
    start_index = 1;
    end_index =frame_size;
    date_points = datetime('01-Jan-1970');
    date_start_points = datetime('01-Jan-1970');
    point_counter = 1;
    hurst=[];
    while end_index < length(data.returns) && end_index < find_index(data.date,indexes{i,3})
        
        fprintf('[hurst_plotter] : Calculating hurst for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        hurst(point_counter) = spectrum_data.MFDFA2.alfa(60);
        date_points(point_counter) = data.date(end_index);
        
                
        date_points(point_counter) = data.date(end_index);
        date_start_points(point_counter) = data.date(start_index);
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        point_counter = point_counter + 1;
        
    end
    
    plot((date_points),hurst,'xk','MarkerSize',8, 'DisplayName',indexes{i,1});
    hold on;
    
    %     xlim([date_points(1) date_points(end)]);
    legend show
    ylabel('H (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([0 1]);
    xlim([date_points(1) date_points(end)]);
    
    datetick('x','yyyy');
    a = get(gca,'XTickLabel');
    if save_figure == true
        savefig(f,[indexes{i,1},'-hurst-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]);
        print(f,[indexes{i,1},'-hurst-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
        save([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/',indexes{i,1},'-hurst.mat'],'date_points','hurst');
    end
    
    if save_data ==true
        fid = fopen([indexes{i},'-hurst.csv'], 'w') ;
        fprintf(fid,['window_start_date,','window_end_date,','hurst','\n']);
        
        for j=1:1:length(date_points)
            fprintf(fid,[datestr(date_start_points(j),'dd-mm-yyyy'),',',datestr(date_points(j),'dd-mm-yyyy'),',',num2str(hurst(j)),'\n']);
        end
        fclose(fid);  
    end
    
end



