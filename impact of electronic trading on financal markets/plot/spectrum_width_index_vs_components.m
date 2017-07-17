clear
clc
figure
data = load('9-companies-components-mean-width-asymmetry.mat');

for i=1:length(data.mean_components)
    
    date_points(i) = data.mean_components(i).date;
    mean_width(i) = data.mean_components(i).mean_width;
    
end

plot(datenum(date_points), mean_width,'xk','DisplayName','9-companies - components mean')
hold on;
index_data = load('9-companies-spectrum-width.mat');

plot(datenum(index_data.date_points),index_data.alpha_y,'>','DisplayName','9-companies - index');

% 
% index_data = load(['DJIA-reconstructed-spectrum-width.mat']);
% plot(datenum(index_data.date_points),index_data.alpha_y,'s','DisplayName',['DJIA - reconstructed index with same p(1)']);

% 
% index_data = load(['DJIA-RR-3-spectrum-width.mat']);
% plot(datenum(index_data.date_points),index_data.alpha_y,'d','DisplayName',['DJIA - reconstructed index with real p(1)']);


legend show;
datetick('x','yyyy');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',14);
hold off;
ylabel('\Delta{\alpha} (t)','FontSize', 14);
xlabel('t [year]','FontSize', 14);
ylim([0 0.7]);


% yyaxis right
% eigen_data = load('max_eigen_value_long.mat');
% plot(datenum(index_data.date_points),eigen_data.eigen_value,'rd','DisplayName',['eigen values']);


% clear
% clc
% figure
% data = load('DJIA-RR-2-components-mean-width-asymmetry.mat');
% 
% for i=1:length(data.mean_components)
%     
%     date_points(i) = data.mean_components(i).date;
%     mean_width(i) = data.mean_components(i).mean_width;
%     
% end
% 
% plot(datenum(date_points), mean_width,'xk','DisplayName','DJIA - components mean')
% hold on;
% index_data = load('DJIA-reconstructed-spectrum-width.mat');
% 
% plot(datenum(index_data.date_points),index_data.alpha_y,'>','DisplayName','DJIA - reconstruced index');
% 
% 
% index_data = load(['DJIA-spectrum-width.mat']);
% plot(datenum(index_data.date_points),index_data.alpha_y,'s','DisplayName',['DJIA - original index']);
% 
% 
% index_data = load(['DJIA-RR-3-spectrum-width.mat']);
% plot(datenum(index_data.date_points),index_data.alpha_y,'d','DisplayName',['DJIA - reconstructed index with real p(1)']);
% 
% 
% legend show;
% datetick('x','yyyy');
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'fontsize',14);
% hold off;
% ylabel('\Delta{\alpha} (t)','FontSize', 14);
% xlabel('t [year]','FontSize', 14);
% ylim([0 0.7]);

