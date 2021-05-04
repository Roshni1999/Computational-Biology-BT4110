function [correct, incorrect] = validate(weights_hidden, weights_out, data, Labels)
  
    testSize = size(data, 2);
    incorrect = 0;
    correct = 0;
    
    for n = 1: testSize
        inVector = data(:, n);
        outputVector = Sigmoid(weights_out*Sigmoid(weights_hidden*inVector));
               
        class = decideClass(outputVector);
        if class == Labels(n)   
            correct = correct + 1;
        else
            incorrect = incorrect + 1;
        end
    end
end

