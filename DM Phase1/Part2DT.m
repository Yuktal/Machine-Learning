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

ModelPart2=fitctree(Trainfull,TargetTrainfull);
%test the Model
[resultPart2,scorePart2]=predict(ModelPart2,Testfull);

[confPart2,orderPart2]=confusionmat(Targettestfull,resultPart2);
[X2,Y2,T2,ROC2] = perfcurve(Targettestfull,resultPart2,1);
prec2 = confPart2(1,1)/(confPart2(1,1)+confPart2(2,1));
recall2 = confPart2(1,1)/(confPart2(1,1)+confPart2(1,2));
fscore2 = harmmean([prec2,recall2]);
