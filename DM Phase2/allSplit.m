summaryData = xlsread('Data/summary.csv');
for ind = 1:size(summaryData,1)
    split(summaryData(ind, :));
end
