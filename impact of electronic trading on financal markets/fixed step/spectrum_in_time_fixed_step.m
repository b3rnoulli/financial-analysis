% index name, start year, end year
indexes = {
%     'SP500-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk';
%     'DJIA', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'o';
%       'NASDAQ-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'o';
      '9-companies', datetime('02-Jan-1962'), datetime('31-Dec-2016'), 'xk';
    };


frame_size = 5000;
% frame_size_type = 'YEAR';
frame_step_size = 20;
% frame_step_type = 'MONTH';

change_color = true;
mean_width = 1;
save_figure= false;
% f = figure('units','normalized','position',[.1 .1 .8 .6]);


for i=1:length(indexes(:,1))
    path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    asymmetry =[];
    
    start_index = 1;
    end_index =frame_size;
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    while end_index < length(data.returns)
        fprintf('[spectrum_asymmetry_plotter] : Calculating asymmetry for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        
        date_points(point_counter) = data.date(end_index);
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        point_counter =point_counter+1;
        date_vector = datetime('01-Jan-1970');
        
        
        [~, left_index] =min(spectrum_data.MFDFA2.alfa(50:71));
        left_index = left_index+49;
        [~, right_index] = max(spectrum_data.MFDFA2.alfa(31:50));
        right_index = 30+right_index;
        
        for j=1:1:length(spectrum_data.MFDFA2.alfa(right_index:left_index))
            date_vector(j) = data.date(end_index);
        end
%         if change_color==true && end_index > find_index(data.date,datetime('19-Oct-1987'))
% %                 && end_index < find_index(data.date,datetime('01-Jan-2010'))
%             plot3(date_vector,spectrum_data.MFDFA2.alfa(right_index:left_index), spectrum_data.MFDFA2.f(right_index:left_index),'Color',[ 0    0.4470    0.7410]);
%         else
%             plot3(date_vector,spectrum_data.MFDFA2.alfa(right_index:left_index), spectrum_data.MFDFA2.f(right_index:left_index),'k');
%         end
        plot3(date_vector(1:50-right_index+1),spectrum_data.MFDFA2.alfa(right_index:50), spectrum_data.MFDFA2.f(right_index:50),'Color',[ 0    0.4470    0.7410]);
        plot3(date_vector(1:left_index-49),spectrum_data.MFDFA2.alfa(50:left_index), spectrum_data.MFDFA2.f(50:left_index),'k')

        
        hold on;
    end
    hold on;
    
end

xlim([date_points(1) date_points(end)]);

ylabel('\alpha','FontSize', 14);
zlabel('f(\alpha)','FontSize', 14);
xlabel('t [year]','FontSize', 14);
ylim([0 1]);
grid on;

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',16);
xticklabels({'1950-1970','1955-1975','1960-1980','1965-1985','1970-1990','1975-1995','1980-2000','1985-2005','1990-2010','1995-2015'})
set(gca,'Ydir','reverse')
