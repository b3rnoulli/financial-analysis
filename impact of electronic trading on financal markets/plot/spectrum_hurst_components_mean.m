clear
clc
figure
data = load('9-companies-components-mean-width-asymmetry.mat');

save_files = true;

for i=1:length(data.mean_components)
    
    date_points(i) = data.mean_components(i).date;
    mean_hurst(i) = data.mean_components(i).mean_hurst;
    
end

plot(date_points, mean_hurst,'xk','DisplayName','9-companies - components mean')
hold on;

legend show;
datetick('x','yyyy');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',14);
hold off;
ylabel('H (t)','FontSize', 14);
xlabel('t [year]','FontSize', 14);
ylim([0 1]);

if save_files
    fid = fopen(['9-companies-components-hurst.csv'], 'w') ;
    fprintf(fid,['window_end_date,','hurst\n']);
    
    for j=1:length(date_points)
        fprintf(fid,[datestr(date_points(j),'dd-mm-yyyy'),',',num2str(mean_hurst(j)),'\n']);
    end
    fclose(fid);
end
