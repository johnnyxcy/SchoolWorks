clc; clear all; close all;
%% noisy case
load('cam1_2.mat')
load('cam2_2.mat')
load('cam3_2.mat')
%% 
[row1, col1, dim1_1, dim2_1] = size(vidFrames1_2);
[row2, col2, dim1_2, dim2_2] = size(vidFrames2_2);
[row3, col3, dim1_3, dim2_3] = size(vidFrames3_2);
%%
for k = 1:dim2_1
    img1{k} = vidFrames1_2(:, :, :, k);
end
for k = 1:dim2_2
    img2{k} = vidFrames2_2(:, :, :, k);
end

for k = 1:dim2_3
    img3{k} = vidFrames3_2(:, :, :, k);
end
%% case 2
x1 = zeros(1, dim2_1);
y1 = zeros(1, dim2_1);
boxX = [300 350];
boxY = [300 350];
for i = 1:dim2_1
    img = vidFrames1_2(:,:,3,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [row, col] = find(box == max(max(box)));
    y1(i) = mean(row) + boxY(1);
    x1(i) = mean(col) + boxX(1);
    boxX = [round(x1(i) - 20), round(x1(i) + 20)];
    boxY = [round(y1(i) - 20), round(y1(i) + 20)];
end

x2 = zeros(1, dim2_2);
y2 = zeros(1, dim2_2);
boxX = [290 340];
boxY = [330 380];
for i = 1:dim2_2
    img = vidFrames2_2(:,:,3,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [row, col] = find(box == max(max(box)));
    y2(i) = mean(row) + boxY(1);
    x2(i) = mean(col) + boxX(1);
    boxX = [round(x2(i) - 30), round(x2(i) + 30)];
    boxY = [round(y2(i) - 30), round(y2(i) + 30)];
end


x3 = zeros(1, dim2_3);
y3 = zeros(1, dim2_3);
boxX = [335 365];
boxY = [240 270];
%[335, 240, 20, 20]
count = 0;
for i = 1:dim2_3
    count = count + 1;
    img = vidFrames3_2(:,:,3,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [row, col] = find(box == max(max(box)));
    y3(i) = mean(row) + boxY(1);
    x3(i) = mean(col) + boxX(1);
    boxX = [round(x3(i) - 30), round(x3(i) + 30)];
    boxY = [round(y3(i) - 30), round(y3(i) + 30)];
end
% %%
% figure(1);
% for i = 1:length(img1)
%    imshow(img1{i}); 
%    hold on;
%    rectangle('position', [x1(i) - 20, y1(i) - 20, 40, 40], 'Linewidth', 2);
%    hold off;
%    pause(0.001)
% end
% %%
% figure(2);
% for i = 1:length(img2)
%    imshow(img2{i}); 
%    hold on;
%    rectangle('position', [x2(i) - 15, y2(i) - 15, 30, 30], 'Linewidth', 2);
%    hold off;
%    pause(0.001)
% end
% %%
% figure(3);
% for i = 1:length(img3)
%    imshow(img3{i}); 
%    hold on;
%    rectangle('position', [x3(i) - 15, y3(i) - 15, 30, 30], 'Linewidth', 2);
%    hold off;
%    pause(0.001)
% end
%%
x1; y1;
x2 = x2(23:dim2_1 + 22);
y2 = y2(23:dim2_1 + 22);
x3 = x3(1:dim2_1);
y3 = y3(1:dim2_1);
%%
figure(2)
subplot(2,1,1);
plot(y1 - mean(y1),'Linewidth', 3); hold on;
plot(y2 - mean(y2),'Linewidth', 3)
plot(x3 - mean(x3),'Linewidth', 3)
title('Y Coordinates of Can in Noisy Case(Normalized)');
xlabel('Time');
ylabel('Displacement');
xlim([0 length(y1) + 50]);
legend('cam1(y1)','cam2(y2)','cam3(y3)');

subplot(2,1,2);
plot(x1 - mean(x1),'Linewidth', 3); hold on;
plot(x2 - mean(x2),'Linewidth', 3)
plot(y3 - mean(y3),'Linewidth', 3)
title('X Coordinates of Can in Noisy Case(Normalized)');
xlabel('Time');
ylabel('Displacement');
legend('cam1(x1)','cam2(x2)','cam3(x3)');
xlim([0 length(y1) + 50]);
%% SVD
X = [x1- mean(x1); y1- mean(y1); x2- mean(x2); y2- mean(y2); y3- mean(y3); x3- mean(x3);];
[u, s, v] = svd(X, 'econ');
%%
figure(3)
plot(diag(s)/sum(diag(s)), 'o','Linewidth', 2);
title('Importance of Singular Values For All Directions in Noisy Case');
xlabel('Singular values');
ylabel('Energy');