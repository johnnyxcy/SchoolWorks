%%  HW 4: DMD for Video Separation
%   Anthony Anderson
%   AMATH 582

clear; close all; clc;

%% Import video

% This function was created with Matlab's Import Data Tool. Returns a 1,
% but loads the video 'rain.mp4' to the workspace as rain.
out = importVideo('C:\Users\Anthony\Documents\School\5. Winter 2018\AMATH 582\Data\HW 4\rain.mp4');

%% Preprocess the Data

% Convert the RGB video to black and white
vid = convert2gray(rain);

% Cut off the beginning and end of the video to reduce the volume of data.
vid = vid(:,:,200:330); % rain

% Take every third frame to further reduce the data.
vid = vid(1:2:end,1:2:end,:);

% Uncomment this to watch the video.

% % for i = 1:size(vid,3)
% %     i
% %     imshow(vid(:,:,i),[]);
% %     pause(0.03)
% % end
% % close all

% Vectorize the video, Make a data matrix where each column is a vectorized
% frame.
parfor i = 1:size(vid,3)
    i
    dataMat(:,i) = reshape(vid(:,:,i),size(vid,1)*size(vid,2),1);
end

%% Compute DMD

% Found the sampling rate in my cellphone's settings
dt = 0.0334;

% Create a vector of time
t = 0:dt:(dt*size(dataMat,2));

% Create our shifted data matrices. 
X = dataMat;
X1 = dataMat(:,1:end-1);
X2 = dataMat(:,2:end);

% Compute SVD
[U,Sigma,V] = svd(X1,'econ');
disp('svd done')

% Truncate matrices via SVD. Keep only 90 out of 130 singular values.
k = 90;
U = U(:,1:k);
Sigma = Sigma(1:k,1:k);
V = V(:,1:k);

%% Compute the Dynamic Mode Decomposition

% Primarily black magic from the notes.
S = U'*X2*V*diag(1./diag(Sigma));
[eV,D] = eig(S);
mu = diag(D);
omega = log(mu)/(dt);
Phi = U*eV;
y0 = Phi\X1(:,1);

% Uncomment code below to make the full DMD reconstruction of the dataset.
% Takes longer, so I've commented it out as I don't really need it to
% remove backgrounds.

for L = 1:length(t)
    L
    Xdmd(:,L) = Phi*diag(exp(omega.*(t(L))))*y0;
end

%% Create the Low-Rank and Sparse Matrices

% Find the location of the eigenvalue/frequency with the lowest absolute
% value. This signifies the background, because there are near zero
% dynamics.
[~,cut] = min(abs(omega));

% Construct the low-rank matrix for every time step by using only the mode
% associated with the minimum frequency.
for L = 1:size(X,2)
    Xlowrank(:,L) = Phi(:,cut)*diag(exp(omega(cut).*t(L)))*y0(cut);
end

% As stated in the homework problem statement, if we assume X = Xlowrank +
% Xsparse, we can solve for Xsparse.
Xsparse = X - abs(Xlowrank);

%% Account for negative values

% The computations below carry out the computations recommended in the
% homework assignment, but I've found that they aren't necessary to view
% the images, as Matlab's imshow function scales the minimum value in the
% matrix to 0. 

% % R = Xsparse;
% % R(R>0) = 0;
% % 
% % Xlowrank = R + abs(Xlowrank);
% % Xsparse = Xsparse - R;

%% Reshape the data into a 3D matrix/movie.

for i = 1:size(dataMat,2)
    vidDMD(:,:,i) = reshape(Xdmd(:,i),size(vid,1),size(vid,2));
end

%% Play the New Movie

figure
for i = 1:size(dataMat,2)
    imshow(vidDMD(:,:,i),[]);
    pause(0.03)
end

%%

v = VideoWriter('dmdReconstruct2.avi');
open(v);

set(gca,'nextplot','replacechildren'); 
% Create a set of frames and write each frame to the file.
for i = 1:size(dataMat,2)
   i
   imshow(abs(vidDMD(:,:,i)),[]);
   frame = getframe;
   writeVideo(v,frame);
end
close(v);