%% Artificial Intelligence Code
clear all

%%
 load cleveland_heart_disease_dataset_labelled.mat

%% Load data
patterns = x;
targets = t;

%% Normalize data set
pt = normalize(patterns,'range');
%pt = patterns;
%pt = (patterns - min(patterns)) ./ (max(patterns) - min(patterns));
norm_patterns = pt';

%% One-hot encoding for the output
lab = categorical(targets,[0 1 2],{'normal','mild','severe'});
target = onehotencode(lab, 2);


%% design network using the train data.
net = feedforwardnet([20]);

% Set training algorithm
net.trainFcn = 'trainlm';

% set data block
[trainInd,valInd,testInd] = dividerand(297,0.8,0.1,0.1);
%net.divideFcn = 'dividetrain';

% Set activation function for hidden layers
% Set activation function for hidden layers
net.layers{1}.transferFcn = 'logsig';
%net.layers{2}.transferFcn = 'logsig';
% net.layers{3}.transferFcn = 'logsig';
net.layers{end}.transferFcn = 'tansig';

% Choose an evaluation metrics (mae, mse)
net.performFcn = 'mse';
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotconfusion', 'plotroc'};


%% Train network
[net,tr] = train(net, norm_patterns, target');

%% Test network next part
predict = sim(net,norm_patterns);

%% Plot confusion
figure;
plotconfusion(target', predict)




