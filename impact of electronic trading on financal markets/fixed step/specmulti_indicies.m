% indexes = {
%     'HPQ' %59 431
%     'AA'; %37 175 - slabe skalowanie
%     'AIG'; %30 380 - dyskusyjne skalowanie
%     'AXP'; %28 328
%     'C'; %43 353
%     'CVX'; %37 240
%     'DD'; % 30 292 
%     'DIS'; %66 417
%     'GE'; %33 417
%     'GT'; %33 422
%     'HON'; %50 435
%     'HPQ'; %76 435
%     'IBM'; %36 305
%     'INTC'; %40 384
%     'IP'; % 30 242 - slabe skalowanie
%     'JNJ';% 30 272
%     'KO'; % 52 470
%     'MCD';% 45 338
%     'MO'; % 34 410
%     'PG'; % 45 550 
%     'PFE'; % 39 203
%     'UTX'; % 41 440
%     'WMT'; % 40 470
%     'XOM'; % 45 325
%     'UTX'; % 35 450
%     'NAV'; % 33 230
%     'MMM'; % 38 266
%     'BA'; % 36 500
%     'BAC'; % 30 380 - slabe skalowanie
%     };

indexes = {
    'DD'; %32 279
    'GE'; %35 266
    'AA'; %30 266 - slabe skalowanie
    'IBM';%33 430
    'KO'; %33 205 - slabe skalowanie
    'BA'; %33 309 - slabe skalowanie
    'CAT';%175 565 - fatalne skalowanie
    'DIS';%63 470 - fatalne skalowanie
    'HPQ';%46 813 
};

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/'];
    data = load([indexes{i,1},'_1962_01_02__2017_07_10_ret']);
    start_index = 1;
    end_index = length(data.returns);
    spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-',datestr(data.date(end_index),'yyyy-mm-dd')];
    spectrum_data = load([path, 'spectrum/', spectrum_file_name,'.mat']);
    
    specmulti_retriable(spectrum_data.MFDFA2, [path, 'spectrum/', spectrum_file_name]);
end