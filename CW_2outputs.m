%%New Code for the data. two classes normal and disease.
clear all

%%
 
load cleveland_heart_disease_dataset_labelled.mat

%%
T = table(x,t);
B = table2array(T);
Table1 = array2table(B);
Table2 = renamevars(Table1, {'B1','B2','B3','B4','B5','B6','B7','B8','B9','B10','B11','B12','B13','B14'}, ...
    {'Age','Sex','CP','Trestbps','Chol','fbs','restecg', ...
    'thalach','exang','oldpeak','slope','ca','thal','target'});
%% combine data and draw new plots.

%create a new table
Table3 = Table2;

% change variable 2 in table3.target to 1 making the class type now "with
% disease' and 'without disease'
Table3.target(Table3.target == 2) = 1;

%% select data zeros and ones.

data = table2array(Table3);
% sorted data in table 3
sorted_d = data;

%% patterns and targets
patterns = sorted_d(:,1:13)';
target = sorted_d(:,14)';
%% design network using the train data.
net = feedforwardnet([6 3 3]);

% Set training algorithm
net.trainFcn = 'trainlm';

%

net.divideFcn = 'divideblock';
net.divideParam.trainRatio = 0.7;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;

% Set activation function for hidden layers
% Set activation function for hidden layers
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'poslin';
net.layers{end}.transferFcn = 'logsig';

% Choose an evaluation metrics (mae, mse)
net.performFcn = 'mse';
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotconfusion', 'plotroc'};

% Set number of epochs for training
net.trainParam.epochs = 1000;

%% select data from training



%% Train network
[net,tr] = train(net, patterns, target);

%% Test network next part
