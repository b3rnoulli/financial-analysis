indexes = {
    'SP500-removed',datetime('03-Jan-1950'), datetime('02-Jan-1987'), datetime('29-Dec-2016'), '^-', 'r', 'S&P500 ';
%          'DJIA',datetime('03-Jan-1950'), datetime('02-Jan-1987'), datetime('03-Jan-2017'), '^-', 'r', 'DJIA ';
%         'NASDAQ-removed', datetime('03-Jan-1950'), datetime('02-Jan-1987'), datetime('29-Dec-2016'), 'o-', 'k', 'NASDAQ COMP '
%         '9-companies', datetime('02-Jan-1962'), datetime('02-Jan-1987'), datetime('03-Jan-2017'), 'o-', 'k', '9-companies'
    };

save_figures = false;
write_to_file = false;
plot_surrogates = true;

for i=1:1:length(indexes(:,1))
    f = figure('units','normalized','position',[.1 .1 .5 .6]);
    f.PaperPositionMode = 'auto';
    
    % first part
    rankings_spectrum_file_name = [indexes{i,1},'-rankings-surrogate-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    rankings_spectrum_data = load([rankings_spectrum_file_name,'.mat']); 
    
    fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    fourier_spectrum_data = load([fourier_spectrum_file_name,'.mat']);
    
    for j=1:1:length(rankings_spectrum_data)
        ranking_spectrum_mean(
    end
    
    
    if plot_surrogates  == true
        spectrum_surrogate_file_name = [indexes{i,1},'-rankings-surrogate-mean-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(datetime('05-Jan-1987'),'yyyy-mm-dd')];
        spectrum_surrogate_data = load([spectrum_surrogate_file_name,'.mat']); 
        p = spectrum_plotter(f, spectrum_surrogate_data.MFDFA2.alfa(31:70), spectrum_surrogate_data.MFDFA2.f(31:70), '-s', 'g', [ indexes{i,7}, datestr(indexes{i,2},'yyyy'),'-',datestr(indexes{i,3},'yyyy')]);
        set(p,'linewidth',3);
        
    end
    
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
    
    legend sho
    
end