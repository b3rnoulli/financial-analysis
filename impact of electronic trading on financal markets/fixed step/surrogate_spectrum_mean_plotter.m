indexes = {
%     'SP500-removed',  datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 30, 160, 300, 700;
        'NASDAQ-removed', datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 28, 240, 300, 700;
    };


save_figures = false;
write_to_file = false;
plot_surrogates = true;

f1 = figure('units','normalized','position',[.1 .1 .6 .6]);
f2 = figure('units','normalized','position',[.1 .1 .6 .6]);
for i=1:1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    
    %SP500
%     plot_part(indexes{i,1}, indexes{i,2},indexes{i,3},'b',f1,f2, indexes{i,5},indexes{i,6});
%     plot_part(indexes{i,1}, indexes{i,2},indexes{i,4},'r',f1,f2, indexes{i,5},indexes{i,6});
%     plot_part(indexes{i,1}, indexes{i,3},indexes{i,4},'k',f1,f2, 30, 300);
%     
    %NASDAQ
%         plot_part(indexes{i,1}, indexes{i,2},indexes{i,3},'b',f1,f2, 23,124);
        plot_part(indexes{i,1}, indexes{i,2},indexes{i,4},'r',f1,f2, 21, 200);
%         plot_part(indexes{i,1}, indexes{i,3},indexes{i,4},'k',f1,f2, 25, 180);
     
        
    figure(f1);
    legend show
    figure(f2);
    legend show
end

function [rankings_mean, fourier_mean] = plot_part(index_name, start_date, end_date, color, f1, f2, rankings_upper, rankings_bottom)
rankings_spectrum_file_name = [index_name,'-rankings-surrogate-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
    '-', datestr(end_date,'yyyy-mm-dd')];
rankings_spectrum_data = load([rankings_spectrum_file_name,'.mat']);
% 
% fourier_spectrum_file_name = [index_name,'-fourier-surrogate-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
%     '-', datestr(end_date,'yyyy-mm-dd')];
% fourier_spectrum_data = load([fourier_spectrum_file_name,'.mat']);

shuffled_spectrum_file_name = [index_name,'-shuffled-surrogate-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
    '-', datestr(end_date,'yyyy-mm-dd')];
shuffled_spectrum_data = load([shuffled_spectrum_file_name,'.mat']);


for j=1:1:length(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix)
%     reshaped_rankings_alfa = specmulti(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(j),[], rankings_upper, rankings_bottom);
%     rankings_alfa(j,:) = reshaped_rankings_alfa.alfa(31:70);
%     rankings_f(j,:) = reshaped_rankings_alfa.f(31:70);
%     
%     fourier_alfa(j,:) = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).alfa(31:70));
%     fourier_f(j,:) = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).f(31:70));



    shuffled_data = specmulti(shuffled_spectrum_data.shuffled_surrogate_mfdfa_matrix(j),[], 1000, 2000);
    shuffled_alfa(j,:) = shuffled_data.alfa(31:70);
    shuffled_f(j,:) = shuffled_data.f(31:70);
end
% rankings_mean = struct;
% rankings_mean.alfa =  mean(rankings_alfa);
% rankings_mean.std_alfa = std(rankings_alfa);
% rankings_mean.f =  mean(rankings_f);
% rankings_mean.std_f = std(rankings_f);
% p = spectrum_plotter(f1, rankings_mean.alfa, rankings_mean.f, 'x-', color, [ index_name,'-rankings-', datestr(start_date,'yyyy'),'-',datestr(end_date,'yyyy')]);
% 
% fourier_mean = struct;
% fourier_mean.alfa =  mean(fourier_alfa);
% fourier_mean.std_alfa = std(fourier_alfa);
% fourier_mean.f =  mean(fourier_f);
% fourier_mean.std_f = std(fourier_f);
% p = spectrum_plotter(f2, fourier_mean.alfa, fourier_mean.f, 'x-', color, [ index_name,'-fourier-', datestr(start_date,'yyyy'),'-',datestr(end_date,'yyyy')]);

shuffled_mean = struct;
shuffled_mean.alfa =  mean(shuffled_alfa);
shuffled_mean.std_alfa = std(shuffled_alfa);
shuffled_mean.f =  mean(shuffled_f);
shuffled_mean.std_f = std(shuffled_f);
p = spectrum_plotter(f2, shuffled_mean.alfa, shuffled_mean.f, 'x-', color, [ index_name,'-shuffled-', datestr(start_date,'yyyy'),'-',datestr(end_date,'yyyy')]);

% 
% fid = fopen([index_name,'-surrogates-rankings-',datestr(start_date,'yyyy-mm-dd'),'-', datestr(end_date,'yyyy-mm-dd'),'.csv'], 'w') ;
% fprintf(fid,'alfa, f, std_alfa, std_f\n');
% 
% for j=1:length(rankings_mean.alfa)
%     fprintf(fid,[num2str(rankings_mean.alfa(j)),',',num2str(rankings_mean.f(j)),',',num2str(rankings_mean.std_alfa(j)),',',num2str(rankings_mean.std_f(j)),'\n']);
% end
% fclose(fid);
% 
% fid = fopen([index_name,'-surrogates-fourier-',datestr(start_date,'yyyy-mm-dd'),'-', datestr(end_date,'yyyy-mm-dd'),'.csv'], 'w') ;
% fprintf(fid,'alfa, f, std_alfa, std_f\n');
% 
% for j=1:length(fourier_mean.alfa)
%     fprintf(fid,[num2str(fourier_mean.alfa(j)),',',num2str(fourier_mean.f(j)),',',num2str(fourier_mean.std_alfa(j)),',',num2str(fourier_mean.std_f(j)),'\n']);
% end
% fclose(fid);

fid = fopen([index_name,'-surrogates-shuffled-',datestr(start_date,'yyyy-mm-dd'),'-', datestr(end_date,'yyyy-mm-dd'),'.csv'], 'w') ;
fprintf(fid,'alfa, f, std_alfa, std_f\n');

for j=1:length(shuffled_mean.alfa)
    fprintf(fid,[num2str(shuffled_mean.alfa(j)),',',num2str(shuffled_mean.f(j)),',',num2str(shuffled_mean.std_alfa(j)),',',num2str(shuffled_mean.std_f(j)),'\n']);
end
fclose(fid);
end
