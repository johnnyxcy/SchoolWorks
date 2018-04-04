%% TEST 2
clc; clear all; close all;
%% Import MP3 Files
% % Choice: Alice In Chains, Soundgarden, Pearl Jam
% myDir = 'C:\Users\Johnnia\Desktop\46\UW\SchoolWorks\2018Winter\AMATH482\HW3\MP3';
% [aic, Raic] = importData([myDir '\AliceInChains']);
% [sg, Rsg] = importData([myDir '\SoundGarden']);
% [pj, Rpj] = importData([myDir '\PearlJam']);
% 
% % Resample the data
% aic = resample(aic, 1, 2);
% sg = resample(sg, 1, 2);
% pj = resample(pj, 1, 2);
% 
% % Save for further use
% save('aic.mat', 'aic');
% save('sg.mat', 'sg');
% save('pj.mat', 'pj');

% Load if possible
load('aic.mat');
load('sg.mat');
load('pj.mat');

% Make into one data matrix
X = [aic, sg, pj];

%% Label

for i = 1:size(aic, 2)
    labs{i} = 'AliceInChains';
end

for i = 1:size(sg, 2)
    labs{i+size(aic, 2)} = 'SoundGarden';
end

for i = 1:size(pj,2)
    labs{i+size(aic, 2)+size(sg, 2)} = 'PearlJam';
end

%% Get Distinguishable Features

zcd = dsp.ZeroCrossingDetector;
for i = 1:size(X,2)
    
    % Count the number of times the signal crosses zero.
    cross0(i,:) = double(zcd(X(:,i)));
        
    % Get the max, min, mean, variance and norm of the signal
    maxV(i,:) = max(abs(X(:,i)));
    minV(i,:) = min(abs(X(:,i)));
    meanV(i,:) = mean(X(:,i));
    varV(i,:) = var(X(:,i));
    normV(i,:) = norm(X(:,i));
    
    % Get the first 2 highest frequencies from the FFT.
    fs = abs(fft(X(:,i)));
    fs = fs(1:floor(end/2));
    [~,f1(i,:)] = max(fs);
    fs(f1(i)) = 0;
    [~,f2(i,:)] = max(fs);   
    
    wavl(i,:) = sum(abs(diff(X(:,i))));
end

% Create the feature matrix
featureData = [cross0, maxV, minV, meanV, varV, normV, f1, f2, wavl];

%% Train the classifier and get the test result for 5 loops
acc_dt = zeros(5, 1);
acc_nb = zeros(5, 1);
for i = 1:5
    acc_dt(i) = Classifier(featureData, labs, 'DecisionTree');
    acc_nb(i) = Classifier(featureData, labs, 'NaiveBayes');
end

