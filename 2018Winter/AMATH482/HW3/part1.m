%% Band Classification Across Genres
% Here I'll use a Random Forest to try to classify between Elton John (80s pop/ballad 
% rock), Kid Cudi (hip-hop), and Sublime (ska/reggae).

clear; close all; clc;
tic

%% Import Data

% Import music matrices. Each column is a five second audio clip. All sampled 
% at 44,100 Hz. 

directory = 'C:\Users\Claudius\Documents\School\AMATH\Data\HW 3';

eltonMat = importMusic(directory, 'Elton John');
cudiMat = importMusic(directory, 'Kid Cudi');
sublimeMat = importMusic(directory, 'Sublime');

% Resample it down to 14,700 Hz.
eltonMat = resample(eltonMat,1,3);
cudiMat = resample(cudiMat,1,3);
sublimeMat = resample(sublimeMat,1,3);

% If they are already on file, load them.
% load('C:\Users\Claudius\Documents\School\AMATH\Data\HW 3\eltonMat.mat')
% load('C:\Users\Claudius\Documents\School\AMATH\Data\HW 3\cudiMat.mat')
% load('C:\Users\Claudius\Documents\School\AMATH\Data\HW 3\sublimeMat.mat')

% There are about twice as many sublime samples as the other samples, so 
% we'll cut off the excess songs. This way we won't overtrain on Sublime songs.
sublimeMat = sublimeMat(:,1:940);

% Compile everything into a large data matrix X. 
X = [eltonMat, cudiMat, sublimeMat];

%% Create Labels for the data

for p = 1:size(eltonMat,2)
    dataLabels{p} = 'elton';
end

for p = 1:size(cudiMat,2)
    dataLabels{p+size(eltonMat,2)} = 'cudi';
end

for p = 1:size(sublimeMat,2)
    dataLabels{p+size(cudiMat,2)+size(eltonMat,2)} = 'sublime';
end

%% Extract features from signals

zcd = dsp.ZeroCrossingDetector;
for p = 1:size(X,2)
    
    % Count the number of times the signal crosses zero.
    zeroCrossings(p,:) = double(zcd(X(:,p)));
        
    % Store the largest value in the signal
    biggest(p,:) = max(abs(X(:,p)));
    
    % Compute the mean of the absolute value of the signal
    MAV(p,:) = mean(abs(X(:,p)));
    
    % Compute the variance of the signal
    VAR(p,:) = var(X(:,p));
    
    % Store the top three highest frequencies from the FFT.
    fftSig = abs(fft(X(:,p)));
    fftSig = fftSig(1:floor(end/2));
    [~,fftLoc1(p,:)] = max(fftSig);
    fftSig(fftLoc1(p)) = 0;
    [~,fftLoc2(p,:)] = max(fftSig);
    fftSig(fftLoc2(p)) = 0;
    [~,fftLoc3(p,:)] = max(fftSig);
    
    % Compute the norm of the signal
    sizeVal(p,:) = norm(X(:,p));
    
    % Compute the waveform length of the signal
    wavl(p,:) = sum(abs(diff(X(:,p))));
    
end

%% Assemble the features in the matrix

featMat = [zeroCrossings, biggest, MAV, fftLoc1, fftLoc2, fftLoc3, sizeVal, wavl];

% Prepare parameters for classifier function
classifier = 'randomForest';
doSVD = 'No';

% Within the for-loop, cross-validate the classifier 10 times.
parfor i = 1:10
    i
    % User-defined function that takes 80-20 cuts of the data to use for
    % training and testing. Returns the classification accuracy every time
    % it's called.
    treeAcc(i) = trainTestClassifier(featMat,dataLabels,classifier,doSVD);
end

meanAcc = mean(treeAcc)
stdAcc = std(treeAcc)

toc