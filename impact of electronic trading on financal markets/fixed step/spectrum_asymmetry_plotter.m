clear
clc

clear
clc

indexes = {
%     '9-companies';
          'SP500-removed',datetime('01-Jan-1963'), datetime('29-Dec-1992'), 'ok', false;
%        'NASDAQ-removed',datetime('01-Jan-1963'), datetime('29-Dec-1992'), 'ok', false;
    };

frame_size = 5000;
frame_step_size = 1;

save_figure = false;
save_data = false;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    
            start_index = 8372 - frame_size;
    end_index = start_index + frame_size;
%     start_index = 1;
%     end_index =frame_size;
    date_points = datetime('01-Jan-1970');
    date_start_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    while end_index < length(data.returns) && end_index < find_index(data.date,indexes{i,3})
        
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path,spectrum_file_name]);
        
        asymmetry(point_counter) = spectrum_asymmetry(spectrum_data.MFDFA2.alfa(50), min(spectrum_data.MFDFA2.alfa(50:71)),...
            spectrum_data.MFDFA2.alfa(31:50));
        date_points(point_counter) = data.date(end_index);
        date_start_points(point_counter) = data.date(start_index);
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        point_counter =point_counter+1;
        
    end
    
    plot((date_points),asymmetry,'xk','MarkerSize',8, 'DisplayName',indexes{i,1});
    hold on;
    
    if save_figure == true
        %         savefig(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]);
        %         print(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
        save([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/',indexes{i,1},'-spectrum-asymmetry.mat'],'date_points','asymmetry');
    end
    
    ylim([-1.1 1.1]);
    datetick('x','yyyy');
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',14);
    
    if save_data ==true
        fid = fopen([indexes{i},'-spectrum-asymmetry.csv'], 'w') ;
        fprintf(fid,['window_start_date,','window_end_date,','asymmetry\n']);
        
        for j=1:1:length(date_points)
            fprintf(fid,[datestr(date_start_points(j),'dd-mm-yyyy'),',',datestr(date_points(j),'dd-mm-yyyy'),',',num2str(asymmetry(j)),'\n']);
        end
        fclose(fid);
        
    end
    
    
    
end

