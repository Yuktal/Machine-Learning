summaryData = xlsread('Data/summary.csv');
 a=[];
 b=[];
 diff = 0;
 accXF= [];
accXNF = [];
rmsaccXF=[];
rmsaccXNF=[];
meanaccXF=[];
meanaccXNF=[];
stdaccXF=[];
stdaccXNF=[];
accYF= [];
accYNF = [];
rmsaccYF=[];
rmsaccYNF=[];
meanaccYF=[];
meanaccYNF=[];
stdaccYF=[];
stdaccYNF=[];
accZF= [];
accZNF = [];
rmsaccZF=[];
rmsaccZNF=[];
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
newMatrix = [];
newMatrixNon= [];
diffAccXE = [];
diffAccYE = [];
diffAccZE = [];
diffAccXNE = [];
diffAccYNE = [];
diffAccZNE = [];
for ind = 1:(size(summaryData,1) - 1)
    [NUM,TXT,RAW]=xlsread("Data\eating\" + summaryData(ind+1, 2) + ".csv");
    for i=5:18:size(NUM,1)
    for index=1:size(NUM(i,:),2)
        if(~isnan(NUM(i,index)))
             b =[b NUM(i,index)];
        else
            break;
        end
    end
    minAccEating = [minAccEating min(b)];
    maxAccEating = [maxAccEating max(b)];
    diff = max(b)-min(b);
    diffAccXE = [diffAccXE diff];
    accXF = [accXF max(fft(b))];
    rmsaccXF = [rmsaccXF rms(b)];
    meanaccXF = [meanaccXF mean(b)];
    stdaccXF = [stdaccXF std(b)];
    b = [];
end
for i=6:18:size(NUM,1)
    for index=1:size(NUM(i,:),2)
        if(~isnan(NUM(i,index)))
             b =[b NUM(i,index)];
        else
            break;
        end
    end
    minAccEating = [minAccEating min(b)];
    maxAccEating = [maxAccEating max(b)];
    diff = max(b)-min(b);
    diffAccYE = [diffAccYE diff];
    accYF = [accYF max(fft(b))];
    rmsaccYF = [rmsaccYF rms(b)];
    meanaccYF = [meanaccYF mean(b)];
    stdaccYF = [stdaccYF std(b)];
    b = [];
end
for i=7:18:size(NUM,1)
    for index=1:size(NUM(i,:),2)
        if(~isnan(NUM(i,index)))
             b =[b NUM(i,index)];
        else
            break;
        end
    end
    minAccEating = [minAccEating min(b)];
    maxAccEating = [maxAccEating max(b)];
    diff = max(b)-min(b);
    diffAccZE = [diffAccZE diff];
    accZF = [accZF max(fft(b))];
    rmsaccZF = [rmsaccZF rms(b)];
    meanaccZF = [meanaccZF mean(b)];
    stdaccZF = [stdaccZF std(b)];
    b = [];
end
end
minAccEating = min(minAccEating);
maxAccEating=max(maxAccEating);
finalSize = size(accXF,2);
totalEating = [accXF; accYF; accZF; rmsaccXF(1,1:finalSize); rmsaccYF(1,1:finalSize); rmsaccZF(1,1:finalSize); stdaccXF(1,1:finalSize); stdaccYF(1,1:finalSize); stdaccZF(1,1:finalSize); meanaccXF(1,1:finalSize); meanaccYF(1,1:finalSize); meanaccZF(1,1:finalSize);diffAccXE(1,1:finalSize);  diffAccYE(1,1:finalSize); diffAccZE(1,1:finalSize)];
temp = linspace(minAccEating, maxAccEating,size(totalEating,2));
plot(temp,totalEating');
title("Eating action: Feature matrix");
result = pca(totalEating');
temp = linspace(minAccEating, maxAccEating,size(result,2));
figure,
plot(temp,result);
title("Eating action: Eigen vectors");
newMatrix = result*totalEating;
temp = linspace(minAccEating, maxAccEating,size(newMatrix,2));
figure,
plot(temp, newMatrix');
title("Eating action: New Feature matrix");

%non-Eating
for ind = 1:(size(summaryData,1) - 1)
    [NUM1,TXT1,RAW1]=xlsread("Data\nonEating\" + summaryData(ind+1, 2) + ".csv");
   for i=5:18:size(NUM1,1)
    for index=1:size(NUM1(1,:),2)
        if(~isnan(NUM1(i,index)))
        a=[a NUM1(i,index)];
        else
            break;
        end
    end
    minAccNon = [minAccNon min(a)];
    maxAccNon = [maxAccNon max(a)];
    diff = max(a)-min(a);
    diffAccXNE = [diffAccXNE diff];
    accXNF = [accXNF max(fft(a))];
    rmsaccXNF = [rmsaccXNF rms(a)]; 
    meanaccXNF = [meanaccXNF mean(a)];
    stdaccXNF = [stdaccXNF std(a)];
    a = [];
end
for i=6:18:size(NUM1,1)
    for index=1:size(NUM1(1,:),2)
        if(~isnan(NUM1(i,index)))
        a=[a NUM1(i,index)];
        else
            break;
        end
    end
    minAccNon = [minAccNon min(a)];
    maxAccNon = [maxAccNon max(a)];
    diff = max(a)-min(a);
    diffAccYNE = [diffAccYNE diff];
    accYNF = [accYNF max(fft(a))];
    rmsaccYNF = [rmsaccYNF rms(a)]; 
    meanaccYNF = [meanaccYNF mean(a)];
    stdaccYNF = [stdaccYNF std(a)];
    a = [];
end
for i=7:18:size(NUM1,1)
    for index=1:size(NUM1(1,:),2)
        if(~isnan(NUM1(i,index)))
        a=[a NUM1(i,index)];
        else
            break;
        end
    end
    minAccNon = [minAccNon min(a)];
    maxAccNon = [maxAccNon max(a)];
    diff = max(a)-min(a);
    diffAccZNE = [diffAccZNE diff];
    accZNF = [accZNF max(fft(a))];
    rmsaccZNF = [rmsaccZNF rms(a)]; 
    meanaccZNF = [meanaccZNF mean(a)];
    stdaccZNF = [stdaccZNF std(a)];
    a = [];
end
end
minAccNon = min(minAccNon);
maxAccNon=max(maxAccNon);
finalSize = size(accXNF,2);
totalnonEating=[accXNF; accYNF; accZNF; rmsaccXNF(1,1:finalSize); rmsaccYNF(1,1:finalSize); rmsaccZNF(1,1:finalSize); stdaccXNF(1,1:finalSize); stdaccYNF(1,1:finalSize); stdaccZNF(1,1:finalSize); meanaccXNF(1,1:finalSize); meanaccYNF(1,1:finalSize); meanaccZNF(1,1:finalSize);diffAccXNE(1,1:finalSize); diffAccYNE(1,1:finalSize); diffAccZNE(1,1:finalSize)];
temp = linspace(minAccNon,maxAccNon,size(totalnonEating,2));
figure,
plot(temp,totalnonEating');
title("Non Eating action: Feature matrix");
result1=[];
result1 = pca(totalnonEating');
temp = linspace(minAccNon, maxAccNon, size(result,2));
figure,
plot(temp,result1);
title("Non Eating action: Eigen vactors");
newMatrixNon = result*totalnonEating;
temp = linspace(minAccNon,maxAccNon,size(newMatrixNon,2));
figure,
plot(temp, newMatrixNon');
title("Non Eating action: New Feature matrix");

%Error plots
errorPlot=[];
errorPlot=newMatrix-totalEating;
temp = linspace(minAccEating, maxAccEating,size(errorPlot,2));
figure,
plot(temp,abs(errorPlot));
title("Error Plot for Eating data");

errorPlotnon=[];
errorPlotnon = newMatrixNon-totalnonEating;
temp = linspace(minAccNon, maxAccNon, size(errorPlotnon,2));
figure,
plot(temp, abs(errorPlotnon));
