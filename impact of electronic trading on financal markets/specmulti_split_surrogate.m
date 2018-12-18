clear
clc

indexes = {
    'SP500-removed',         '01-Jan-1950','02-Jan-1987',  '31-Dec-2016',30, 280;
    'NASDAQ-removed',        '01-Jan-1950','02-Jan-1987',  '31-Dec-2016',30, 280;
%     'DJIA',                  '01-Jan-1950','02-Jan-1987',  '31-Dec-2016',30, 280;
    };


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/mean/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    split_index = find_index(data.date,indexes{i,3});
    end_index = find_index(data.date,indexes{i,4});
    
    calculate_specmulti(indexes{i,1}, data, start_index, end_index, indexes{i,5}, indexes{i,6}, path);
%     calculate_specmulti(indexes{i,1}, data, split_index, end_index, indexes{i,5}, indexes{i,6}, path);
%     calculate_specmulti(indexes{i,1}, data, start_index, split_index, indexes{i,5}, indexes{i,6}, path);
    
end

function calculate_specmulti(index, data, start_index, end_index,  bottom_bound, upper_bound, path)
 fprintf('[specmulti_window_surrogate] : Calculating MFDFA for index %s date scope %s to %s\n', index,...
        datestr(data.date(start_index)), datestr(data.date(end_index)));
%     fourier_spectrum_file_name = [index,'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%         '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%     
%     fourier_spectrum_data = load([path, fourier_spectrum_file_name]);
%     
%     rankings_spectrum_file_name = [index,'-rankings-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
%         '-',datestr(data.date(end_index),'yyyy-mm-dd')];
%     rankings_surrogate_data = load([path, rankings_spectrum_file_name]);
    
shuffled_spectrum_file_name = [index,'-shuffled-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-',datestr(data.date(end_index),'yyyy-mm-dd')];
    
    shuffled_spectrum_data = load([path, shuffled_spectrum_file_name]);

%     specmulti(fourier_spectrum_data.MFDFA2, [path, fourier_spectrum_file_name], bottom_bound, upper_bound);
%     specmulti(rankings_surrogate_data.MFDFA2, [path, rankings_spectrum_file_name], bottom_bound, upper_bound);
    specmulti(shuffled_spectrum_data.MFDFA2, [path, shuffled_spectrum_file_name], 200, 700);

end