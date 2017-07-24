clear
clc

indexes = {
    'SP500-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok', true;
    };

frame_size = 5000;
frame_step_size = 20;

save_figure = false;


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index =frame_size;
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    while end_index < length(data.returns)
        
        fprintf('[spectrum_width_plotter] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        alpha_y(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:70),spectrum_data.MFDFA2.f(31:70));
        
        if indexes{i,5}
            fourier_surrogate_mean_spectrum = load([path,'/surrogate/mean/',indexes{i,1},'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
                '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
            alpha_y_fourier_surrogate(point_counter) = spectrum_width(fourier_surrogate_mean_spectrum.MFDFA2.alfa(31:70), fourier_surrogate_mean_spectrum.MFDFA2.f(31:70));
            
            shuffled_surrogate_mean_spectrum = load([path,'/surrogate/mean/',indexes{i,1},'-shuffled-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
                '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
            alpha_y_shuffled_surrogate(point_counter) = spectrum_width(shuffled_surrogate_mean_spectrum.MFDFA2.alfa(31:70), shuffled_surrogate_mean_spectrum.MFDFA2.f(31:70));
            
            
            rankings_surrogate_mean_spectrum = load([path,'/surrogate/mean/',indexes{i,1},'-rankings-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
                '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
            alpha_y_rankings_surrogate(point_counter) =spectrum_width(rankings_surrogate_mean_spectrum.MFDFA2.alfa(31:70), rankings_surrogate_mean_spectrum.MFDFA2.f(31:70));
        end
        
        date_points(point_counter) = data.date(end_index);
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        point_counter =point_counter+1;
        
    end
    
    plot(datenum(date_points),alpha_y,'xk','MarkerSize',8, 'DisplayName',indexes{i,1});
    hold on;
    
    %     xlim([date_points(1) date_points(end)]);
    
    ylabel('\Delta\alpha (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([0 0.7]);
    if save_figure == true
        %         savefig(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')]);
        %         print(f,[indexes{i,1},'-spectrum-width-',datestr(indexes{i,2},'yyyy-mm-dd'),'-', datestr(indexes{i,3},'yyyy-mm-dd')],'-depsc')
        save([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/',indexes{i,1},'-spectrum-width.mat'],'date_points','alpha_y');
    end
end



