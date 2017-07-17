load('/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/SP500/SP500.mat')
f = figure('units','normalized','position',[.1 .1 .8 .4]);
semilogy(date, close,'k','LineWidth',1.5);

datetick('x','yyyy');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',14);
xlabel('t [year]')
ylabel('P(t)');
xlim([date(1) date(end)])

set(gca,'XTickLabel',a,'fontsize',16);
set(gca,'XTickLabel',a,'fontsize',16);

