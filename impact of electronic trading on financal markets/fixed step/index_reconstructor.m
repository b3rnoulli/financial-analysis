clear
clc
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
    'DD';
    'GE';
    'AA';
    'IBM';
    'KO';
    'BA';
    'CAT';
    'DIS';
    'HPQ';  
};

data = load('AA_1962_01_02__2017_07_10_ret');

components = zeros(length(indexes),length(data.close));
for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load([indexes{i,1},'_1962_01_02__2017_07_10_ret']);
    components(i,:) = data.close;
end

% starting_price = 10;
% for i=1:length(components(:,1))
%     log_prices(i,1) = starting_price;
%     for j=1:1:length(components(i,:))
%         log_prices(i,j+1) = log_prices(i,j) + components(i,j);
%     end
% end
% 
% raw_prices = exp(log_prices);
% returns = zeros(length(raw_prices(:,1)), length(raw_prices(1,:))-1);
% for i=1:1:length(raw_prices(1,:))
%     index(i) = sum(raw_prices(:,i));
% end

index = [];
for i=1:1:length(components(1,:))
    index(i) = sum(components(:,i));
end

close = index;
returns = zscore(diff(log(close)));
date = data.date;
% close(1) = [];
save(['9-companies','.mat'],'close','returns','date');


