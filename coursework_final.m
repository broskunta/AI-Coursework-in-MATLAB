%% CourseWork Standardization code not good code.
%clean screen
% clc
% clear all
clear all
load cleveland_heart_disease_dataset_labelled.mat
%% Load data

patterns = x;
targets = t';

%% normalize data set
pt = (patterns - min(patterns)) ./ (max(patterns) - min(patterns));
pt_norm = pt';
%pt_norm = normalize(patterns,'range')';


%% one hot encoding for the output
lab = categorical(labels);
tar = onehotencode(lab,2);

%% finished data
p1 = pt_norm;
t1 = tar';

% %% design 
% net = feedforwardnet([10 7 5]);
% 
% % Set training algorithm
% net.trainFcn = 'trainlm';
% 
% % Set activation function for hidden layers
% net.layers{1}.transferFcn = 'logsig';
% net.layers{2}.transferFcn = 'tansig';
% net.layers{3}.transferFcn = 'softmax';
% 
% % Choose an evaluation metrics (mae, mse)
% net1.performFcn = 'mse';
% net1.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotfit', 'plotconfusion', 'plotroc'};
%  
% 
% % Set number of epochs for training
% net.trainParam.epochs = 10000;
% 
% 
% %% train network
% 
% % for i = 1:10
% %     net = train(net, pt_norm, targets);
% % end
% 
% [net,tr] = train(net, p1, t1);
% 
% %% test network
% output = sim(net,pt_norm);
% output = round(output);
% 
% %% 
% 
% accuracy = sum(output==t1)/numel(t1) *100;
% %formatspec = 'The model accuracy is %accuracyf';
% fprintf("The model accuracy is %.2f%%\n", accuracy);
% %fprintf(formatspec,accuracy);
% 
% %% plot confusion
% %plotconfusion(targets,output);

%% design 
net = feedforwardnet([10 7 5]);

% Set training algorithm
net.trainFcn = 'traingd';

% Set activation function for hidden layers
net.layers{1}.transferFcn = 'poslin';
net.layers{2}.transferFcn = 'poslin';
net.layers{3}.transferFcn = 'poslin';
net.layers{end}.transferFcn = 'purelin';

% Choose an evaluation metrics (mae, mse)
net.performFcn = 'mse';
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotfit', 'plotconfusion', 'plotroc'};

% Set number of epochs for training
net.trainParam.epochs = 10000;

%% train network
[net,tr] = train(net, p1, t1);

%% test network
output = sim(net,pt_norm);
%output = round(output);

%% calculate accuracy
predicted_labels = decode(onehotdecode(output));
true_labels = decode(onehotdecode(t1));
accuracy = sum(predicted_labels == true_labels)/numel(true_labels) * 100;
fprintf("The model accuracy is %.2f%%\n", accuracy);
