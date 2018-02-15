summaryData = xlsread('Data/summary.csv');
 a=[];
 b=[];
 accXF= [];
accXNF = [];
rmsaccXF=[];
rmsaccXNF=[];
accYF= [];
accYNF = [];
rmsaccYF=[];
rmsaccYNF=[];
accZF= [];
accZNF = [];
rmsaccZF=[];
rmsaccZNF=[];
totalEating = [];
totalnonEating = [];
totalEating1 = [];
totalnonEating1 = [];
minAccEating= [];
maxAccEating=[];
minAccNon=[];
maxAccNon=[];
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
        accXF = [accXF max(fft(b))];
        rmsaccXF = [rmsaccXF rms(b)];
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
        accYF = [accYF max(fft(b))];
        rmsaccYF = [rmsaccYF rms(b)];

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
        accZF = [accZF max(fft(b))];
        rmsaccZF = [rmsaccZF rms(b)];

        b = [];
    end
end
minAccEating = min(minAccEating);
maxAccEating=max(maxAccEating);
totalEating = [accXF; accYF; accZF];
totalEating1 = [rmsaccXF; rmsaccYF; rmsaccZF];
temp = linspace(minAccEating, maxAccEating,size(totalEating,2));
figure,
plot(temp,totalEating');
title("Eating: FFT");
figure,
temp = linspace(minAccEating, maxAccEating,size(totalEating1,2));
plot(temp,totalEating1');
title("Eating: RMS");
result=[];


%non-Eating
for ind = 5:(size(summaryData,1) - 1)
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
        accXNF = [accXNF max(fft(a))];
        rmsaccXNF = [rmsaccXNF rms(a)]; 
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
        accYNF = [accYNF max(fft(a))];
        rmsaccYNF = [rmsaccYNF rms(a)]; 
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
        accZNF = [accZNF max(fft(a))];
        rmsaccZNF = [rmsaccZNF rms(a)]; 
        a = [];
    end
end
minAccNon = min(minAccNon);
maxAccNon=max(maxAccNon);
figure,
totalnonEating=[accXNF;accYNF;accZNF];
totalnonEating1=[rmsaccXNF;rmsaccYNF;rmsaccZNF];
temp = linspace(minAccNon, maxAccNon,size(totalnonEating,2));
plot(temp,totalnonEating');
title("Non Eating: FFT");
figure,
temp = linspace(minAccNon, maxAccNon,size(totalnonEating1,2));
plot(temp,totalnonEating1');
title("Non Eating: RMS");