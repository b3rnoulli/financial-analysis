clear
clc

% index name, start year, end year
index_data = {
%   'CL', '01-Jan-1985', '31-Dec-2015', 28, 187;
%    'EURUSD', '01-Jan-1950', '31-Dec-2015', 29, 230;
    'SP500-removed-surrogate', '01-Jan-1950', '31-Dec-2015',29, 239;
%     'SP500', '01-Jan-1950', '31-Dec-2015', 29, 230;
%     'DJIA',  '01-Jan-1950', '31-Dec-2015', 30, 300;
%     'NDX',   '01-Jan-1950', '31-Dec-2015', 30, 208;
%     'DAX',   '01-Jan-1960', '31-Dec-2015', 29, 200;
%     'UKX',   '01-Jan-1955', '31-Dec-2015', 29, 240;
%     'NKX',   '01-Jan-1955', '31-Dec-2015', 36, 225;
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';
plot_auto_scaled = 1;
plot_manually_scaled = 0;
enable_rescaling = 0;

plot_market_crash_dates = 1;


for i=1:length(index_data(:,1))
    plot_path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\plots\'];
    data = load(index_data{i,1});
  
    
    start_index = find_index(data,index_data{i,2});
    end_index = shift_index(data, start_index, frame_size, frame_size_type);
    
    alpha_plot = figure('units','normalized','position',[.1 .1 .6 .6]);
    a_alpha_plot = figure('units','normalized','position',[.1 .1 .6 .6]);
    hurst_plot = figure('units','normalized','position',[.1 .1 .6 .6]);
    path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\frame\'];
    
    has_changed_to_week = 0;
    has_changed_to_year = 0;
    point_counter = 1;
    a_y_auto = [];
    a_y = [];
    h_y_auto = [];
    alpha_y_auto = [];
    date_points = datetime('01-Jan-1970');
    while end_index < find_index(data,index_data{i,3})
        
        
%         spectrum_file_name = [index_data{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%             '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%         spec_data = load([spectrum_file_name,'_m2_wyniki.mat']);
        
        if(plot_auto_scaled == 1)
%             auto_spectrum_file_name = [path,spectrum_file_name,'_',num2str(index_data{i,4}),...
%                 '_',num2str(index_data{i,5})];
            spec_data_auto = load(['SP500-removed-surrogate','_m2_wyniki.mat']);
        end
        
        %alpha_plot
        lowest = min(spec_data.MFDFA2.alfa(31:70));
        highest = max(spec_data.MFDFA2.alfa(31:70));
        alpha_y(point_counter) = highest - lowest;
        if (plot_auto_scaled == 1)
            auto_lowest = min(spec_data_auto.MFDFA2.alfa(31:70));
            auto_highest = max(spec_data_auto.MFDFA2.alfa(31:70));
            alpha_y_auto(point_counter) = auto_highest - auto_lowest;
            title([index_data{i,1},' - \Delta\alpha'],'FontSize', 14)
        end
        
        
        %a_alpha_plot
        left_width = spec_data.MFDFA2.alfa(50)-min(spec_data.MFDFA2.alfa(50:71));
        right_width = max(spec_data.MFDFA2.alfa(31:50)) - spec_data.MFDFA2.alfa(50);
        spectrum_asymmetry_value = (left_width - right_width)/(right_width + left_width);
        a_y(point_counter) = spectrum_asymmetry_value;
        date_points(point_counter) = data.date(end_index);
        if (plot_auto_scaled == 1)
            auto_left_width = spec_data_auto.MFDFA2.alfa(50)-min(spec_data_auto.MFDFA2.alfa(50:71));
            auto_right_width = max(spec_data_auto.MFDFA2.alfa(31:50)) - spec_data_auto.MFDFA2.alfa(50);
            spectrum_asymmetry_value = (auto_left_width - auto_right_width)/(auto_right_width + auto_left_width);
            a_y_auto(point_counter) = spectrum_asymmetry_value;
        end
        
        %hurst_plot
        h_y(point_counter) = spec_data.MFDFA2.alfa(60);
        if (plot_auto_scaled == 1)
            h_y_auto(point_counter) = spec_data_auto.MFDFA2.alfa(60);
        end
        
        if enable_rescaling == 1
            if has_changed_to_week == 0 && find_index(data,datetime('1984-12-30')) < end_index
                frame_step_type = 'WEEK';
                start_index = find_index(data,datetime('1965-01-01'));
                end_index = shift_index(data, start_index, frame_size, frame_size_type);
                has_changed_to_week = 1;
            end
            
            if has_changed_to_year == 0 && end_index > find_index(data,datetime('1989-11-30'))
                frame_step_type = 'YEAR';
                start_index = find_index(data,datetime('1969-01-01'));
                end_index = shift_index(data, start_index, frame_size, frame_size_type);
                has_changed_to_year = 1;
            end
        end
        
        start_index = shift_index(data, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data, end_index, frame_step_size, frame_step_type);
        
        point_counter= point_counter+1;
    end
    
    figure(alpha_plot);
    hold on;
    x_left = datenum(data.date(shift_index(data, find_index(data,index_data{i,2}), frame_size, frame_size_type)))-100;
    x_right = datenum(index_data{i,3});
    y_left = 0.1;
    y_right = 0.1;
    p = patch([x_left x_right x_right x_left],[-0.1 -0.1 y_left y_right ],[0.62 0.62 0.62]);
    set(p,'FaceAlpha',0.5);
    if plot_manually_scaled == 1
        plot(date_points,alpha_y,'or','MarkerSize',8);
        hold on;
    end
    if (plot_auto_scaled == 1)
        plot(date_points,alpha_y_auto,'xk','MarkerSize',8);
        hold on;
    end
    pause(0.1);
    title([index_data{i,1},' - \Delta\alpha'],'FontSize', 14)
    ylabel('\Delta\alpha (t)','FontSize', 14, 'FontWeight','bold');
    xlabel('t [year]','FontSize', 14, 'FontWeight','bold');
    ylim([0 0.8]);
    xlim([datenum(data.date(shift_index(data, find_index(data,index_data{i,2}), frame_size, frame_size_type))),...
        datenum(index_data{i,3})])
    box on;
    hold off
    
    figure(a_alpha_plot);
    if plot_manually_scaled == 1
        plot(date_points,a_y,'or','MarkerSize',8);
        hold on;
    end
    if (plot_auto_scaled ==1)
        plot(date_points,a_y_auto,'xk','MarkerSize',8);
        hold on;
    end
    pause(1);
    title([index_data{i,1},' - A_{\alpha}'],'FontSize', 14)
    ylabel('A_{\alpha} (t)','FontSize', 14, 'FontWeight','bold');
    xlabel('t [year]','FontSize', 14, 'FontWeight','bold');
    ylim([-1.5 1.5]);
    xlim([datenum(data.date(shift_index(data, find_index(data,index_data{i,2}), frame_size, frame_size_type))),...
        datenum(index_data{i,3})])
    box on
    hold off
    
    figure(hurst_plot);
    if plot_manually_scaled == 1
        plot(date_points,h_y,'or','MarkerSize',8);
        hold on;
    end
    if (plot_auto_scaled ==1)
        plot(date_points,h_y_auto,'xk','MarkerSize',8);
        hold on;
    end
    pause(1);
    title([index_data{i,1},' - H'],'FontSize', 14)
    ylabel('H (t)','FontSize', 14, 'FontWeight','bold');
    xlabel('t [year]','FontSize', 14, 'FontWeight','bold');
    ylim([0.0 0.8]);
    xlim([datenum(data.date(shift_index(data, find_index(data,index_data{i,2})+1, frame_size, frame_size_type))),...
        datenum(index_data{i,3})])
    hold off
    
    if (plot_auto_scaled ==1 && plot_manually_scaled == 1)
        figure(hurst_plot)
        legend('manually adjusted scales','automatically adjusted scales');
        figure(a_alpha_plot);
        legend('manually adjusted scales','automatically adjusted scales');
        figure(alpha_plot);
        legend('manually adjusted scales','automatically adjusted scales');
    end
    
    if (plot_market_crash_dates == 1)
        crash_1987 = datetime('19-Oct-1987');
        crash_2008 = datetime('15-Sep-2008');
        
        figure(hurst_plot);
        hold on;
        plot([crash_1987, crash_1987],[0.1, 0.7],'--r');
        plot([crash_2008, crash_2008],[0.1, 0.7],'--r');
        xlim([datenum(data.date(shift_index(data, find_index(data,index_data{i,2}), frame_size, frame_size_type))),...
            datenum(index_data{i,3})])
        hold off
        
        figure(a_alpha_plot);
        hold on;
        plot([crash_1987, crash_1987],[-1.25, 1.25],'--r');
        plot([crash_2008, crash_2008],[-1.25, 1.25],'--r');
        xlim([datenum(data.date(shift_index(data, find_index(data,index_data{i,2}), frame_size, frame_size_type))),...
            datenum(index_data{i,3})])
        hold off
        
        figure(alpha_plot);
        hold on;
        plot([crash_1987, crash_1987],[0.1, 0.7],'--r');
        plot([crash_2008, crash_2008],[0.1, 0.7],'--r');
        xlim([datenum(data.date(shift_index(data, find_index(data,index_data{i,2}), frame_size, frame_size_type))),...
            datenum(index_data{i,3})])
        hold off
    end
    
   % saveas(alpha_plot,[plot_path, index_data{i,1},'_spectrum_width_',frame_step_type],'fig');
   % saveas(a_alpha_plot,[plot_path, index_data{i,1},'_spectrum_asymmetry_',frame_step_type],'fig');
   % saveas(hurst_plot,[plot_path, index_data{i,1},'_hurst_',frame_step_type],'fig');
end


