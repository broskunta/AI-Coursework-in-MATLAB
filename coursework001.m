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
% p1 = ((patterns(:,1) - min(patterns(:,1))))./(max(patterns(:,1))-min(patterns(:,1)));
% p2 = ((patterns(:,2) - min(patterns(:,2))))./(max(patterns(:,2))-min(patterns(:,2)));
% p3 = ((patterns(:,3) - min(patterns(:,3))))./(max(patterns(:,3))-min(patterns(:,3)));
% p4 = ((patterns(:,4) - min(patterns(:,4))))./(max(patterns(:,4))-min(patterns(:,4)));
% p5 = ((patterns(:,5) - min(patterns(:,5))))./(max(patterns(:,5))-min(patterns(:,5)));
% p6 = ((patterns(:,6) - min(patterns(:,6))))./(max(patterns(:,6))-min(patterns(:,6)));
% p7 = ((patterns(:,7) - min(patterns(:,7))))./(max(patterns(:,7))-min(patterns(:,7)));
% p8 = ((patterns(:,8) - min(patterns(:,8))))./(max(patterns(:,8))-min(patterns(:,8)));
% p9 = ((patterns(:,9) - min(patterns(:,9))))./(max(patterns(:,9))-min(patterns(:,9)));
% p10 = ((patterns(:,10) - min(patterns(:,10))))./(max(patterns(:,10))-min(patterns(:,10)));
% p11 = ((patterns(:,11) - min(patterns(:,11))))./(max(patterns(:,11))-min(patterns(:,11)));
% p12 = ((patterns(:,12) - min(patterns(:,12))))./(max(patterns(:,12))-min(patterns(:,12)));
% p13 = ((patterns(:,13) - min(patterns(:,13))))./(max(patterns(:,13))-min(patterns(:,13)));
%p14 = ((patterns(:,14) - min(patterns(:,14))))./(max(patterns(:,14))-min(patterns(:,14)));

patterns_norm = (patterns - min(patterns)) ./ (max(patterns) - min(patterns));
%patterns_norm = normalize(patterns,'range');
%% create table = the 14 new variables then assign this table to inputs.

dataIn = table(patterns_norm,targets);

%% Sort data table using targets so that we can select the same number of output class. 
%from the histogram of the data, the lowest class is the 2nd class with 48
%data points. This means that we will then sort the data then selects the
%inputs to be a new table of 48 * 3 data points with an equal distribution
%for all classes/

sortedtable = sortrows(dataIn,'targets');

%% Pick sorted data.

%first convert table to array for easier selection
cdata = table2array(sortedtable);

%% select the equat number of classes from the data
class0 = cdata(1:48,:);
class1 = cdata(161:209,:);
class2 = cdata(250:297,:);

%% combine all classes to one array comprising of 48*3 elements
trainData = cat(1,class0,class1,class2);
%testData = setdiff(sortedtable,trainData);

%% Now that the data is okay, we can now start designing the network.
%%
%Select input training data

inputs = trainData(1:144,1:13)';
output = trainData(1:144,14)';

%% design neural net

mynet = feedforwardnet([6 3 3]);


% Set activation function for hidden layers
mynet.layers{1}.transferFcn = 'poslin';
mynet.layers{2}.transferFcn = 'poslin';
mynet.layers{3}.transferFcn = 'poslin';
mynet.layers{end}.transferFcn = 'softmax';

mynet.trainFcn = 'trainlm';
mynet.divideFcn = 'dividetrain';
%%set output function. Softmax is bettter for multivariate data
%mynet.layers{end}.transferFcn = 'softmax';

mynet.trainParam.epochs = 1000; % added line
%mynet.trainParam.showWindow = false; % added line
%% choose evaluation metrics
% mynet.performFcn = 'mse';
 mynet.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 'plotfit', 'plotconfusion', 'plotroc'};

%% Train the network
% for i = 1:10
%     mynet = train(mynet,inputs, output);
% end
mynet = train(mynet,inputs, output);
%% simulate the results.

 % simulate the network
testOutput = sim(mynet,patterns_norm');

%% check results

accuracy = sum(round(testOutput) == target) / numel(target)*100;

%% Print the accuracy as a percentage
fprintf("The model accuracy is %.2f%%\n", accuracy);

%% Plot confusion matric
%%plotconfusion3(testOutput,target);

