%% Exploratory data analysis code
clear all

%%
 
load cleveland_heart_disease_dataset_labelled.mat

%% create table from the data
T = table(x,t);
B = table2array(T);
Table1 = array2table(B);
Table2 = renamevars(Table1, {'B1','B2','B3','B4','B5','B6','B7','B8','B9','B10','B11','B12','B13','B14'}, ...
    {'Age','Sex','CP','Trestbps','Chol','fbs','restecg', ...
    'thalach','exang','oldpeak','slope','ca','thal','target'});


%% plots
%% distribution of Sec
c = categorical(Table2.Sex,[0 1],{'Female','Male'});
histogram(c)
%histogram(c,{'Female','Male'},"FaceColor",{'r','g'})
%%
%distribution of age
histogram(Table2.Age)
%%
%distribution of sex
C = categorical(Table2.target,[0 1 2],{'No Heart Disease','Mild Heart Disease','Severe Heart Disease'});
histogram(C)
%% correlation coefficient of the data
R = corrplot(Table2,Type="Pearson",TestR="on");


%% Scatterplots
scatter(Table2,"target",{'CP','exang','ca','thal'});
%%
%%Normalize data
norm_T = normalize(Table2,'range');

%%
figure
corrplot(Table2(:,1:end),'testR','on')
title('Correlation plot')

%%
%bivariate histogram
c = [Table2.target; Table2.Sex];
bar(c)
colorbar

%%
% Create a histogram of age
figure
histogram(Table2.Age)
title('Age Distribution')
% xlabel('Age')
% ylabel('Frequency')
%%
% Create a scatter plot of age vs. cholesterol
figure
scatter(Table2.target, Table2.Age)
title('Age vs. Cholesterol')
xlabel('Age')
ylabel('Cholesterol')
%%
% Create a bar plot of the frequency of each chest pain type
figure
cp_counts = countcats(categorical(Table2.CP));
bar(cp_counts)
title('Chest Pain Type Frequencies')
xlabel('Chest Pain Type')
ylabel('Frequency')
xticklabels({'Typical Angina','Atypical Angina','Non-Anginal Pain','Asymptomatic'})
%%
% Create a bar plot of the frequency of each resting ECG type
figure
cp_counts = countcats(categorical(Table2.restecg));
bar(cp_counts)
title('Rest ECG Frequencies')
xlabel('Rest ECG')
ylabel('Frequency')
xticklabels({'Normal','Having ST-T wave abnormality','Left ventricular hypertrophy'})
xtickangle(45)
%%
c = [Table2.restecg Table2.target];
histogram(c)
colorbar
%%
figure
histogram(Table2.CP,"Data",Table2.target)

%%
figure
histogram(Table2.target,"Data",Table2.restecg)
xticks([0,1,2])
xticklabels({'Normal','Having ST-T wave abnormality','Left ventricular hypertrophy'})
% xlabel('Rest ECG')
% ylabel('Frequency')
%%
figure
histogram(Table2.target,"Data",Table2.thalach,"","auto")


%% 
% Histogram of thalac by target type
figure;
histogram(Table2.thalach(Table2.target==0), 'BinWidth', 5, 'FaceColor', 'blue');
hold on;
histogram(Table2.thalach(Table2.target==1),  'BinWidth', 5, 'FaceColor', 'red');
histogram(Table2.thalach(Table2.target==2), 'BinWidth', 5, 'FaceColor', 'green');
legend('Normal', 'Mild','Severe' );
title('Histogram of Thalac by Target Type');
%%
figure;
histogram(Table2.Age(Table2.target==0), 'BinWidth', 5, 'FaceColor', 'blue');
hold on;
histogram(Table2.Age(Table2.target==1), 'BinWidth', 5, 'FaceColor', 'red');
histogram(Table2.Age(Table2.target==2),  'BinWidth', 5, 'FaceColor', 'green');
legend('Normal', 'Mild','Severe' );
title('Histogram of Age by Target Type');

%%
figure;
histogram(Table2.Trestbps(Table2.target==0), 'BinWidth', 5, 'FaceColor', 'blue');
hold on;
histogram(Table2.Trestbps(Table2.target==1), 'BinWidth', 5, 'FaceColor', 'red');
histogram(Table2.Trestbps(Table2.target==2),  'BinWidth', 5, 'FaceColor', 'green');
legend('Normal', 'Mild','Severe' );
title('Histogram of Trestbps by Target Type');

%%
% figure;
histogram(Table2.Chol(Table2.target==0), 'BinWidth', 5, 'FaceColor', 'blue');
hold on;
histogram(Table2.Chol(Table2.target==1), 'BinWidth', 5, 'FaceColor', 'red');
histogram(Table2.Chol(Table2.target==2),  'BinWidth', 5, 'FaceColor', 'green');
legend('Normal', 'Mild','Severe' );
title('Histogram of Cholesterol by Target Type');

%% generate data subplots

subplot(2,2,1);
histogram(Table2.thalach(Table2.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table2.thalach(Table2.target==1),  'BinWidth', 5, 'FaceColor', "#A2142F");
histogram(Table2.thalach(Table2.target==2), 'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal', 'Mild','Severe' );
title('Histogram of Thalac by Target Type');


subplot(2,2,2);
histogram(Table2.Age(Table2.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table2.Age(Table2.target==1), 'BinWidth', 5, 'FaceColor', "#A2142F");
histogram(Table2.Age(Table2.target==2),  'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal', 'Mild','Severe' );
title('Histogram of Age by Target Type');

subplot(2,2,3);
histogram(Table2.Trestbps(Table2.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table2.Trestbps(Table2.target==1), 'BinWidth', 5, 'FaceColor', "#A2142F");
histogram(Table2.Trestbps(Table2.target==2),  'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal', 'Mild','Severe' );
title('Histogram of Trestbps by Target Type');

subplot(2,2,4);
% figure;
histogram(Table2.Chol(Table2.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table2.Chol(Table2.target==1), 'BinWidth', 5, 'FaceColor', "#A2142F");
histogram(Table2.Chol(Table2.target==2),  'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal', 'Mild','Severe' );
title('Histogram of Cholesterol by Target Type');


%% combine data and draw new plots.

%create a new table
Table3 = Table2;

% change variable 2 in table3.target to 1 making the class type now "with
% disease' and 'without disease'
Table3.target(Table3.target == 2) = 1;
%%
subplot(2,2,1);
histogram(Table3.thalach(Table3.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table3.thalach(Table3.target==1),  'BinWidth', 5, 'FaceColor', "#A2142F");
%histogram(Table2.thalach(Table3.target==2), 'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal Heart', 'Diseased Heart' );
title('Histogram of Thalac by Target Type');


subplot(2,2,2);
histogram(Table3.Age(Table3.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table3.Age(Table3.target==1), 'BinWidth', 5, 'FaceColor', "#A2142F");
%histogram(Table2.Age(Table2.target==2),  'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal Heart', 'Diseased Heart' );
title('Histogram of Age by Target Type');

subplot(2,2,3);
histogram(Table3.Trestbps(Table3.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table3.Trestbps(Table3.target==1), 'BinWidth', 5, 'FaceColor', "#A2142F");
%histogram(Table2.Trestbps(Table2.target==2),  'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal Heart', 'Diseased Heart' );
title('Histogram of Trestbps by Target Type');

subplot(2,2,4);
% figure;
histogram(Table3.Chol(Table3.target==0), 'BinWidth', 5, 'FaceColor', "#77AC30");
hold on;
histogram(Table3.Chol(Table3.target==1), 'BinWidth', 5, 'FaceColor', "#A2142F");
%histogram(Table2.Chol(Table2.target==2),  'BinWidth', 5, 'FaceColor', "#D95319");
legend('Normal Heart', 'Diseased Heart' );
title('Histogram of Cholesterol by Target Type');


%% scatterplot
figure
gscatter(Table2.Age, Table2.Trestbps, Table2.target)

%% scatterplot
figure
gscatter(Table3.Age, Table3.Trestbps, Table3.target,group,'br','xo')

%%
%% scatterplot
figure
gscatter(Table2.Age, Table2.thalach, Table2.target,'','sd*','','on','Age','Cholesterol')
title('Scatterplot of Age against thalac grouped by targets')
grid on
grid minor
legend

%% scatterplot
figure
gscatter(Table2.Age, Table2.oldpeak, Table2.target,'','sd*','','on','Age','Oldpeak')
title('Scatterplot of Age against oldpeak grouped by targets')
grid on
grid minor
legend

%% 
subplot(2,2,1)
gscatter(Table2.Age, Table2.thalach, Table2.target,'','sd*','','on','Age','thalac')
title('Scatterplot of Age against thalac grouped by targets')
grid on
grid minor
legend

subplot(2,2,2)
gscatter(Table2.Age, Table2.oldpeak, Table2.target,'','sd*','','on','Age','Oldpeak')
title('Scatterplot of Age against oldpeak grouped by targets')
grid on
grid minor
legend

subplot(2,2,3)
gscatter(Table2.Age, Table2.Trestbps, Table2.target,'','sd*','','on','Age','Trestbps')
title('Scatterplot of Age against Trestbps grouped by targets')
grid on
grid minor
legend

subplot(2,2,4)
gscatter(Table2.Age, Table2.Chol, Table2.target,'','sd*','','on','Age','Chol')
title('Scatterplot of Age against Cholesterol grouped by targets')
grid on
grid minor
legend

%%
