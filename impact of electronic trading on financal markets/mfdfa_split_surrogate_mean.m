clear
clc
indexes = {
    'SP500-removed',         '01-Jan-1950','02-Jan-1987',  '31-Dec-2016';
    'NASDAQ-removed',        '01-Jan-1950','02-Jan-1987',  '31-Dec-2016';
%     'DJIA',                  '01-Jan-1950','02-Jan-1987',  '31-Dec-2016';
    };


surrogate_count = 100;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    split_index = find_index(data.date,indexes{i,3});
    end_index = find_index(data.date,indexes{i,4});
    
    calculate_fq_mean(indexes{i,1}, data, start_index, end_index, surrogate_count, path);
%     calculate_fq_mean(indexes{i,1}, data, start_index, split_index, surrogate_count, path);
%     calculate_fq_mean(indexes{i,1}, data, split_index, end_index, surrogate_count, path);
end


function calculate_fq_mean(index, data, start_index, end_index, surrogate_count, path)

fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', index,...
    datestr(data.date(start_index)), datestr(data.date(end_index)));
% rankings_spectrum_file_name = [index,'-rankings-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];
% 
% rankings_spectrum_data = load([path, rankings_spectrum_file_name]);
% rankings_surrogate_scales = zeros(surrogate_count, 41);
% rankings_surrogate_fq = zeros(surrogate_count, 41, 100);
% 
% for j=1:surrogate_count
%     rankings_surrogate_scales(j,:) = rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(j).Scale;
%     rankings_surrogate_fq(j,:,:) = rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(j).Fq;
% end
% 
% save_path = [path,'/mean/'];
% rankings_surrogate_mean_file_name = [save_path,index,'-rankings-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];
% MFDFA2.q = -10:0.2:10;
% MFDFA2.q(51) = [];
% MFDFA2.Scale = mean(rankings_surrogate_scales);
% MFDFA2.Fq = reshape(mean(rankings_surrogate_fq),41,100);
% save(rankings_surrogate_mean_file_name,'MFDFA2');
% 
% clear 'MFDFA2'
% 
% fourier_spectrum_file_name = [index,'-fourier-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];
% 
% fourier_spectrum_data = load([path, fourier_spectrum_file_name]);
% fourier_surrogate_scales = zeros(surrogate_count, 41);
% fourier_surrogate_fq = zeros(surrogate_count, 41, 100);
% 
% for j=1:surrogate_count
%     fourier_surrogate_scales(j,:) = fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).Scale;
%     fourier_surrogate_fq(j,:,:) = fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).Fq;
% end
% 
% save_path = [path,'/mean/'];
% fourier_surrogate_mean_file_name = [save_path,index,'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%     '-',datestr(data.date(end_index),'yyyy-mm-dd')];
% MFDFA2.q = -10:0.2:10;
% MFDFA2.q(51) = [];
% MFDFA2.Scale = mean(fourier_surrogate_scales);
% MFDFA2.Fq = reshape(mean(fourier_surrogate_fq),41,100);
% save(fourier_surrogate_mean_file_name,'MFDFA2');
% clear 'MFDFA2'


shuffled_spectrum_file_name = [index,'-shuffled-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
    '-',datestr(data.date(end_index),'yyyy-mm-dd')];

shuffled_spectrum_data = load([path, shuffled_spectrum_file_name]);
shuffled_surrogate_scales = zeros(surrogate_count, 41);
shuffled_surrogate_fq = zeros(surrogate_count, 41, 100);

for j=1:surrogate_count
    shuffled_surrogate_scales(j,:) = shuffled_spectrum_data.shuffled_surrogate_mfdfa_matrix(j).Scale;
    shuffled_surrogate_fq(j,:,:) = shuffled_spectrum_data.shuffled_surrogate_mfdfa_matrix(j).Fq;
end

save_path = [path,'/mean/'];
shuffled_surrogate_mean_file_name = [save_path,index,'-shuffled-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
    '-',datestr(data.date(end_index),'yyyy-mm-dd')];
MFDFA2.q = -10:0.2:10;
MFDFA2.q(51) = [];
MFDFA2.Scale = mean(shuffled_surrogate_scales);
MFDFA2.Fq = reshape(mean(shuffled_surrogate_fq),41,100);
save(shuffled_surrogate_mean_file_name,'MFDFA2');


end