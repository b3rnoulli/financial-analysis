clear
% symbols = {
% 'HON', 8.268444061279297;
% 'DD',  5.262741565704346;
% 'GE',  0.9739583134651184;
% 'GT',  5.625;
% 'NAV', 297.5;
% 'IP',  8.567554473876953;
% 'PG',  1.96875;
% 'CVX', 8.859375;
% 'XOM', 3.6015625;
% 'UTX', 2.6875;
% 'AA',  8.608747482299805;
% 'MMM', 5.96875;
% 'IBM', 14.78125;
% 'AXP', 1.6414610147476196;
% 'MO',  1.265625;
% 'MCD', 0.9135802388191223;
% 'KO',  0.609375;
% 'BA',  5.469135761260986;
% 'CAT', 5.875;
% 'DIS', 0.8731919527053833;
% 'JPM', 5.037036895751953;
% 'JNJ', 1.3854166269302368;
% 'HPQ', 0.8550465703010559;
% 'C',   12.242500305175781;
% 'WMT', 0.11328125;
% 'INTC',0.3255208432674408;
% 'AIG', 24.160219192504883;
% 'PFE', 0.7005208134651184;
% 'BAC', 1.40625;
% };

symbols = {
    'DD', 12.74;
    'GE', 0.77;
    'AA', 6.53;
    'IBM', 7.62;
    'KO', 0.26;
    'BA', 0.82;
    'CAT', 1.60;
    'DIS', 0.09;
    'HPQ', 0.12;
};
for i=1:1:length(symbols)
    path = [get_root_path(),'/financial-analysis/empirical data/',symbols{i,1},'/'];
    data_table = importdata([symbols{i},'_1962_01_02__2017_07_10_ret_no_norm_no_log.dat'],'}');
    returns = data_table.data;
    close = zeros(1,length(returns)+1);
    close(1) = symbols{i,2};
    for j=2:1:length(returns)+1
        close(j) = close(j-1) + returns(j-1);
    end
    returns = zscore(diff(log(close)));
    returns_raw = data_table.data;
    date = datetime(strrep(strrep(data_table.textdata,'{',''),', ','-'));
    save([path,symbols{i,1},'_1962_01_02__2017_07_10_ret.mat'],'date','close','returns','returns_raw');
end