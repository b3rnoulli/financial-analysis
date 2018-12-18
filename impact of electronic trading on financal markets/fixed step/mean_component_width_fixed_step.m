clear
clc

% index_name='NASDAQ';
index_name='9-companies';
% indexes = {
%     'HPQ', 59, 431;
%     'AA',  37, 175;
%     'AIG', 30, 380;
%     'AXP', 28, 328;
%     'C',   43, 353;
%     'CVX', 37, 240;
%     'DD',  30, 292;
%     'DIS', 66, 417;
%     'GE',  33, 417;
%     'GT',  33, 422;
%     'HON', 50, 435;
%     'HPQ', 76, 435;
%     'IBM', 36, 305;
%     'INTC',40, 384;
%     'IP',  30, 242;
%     'JNJ', 30, 272;
%     'KO',  52, 470;
%     'MCD', 45, 338;
%     'MO',  34, 410;
%     'PG',  45, 550;
%     'PFE', 39, 203;
%     'UTX', 41, 440;
%     'WMT', 40, 470;
%     'XOM', 45, 325;
%     'UTX', 35, 450;
%     'NAV', 33, 230;
%     'MMM', 38, 266;
%     'BA',  36, 500;
%     'BAC', 30, 380;
%     };

indexes = {
%     'DD' , 34, 400;
%     'GE' , 34, 400;
%     'AA' , 34, 400;
    'IBM', 34, 400;
%     'KO' , 34, 400;
%     'BA' , 34, 400;
%     'CAT', 34, 400;
%     'DIS', 34, 400;
    'HPQ', 34, 400;
    };

components = struct;
frame_size = 5000;
frame_step_size = 20;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load([indexes{i,1},'_1962_01_02__2017_07_10_ret']);
    point_counter=1;
    start_index = 1;
    end_index = frame_size;
    
    while end_index < length(data.returns)
        fprintf('[mfdfa_window_fixed_step] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index),'yyyy-mm-dd'), datestr(data.date(end_index),'yyyy-mm-dd'));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path,spectrum_file_name]);
        
        components(i).alpha_y(point_counter) = spectrum_width(spectrum_data.MFDFA2.alfa(31:70),spectrum_data.MFDFA2.f(31:70));
        components(i).a_y(point_counter) = spectrum_asymmetry(spectrum_data.MFDFA2.alfa(50), (spectrum_data.MFDFA2.alfa(50:71)),...
            spectrum_data.MFDFA2.alfa(31:50));
        components(i).date_x(point_counter) = datenum(data.date(end_index));
        components(i).hurst(point_counter) = spectrum_data.MFDFA2.alfa(60);
        components(i).MFDFA2(point_counter).alfa = spectrum_data.MFDFA2.alfa;
        components(i).MFDFA2(point_counter).f = spectrum_data.MFDFA2.f;
        components(i).window_start_date(point_counter) = data.date(start_index);
        components(i).window_end_date(point_counter) = data.date(end_index);
        point_counter = point_counter + 1;
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        
    end
end

mean_components = struct;
date_counter = 1;
end_index = frame_size;
mw = [];
while date_counter < length(components(1).alpha_y)
    
    mean_components(date_counter).date =  data.date(end_index);
    for i=1:length(indexes(:,1))
        mean_components(date_counter).width(i) = components(i).alpha_y(date_counter);
        mean_components(date_counter).asymmetry(i) = components(i).a_y(date_counter);
        mean_components(date_counter).hurst(i) = components(i).hurst(date_counter);
        mean_components(date_counter).alfa_c(i,:,:) = components(i).MFDFA2(date_counter).alfa;
        mean_components(date_counter).f_c(i,:,:) = components(i).MFDFA2(date_counter).f;
    end
    
    mean_components(date_counter).mean_width = nanmean(mean_components(date_counter).width);
    mw(date_counter) = mean_components(date_counter).mean_width;
    mean_components(date_counter).mean_asymmetry = nanmean(mean_components(date_counter).asymmetry);
    ms(date_counter) = mean_components(date_counter).mean_asymmetry;
    dat(date_counter) = components(1).window_end_date(date_counter);
    mean_components(date_counter).mean_hurst = nanmean(mean_components(date_counter).hurst);
    mean_components(date_counter).alfa = mean(mean_components(date_counter).alfa_c);
    mean_components(date_counter).f = mean(mean_components(date_counter).f_c);
    mean_components(date_counter).window_start_date=components(1).window_start_date(date_counter);
    mean_components(date_counter).window_end_date=components(1).window_end_date(date_counter);
    
    date_counter = date_counter + 1;
    end_index = end_index + frame_step_size;
    
    
    mean_components(date_counter).alfa_c = [];
    mean_components(date_counter).f_c = [];
end

figure
plot(dat,mw,'xk');
ylabel('\Delta\alpha (t)','FontSize', 14);
xlabel('t [year]','FontSize', 14);
ylim([0 0.7]);
datetick('x','yyyy');
set(gca,'FontSize',20);
a = get(gca,'XTickLabel');

figure
plot(dat,ms,'xk');
ylabel('A_{\alpha} (t)','FontSize', 14);
xlabel('t [year]','FontSize', 14);
ylim([-1.05 1.05]);
datetick('x','yyyy');
set(gca,'FontSize',20);
a = get(gca,'XTickLabel');


% save([index_name,'-non-IBM-HPQ-mean-width-asymmetry','.mat'],'mean_components');


