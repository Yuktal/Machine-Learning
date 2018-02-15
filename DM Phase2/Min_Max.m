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
    %stem(accXF,'Color',[0 1 0]);
    %hold on
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
totalDiffE = [diffAccXE;  diffAccYE; diffAccZE];
temp = linspace(minAccEating, maxAccEating,size(totalDiffE,2));
figure,
plot(temp,totalDiffE);


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
        %stem(accXNF,'Color',[1 0 0]);
        %hold on
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
        %stem(accXNF,'Color',[1 0 0]);
        %hold on
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
        %stem(accXNF,'Color',[1 0 0]);
        %hold on
        a = [];
    end
    end
minAccNon = min(minAccNon);
maxAccNon=max(maxAccNon);
totalDiffNE = [diffAccXNE; diffAccYNE; diffAccZNE];
temp = linspace(minAccNon, maxAccNon,size(totalDiffNE,2));
figure,
plot(temp,totalDiffNE);

