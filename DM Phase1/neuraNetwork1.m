totaEating=[];
totalNonEating = [];
out1=[];
out2=[];
total=[];
output=[];
inputs=[];
targets = [];
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
%     newName = strcat('user',num2str(1));
%     totalEating1 = [struct.(newName)];
%     totalNonEating1 = [structNon.(newName)];
%     out1 = ones(size(struct.(newName)));
%     out2 = zeros(size(structNon.(newName)));
%     total1 = [totalEating1;totalNonEating1];
%     output = [out1;out2];
for i=1:65
    newName = strcat('user',num2str(i));
    totalEating = [struct.(newName)];
    totalNonEating = [structNon.(newName)];
    sizeVal = size(struct.(newName),1);
    out1 = ones(sizeVal,1);
    sizeVal1 = size(structNon.(newName),1)
    out2 = zeros(sizeVal1,1);
    total = [total;totalEating;totalNonEating];
    output = [output;out1;out2];

end
inputs = total';
targets = output';

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = feedforwardnet(hiddenLayerSize);


% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 30/100;
% net.divideParam.valRatio = 35/100;
net.divideParam.testRatio = 70/100;


% Train the Network
 [net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

simpleclusterOutputs = sim(net,inputs);
plotroc(targets,targets);

% View the Network
view(net)   
outputs1 = round(outputs);
conf = confusionmat(targets', outputs1);
prec = conf(1,1)/(conf(1,1)+conf(2,1))
% accu = confusion.accuracy
% prec = confusion.precision
figure, f =plotconfusion(targets,outputs);
