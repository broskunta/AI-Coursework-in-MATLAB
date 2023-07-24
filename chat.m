%% CourseWork Standardization code
clear all

%% Load data
load cleveland_heart_disease_dataset_labelled.mat
patterns = x;
targets = t';

%% Normalize data set
pt = normalize(patterns,'range');
pt_norm = pt';

%% One-hot encoding for the output
lab = categorical(labels);
tar = onehotencode(lab, 2);

%% Create new table - combine two inputs and output together
newtag = [pt,t];

%% Separate data based on output in column 14.
sorted_d = sortrows(newtag,14);

%% Stratified sampling
cv = cvpartition(sorted_d(:,14),'Holdout',0.2,'Stratify',true);
training_set = sorted_d(training(cv),:);
test_set = sorted_d(test(cv),:);

%% Replace data in column 14 with the correct labels then change the labels to something that can be used for hot encoding
training_set_target = training_set(:,14);
test_set_target = test_set(:,14);

% Convert targets to categorical array
training_set_target = categorical(training_set_target, [0 1 2], {'normal' 'mild heart disease' 'severe heart disease'});
test_set_target = categorical(test_set_target, [0 1 2], {'normal' 'mild heart disease' 'severe heart disease'});

% One-hot encoding for the training and test sets
en_train = onehotencode(training_set_target, 2);
en_test = onehotencode(test_set_target, 2);

%% Design network using the train data.
net = feedforwardnet([6 3]);

% Set training algorithm
net.trainFcn = 'trainlm';

%
net.divideFcn = 'dividetrain';

% Set activation function for hidden layers
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';
net.layers{3}.transferFcn = 'softmax';

% Choose an evaluation metrics (mae, mse)
net.performFcn = 'mse';
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotfit', 'plotconfusion', 'plotroc'};

% Set number of epochs for training
net.trainParam.epochs = 1000;

%% Select data from training
training_pattern = training_set(:,1:13)';
training_target = en_train';

%% Train network
[net,tr] = train(net, training_pattern, training_target);

%% Test network
test_set_pattern = test_set(:,1:13)';
predict = sim(net,test_set_pattern);

%% Plot confusion
figure;
plotconfusion(en_test', predict)

%% Compute accuracy
% accuracy = sum(predicted_labels == labels') / numel(labels) * 100;
% fprintf("The model accuracy is %.2f%%\n", accuracy);
