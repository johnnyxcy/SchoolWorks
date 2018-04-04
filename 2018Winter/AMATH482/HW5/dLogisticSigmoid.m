function y = dLogisticSigmoid(x)
    y = logisticSigmoid(x).*(1 - logisticSigmoid(x));
end