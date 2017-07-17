clear
clc
data = load('9-companies-components-mean-width-asymmetry.mat');

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
