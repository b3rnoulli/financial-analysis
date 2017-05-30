load('/Users/b3rnoulli/Development/Matlab workspace/empirical data/SP500/SP500_removed.mat')

lrr = zscore(diff(log(price(1:5000))));
to_append = fbm1d(0.3);



for i=50:50:2500
    appended = [lrr;
    to_append(1:i)];
    MFDFA(appended,['SP500-removed-',num2str(i),'-appended']);
end



specmulti_a