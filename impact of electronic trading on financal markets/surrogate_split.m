% index name, start year, end year
clear

indexes = {
    'SP500-removed',  '02-Jan-1950','02-Jan-1987','31-Dec-2016';
    'NASDAQ-removed', '02-Jan-1950','02-Jan-1987','31-Dec-2016';
%     'DJIA',           '02-Jan-1950','02-Jan-1987','31-Dec-2016';
    };

surrogate_count = 100;

for i=1:length(indexes(:,1))
    
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/surrogate/window/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    split_index = find_index(data.date,indexes{i,3});
    end_index = find_index(data.date,indexes{i,4});
    
    calculate_surrogates(indexes{i,1}, data, start_index, end_index, surrogate_count,path);
    calculate_surrogates(indexes{i,1}, data, split_index, end_index, surrogate_count,path);
    calculate_surrogates(indexes{i,1}, data, start_index, split_index, surrogate_count,path);
    
   
end


function calculate_surrogates(index, data, start_index, end_index, surrogate_count, path)
% fourier_surrogate_file_name = [index,'-fourier-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];
% 
% rankings_surrogate_file_name = [index,'-rankings-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];

shuffled_surrogate_file_name = [index,'-shuffled-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
    '-',datestr(data.date(end_index),'yyyy-mm-dd')];

% rankings_surrogate_matrix = zeros(surrogate_count,end_index-start_index);
% fourier_surrogate_matrix = zeros(surrogate_count,end_index-start_index);
shuffled_surrogate_matrix = zeros(surrogate_count,end_index-start_index);

for j=1:surrogate_count
%     fourier_surrogate_matrix(j,:) = surrogate_fourier(data.returns(start_index:end_index-1));
%     rankings_surrogate_matrix(j,:) = surrogate_rankings(data.returns(start_index:end_index-1));
    returns = data.returns(start_index:end_index-1);
    shuffled_surrogate_matrix(j,:) = returns(randperm(length(returns)));
end

% save([path,fourier_surrogate_file_name],'fourier_surrogate_matrix');
% save([path,rankings_surrogate_file_name],'rankings_surrogate_matrix');
save([path,shuffled_surrogate_file_name],'shuffled_surrogate_matrix');
end
