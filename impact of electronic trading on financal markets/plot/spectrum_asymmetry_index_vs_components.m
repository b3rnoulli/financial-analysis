clear
clc
data = load('9-companies-components-mean-width-asymmetry.mat');

save_files = true;

for i=1:length(data.mean_components)
    
    date_points(i) = data.mean_components(i).date;
    mean_asymmetry(i) = data.mean_components(i).mean_asymmetry;
    
end

plot(datenum(date_points), mean_asymmetry,'xk','DisplayName','9-companies - components mean')
hold on;
index_data = load('9-companies-spectrum-asymmetry.mat');

plot(datenum(index_data.date_points),index_data.asymmetry,'o','DisplayName','9-companies - index');

legend show;
datetick('x','yyyy');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',14);
hold off;
ylabel('A_{\alpha} (t)','FontSize', 14);
xlabel('t [year]','FontSize', 14);
ylim([-1.1 1.1]);


if save_files
    fid = fopen(['9-companies-spectrum-asymmetry-index-vs-components-mean.csv'], 'w') ;
    fprintf(fid,['window_end_date,','index-asymmetry,','components-mean-asymmetry\n']);
    
    for j=1:length(date_points)
        fprintf(fid,[datestr(date_points(j),'dd-mm-yyyy'),',',num2str(index_data.asymmetry(j)),',',num2str(mean_asymmetry(j)),'\n']);
    end
    fclose(fid);
end

% clear
% clc
% data = load('DJIA-RR-2-components-mean-width-asymmetry.mat');
%
% for i=1:length(data.mean_components)
%
%     date_points(i) = data.mean_components(i).date;
%     mean_asymmetry(i) = data.mean_components(i).mean_asymmetry;
%
% end
%
% plot(datenum(date_points), mean_asymmetry,'xk','DisplayName','DJIA - components mean')
% hold on;
% index_data = load('DJIA-reconstructed-spectrum-asymmetry.mat');
%
% plot(datenum(index_data.date_points),index_data.asymmetry,'o','DisplayName','DJIA - reconstructed index');
%
% legend show;
% datetick('x','yyyy');
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'fontsize',14);
% hold off;
% ylabel('A_{\alpha} (t)','FontSize', 14);
% xlabel('t [year]','FontSize', 14);
% ylim([-1.1 1.1]);
