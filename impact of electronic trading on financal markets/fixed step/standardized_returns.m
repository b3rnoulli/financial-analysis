UTX.returns_standardized_01 = diff(log(UTX.close))./std(diff(log(UTX.close))).*0.01;


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

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load([indexes{i,1},'_1962_01_02__2017_07_10_ret']);
    returns(6484) = [];
    returns_standardized_01 = 
    save([path,indexes{i,1},'_1962_01_02__2017_07_10_ret.mat'],'date','close','returns','returns_raw');
end

