clear
clc
% index name, start year, end year
indexes = {
%     'SP500-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'xk';
    %         'DJIA', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'o';
%                 'NASDAQ-removed', datetime('01-Jan-1950'), datetime('31-Dec-2016'), 'o';
            '9-companies', datetime('02-Jan-1962'), datetime('31-Dec-2016'), 'xk';
    };


frame_size = 5000;
% frame_size_type = 'YEAR';
frame_step_size = 20;
% frame_step_type = 'MONTH';


is_2d = true;
plot_index=true;
change_color = true;
mean_width = 1;
save_figure= false;
write_to_file = false;
write_full_data_to_file = false;
fix_maximum = false;
f = figure('units','normalized','position',[.1 .1 .70 .55]);
% cc=3;

price_data_dat = load('DJIA.dat');
price_data = load('DJIA.mat');

for i=1:length(indexes(:,1))
    path = ['/Users/b3rnoulli/Development/Matlab workspace/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    asymmetry =[];
    
    start_index = 1;
    end_index =frame_size;
    date_points = datetime('01-Jan-1970');
    point_counter = 1;
    
    full_data_points = struct;
    cc_counter=1;
    while end_index < length(data.returns)-30
        
        %         && data.date(end_index) ~= datetime('14-Nov-2008')
        %         if cc_counter<cc
        %             cc_counter = cc_counter+1;
        %             start_index = start_index + frame_step_size;
        %             end_index = end_index + frame_step_size;
        %             continue;
        %         end
        %         cc_counter=1;
        
        fprintf('[spectrum_asymmetry_plotter] : Calculating asymmetry for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spectrum_data = load(spectrum_file_name);
        
        date_points(point_counter) = data.date(end_index);
        
        date_vector = datetime('01-Jan-1970');
        
        [~, left_index] =min(spectrum_data.MFDFA2.alfa(50:71));
        left_index = left_index+49;
        [~, right_index] = max(spectrum_data.MFDFA2.alfa(31:50));
        right_index = 30+right_index;
        
        
        for j=1:1:length(spectrum_data.MFDFA2.alfa(right_index:left_index))
            date_vector(j) = data.date(end_index);
        end
        full_data_points(point_counter).date = data.date(end_index);
        %         if change_color==true && end_index > find_index(data.date,datetime('19-Oct-1987'))
        % %                 && end_index < find_index(data.date,datetime('01-Jan-2010'))
        %             plot3(date_vector,spectrum_data.MFDFA2.alfa(right_index:left_index), spectrum_data.MFDFA2.f(right_index:left_index),'Color',[ 0    0.4470    0.7410]);
        %         else
        %             plot3(date_vector,spectrum_data.MFDFA2.alfa(right_index:left_index), spectrum_data.MFDFA2.f(right_index:left_index),'k');
        %         end
        
        if is_2d==true
            plot(date_vector(1:50-right_index+1),spectrum_data.MFDFA2.alfa(right_index:50),'Color',[ 0    0.4470    0.7410]);
            plot(date_vector(50-right_index+1),spectrum_data.MFDFA2.alfa(50),'rx');
            plot(date_vector(1:left_index-49),spectrum_data.MFDFA2.alfa(50:left_index),'k');
        else
            if fix_maximum==true
                alfa_r = spectrum_data.MFDFA2.alfa(right_index:50)-0.3*(spectrum_data.MFDFA2.alfa(50)-0.5);
                alfa_l = spectrum_data.MFDFA2.alfa(50:left_index)-0.3*(spectrum_data.MFDFA2.alfa(50)-0.5);
                
                if should_render(indexes{i,1},date_vector(1))
                    plot3(date_vector(1:50-right_index+1),alfa_r, spectrum_data.MFDFA2.f(right_index:50),'Color',[ 0    0.4470    0.7410], 'LineWidth',2);
%                     
                    plot3(date_vector(1:left_index-49),   alfa_l, spectrum_data.MFDFA2.f(50:left_index),'k', 'LineWidth',2);
                end
                
            else
                %                 plot3(date_vector(1:50-right_index+1),spectrum_data.MFDFA2.alfa(right_index:50), spectrum_data.MFDFA2.f(right_index:50),'Color',[ 0    0.4470    0.7410]);
                %                 plot3(date_vector(1:left_index-49),spectrum_data.MFDFA2.alfa(50:left_index), spectrum_data.MFDFA2.f(50:left_index),'k');
                plot3(spectrum_data.MFDFA2.alfa(right_index:50),date_vector(1:50-right_index+1), spectrum_data.MFDFA2.f(right_index:50),'Color',[ 0    0.4470    0.7410], 'LineWidth',0.5)
                plot3(spectrum_data.MFDFA2.alfa(50:left_index),date_vector(1:left_index-49), spectrum_data.MFDFA2.f(50:left_index),'k','LineWidth',0.5);
%                 plot3(spectrum_data.MFDFA2.alfa(50),date_vector(50-right_index+1), spectrum_data.MFDFA2.f(50),'.r','MarkerSize',15);

            end
            
        end
        
        full_data_points(point_counter).alfa = spectrum_data.MFDFA2.alfa(right_index:left_index);
        full_data_points(point_counter).right = right_index;
        full_data_points(point_counter).left = left_index;
        if write_to_file == true
            fid = fopen([indexes{i,1},'-spectrum-in-time-',datestr(data.date(start_index),'yyyy-mm-dd'),'-', datestr(data.date(end_index), 'yyyy-mm-dd'),'.csv'], 'w') ;
            fprintf(fid,['alfa,','f_alfa\n']);
            dlmwrite([indexes{i,1},'-spectrum-in-time-',datestr(data.date(start_index),'yyyy-mm-dd'),'-', datestr(data.date(end_index), 'yyyy-mm-dd'),'.csv'],[spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70)],'delimiter',',','-append');
        end
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        point_counter =point_counter+1;
        
        hold on;
    end
    hold on;
    
    if write_full_data_to_file == true
        full_data_fid = fopen([indexes{i,1},'-spectrum-in-time-alpha-data','.csv'], 'w') ;
        
        fprintf(full_data_fid,['date,','max_index,','alfa\n']);
        
        for j=1:length(full_data_points)
            str = [datestr(full_data_points(j).date,'yyyy-mm-dd')];
            
            points=full_data_points(j).alfa;
            required_points_count = 41 -length(points);
            if required_points_count>0
                [~, index]=max(spectrum_data.MFDFA2.f(full_data_points(j).right:full_data_points(j).left));
                duplicated_points = ones(required_points_count,1).*points(index);
                points=[points(1:index);duplicated_points;points(index+1:end)];
            end
            [~, full_data_points(j).max_index]=max(spectrum_data.MFDFA2.f(full_data_points(j).right:full_data_points(j).left));
            str  = [str,',',num2str(full_data_points(j).max_index)];
            for k=1:length(points)
                str = [str,',',num2str(points(k))];
            end
            fprintf(full_data_fid,[str,'\n']);
            full_data_points(j).points = points;
        end
        
    end
    
end

if write_to_file == true
    fclose(fid);
end

xlim([date_points(1) date_points(end)]);
ylim([0 1]);

% ylim([date_points(1) date_points(end)])
% xlim([0 1]);
% xticks([0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0])


a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',20);
if is_2d==true
    xlabel('\it \bf t [year]','FontSize', 30);
    ylabel('\it \bf \alpha','FontSize', 35);
    zlabel('\it \bf f(\alpha)','FontSize', 30);
    plot([datetime('19-Oct-1987'), datetime('19-Oct-1987')],[0.1, 0.9],'--r','LineWidth',1.5);
    dim = [.45 .6 .3 .3];
    annotation('textbox',dim,'String','Black Monday','FitBoxToText','on','FontSize',20,'FontName','Times');
    
    plot([datetime('10-Mar-2000'), datetime('10-Mar-2000')],[0.1, 0.9],'--r','LineWidth',1.5);   
    dim = [.65 .6 .3 .3];
    annotation('textbox',dim,'String','Dot com bubble','FitBoxToText','on','FontSize',20,'FontName','Times');
    
    plot([datetime('15-Sep-2008'), datetime('15-Sep-2008')],[0.1, 0.9],'--r','LineWidth',1.5);  
    dim = [.8 .6 .3 .3];
    annotation('textbox',dim,'String','Bankruptcy of Lehman Brothers','FitBoxToText','on','FontSize',20,'FontName','Times');
    
    a=2;
    xlim([ datetime('03-Dec-1981') indexes{i,3}])
    
    
    %     saveas(gcf,'9-companies-2d.jpg')
else
    zlim([0 1.2]);
    grid on;
    view(gca,[-40 14]);
    xtickangle(-10);
    %     [21600.575 0.40 -0.36]
    % 'Position',[16600.575 0.40 -0.36]
    %
    
    ylabel('\it \bf t [year]','FontSize', 30);
    xlabel('\it \bf \alpha','FontSize', 35);
    zlabel('\it \bf f(\alpha)','FontSize', 30, 'FontName','Times');
    set(gca,'Ydir','reverse')
    %     set(gca,'Xdir','reverse')
    title('\fontsize{35} S&P500');
    %     saveas(gcf,'9-companies-3d.jpg')
end

if plot_index
    plot([datetime('19-Oct-1987'), datetime('19-Oct-1987')],[0.0, 1],'--k','LineWidth',3);
    dim = [.45 .6 .3 .3];
    
    plot([datetime('25-Sep-2008'), datetime('25-Sep-2008')],[0.0, 1],'--k','LineWidth',3);
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
    
end

% xticklabels({'1950-1970','1955-1975','1960-1980','1965-1985','1970-1990','1975-1995','1980-2000','1985-2005','1990-2010','1995-2015'})
% xticklabels({'1965-1985','1970-1990','1975-1995','1980-2000','1985-2005','1990-2010','1995-2015'})

% xticklabels({'1970','1975','1980','1985','1990','1995','2000','2005','2010','2015'})
% xticklabels({'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'})
function [do_render] = should_render(name,date)
do_render = true;

if (date == datetime('14-Mar-2017') || date == datetime('30-Oct-2015') || date == datetime('30-Nov-2015') || ...
        date == datetime('11-Nov-2010') || date == datetime('17-Jul-2014') || date==datetime('02-Oct-2015'))
    do_render = false;
end

if name~='9-companies'
    do_render = true;
end

end
