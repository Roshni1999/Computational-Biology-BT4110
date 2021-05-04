function class = decideClass(outputVector)
    class = 1;
    max = 0;
    for i = 1: size(outputVector, 1)
        if outputVector(i) > max
            max = outputVector(i);
            class = i;
        end
    end
end
