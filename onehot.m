%% CourseWork Standardization code
%clean screen
% clc
% clear all
clear all
load cleveland_heart_disease_dataset_labelled.mat
%% Load data

patterns = x;
targets = t;
target = t';

%% normalize all data tabs 14 of them in 14 new  using the min-max normalization technique
patterns_norm = (patterns - min(patterns)) ./ (max(patterns) - min(patterns));

%% create table = the 14 new variables then assign this table to inputs.

dataIn = array2table([patterns_norm targets]);

%% Sort data table using targets so that we can select the same number of output class. 
%from the histogram of the data, the lowest class is the 2nd class with 48
%data points. This means that we will then sort the data then selects the
%inputs to be a new table of 48 * 3 data points with an equal distribution
%for all classes/

sortedtable = sortrows(dataIn,'Var14');

%% Pick sorted data.

%first convert table to array for easier selection
cdata = table2array(sortedtable);

%% select the equal number of classes from the data
class0 = cdata(1:48,:);
class1 = cdata(161:209,:);
class2 = cdata(250:297,:);

%% combine all classes to one array comprising of 48*3 elements
trainData = cat(1,class0,class1,class2);
%testData = setdiff(sortedtable,trainData);

%% Now that the data is okay, we can now start designing the network.
%%
%Select input training data

inputs = trainData(:,1:13)';
output = trainData(:,14)';

%% design neural net

mynet = feedforwardnet([15 10 5]);

mynet.trainFcn = 'trainlm';
mynet.divideFcn = 'dividetrain';

% Set activation function for hidden layers
mynet.layers{1}.transferFcn = 'logsig';
mynet.layers{2}.transferFcn = 'tansig';
mynet.layers{3}.transferFcn = 'logsig';

%%set output function. Softmax is better for multivariate data
mynet.layers{end}.transferFcn = 'softmax';
%% choose evaluation metrics
% mynet.performFcn = 'mse';
% mynet.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotfit', 'plotconfusion', 'plotroc'};

%% Train the network
for i = 1:10
    mynet = train(mynet,inputs, output);
end

%% simulate the results.

% simulate the network
testOutput = sim(mynet,patterns_norm');

%% check results

% decode one-hot encoding of target labels
[~, target_decoded] = max(target,[],2);
[~, testOutput_decoded] = max(testOutput,[],2);

accuracy = sum(testOutput_decoded' == target_decoded) / numel(target_decoded)*100;

%% Print the accuracy as a percentage
fprintf("The model accuracy is %.2f%%\n", accuracy);

%% Plot confusion matrix
% figure;
% plotconfusion(target', testOutput);
