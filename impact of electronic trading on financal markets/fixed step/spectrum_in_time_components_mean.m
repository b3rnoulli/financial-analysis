% clear
% clc
% index name, start year, end year
indexes = {
    '9-companies', datetime('02-Jan-1962'), datetime('31-Dec-2016'), 'xk';
    };


frame_size = 5000;
% frame_size_type = 'YEAR';
frame_step_size = 20;
% frame_step_type = 'MONTH';

change_color = true;
mean_width = 1;
save_figure= false;
write_to_file = false;
fix_maximum = false;
write_full_data_to_file=false;
% f = figure('units','normalized','position',[.1 .1 .8 .6]);
is_2d=true;

data = load('9-companies-components-mean-width-asymmetry.mat');
price_data = load('DJIA.mat');
price_data_dat = load('DJIA.dat');
% subplot(3,1,2)
f = figure('units','normalized','position',[.1 .1 .70 .55]);

for i=1:1:length(data.mean_components)-1
    
    
    [~, left_index] =min(data.mean_components(i).alfa(50:71));
    left_index = left_index+49;
    [~, right_index] = max(data.mean_components(i).alfa(31:50));
    right_index = 30+right_index;
    
    for j=1:1:length(data.mean_components(i).alfa(right_index:left_index))
        date_vector(j) = data.mean_components(i).window_end_date;
    end
    
    if fix_maximum == true
        alfa_r = data.mean_components(i).alfa(right_index:50)-0.3*(data.mean_components(i).alfa(50)-0.5);
        alfa_l = data.mean_components(i).alfa(50:left_index)-0.3*(data.mean_components(i).alfa(50)-0.5);
        
        plot3(date_vector(1:50-right_index+1),alfa_r, data. (i).f(right_index:50),'Color',[ 0    0.4470    0.7410]);
        plot3(date_vector(1:left_index-49),   alfa_l, data.mean_components(i).f(50:left_index),'k');
    else
        if is_2d==true
            plot(date_vector(1:50-right_index+1),data.mean_components(i).alfa(right_index:50),'Color',[ 0    0.4470    0.7410]);
            plot(date_vector(50-right_index+1),data.mean_components(i).alfa(50),'rx');
            plot(date_vector(1:left_index-49),data.mean_components(i).alfa(50:left_index),'k');
            
        else
            plot3(date_vector(1:50-right_index+1),data.mean_components(i).alfa(right_index:50), data.mean_components(i).f(right_index:50),'Color',[ 0    0.4470    0.7410]);
            plot3(date_vector(1:left_index-49),data.mean_components(i).alfa(50:left_index), data.mean_components(i).f(50:left_index),'k');
        end
        
    end
    full_data_points(i).alfa = data.mean_components(i).alfa(right_index:left_index);
    full_data_points(i).right = right_index;
    full_data_points(i).left = left_index;
    full_data_points(i).date = date_vector(1);
    hold on;
    if date_vector(1) > datetime('31-Dec-2016')
       break; 
    end
end
plot([datetime('19-Oct-1987'), datetime('19-Oct-1987')],[0.0, 1],'--k','LineWidth',5);
dim = [.45 .6 .3 .3];

plot([datetime('25-Sep-2008'), datetime('25-Sep-2008')],[0.0, 1],'--k','LineWidth',5);
dim = [.8 .6 .3 .3];

plot([datetime('1-Oct-1990'), datetime('1-Oct-1990')],[0.0 1],':k','LineWidth',1.5);
% dim = [.45 .6 .3 .3];

plot([datetime('1-Apr-1994'), datetime('1-Apr-1994')],[0.0 1],':k','LineWidth',1.5);
% dim = [.8 .6 .3 .3];

yyaxis 'right';

semilogy(price_data.date(3108:16955), price_data.close(3108:16955),'Color',[0.31,0.31,0.31],'LineStyle','-','LineWidth',1.0)
ylabel('\bf \it Index')
ylim([500 25000]);
ax = gca;
ax.YColor = [0.31,0.31,0.31];
ax.YScale = 'log';
yyaxis 'left';

xlim([datetime('03-Dec-1981') datetime('31-Dec-2016')])


if write_full_data_to_file == true
    full_data_fid = fopen([indexes{1,1},'-components-spectrum-in-time-alpha-data','.csv'], 'w') ;
    
    fprintf(full_data_fid,['date,','alfa\n']);
    
    for j=1:length(full_data_points)
        str = [datestr(full_data_points(j).date,'yyyy-mm-dd')];
        
        points=full_data_points(j).alfa;
        required_points_count = 41 -length(points);
        
        if required_points_count>0
            [~, index]=max(spectrum_data.MFDFA2.f(full_data_points(j).right:full_data_points(j).left));
            duplicated_points = ones(required_points_count,1).*points(index);
            points=[points(1:index);duplicated_points;points(index+1:end)];
        end
        
        for k=1:length(points)
            str = [str,',',num2str(points(k))];
        end
        fprintf(full_data_fid,[str,'\n']);
    end
    
end

%
% for i=1:length(indexes(:,1))
%     path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/'];
%     data = load(indexes{i,1});
%
%     asymmetry =[];
%
%     start_index = 1;
%     end_index =frame_size;
%     date_points = datetime('01-Jan-1970');
%     point_counter = 1;
%
%
%
%     while end_index < length(data.returns)
%         fprintf('[spectrum_asymmetry_plotter] : Calculating asymmetry for index %s date scope %s to %s\n', indexes{meai,1},...
%             datestr(data.date(start_index)), datestr(data.date(end_index)));
%         spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%             '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%         spectrum_data = load(spectrum_file_name);
%
%         date_points(point_counter) = data.date(end_index);
%
%         date_vector = datetime('01-Jan-1970');
%
%         [~, left_index] =min(spectrum_data.MFDFA2.alfa(50:71));
%         left_index = left_index+49;
%         [~, right_index] = max(spectrum_data.MFDFA2.alfa(31:50));
%         right_index = 30+right_index;
%
%         for j=1:1:length(spectrum_data.MFDFA2.alfa(right_index:left_index))
%             date_vector(j) = data.date(end_index);
%         end
%         %         if change_color==true && end_index > find_index(data.date,datetime('19-Oct-1987'))
%         % %                 && end_index < find_index(data.date,datetime('01-Jan-2010'))
%         %             plot3(date_vector,spectrum_data.MFDFA2.alfa(right_index:left_index), spectrum_data.MFDFA2.f(right_index:left_index),'Color',[ 0    0.4470    0.7410]);
%         %         else
%         %             plot3(date_vector,spectrum_data.MFDFA2.alfa(right_index:left_index), spectrum_data.MFDFA2.f(right_index:left_index),'k');
%         %         end
%         if fix_maximum == true
%             alfa_r = spectrum_data.MFDFA2.alfa(right_index:50)-0.3*(spectrum_data.MFDFA2.alfa(50)-0.5);
%             alfa_l = spectrum_data.MFDFA2.alfa(50:left_index)-0.3*(spectrum_data.MFDFA2.alfa(50)-0.5);
%
%             plot3(date_vector(1:50-right_index+1),alfa_r, spectrum_data.MFDFA2.f(right_index:50),'Color',[ 0    0.4470    0.7410]);
%             plot3(date_vector(1:left_index-49),   alfa_l, spectrum_data.MFDFA2.f(50:left_index),'k');
%         else
%             plot3(date_vector(1:50-right_index+1),spectrum_data.MFDFA2.alfa(right_index:50), spectrum_data.MFDFA2.f(right_index:50),'Color',[ 0    0.4470    0.7410]);
%             plot3(date_vector(1:left_index-49),spectrum_data.MFDFA2.alfa(50:left_index), spectrum_data.MFDFA2.f(50:left_index),'k');
%         end
%
%         if write_to_file == true
%             fid = fopen([indexes{i,1},'-spectrum-in-time-',datestr(data.date(start_index),'yyyy-mm-dd'),'-', datestr(data.date(end_index), 'yyyy-mm-dd'),'.csv'], 'w') ;
%             fprintf(fid,['alfa,','f_alfa\n']);
%             dlmwrite([indexes{i,1},'-spectrum-in-time-',datestr(data.date(start_index),'yyyy-mm-dd'),'-', datestr(data.date(end_index), 'yyyy-mm-dd'),'.csv'],[spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70)],'delimiter',',','-append');
%         end
%
%         start_index = start_index + frame_step_size;
%         end_index = end_index + frame_step_size;
%         point_counter =point_counter+1;
%
%         hold on;
%     end
%     hold on;
%
% end

if write_to_file == true
    fclose(fid);
end

xlim([data.mean_components(1).window_end_date data.mean_components(end-1).window_end_date ]);

ylim([0 1]);

ylim([0 1]);


a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',20);
if is_2d==true
    xlabel('\it \bf t [year]','FontSize', 30);
    ylabel('\it \bf \alpha','FontSize', 35);
    zlabel('\it \bf f(\alpha)','FontSize', 30);
    saveas(gcf,'9-companies-components-2d.jpg')
else
    zlim([0 1.2]);
    grid on;
    view(gca,[-50.3 14]);
    xtickangle(-10);
    %     [21600.575 0.40 -0.36]
    xlabel('\it \bf t [year]','FontSize', 30, 'Position',[16600.575 0.40 -0.36]);
    ylabel('\it \bf \alpha','FontSize', 35, 'Position', [-1158.722 0.56 -0.05]);
    zlabel('\it \bf f(\alpha)','FontSize', 30, 'FontName','Times');
    set(gca,'Ydir','reverse')
    %     title('\fontsize{35} NASDAQ');
    saveas(gcf,'9-companies-components-3d.jpg')
end

hold off;
