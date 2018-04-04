clear all
close all
clc

% Size of each picture
m = 200;
n = 175;

% Number of sample pictures
N = 20;

avg = zeros(m*n,1);  % the average face
A = [];

%% Load Arnold Schwarzenegger
count = 0;
for j = 1:N
    figure(1)
    ff = ['faces/arnold',num2str(j,'%02d'),'.jpg'];
%    ff = ['faces/taylor',num2str(j,'%02d'),'.jpg'];
    u = imread(ff); % Read the image into a matrix
    imshow(u)
    if(size(u,3)==1)
        M=double(u);
    else
        M=double(rgb2gray(u)); 
    end
    pause(0.1);
    R = reshape(M,m*n,1);
    A = [A,R];
   avg = avg + R;
   count = count + 1;
end
%% Load Sylvester Stallone
for j = 1:N
    figure(1)
    ff = ['faces/stallone',num2str(j,'%02d'),'.jpg'];
    u = imread(ff); % Read the image into a matrix
    imshow(u)
    M = double(u(:,:,1));
    
    R = reshape(M,m*n,1);
    A = [A,R];
    pause(0.1);
   avg = avg + R;
   count = count + 1
end
avg = avg /count;

%% Calculate the "averaged" face
avgTS = uint8(reshape(avg,m,n));
figure(1), imshow(avgTS);


%% Center the sample pictures at the "origin"
figure
for j = 1:2*N
    A(:,j) = A(:,j) - avg;
    R = reshape(A(:,j),m,n);
    imshow(R);
    pause(.1);
end

%%  Computing the SVD
[U,S,V] = svd(A,0);
Phi = U(:,1:2*N);
Phi(:,1) = -1*Phi(:,1);
figure()
count = 1;
for i=1:3
    for j=1:3
        subplot(3,3,count)
        imshow(uint8(25000*reshape(Phi(:,count),m,n)));
        count = count + 1;
    end
end


%% project each image onto basis 
for j = 1:N
    imvec = A(:,j);
    ARN(:,j) = imvec'*Phi(:,1:3);
end
for j = 1:N
    imvec = A(:,N+j);
    STAL(:,j) = imvec'*Phi(:,1:3);
end

figure(3)

plot3(ARN(1,:),ARN(2,:),ARN(3,:),'ro')
hold on
plot3(STAL(1,:),STAL(2,:),STAL(3,:),'bo')
legend('ARNOLD','STALONE')

%% add some unexpected pics
u = imread('faces/teststallone1.jpg');        
figure(4)
subplot(1,2,1)
imshow(u);
u = double(rgb2gray(u));
ustal = reshape(u,m*n,1)-avg;
stalpts = ustal'*Phi(:,1:3);
v = imread('faces/testterminator8.jpg');
subplot(1,2,2)
imshow(v);
v = double(rgb2gray(v));
vterm = reshape(v,m*n,1)-avg;
termpts = vterm'*Phi(:,1:3);
%%
figure(3)
plot3(stalpts(1),stalpts(2),stalpts(3),'g^')
plot3(termpts(1),termpts(2),termpts(3),'ko')