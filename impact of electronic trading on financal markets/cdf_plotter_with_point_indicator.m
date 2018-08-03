clear
clc
symbols = {
    'NASDAQ', 9580, 9599;
    };


f = figure('units','normalized','position',[.1 .1 .4 .5]);
f.PaperPositionMode = 'auto';
for i=1:1:length(symbols(:,1))
    data = load(symbols{i,1});
    
    returns = diff(log(data.close));
    returns(symbols{i,2}:symbols{i,3}) = [];
    returns = zscore(returns);
    
    [y,x] = ecdf(abs(returns));
    loglog(x,1-y,'x','MarkerSize',8);
    
    xlim([0.2,100]);
    ylim([10^-5,1]);
    
    xlabel('r(t)', 'FontSize', 14);
    ylabel('F(|r(t)|)', 'FontSize', 14);
    ax = gca;
    ax.FontSize = 20;
    hold on;
    
    [y_removed,x_removed] = ecdf(abs(data.returns));
    for j=symbols{i,2}:symbols{i,3}
        
        ret = data.returns(j);
        index = find(x_removed<=abs(ret));
        index = index(end);
        loglog(x_removed(index),1-y_removed(index),'^r','MarkerSize',10,'MarkerFaceColor','red');
        
       
        
        
        
    end
    
end

