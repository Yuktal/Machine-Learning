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
Part1prec=[];
Part1recall=[];
Part1fscore=[];
Part1ROC=[];
j=1;
struct = load("st.mat");
struct = struct.struct;
struct60 = load("st60.mat");
struct60 = struct60.struct60;
struct40 = load("st40.mat");
struct40 = struct40.struct40;
structNon = load("stn.mat");
structNon = structNon.structNon;
structNon60 = load("stn60.mat");
structNon60 = structNon60.structNon60;
structNon40 = load("stn40.mat");
structNon40 = structNon40.structNon40;
%Part 1

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
    testEtot=vertcat(trainE,trainEF);
    targettestEtot=ones(size(trainEtot,1),1);
    %Non-Eating
    testNE=structNon40.(strcat('user',num2str(i)));
    testNEF=structNon40.(strcat('user',num2str(i+1)));
    testNEtot=vertcat(testNE,testNEF);
    targettestNEtot=zeros(size(testNEtot,1),1);
    %Test total and Target Values
    testtot=vertcat(testEtot,testNEtot);
    testtottarget=vertcat(targettestEtot,targettestNEtot);
    
    %train the Model
    SVMModel=fitcsvm(traintot,traintottarget);
    %test the Model
    [resultsvm,scoresvm]=predict(SVMModel,testtot);
    %[c,cm,ind,per] = confusion(testtottarget,resultsvm);
    [conf,order]=confusionmat(testtottarget,resultsvm);
    %c=plotconfusion(testtottarget,resultsvm)
    
    %CM = confusionmat(test_labels,predicted_labels);
     [X,Y,T,ROC] = perfcurve(testtottarget,resultsvm,1);
     prec = conf(1,1)/(conf(1,1)+conf(2,1));
     recall = conf(1,1)/(conf(1,1)+conf(1,2));
     fscore = harmmean([prec,recall]);
     
     
     Part1prec(j,1)=prec;
     Part1recall(j,1)=recall;
     Part1fscore(j,1)=fscore;
     Part1ROC(j,1)=ROC;
     j=j+1;
    
end




%Part 2 
for i=1:21
    trainfullEating=vertcat(trainfullEating,struct.(strcat('user',num2str(i))));
    trainfullNEating=vertcat(trainfullNEating,structNon.(strcat('user',num2str(i)))); 
end
traintargetEating=ones(size(trainfullEating,1),1);
traintargetNEating=zeros(size(trainfullNEating,1),1);

for i=22:66
    testfullEating=vertcat(testfullEating,struct.(strcat('user',num2str(i))));
    testfullNEating=vertcat(testfullNEating,structNon.(strcat('user',num2str(i)))); 
end
testtargetEating=ones(size(testfullEating,1),1);
testtargetNEating=zeros(size(testfullNEating,1),1);


%Train and Test Data for the Second Part
Trainfull=vertcat(trainfullEating,trainfullNEating);
Testfull=vertcat(testfullEating,testfullNEating);

%Targets for the train and the Test for Second Part
TargetTrainfull=vertcat(traintargetEating,traintargetNEating);
Targettestfull=vertcat(testtargetEating,testtargetNEating);



    SVMModelPart2=fitcsvm(Trainfull,TargetTrainfull);
    %test the Model
    [resultsvmPart2,scoresvmPart2]=predict(SVMModel,Testfull);
    %[c,cm,ind,per] = confusion(testtottarget,resultsvm);
    [confPart2,orderPart2]=confusionmat(Targettestfull,resultsvmPart2);
    [X2,Y2,T2,ROC2] = perfcurve(Targettestfull,resultsvmPart2,1);
    prec2 = confPart2(1,1)/(confPart2(1,1)+confPart2(2,1));
    recall2 = confPart2(1,1)/(confPart2(1,1)+confPart2(1,2));
    fscore2 = harmmean([prec2,recall2]);


