f = figure('units','normalized','position',[.1 .1 .9 .8]);
subplot(3,1,3)
spectrum_in_time_fixed_step;
set(gca,'Position', [0.1 0.1 0.8 0.28])
yticklabels({'','0.2','0.4','0.6','0.8',''})
legend('9 companies index')
subplot(3,1,2)
spectrum_in_time_components_mean;
xlabel([]);
set(gca,'Position', [0.1 0.38 0.8 0.28])
xticklabels({[]});
yticklabels({'','0.2','0.4','0.6','0.8',''})
legend('Average of individual MF spectra')
subplot(3,1,1)
eigen_value_plotter;
set(gca,'Position', [0.1 0.66 0.8 0.28]);
% xlabel('\it \bf t [year]','FontSize', 30);
ylabel('\it \bf \lambda_{1}','FontSize', 35);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',20);
xticklabels({[]});
yticklabels({'','3.6','3.8','4.0','4.2','4.4'})
