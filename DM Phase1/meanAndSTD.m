summaryData = xlsread('Data/summary.csv');
 a=[];
 b=[];
meanaccXF=[];
meanaccXNF=[];
stdaccXF=[];
stdaccXNF=[];
meanaccYF=[];
meanaccYNF=[];
stdaccYF=[];
stdaccYNF=[];
meanaccZF=[];
meanaccZNF=[];
stdaccZF=[];
stdaccZNF=[];
totalEating = [];
totalnonEating = [];
totalEating1 = [];
totalnonEating1 = [];
minAccEating= [];
maxAccEating=[];
minAccNon=[];
maxAccNon=[];
meantotalEating=[];
meantotalnonEating=[];
for ind = 1:(size(summaryData,1) - 1)
    [NUM,TXT,RAW]=xlsread("Data\eating\" + summaryData(ind+1, 2) + ".csv");
    for i=8:18:size(NUM,1)
    for index=1:size(NUM(i,:),2)
        if(~isnan(NUM(i,index)))
             b =[b NUM(i,index)];
        else
            break;
        end
    end
    minAccEating = [minAccEating min(b)];
    maxAccEating = [maxAccEating max(b)];
    meanaccXF = [meanaccXF mean(b)];
    stdaccXF = [stdaccXF std(b)];
    b = [];
end
for i=9:18:size(NUM,1)
    for index=1:size(NUM(i,:),2)
        if(~isnan(NUM(i,index)))
             b =[b NUM(i,index)];
        else
            break;
        end
    end
    minAccEating = [minAccEating min(b)];
    maxAccEating = [maxAccEating max(b)];
    meanaccYF = [meanaccYF mean(b)];
    stdaccYF = [stdaccYF std(b)];
    b = [];
end
for i=10:18:size(NUM,1)
    for index=1:size(NUM(i,:),2)
        if(~isnan(NUM(i,index)))
             b =[b NUM(i,index)];
        else
            break;
        end
    end
    minAccEating = [minAccEating min(b)];
    maxAccEating = [maxAccEating max(b)];
    meanaccZF = [meanaccZF mean(b)];
    stdaccZF = [stdaccZF std(b)];
    b = [];
end
end
minAccEating = min(minAccEating);
maxAccEating=max(maxAccEating);
totalEating = [meanaccXF; meanaccYF; meanaccZF];
totalEating1 = [stdaccXF; stdaccYF; stdaccZF];
temp = linspace(minAccEating, maxAccEating,size(totalEating,2));
figure,
plot(temp,totalEating');
figure,
temp = linspace(minAccEating, maxAccEating,size(totalEating1,2));
plot(temp,totalEating1');
result=[];


%non-Eating
for ind = 1:(size(summaryData,1) - 1)
    [NUM1,TXT1,RAW1]=xlsread("Data\nonEating\" + summaryData(ind+1, 2) + ".csv");
   for i=8:18:size(NUM1,1)
    for index=1:size(NUM1(1,:),2)
        if(~isnan(NUM1(i,index)))
        a=[a NUM1(i,index)];
        else
            break;
        end
    end
    minAccNon = [minAccNon min(a)];
    maxAccNon = [maxAccNon max(a)];
    meanaccXNF = [meanaccXNF mean(a)];
    stdaccXNF = [stdaccXNF std(a)];
    a = [];
end
for i=9:18:size(NUM1,1)
    for index=1:size(NUM1(1,:),2)
        if(~isnan(NUM1(i,index)))
        a=[a NUM1(i,index)];
        else
            break;
        end
    end
    minAccNon = [minAccNon min(a)];
    maxAccNon = [maxAccNon max(a)];
    meanaccYNF = [meanaccYNF mean(a)];
    stdaccYNF = [stdaccYNF std(a)];

    a = [];
end
for i=10:18:size(NUM1,1)
    for index=1:size(NUM1(1,:),2)
        if(~isnan(NUM1(i,index)))
        a=[a NUM1(i,index)];
        else
            break;
        end
    end
    minAccNon = [minAccNon min(a)];
    maxAccNon = [maxAccNon max(a)];
    meanaccZNF = [meanaccZNF mean(a)];
    stdaccZNF = [stdaccZNF std(a)];
    %stem(accXNF,'Color',[1 0 0]);
    %hold on
    a = [];
end
end
minAccNon = min(minAccNon);
maxAccNon=max(maxAccNon);
figure,
totalnonEating=[meanaccXNF;meanaccYNF;meanaccZNF];
totalnonEating1=[stdaccXNF;stdaccYNF;stdaccZNF];
temp = linspace(minAccNon, maxAccNon,size(totalnonEating,2));
plot(temp,totalnonEating');
figure,
temp = linspace(minAccNon, maxAccNon,size(totalnonEating1,2));
plot(temp,totalnonEating1');
