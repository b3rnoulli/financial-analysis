load('NASDAQ-components-mean-width-asymmetry.mat');
date = [];
width = [];
asymmetry_m = [];
for i=1:1:length(mean_components)
    date(i) = mean_components(i).date;
    width(i) = mean_components(i).mean_weighted_width;
    asymmetry_m(i) = mean_components(i).mean_weighted_asymmetry;
end
% figure
% plot(date,width,'x','DisplayName','NASDAQ - width');
% 
% hold on;
% legend show
% xlim([date(1) date(end)]);
% 
% ylabel('\Delta\alpha (t)','FontSize', 14);
% xlabel('t [year]','FontSize', 14);
% ylim([0 0.7]);
% datetick('x','yyyy');
% a = get(gca,'XTickLabel');
% set(gca,'XTickLabel',a,'fontsize',16)

f = figure;
plot(date,asymmetry_m,'x','DisplayName','NASDAQ - asymmetry');
xlim([date(1) date(end)]);

ylabel('A_{\alpha} (t)','FontSize', 14);
xlabel('t [year]','FontSize', 14);
ylim([-1.1 1.1]);
legend show

datetick('x','yyyy');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',14)