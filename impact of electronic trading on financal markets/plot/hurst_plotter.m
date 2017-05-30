clear
clc

% index name, start year, end year
indexes = {
    'SP500-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk';
    'NASDAQ',        datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'ok';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';



for i=1:length(indexes(:,1))
    path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    f = figure('units','normalized','position',[.1 .1 .6 .6]);
    
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    hurst =[];
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[hurst_plotter] : Calculating hurst for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index)),...
            '-',datestr(data.date(end_index))];
        spectrum_data = load(spectrum_file_name);

        hurst(point_counter) = spectrum_data.MFDFA2.alfa(60);
        date_points(point_counter) = data.date(end_index);
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        point_counter = point_counter + 1;
    end
    plot(date_points, hurst, 'xk','MarkerSize',8);
    hold on;
    
    xlim([date_points(1) date_points(end)]);
    
    ylabel('H (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([0 1]);
    
    
end
