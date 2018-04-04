clc; clear all; close all;
%%
% Load MNIST.
train_data = loadMNISTImages('train-images.idx3-ubyte');
train_labs = loadMNISTLabels('train-labels.idx1-ubyte');

targetValues = 0.*ones(10, size(train_labs, 1));
for n = 1: size(train_labs, 1)
    targetValues(train_labs(n) + 1, n) = 1;
end

units = 10;

alpha = 0.1;

activation = @logisticSigmoid;
dactivation = @dLogisticSigmoid;

batchSize = 100;
epochs = 500;

[w_between, w_output, error] = train(activation, dactivation, ...
    units, train_data, targetValues,epochs, batchSize, alpha);

test_data = loadMNISTImages('t10k-images.idx3-ubyte');
test_labs = loadMNISTLabels('t10k-labels.idx1-ubyte');

[correct, err] = validate(activation, w_between, w_output, test_data, test_labs);

fprintf('Classification errors: %d\n', err);
fprintf('Correctly classified: %d\n', correct);
fprintf('Accuracy: %d\n', correct/(err+correct));