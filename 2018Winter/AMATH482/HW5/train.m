function [w_bet, w_out, error] = train(act, deact, units, data, labs, epochs, batchSize, alpha)
    trainingSetSize = size(data, 2);
    datasize = size(data, 1);
    pattern = size(labs, 1);
    w_bet = rand(units, datasize);
    w_out = rand(pattern, units);
    
    w_bet = w_bet./size(w_bet, 2);
    w_out = w_out./size(w_out, 2);
    
    n = zeros(batchSize);
    
    figure; hold on;

    for t = 1: epochs
        for k = 1: batchSize
            % Select which input vector to train on.
            n(k) = floor(rand(1)*trainingSetSize + 1);
            
            % Propagate the input vector through the network.
            inputVector = data(:, n(k));
            hiddenActualInput = w_bet*inputVector;
            hiddenOutputVector = act(hiddenActualInput);
            outputActualInput = w_out*hiddenOutputVector;
            outputVector = act(outputActualInput);
            
            targetVector = labs(:, n(k));
            
            % Backpropagate the errors.
            outputDelta = deact(outputActualInput).*(outputVector - targetVector);
            hiddenDelta = deact(hiddenActualInput).*(w_out'*outputDelta);
            
            w_out = w_out - alpha.*outputDelta*hiddenOutputVector';
            w_bet = w_bet - alpha.*hiddenDelta*inputVector';
        end
        
        % Calculate the error for plotting.
        error = 0;
        for k = 1: batchSize
            inputVector = data(:, n(k));
            targetVector = labs(:, n(k));
            
            error = error + norm(act(w_out*...
                act(w_bet*inputVector)) - targetVector, 2);
        end
        error = error/batchSize;
        
        plot(t, error,'*');
        xlabel('Epochs'), ylabel('Crossentropy');
        title('Error Rate vs. Number of Epochs');
    end
end