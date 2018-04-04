%% TEST 1
clc; clear all; close all;
%% Import MP3 Files
% Choice: Michael Jackson, Soundgarden, Beethoven
% myDir = 'C:\Users\Johnnia\Desktop\46\UW\SchoolWorks\2018Winter\AMATH482\HW3\MP3';
% [mj, Rmj] = importData([myDir '\MichaelJackson']);
% [sg, Rsg] = importData([myDir '\SoundGarden']);
% [bee, Rbee] = importData([myDir '\Beethoven']);
% 
% % Resample the data
% mj = resample(mj, 1, 2);
% sg = resample(sg, 1, 2);
% bee = resample(bee, 1, 2);
% 
% % Save for further use
% save('mj.mat', 'mj');
% save('sg.mat', 'sg');
% save('bee.mat', 'bee');

% Load if possible
load('mj.mat');
load('sg.mat');
load('bee.mat');

% Make into one data matrix
X = [mj, sg, bee];

%% Label

for i = 1:size(mj, 2)
    labs{i} = 'MichaelJackson';
end

for i = 1:size(sg, 2)
    labs{i+size(mj, 2)} = 'SoundGarden';
end

for i = 1:size(bee,2)
    labs{i+size(mj, 2)+size(sg, 2)} = 'Beethoven';
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
end

% Create the feature matrix
featureData = [cross0, maxV, minV, meanV, varV, normV, f1, f2];

%% Train the classifier and get the test result for 5 loops
acc_dt = zeros(5, 1);
acc_nb = zeros(5, 1);
for i = 1:5
    acc_dt(i) = Classifier(featureData, labs, 'DecisionTree');
    acc_nb(i) = Classifier(featureData, labs, 'NaiveBayes');
end

