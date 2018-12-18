function [ f ] = fq_plotter(f, scales, fq, marker, figure_title)
fprintf('[fq_plotter] Plotting fluctuation function \n');

loglog(scales, fq, marker);
hold on
if exist('figure_title','var')
    title(figure_title);
end

loglog(scales, fq,'k');
% axis tight
ylim([0 20]);
xlim([35 350])
xlabel('s');
ylabel('F_{q}(s)')
ax = gca;
ax.FontSize = 12;
fprintf('[fq_plotter] Plotting fluctuation function \n');
end


