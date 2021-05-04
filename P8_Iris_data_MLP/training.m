function [MSEtrain, MSEtest, TrainAccuracy, TestAccuracy] = training(noHiddenUnits, trainImages, trainLabels,TargetValuesTrain,...
                             testImages, testLabels, TargetValuesTest, epochs, batchSize, learningRate)
        
    trainingSize = size(trainImages, 2);     % 800 training images.
    testSize = size(testImages, 2);     % 800 training images.
    in_dimensions = size(trainImages, 1);     % 784
    out_dimensions = size(TargetValuesTrain, 1);   % Distinguish 10 digits.
    
    % Initialize weights for hidden layer and the output layer.
    weights_hidden = rand(noHiddenUnits, in_dimensions);   %700x800   
    weights_out = rand(out_dimensions, noHiddenUnits);  %10x700
    
    weights_hidden = weights_hidden./size(weights_hidden, 2);
    weights_out = weights_out./size(weights_out, 2);
    
    n = zeros(batchSize);
    m = zeros(testSize); 
    
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
            m(k) = floor(rand(1)*testSize + 1);
            inVector = trainImages(:, n(k));
                       
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
            inVector = trainImages(:, n(k));
            targetVector = TargetValuesTrain(:, n(k));
            MSEtrain = MSEtrain + norm(Sigmoid(weights_out*Sigmoid(weights_hidden*inVector)) - targetVector, 2);
        end
        MSEtrain= MSEtrain/batchSize;
        
        MSEtest = 0;
        for k = 1: testSize
            inVectorTest = testImages(:, m(k));
            targetVectorTest = TargetValuesTest(:, m(k));
            MSEtest = MSEtest + norm(Sigmoid(weights_out*Sigmoid(weights_hidden*inVectorTest)) - targetVectorTest, 2);
        end
        MSEtest= MSEtest/testSize;
                   
        figure(1)
        ylim([0 1])
        plot(t, MSEtrain,'*b');
        plot(t, MSEtest,'*r');
        legend('Training Set','Test Set')
        
        %Accuracy Plot
        [correctTrain, ~] = validate(weights_hidden, weights_out, trainImages, trainLabels);
        [correctTest, ~] = validate(weights_hidden, weights_out, testImages, testLabels);
        TrainAccuracy= correctTrain/trainingSize*100;
        TestAccuracy= correctTest/testSize*100;
        
        figure(2)
        plot(t, TrainAccuracy,'*b');
        plot(t, TestAccuracy,'*r');
        legend('Training Set','Test Set', 'Location','southeast')
        
    end
    
end