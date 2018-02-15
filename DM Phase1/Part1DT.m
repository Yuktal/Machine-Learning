precisionE=[];
recallE=[];
F1scoreE=[];
performanceE=[];
ROCe=[];
%i=1;
C=[];
trainfullEating=[];
trainfullNEating=[];
testfullEating=[];
testfullNEating=[];
testfullNEating=[];
testtargetNEating=[];
Trainfull=[];
Testfull=[];
TargetTrainfull=[];
Targettestfull=[];
j=1;
p1prec = [];
p1rec = [];
p1fscore = [];
p1roc = [];
% struct = load("st.mat");
% struct = struct.struct;
% struct60 = load("st60.mat");
% struct60 = struct60.struct60;
% struct40 = load("st40.mat");
% struct40 = struct40.struct40;
% structNon = load("stn.mat");
% structNon = structNon.structNon;
% structNon60 = load("stn60.mat");
% structNon60 = structNon60.structNon60;
% structNon40 = load("stn40.mat");
% structNon40 = structNon40.structNon40;
for i=1:2:length(fieldnames(struct60))

    %training data
    %Eating
    trainE=struct60.(strcat('user',num2str(i)));
    trainEF=struct60.(strcat('user',num2str(i+1)));
    trainEtot=vertcat(trainE,trainEF);
    targettrainEtot=ones(size(trainEtot,1),1);
    %Non-Eating
    trainNE=structNon60.(strcat('user',num2str(i)));
    trainNEF=structNon60.(strcat('user',num2str(i+1)));
    trainNEtot=vertcat(trainNE,trainNEF);
    targettrainNEtot=zeros(size(trainNEtot,1),1);
    %Train total and Target Values
    traintot=vertcat(trainEtot,trainNEtot);
    traintottarget=vertcat(targettrainEtot,targettrainNEtot);
    
    %test data
    %Eating
    testE=struct40.(strcat('user',num2str(i)));
    testEF=struct40.(strcat('user',num2str(i+1)));
    testEtot=vertcat(testE,testEF);
    targettestEtot=ones(size(testEtot,1),1);
    %Non-Eating
    testNE=structNon40.(strcat('user',num2str(i)));
    testNEF=structNon40.(strcat('user',num2str(i+1)));
    testNEtot=vertcat(testNE,testNEF);
    targettestNEtot=zeros(size(testNEtot,1),1);
    %Test total and Target Values
    testtot=vertcat(testEtot,testNEtot);
    testtottarget=vertcat(targettestEtot,targettestNEtot);
    
    %train the Model
    Model=fitctree(traintot,traintottarget);
    %test the Model
    [result,scores]=predict(Model,testtot);
    %[c,cm,ind,per] = confusion(testtottarget,resultsvm);
    [conf,order]=confusionmat(testtottarget,result);
    %c=plotconfusion(testtottarget,resultsvm)
    
    %CM = confusionmat(test_labels,predicted_labels);
     [X,Y,T,ROC] = perfcurve(testtottarget,result,1);
     prec = conf(1,1)/(conf(1,1)+conf(2,1));
     recall = conf(1,1)/(conf(1,1)+conf(1,2));
     fscore = harmmean([prec,recall]);
     
     p1prec(j,1) = prec;
     p1rec(j,1) = recall;
     p1fscore(j,1) = fscore;
     p1roc(j,1) = ROC;
     j = j+1;
end


 


