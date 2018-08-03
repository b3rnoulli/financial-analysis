% index name, start year, end year
clear
indexes = {
    'SP500-removed',         '01-Jan-1950','02-Jan-1987',  '31-Dec-2016';
    'NASDAQ-removed',        '01-Jan-1950','01-Jan-1987',  '31-Dec-2016';
%     'DJIA',                  '01-Jan-1950','01-Jan-1987',  '31-Dec-2016';
    };


surrogate_count = 100;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date, indexes{i,2});
    split_index = find_index(data.date, indexes{i,3});
    end_index =   find_index(data.date, indexes{i,4});
    
    calculate_mfdfa(indexes{i,1}, data, start_index, end_index, surrogate_count, path);
%     calculate_mfdfa(indexes{i,1}, data, start_index, split_index, surrogate_count, path);
%     calculate_mfdfa(indexes{i,1}, data, split_index, end_index, surrogate_count, path);
    
%     fprintf('[surrogate_mfdfa_script] : Calculating MFDFA for surrogate index %s date scope %s to %s\n', indexes{i,1},...
%         datestr(data.date(start_index)), datestr(data.date(end_index)));
%     
%     fourier_surrogate_file_name = [indexes{i,1},'-fourier-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%         '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%     
%     shuffled_surrogate_file_name = [indexes{i,1},'-shuffled-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%         '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%     
%     fourier_surrogate_data = load(fourier_surrogate_file_name);
%     shuffled_surrogate_data = load(shuffled_surrogate_file_name);
%     
%     parfor j=1:surrogate_count
%         fourier_surrogate_mfdfa_matrix(j) = MFDFA(fourier_surrogate_data.fourier_surrogate_matrix(j,:),' not_used', false);
%         shuffled_surrogate_mfdfa_matrix(j) = MFDFA(shuffled_surrogate_data.shuffled_surrogate_matrix(j,:),'not_used', false);
%     end
%     
%     fourier_surrogate_mfdfa_file_name =  [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%         '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%     
%     shuffled_surrogate_mfdfa_file_name =  [indexes{i,1},'-shuffled-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%         '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%     
%     save([path,fourier_surrogate_mfdfa_file_name],'fourier_surrogate_mfdfa_matrix');
%     save([path,shuffled_surrogate_mfdfa_file_name],'shuffled_surrogate_mfdfa_matrix');
    
end


function calculate_mfdfa(index, data, start_index, end_index, surrogate_count, path)
fprintf('[surrogate_mfdfa_script] : Calculating MFDFA for surrogate index %s date scope %s to %s\n', index,...
    datestr(data.date(start_index)), datestr(data.date(end_index)));

fourier_surrogate_file_name = [index,'-fourier-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
    '-',datestr(data.date(end_index),'yyyy-mm-dd')];

rankings_surrogate_file_name = [index,'-rankings-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
    '-',datestr(data.date(end_index),'yyyy-mm-dd')];

shuffled_surrogate_file_name = [index,'-shuffled-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
    '-',datestr(data.date(end_index),'yyyy-mm-dd')];

fourier_surrogate_data = load(fourier_surrogate_file_name);
rankings_surrogate_data = load(rankings_surrogate_file_name);
shuffled_surrogate_data = load(shuffled_surrogate_file_name);


parfor j=1:surrogate_count
%     fourier_surrogate_mfdfa_matrix(j) = MFDFA(fourier_surrogate_data.fourier_surrogate_matrix(j,:),' not_used', false);
%     rankings_surrogate_mfdfa_matrix(j) = MFDFA(rankings_surrogate_data.rankings_surrogate_matrix(j,:),'not_used', false);
    shuffled_surrogate_mfdfa_matrix(j) = MFDFA(shuffled_surrogate_data.shuffled_surrogate_matrix(j,:),'not_used', false);
end

% fourier_surrogate_mfdfa_file_name =  [index,'-fourier-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];
% 
% rankings_surrogate_mfdfa_file_name =  [index,'-rankings-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];

rankings_surrogate_mfdfa_file_name =  [index,'-shuffled-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
    '-',datestr(data.date(end_index),'yyyy-mm-dd')];

% save([path,fourier_surrogate_mfdfa_file_name],'fourier_surrogate_mfdfa_matrix');
% save([path,rankings_surrogate_mfdfa_file_name],'rankings_surrogate_mfdfa_matrix');
save([path,rankings_surrogate_mfdfa_file_name],'shuffled_surrogate_mfdfa_matrix');

end