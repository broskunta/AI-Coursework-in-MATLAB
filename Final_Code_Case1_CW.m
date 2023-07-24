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
%% change class 2 to 1
Table3 = Table2;
Table3.target(Table3.target == 2) = 1;
%% convert table to array

data = table2array(Table3);
data = normalize(data,'range');
sorted_d = sortrows(data,14);
%%
patterns = sorted_d(:,1:13)';
targets = sorted_d(:,14)';
%%
net = feedforwardnet([20]);
net.trainFcn = 'trainlm';
[trainInd,valInd,testInd] = dividerand(297,0.8,0.1,0.1);

net.layers{1}.transferFcn = 'logsig';
%net.layers{2}.transferFcn = 'logsig';
%net.layers{3}.transferFcn = 'logsig';
net.layers{end}.transferFcn = 'purelin';

net.performFcn = 'mse';
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotregression', 
    'plotconfusion', 'plotroc'};

net.trainParam.epochs = 1000;

[net,tr] = train(net, patterns, targets);

%% output
predict = sim(net,patterns);

%% plot confusion
figure;
plotconfusion(targets, predict)
