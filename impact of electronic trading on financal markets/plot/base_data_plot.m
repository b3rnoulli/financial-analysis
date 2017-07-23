indexes = {'SP500-removed', 'NASDAQ-removed','DJIA','9-companies'};
base_path = ['/Users/b3rnoulli/Development/Matlab workspace/impact of electronic trading on financial markets/',...
    'plot/'];
data_base_path = [get_root_path(),'/empirical data'];

for i=1:1:length(indexes)
    data = load([indexes{i},'.mat']);
    price_and_returns_plotter(data.close,data.date,[base_path,indexes{i}], indexes{i});
end
