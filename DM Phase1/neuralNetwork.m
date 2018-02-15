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
prec=[];
recall=[];
fscore=[];
for i= 1:2:66
    output = [];
    totalEating = [];
newName = strcat('user',num2str(i));
 div1 = floor(size(struct.(newName),1)*0.6);
 div2 = floor(size(structNon.(newName),1)*0.6);
totalEating = [struct.(newName)(1:div1,:); structNon.(newName)(1:div2,:);struct.(newName)(div1+1:end,:);structNon.(newName)(div2+1:end,:)];

sizeVal = size(struct.(newName),1);
out1 = ones(sizeVal,1);
sizeVal1 = size(structNon.(newName),1);
out2 = zeros(sizeVal1,1);
output = [out1(1:div1,:);out2(1:div2,:);out1(div1+1:end,:);out2(div2+1:end,:)];

%fork
newName = strcat('user',num2str(i+1));
 div1 = floor(size(struct.(newName),1)*0.6);
 div2 = floor(size(structNon.(newName),1)*0.6);
totalEating = [totalEating; struct.(newName)(1:div1,:); structNon.(newName)(1:div2,:);struct.(newName)(div1+1:end,:);structNon.(newName)(div2+1:end,:)];

sizeVal = size(struct.(newName),1);
out1 = ones(sizeVal,1);
sizeVal1 = size(structNon.(newName),1);
out2 = zeros(sizeVal1,1);
output = [output; out1(1:div1,:);out2(1:div2,:);out1(div1+1:end,:);out2(div2+1:end,:)];



inputs = totalEating';
targets = output';



% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = feedforwardnet(hiddenLayerSize);
% net.layers{1}.transferFcn = 'logsig';
%net.layers{2}.transferFcn = 'logsig';
% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 60/100;
% net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 40/100;


% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
%outputs = floor(abs(outputs));
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);
% View the Network`
view(net);
outputs1 = round(outputs);
conf = confusionmat(targets', outputs1');
prec = [prec conf(1,1)/(conf(1,1)+conf(2,1))]
recall = [recall conf(1,1)/(conf(1,1)+conf(1,2))]
fscore = [fscore harmmean([prec,recall])]
% confusion = confusionmatStats(targets, outputs);
% prec = max(confusion.precision)
% rec = max(confusion.recall)
% f1 = max(confusion.Fscore)
figure, f =plotconfusion(targets,outputs);
end