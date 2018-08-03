clear
clc
% nine_comp = load('/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/9-companies/9-companies.mat');
% sp500=load('/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/SP500/SP500.mat');
% djia=load('/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/DJIA/DJIA.mat');
nasdaq=load('/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/NASDAQ/NASDAQ.mat');

for i=1:1:length(nine_comp.date)
%     sp500_data(i).date=nine_comp.date(i);
%     sp500_data(i).close=sp500.close(find_index(sp500.date,nine_comp.date(i))-1);
%     sp500_price(i) = sp500_data(i).close;
%     
%     djia_data(i).date=nine_comp.date(i);
%     djia_data(i).close=djia.close(find_index(djia.date,nine_comp.date(i))-1);
%     djia_price(i) = djia_data(i).close;
%     
%     
%     nine_comp_data(i).date=nine_comp.date(i);
%     nine_comp_data(i).close=nine_comp.close(i);
%     nine_comp_price(i) = nine_comp_data(i).close;

%     nasdaq_data(i).date=nine_comp.date(i);
%     nasdaq_data(i).close=djia.close(find_index(djia.date,nine_comp.date(i))-1);
%     djia_price(i) = djia_data(i).close;
end

subplot(3,1,1)
plot(nine_comp.date,nine_comp_price,'r','DisplayName','9-companies');
subplot(3,1,2)
plot(nine_comp.date,sp500_price,'b','DisplayName','SP500');
subplot(3,1,3)
plot(nine_comp.date,djia_price,'g','DisplayName','DJIA');
