function accuracy = Classifier(dat,labs, classifier)
n = size(dat,1);
trainSize = floor(n*0.7);
testSize = floor(n*0.3);

%% Divide data to be training set and testing set
randIndex = randperm(n);
randData = dat(randIndex,:);
randlabs = labs(randIndex);

% First 70% to be training data
train = randData(1:trainSize,:);
trainlabs = randlabs(1:trainSize);

% The other 30% to be testing data
test = randData(trainSize+1:end,:);
testlabs = randlabs(trainSize+1:end);

%% Perform SVD

[u,s,v] = svd(train','econ');

% Compute energy
energy = diag(s)/sum(diag(s));

% Find modes with less than 10% energy
i = find(energy < 0.1);

% If the above all modes are within 10%
if isempty(i)
    endInd = size(v,2);
else
    endInd = i(1)-1;
end

% Get the data with only modes with more than 10% energy
train = v(:,1:endInd);
test = s\u'*test';
test = test(1:endInd,:)';

%% Train
if (strcmp(classifier, 'DecisionTree'))
    model = TreeBagger(30, train, trainlabs);
elseif (strcmp(classifier, 'NaiveBayes'))
    model = fitcnb(train, trainlabs);
end
%% Test
    
predictions{testSize,1} = [];
correctness = zeros(testSize, 1);

for i = 1:testSize   
    predictions{i,:} = predict(model, test(i,:));
    correctness(i) = strcmp(predictions{i,:}, testlabs{i});
end
    
accuracy = 100*sum(correctness)/length(correctness);

end