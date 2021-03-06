clear
clc

% index name, start year, end year
indexes = {
    'SP500-removed-2', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'x';
    'SP500-removed-3', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'o';
    'SP500-removed-4', datetime('01-Jan-1950'), datetime('31-Dec-2016'), '^';
    'SP500-removed-5', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'd';
    'SP500-removed-6', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 's';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';



for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    f = figure('units','normalized','position',[.1 .1 .6 .6]);

    
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    alpha_y =[];
    alpha_fourier_surrogate = [];
    alpha_shuffled_surrogate = [];
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[spectrum_width_plotter] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        alpha_y(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:70),spectrum_data.MFDFA2.f(31:70));
  
        date_points(point_counter) = data.date(end_index);
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        point_counter = point_counter + 1;
    end
    plot(date_points,alpha_y,indexes{i,4},'MarkerSize',8,'DisplayName',indexes{i,1});
    hold on;
    x_left = datenum(data.date(shift_index(data.date, find_index(data.date, indexes{i,2}), frame_size, frame_size_type)))-100;
    x_right = datenum(indexes{i,3});
    y_left = 0.1;
    y_right = 0.1;
    p = patch([1 x_right x_right 1],[-0.1 -0.1 y_left y_right ],[0.62 0.62 0.62]);
    set(p,'FaceAlpha',0.5);
    
    ylim([0 .5]);
    xlim([date_points(1) date_points(end)]);
    
    ylabel('\Delta\alpha (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([0 0.7]);
    hold off
    legend show
end
