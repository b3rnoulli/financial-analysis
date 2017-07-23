indexes = {
%     'SP500-removed',datetime('03-Jan-1950'), datetime('02-Jan-1987'), datetime('29-Dec-2016'), '^-', 'r', 'S&P500 ';
%          'DJIA',datetime('03-Jan-1950'), datetime('02-Jan-1987'), datetime('03-Jan-2017'), '^-', 'r', 'DJIA ';
%         'NASDAQ-removed', datetime('03-Jan-1950'), datetime('02-Jan-1987'), datetime('29-Dec-2016'), 'o-', 'k', 'NASDAQ COMP '
        '9-companies', datetime('02-Jan-1962'), datetime('02-Jan-1987'), datetime('03-Jan-2017'), 'o-', 'k', '9-companies'
    };

save_figures = true;
write_to_file = true;

for i=1:1:length(indexes(:,1))
    f = figure('units','normalized','position',[.1 .1 .5 .6]);
    f.PaperPositionMode = 'auto';
    
    % first part
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    spectrum_data = load([spectrum_file_name,'.mat']);
    p = spectrum_plotter(f, spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70), '-o', [ 0    0.4470    0.7410], [ indexes{i,7}, datestr(indexes{i,2},'yyyy'),'-',datestr(indexes{i,3},'yyyy')]);
    set(p,'linewidth',3);
    if write_to_file == true
        fid = fopen([spectrum_file_name,'.csv'], 'w') ;
        fprintf(fid,['alfa,','f_alfa\n']);
        fclose(fid);
        dlmwrite([spectrum_file_name,'.csv'],[spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70)],'delimiter',',','-append');
    end
    
    % second part
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,3},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    spectrum_data = load([spectrum_file_name,'.mat']);
    p = spectrum_plotter(f, spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70), 'x-', 'k', [ indexes{i,7}, datestr(indexes{i,3},'yyyy'),'-',datestr(indexes{i,4},'yyyy')]);
    set(p,'linewidth',3);
    if write_to_file == true
        fid = fopen([spectrum_file_name,'.csv'], 'w') ;
        fprintf(fid,['alfa,','f_alfa\n']);
        fclose(fid);
        dlmwrite([spectrum_file_name,'.csv'],[spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70)],'delimiter',',','-append');
    end
    
    % whole data
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    spectrum_data = load([spectrum_file_name,'.mat']);
    p = spectrum_plotter(f, spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70), '-^', 'r', [indexes{i,7}, datestr(indexes{i,2},'yyyy'),'-',datestr(indexes{i,4},'yyyy')]);
    set(p,'linewidth',3);
    if write_to_file == true
        fid = fopen([spectrum_file_name,'.csv'], 'w') ;
        fprintf(fid,['alfa,','f_alfa\n']);
        fclose(fid);
        dlmwrite([spectrum_file_name,'.csv'],[spectrum_data.MFDFA2.alfa(31:70), spectrum_data.MFDFA2.f(31:70)],'delimiter',',','-append');
    end
    
    legend show
    
    %% insets
    
    %lewo - first part
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    spectrum_data = load([spectrum_file_name,'.mat']);
    axes('Position',[.47 .15 .21 .21]);
    box on
    fq_plotter(f, spectrum_data.MFDFA2.Scale(1:end), spectrum_data.MFDFA2.Fq(1:end,31:70), '-k')
    xlabh = get(gca,'XLabel');
    set(xlabh,'Position',get(xlabh,'Position') + [0 .1 0]);
    ylabh = get(gca,'YLabel');
    set(ylabh,'Position',get(ylabh,'Position') + [10 0 1]);
    set(gca,'TickLength',[0.03 1]);
    ylim([.4 30]);
    xlim([20 1400]);
    legend([indexes{i,7}, datestr(indexes{i,2},'yyyy'),'-',datestr(indexes{i,3},'yyyy')],'Location','northeast')
    hold off
    if write_to_file == true
        fid = fopen([spectrum_file_name,'-fq.csv'], 'w') ;
        fprintf(fid,['scale,']);
        for index=1:40
            fprintf(fid,['f_q,']);
        end
        fprintf(fid,['f_q\n']);
        fclose(fid);
        dlmwrite([spectrum_file_name,'-fq.csv'],[spectrum_data.MFDFA2.Scale(1:end)', spectrum_data.MFDFA2.Fq(1:end,31:70)],'delimiter',',','-append');
    end
    
    %prawo - second part
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,3},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    spectrum_data = load([spectrum_file_name,'.mat']);
    axes('Position',[.68 .15 .21 .21]);
    box on
    fq_plotter(f, spectrum_data.MFDFA2.Scale(1:end), spectrum_data.MFDFA2.Fq(1:end,31:70), '-k')
    xlabh = get(gca,'XLabel');
    set(xlabh,'Position',get(xlabh,'Position') + [0 .1 0]);
    ylabh = get(gca,'YLabel');
    set(ylabh,'Position',get(ylabh,'Position') + [2 0 1]);
    set(gca,'YTickLabel',[]);
    set(gca,'YLabel',[]);
    set(gca,'TickLength',[0.03 1]);
    ylim([.4 30]);
    xlim([20 1400]);
    legend([indexes{i,7}, datestr(indexes{i,3},'yyyy'),'-',datestr(indexes{i,4},'yyyy')],'Location','northeast')
    hold off
    if write_to_file == true
                fid = fopen([spectrum_file_name,'-fq.csv'], 'w') ;
        fprintf(fid,['scale,']);
        for index=1:40
            fprintf(fid,['f_q,']);
        end
        fprintf(fid,['f_q\n']);
        fclose(fid);
        dlmwrite([spectrum_file_name,'-fq.csv'],[spectrum_data.MFDFA2.Scale(1:end)', spectrum_data.MFDFA2.Fq(1:end,31:70)],'delimiter',',','-append');
    end
    
    %gora - whole data
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    spectrum_data = load([spectrum_file_name,'.mat']);
    axes('Position',[.68 .36 .21 .21]);
    box on
    fq_plotter(f, spectrum_data.MFDFA2.Scale(1:end), spectrum_data.MFDFA2.Fq(1:end,31:70), '-k')
    xlabh = get(gca,'XLabel');
    set(xlabh,'Position',get(xlabh,'Position') + [0 .1 0]);
    ylabh = get(gca,'YLabel');
    set(ylabh,'Position',get(ylabh,'Position') + [10 0 1]);
    set(gca,'TickLength',[0.03 1]);
    set(gca,'XTickLabel',[]);
    set(gca,'XLabel',[]);
    ylim([.4 30]);
    xlim([20 1400]);
    legend([indexes{i,7}, datestr(indexes{i,2},'yyyy'),'-',datestr(indexes{i,4},'yyyy')],'Location','northeast')
    hold off
    if write_to_file == true
               fid = fopen([spectrum_file_name,'-fq.csv'], 'w') ;
        fprintf(fid,['scale,']);
        for index=1:40
            fprintf(fid,['f_q,']);
        end
        fprintf(fid,['f_q\n']);
        fclose(fid);
        dlmwrite([spectrum_file_name,'-fq.csv'],[spectrum_data.MFDFA2.Scale(1:end)', spectrum_data.MFDFA2.Fq(1:end,31:70)],'delimiter',',','-append');
    end
    
    
    if save_figures == true
        savefig(f,[indexes{i,1},'-spectrum-split']);
        print(f,[indexes{i,1},'-spectrum-split'],'-depsc')
    end
    
end