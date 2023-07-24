%% CourseWork Standardization code
clc
clear all

load cleveland_heart_disease_dataset_labelled.mat

patterns = x;
targets = t;
%% Normalize data
patterns_norm = (patterns - min(patterns)) ./ (max(patterns) - min(patterns));

%% Split data into training and testing sets
[trainInd,valInd,testInd] = dividerand(size(patterns_norm,1),0.6,0.2,0.2);
inputs_train = patterns_norm(trainInd,:)';
targets_train = t(trainInd,:)';
inputs_val = patterns_norm(valInd,:)';
targets_val = t(valInd,:)';
inputs_test = patterns_norm(testInd,:)';
targets_test = t(testInd,:)';

%% Design neural net
net = feedforwardnet([10 5]);

% Set training algorithm
net.trainFcn = 'trainlm';

% Set activation function for hidden layers
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';

% Choose an evaluation metrics (mae, mse)
net.performFcn = 'mse';
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotfit', 'plotconfusion', 'plotroc'};

% Set number of epochs for training
net.trainParam.epochs = 10000;


%% Train the network
[net,tr] = train(net,inputs_train, targets_train, 'useParallel', 'yes');

%% Test the network
outputs = sim(net,inputs_test);
accuracy = sum(round(outputs) == targets_test) / numel(targets_test);
fprintf('Accuracy: %.2f%%\n', accuracy*100);
