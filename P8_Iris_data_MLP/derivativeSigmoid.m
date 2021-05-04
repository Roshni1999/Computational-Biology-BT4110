function y = derivativeSigmoid(x)
    y = Sigmoid(x).*(1 - Sigmoid(x));
end