%IRIS data
clear; clc;
close all
% Load IRIS dataset
load('iris_given.mat');
trainData = iris_data';
trainDataLabels = iris_label;
% Class 1 = Iris-setosa
% Class 2 = Iris-versicolor
% Class 3 = Iris-virginica

%%
% Transform labels to correct target values.
TargetValuesTrain = zeros(3, size(trainDataLabels, 1));
for n = 1: size(trainDataLabels, 1)
    TargetValuesTrain(trainDataLabels(n), n) = 1;
end

%% 
noHiddenUnits =2; %Network Architecture
learningRate = 0.01; %Learning Rate
    
batchSize = 150; % Choosing batch size as entire train dataset
epochs = 700;
    
fprintf('No of hidden units: %d.\n', noHiddenUnits);
fprintf('Activation function used: Logistic Sigmoid. \n');
fprintf('Error function: MSE. \n');
fprintf('Learning rate: %d.\n', learningRate);

[MSEtrain, TrainAccuracy] = iris_training(noHiddenUnits, trainData, trainDataLabels,TargetValuesTrain, epochs, batchSize, learningRate);

%%  
fprintf('Final Accuracy after %d epochs: \n', epochs);
fprintf('Training Accuracy: %d \n', TrainAccuracy);
  
