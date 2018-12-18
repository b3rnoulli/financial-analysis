clear
clc

% index name, start year, end year
index_data = {
    'SP500_removed', '01-Jan-1950', '31-Dec-2015', 29, 230;
%     'DJIA',  '01-Jan-1950', '31-Dec-2015', 30, 300;
%     'NDX',   '01-Jan-1950', '31-Dec-2015', 30, 208;
%     'DAX',   '01-Jan-1960', '31-Dec-2015', 29, 200;
%     'UKX',   '01-Jan-1955', '31-Dec-2015', 29, 240;
%     'NKX',   '01-Jan-1955', '31-Dec-2015', 36, 225;
    };

% index_data = {
%     'SP500', '01-Jan-1965', '01-Jan-1990' 29, 230;
%     'DJIA',  '01-Jan-1965', '01-Jan-1990' 30, 300;
%     'NDX',   '01-Jan-1965', '01-Jan-1990' 30, 208;
%     'DAX',   '01-Jan-1965', '01-Jan-1990' 29, 200;
%     'UKX',   '01-Jan-1965', '01-Jan-1990' 29, 240;
%     'NKX',   '01-Jan-1965', '01-Jan-1990' 36, 225;
%     };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';



for i=1:length(index_data(:,1))
    path = ['C:\Users\Rafa³\Documents\MATLAB\real_data\',index_data{i,1},'\frame\'];
    data = load(index_data{i,1});
    log_return_rates = zscore(diff(log(data.price)));
    
    start_index = find_index(data,index_data{i,2});
    end_index = shift_index(data, start_index, frame_size, frame_size_type);

    while end_index < find_index(data,index_data{i,3})
        fprintf('specmulti_frame_fixed : Calculating spectrum for index %s date scope %s to %s \n using fixed scales from %s to %s\n',...
            index_data{i,1},datestr(data.date(start_index)), datestr(data.date(end_index)),...
            num2str(index_data{i,4}), num2str(index_data{i,5}));
        spectrum_file_name = [index_data{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        spec_data = load([spectrum_file_name,'_m2_wyniki.mat']);
        new_spectrum_file_name = [path, spectrum_file_name,'_',num2str(index_data{i,4}),'_',num2str(index_data{i,5}),'_m2_wyniki'];
        
        specmulti_auto(spec_data.MFDFA2, new_spectrum_file_name, index_data{i,4}, index_data{i,5})
        start_index = shift_index(data, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data, end_index, frame_step_size, frame_step_type);
    end
end

