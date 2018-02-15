summaryData = xlsread('Data/summary.csv');
 a=[];b=[];
temp=[];
%Eating
minAccEating= [];
maxAccEating=[];
diffAccXE = [];
diffAccYE = [];
diffAccZE = [];
accXF= [];
accYF= [];
accZF= [];
 rmsaccXF=[];
 rmsaccYF=[];
 rmsaccZF=[];
 meanaccXF=[];
 meanaccYF=[];
 meanaccZF=[];
 stdaccXF=[];
 stdaccYF=[];
 stdaccZF=[];
 
diff = 0;

accXNF = [];
rmsaccXNF=[];
meanaccXNF=[];
stdaccXNF=[];
accYNF = [];
rmsaccYNF=[];
meanaccYNF=[];
stdaccYNF=[];
accZNF = [];
rmsaccZNF=[];
meanaccZNF=[];
stdaccZNF=[];
minAccNon=[];
maxAccNon=[];
diffAccXNE = [];
diffAccYNE = [];
diffAccZNE = [];



newMatrix = [];
newMatrixNon= [];
totalEating = [];
totalnonEating = [];
totalEating1 = [];
totalnonEating1 = [];
meantotalEating=[];
meantotalnonEating=[];


for ind = 1:(size(summaryData,1))
    [NUM,TXT,RAW]=xlsread("Data\eating\" + summaryData(ind, 2) + ".csv");

    [minAccEating, maxAccEating, diffAccXE, accXF, rmsaccXF, meanaccXF, stdaccXF] = featureExtractor(5, NUM);
    [minAccEating, maxAccEating, diffAccYE, accYF, rmsaccYF, meanaccYF, stdaccYF] = featureExtractor(6, NUM);
    [minAccEating, maxAccEating, diffAccZE, accZF, rmsaccZF, meanaccZF, stdaccZF] = featureExtractor(7, NUM);
    finalSize = size(accXF,2);
    totalEating = [accXF; accYF; accZF; rmsaccXF(1,1:finalSize); rmsaccYF(1,1:finalSize); rmsaccZF(1,1:finalSize); stdaccXF(1,1:finalSize); stdaccYF(1,1:finalSize); stdaccZF(1,1:finalSize); meanaccXF(1,1:finalSize); meanaccYF(1,1:finalSize); meanaccZF(1,1:finalSize);diffAccXE(1,1:finalSize);  diffAccYE(1,1:finalSize); diffAccZE(1,1:finalSize)];
    norm_mat = totalEating - min(totalEating);
    norm_mat = norm_mat./max(norm_mat(:));
    result = pca(norm_mat');
    newMatrix = totalEating'*result;
    newName = strcat('user',num2str(ind));
    div = floor(size(newMatrix,1)*0.6);
    newMatrix = abs(newMatrix);  
    struct.(newName)=newMatrix;
    struct60.(newName) = newMatrix(1:div,:);
    struct40.(newName) = newMatrix(div+1:end,:);
end

%non-Eating
for ind = 1:(size(summaryData,1))
    [NUM1,TXT1,RAW1]=xlsread("Data\nonEating\" + summaryData(ind, 2) + ".csv");
    
    [minAccNon, maxAccNon, diffAccXNE, accXNF, rmsaccXNF, meanaccXNF, stdaccXNF] = featureExtractor(5, NUM1);
    [minAccNon, maxAccNon, diffAccYNE, accYNF, rmsaccYNF, meanaccYNF, stdaccYNF] = featureExtractor(6, NUM1);
    [minAccNon, maxAccNon, diffAccZNE, accZNF, rmsaccZNF, meanaccZNF, stdaccZNF] = featureExtractor(7, NUM1);
    finalSize = size(accXNF,2);
    totalnonEating=[accXNF; accYNF; accZNF; rmsaccXNF(1,1:finalSize); rmsaccYNF(1,1:finalSize); rmsaccZNF(1,1:finalSize); stdaccXNF(1,1:finalSize); stdaccYNF(1,1:finalSize); stdaccZNF(1,1:finalSize); meanaccXNF(1,1:finalSize); meanaccYNF(1,1:finalSize); meanaccZNF(1,1:finalSize);diffAccXNE(1,1:finalSize); diffAccYNE(1,1:finalSize); diffAccZNE(1,1:finalSize)];
    norm_mat = totalnonEating - min(totalnonEating);
    norm_mat = norm_mat./max(norm_mat(:));
    result = pca(norm_mat');
    newMatrixNon = totalnonEating'*result;
    newName = strcat('user',num2str(ind));
    div = floor(size(newMatrixNon,1)*0.6);
    newMatrixNon = abs(newMatrixNon);
    structNon.(newName) = newMatrixNon;
    structNon60.(newName) = newMatrixNon(1:div,:);
    structNon40.(newName) = newMatrixNon(div+1:end,:);
end
