%% xor problem

a = [0 0 0; 0 1 1; 1 0 1; 1 1 0];
a = a';

input = a(1:2,:);
output = a(3,:);

%scatter(output, input)
%define neuralnet
mynet = feedforwardnet([3]);
%mynet.trainFcn = 'traingd';
mynet.divideFcn = 'dividetrain';

%initialize the weights
%mynet = init(mynet);
%train the network
mynet = train(mynet,input, output);

 % simulate the network
y1 = sim(mynet,input)