function [correct, err] = validate(act, w_bet, w_out, data, labels)

    testSetSize = size(data, 2);
    err = 0;
    correct = 0;
    
    for n = 1: testSetSize
        inputVector = data(:, n);
        outputVector = evaluate(act, w_bet, w_out, inputVector);
        
        class = decisionRule(outputVector);
        if class == labels(n) + 1
            correct = correct + 1;
        else
            err = err + 1;
        end
    end
end

function class = decisionRule(output)
    max = 0;
    class = 1;
    for i = 1: size(output, 1)
        if output(i) > max
            max = output(i);
            class = i;
        end
    end
end

function output = evaluate(act, w_bet, w_out, data)
    output = act(w_out*act(w_bet*data));
end