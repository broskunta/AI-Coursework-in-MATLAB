%% CourseWork Section 2: 3 outputs.
clear all

%%
 load cleveland_heart_disease_dataset_labelled.mat

%% Load data
patterns = x;
targets = t';

%% Normalize data set

%pt = normalize(patterns,'range');
pt = (patterns - min(patterns)) ./ (max(patterns) - min(patterns));
pt_norm = pt';

%% create new table - combine two inputs and output together
newtag = [pt,t];
%% separate data based on output in column 14.
sorted_d = sortrows(newtag,14);


%% select data
zeros_array = sorted_d(1:160,1:13);
ones_array = sorted_d(161:249,1:13);
twos_array = sorted_d(250:end,1:13);
target = sorted_d(:,14);
%% create complete data but sorted

data = cat(1,zeros_array,ones_array,twos_array);
data = data';
data_targets = target;



%% Replace data in column 14 with the correct labels then change the labels 
% to something that can be used for hot encoding

% Convert targets to categorical array
data_target = categorical(data_targets, [0 1 2], {'normal' 'mild heart disease' 'severe heart disease'});
%test_set_target = categorical(test_set_target, [0 1 2], {'normal' 'mild heart disease' 'severe heart disease'});
d_target = data_target;
d_tar = onehotencode(d_target,2);
tar = d_tar';

%% design network using the train data.
net = feedforwardnet([20]);

% Set training algorithm
net.trainFcn = 'trainlm';

%
%net.divideFcn = 'dividetrain';

% Set activation function for hidden layers
% Set activation function for hidden layers
net.layers{1}.transferFcn = 'logsig';
% net.layers{2}.transferFcn = 'tansig';
% net.layers{3}.transferFcn = 'logsig';
net.layers{end}.transferFcn = 'tansig';

%set training fuction and ratios
[trainInd,valInd,testInd] = dividerand(297,0.8,0.1,0.1);

% net.divideFcn = 'dividerand';
% net.divideParam.trainRatio = 0.8;
% net.divideParam.valRatio = 0.1;
% net.divideParam.testRatio = 0.1;

% Choose an evaluation metrics (mae, mse)
net.performFcn = 'mse';
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotroc', 'plotconfusion'};

% Set number of epochs for training
net.trainParam.epochs = 1000;
%% Train network
[net,tr] = train(net, data, tar);

%% Test network next part

predict = sim(net,data);
%% Plot confusion
figure;
plotconfusion(tar, predict)


