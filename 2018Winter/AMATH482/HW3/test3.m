%% TEST 2
clc; clear all; close all;
%% Import MP3 Files
% Choice: Alice In Chains, Soundgarden, Pearl Jam
myDir = 'C:\Users\Johnnia\Desktop\46\UW\SchoolWorks\2018Winter\AMATH482\HW3\genres';
[blues, Rb] = importData([myDir '\blues']);
[classical, Rclas] = importData([myDir '\classical']);
[country, Rcoun] = importData([myDir '\country']);
[disco, Rd] = importData([myDir '\disco']);
[hiphop, Rhh] = importData([myDir '\hiphop']);
[jazz, Rjz] = importData([myDir '\jazz']);
[metal, Rm] = importData([myDir '\metal']);
[pop, Rp] = importData([myDir '\pop']);
[reggae, Rr] = importData([myDir '\reggae']);
[rock, Rrc] = importData([myDir '\rock']);

%% Resample the data
blues = resample(blues, 1, 2);
classical = resample(classical, 1, 2);
country = resample(country, 1, 2);
disco = resample(disco, 1, 2);
hiphop = resample(hiphop, 1, 2);
hiphop = hiphop(:, 1:end-1);
jazz = resample(jazz, 1, 2);
metal = resample(metal, 1, 2);
pop = resample(pop, 1, 2);
reggae = resample(reggae, 1, 2);
rock = resample(rock, 1, 2);

% Save for further use
save('blues.mat', 'blues');
save('classical.mat', 'classical');
save('country.mat', 'country');
save('disco.mat', 'disco');
save('hiphop.mat', 'hiphop');
save('jazz.mat', 'jazz');
save('metal.mat', 'metal');
save('pop.mat', 'pop');
save('reggae.mat', 'reggae');
save('rock.mat', 'rock');

%% Load if possible
load('blues.mat');
load('classical.mat');
load('country.mat');
load('disco.mat');
load('hiphop.mat');
load('jazz.mat');
load('metal.mat');
load('pop.mat');
load('reggae.mat');
load('rock.mat');

% Make into one data matrix
X = [blues, classical, country, disco, hiphop, jazz, metal, pop, reggae, rock];

%% Label

for i = 1:size(blues, 2)
    labs{i} = 'blues';
end

for i = 1:size(classical, 2)
    labs{i+size(blues, 2)} = 'classical';
end

for i = 1:size(country,2)
    labs{i+size(blues, 2)+size(classical, 2)} = 'country';
end

for i = 1:size(disco,2)
    labs{i+size(blues, 2)+size(classical, 2)+size(country, 2)} = 'disco';
end

for i = 1:size(hiphop,2)
    labs{i+size(blues, 2)+size(classical, 2)+size(country, 2)...
        +size(disco, 2)} = 'hiphop';
end

for i = 1:size(jazz,2)
    labs{i+size(blues, 2)+size(classical, 2)+size(country, 2)...
        +size(disco, 2)+size(hiphop, 2)} = 'jazz';
end

for i = 1:size(metal,2)
    labs{i+size(blues, 2)+size(classical, 2)+size(country, 2)...
        +size(disco, 2)+size(hiphop, 2)+size(jazz, 2)} = 'metal';
end

for i = 1:size(pop,2)
    labs{i+size(blues, 2)+size(classical, 2)+size(country, 2)...
        +size(disco, 2)+size(hiphop, 2)+size(jazz, 2)...
        +size(metal, 2)} = 'pop';
end

for i = 1:size(reggae,2)
    labs{i+size(blues, 2)+size(classical, 2)+size(country, 2)...
        +size(disco, 2)+size(hiphop, 2)+size(jazz, 2)...
        +size(metal, 2)+size(pop, 2)} = 'reggae';
end

for i = 1:size(rock,2)
    labs{i+size(blues, 2)+size(classical, 2)+size(country, 2)...
        +size(disco, 2)+size(hiphop, 2)+size(jazz, 2)...
        +size(metal, 2)+size(pop, 2)+size(reggae, 2)} = 'rock';
end

%% Label2
for i = 1:size(rock, 2)
    labs{i} = 'rock';
end

for i = 1:size(jazz, 2)
    labs{i+size(rock, 2)} = 'jazz';
end

for i = 1:size(classical,2)
    labs{i+size(rock, 2)+size(jazz, 2)} = 'classical';
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

