function [MSEtrain, TrainAccuracy] = iris_training(noHiddenUnits, trainData, trainDataLabels,TargetValuesTrain, epochs, batchSize, learningRate)
        
    trainingSize = size(trainData, 2);     % 150 training data.
    in_dimensions = size(trainData, 1);     % 4
    out_dimensions = size(TargetValuesTrain, 1);   % Distinguish 3 classes
    
    % Initialize weights for hidden layer and the output layer.
    weights_hidden = rand(noHiddenUnits, in_dimensions);   %100xHiddenUnits
    weights_out = rand(out_dimensions, noHiddenUnits);  %3xHiddenUnits
    
    weights_hidden = weights_hidden./size(weights_hidden, 2);
    weights_out = weights_out./size(weights_out, 2);
    
    n = zeros(batchSize);
        
    figure(1);
    xlabel('No. of Epochs')
    ylabel('MSE (normalized)')
    title('Loss function vs No. of epochs');
    hold on;
    
    figure(2)
    xlabel('No. of Epochs')
    ylabel('Accuracy (%)')
    title('Accuracy vs No. of epochs');
    hold on;
    

    for t = 1: epochs
        for k = 1: batchSize
            % Select which input vector to train on.
            n(k) = floor(rand(1)*trainingSize + 1);
            inVector = trainData(:, n(k));
                       
            hiddenActualInput = weights_hidden*inVector;
            hiddenOutputVector = Sigmoid(hiddenActualInput);
            outputActualInput = weights_out*hiddenOutputVector;
            
            outputVector = Sigmoid(outputActualInput);
            targetVector = TargetValuesTrain(:, n(k));
            
            % Backpropagating the errors.
            output_eps = derivativeSigmoid(outputActualInput).*(outputVector - targetVector);
            hidden_eps = derivativeSigmoid(hiddenActualInput).*(weights_out'*output_eps);
            
            weights_out = weights_out - learningRate.*output_eps*hiddenOutputVector';
            weights_hidden = weights_hidden - learningRate.*hidden_eps*inVector';
        end
        
        % Loss function plot
        MSEtrain = 0;
        for k = 1: batchSize
            inVector = trainData(:, n(k));
            targetVector = TargetValuesTrain(:, n(k));
            MSEtrain = MSEtrain + norm(Sigmoid(weights_out*Sigmoid(weights_hidden*inVector)) - targetVector, 2);
        end
        MSEtrain= MSEtrain/batchSize;
                       
        figure(1)
        ylim([0 1])
        plot(t, MSEtrain,'*b');
                
        %Accuracy Plot
        [correctTrain, ~] = validate(weights_hidden, weights_out, trainData, trainDataLabels);
        TrainAccuracy= correctTrain/trainingSize*100;
                
        figure(2)
        plot(t, TrainAccuracy,'*b');
                
    end
    
end