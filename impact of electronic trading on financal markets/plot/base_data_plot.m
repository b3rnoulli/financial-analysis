indexes = {'SP500', 'NASDAQ'};
base_path = ['/Users/b3rnoulli/Development/Matlab workspace/impact of electronic trading on financial markets/',...
    'plot/'];
data_base_path = '/Users/b3rnoulli/Development/Matlab workspace/empirical data';

for i=1:1:length(indexes)
    data = load([data_base_path,'/',indexes{i},'/',indexes{i},'.mat']);
    price_and_returns_plotter(data.close,data.date,[base_path,indexes{i}], indexes{i});
end
