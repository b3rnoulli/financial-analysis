clear
clc

clear
clc

indexes = {
    'DJIA-reconstructed';
    };

frame_size = 5000;
frame_step_size = 20;

save_figure = true;


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index =frame_size;
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    while end_index < length(data.returns)
        
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path,spectrum_file_name]);
        
        asymmetry(point_counter) = spectrum_asymmetry(spectrum_data.MFDFA2.alfa(50), min(spectrum_data.MFDFA2.alfa(50:71)),...
            spectrum_data.MFDFA2.alfa(31:50));
        date_points(point_counter) = data.date(end_index);
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        point_counter =point_counter+1;
        
    end
    
    plot(datenum(date_points),asymmetry,'xk','MarkerSize',8, 'DisplayName',indexes{i,1});
    hold on;
    
    if save_figure == true
        %         savefig(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]);
        %         print(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
        save([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/',indexes{i,1},'-spectrum-asymmetry.mat'],'date_points','asymmetry');
    end
    
    
end

