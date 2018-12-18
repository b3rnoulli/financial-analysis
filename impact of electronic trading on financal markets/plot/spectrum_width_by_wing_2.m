clear
clc

indexes = {
%     '9-companies';
%     'DD' ;
%     'GE' ;
%     'AA' ;
%     'IBM';
%     'KO' ;
%     'BA' ;
%     'CAT';
%     'DIS';
%     'HPQ';
%     'DJIA';
%     'SP500-removed';
    'NASDAQ-removed';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';


save_figure = true;


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
%     data = load([indexes{i,1},'_1962_01_02__2017_07_10_ret']);
    data = load([indexes{i,1}]);
    f = figure('units','normalized','position',[.1 .1 .6 .6]);
    
    
    start_index = 1;
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);   
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    while end_index < find_index(data.date,'31-Dec-2016')
        
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path,spectrum_file_name]);
        
        alpha_y(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:70),spectrum_data.MFDFA2.f(31:70));
        alpha_y_l(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:50),spectrum_data.MFDFA2.f(31:50));
        alpha_y_r(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(51:70),spectrum_data.MFDFA2.f(51:70));
        date_points(point_counter) = data.date(end_index);
      
        date_points(point_counter) = data.date(end_index);
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        point_counter = point_counter + 1;
        
    end
    
    plot(datenum(date_points),alpha_y,'xk','MarkerSize',8, 'DisplayName',indexes{i,1});
    hold on;
    plot(datenum(date_points),alpha_y_l,'ob','MarkerSize',8, 'DisplayName',[indexes{i,1},'- right wing']);
    plot(datenum(date_points),alpha_y_r,'<r','MarkerSize',8, 'DisplayName',[indexes{i,1},'- left wing']);
    hold on;
    
    legend show;
    datetick('x','yyyy');
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',14);
    hold off;
    ylabel('\Delta{\alpha} (t)','FontSize', 14);
    xlabel('t [year]','FontSize', 14);
    ylim([0 0.7]);
    xlim([datenum(date_points(1)) datenum(date_points(end))]);
    
    if save_figure == true
        savefig(f,[indexes{i,1},'-spectrum-width-by-wing']);
    end
    
end


