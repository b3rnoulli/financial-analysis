load('/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/9-companies/eig_values.mat')
data = load('/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/9-companies/9-companies.mat');

frame_size = 5000;
frame_step_size = 20;
start_index = 1;
end_index =frame_size;
date_points = datetime('01-Jan-1970');
point_counter = 1;

full_data_points = struct;
while end_index < length(data.returns) && point_counter<=length(eig_values)
    
    dd(point_counter)=data.date(end_index);
    
    start_index = start_index + frame_step_size;
    end_index = end_index + frame_step_size;
    point_counter =point_counter+1;
end

plot(dd,eig_values,'k','LineWidth',1.8)
hold on;
crash_1987 = datetime('19-Oct-1987');
crash_2008 = datetime('15-Sep-2008');

plot([crash_1987, crash_1987],[3.3, 4.3],'--r','LineWidth',1.3);
plot([crash_2008, crash_2008],[3.3, 4.3],'--r','LineWidth',1.3);