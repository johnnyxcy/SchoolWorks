clear all; close all; clc;
%% Import cam data
load('cam1_1.mat');
load('cam2_1.mat');
load('cam3_1.mat');
%% Get rows/columns and dimensions
[row1, col1, dim1_1, dim2_1] = size(vidFrames1_1);
[row2, col2, dim1_2, dim2_2] = size(vidFrames2_1);
[row3, col3, dim1_3, dim2_3] = size(vidFrames3_1);
%% Store the video by frames
for k = 1:dim2_1
    img1{k} = vidFrames1_1(:, :, :, k);
end
for k = 1:dim2_2
    img2{k} = vidFrames2_1(:, :, :, k);
end

for k = 1:dim2_3
    img3{k} = vidFrames3_1(:, :, :, k);
end
%% Ideal Case
x1 = zeros(1, dim2_1);
y1 = zeros(1, dim2_1);
boxX1 = [300, 350];
boxY1 = [200, 250];
for k = 1:dim2_1
    img = vidFrames1_1(:, :, 3, k);
    box = double(img(boxY1(1):boxY1(2), boxX1(1):boxX1(2)));
    [row, col] = find(box == max(max(box)));
    y1(k) = mean(row) + boxY1(1);
    x1(k) = mean(col) + boxX1(1);
    boxX1 = [round(x1(k) - 20), round(x1(k) + 20)];
    boxY1 = [round(y1(k) - 20), round(y1(k) + 20)];
end

x2 = zeros(1, dim2_2);
y2 = zeros(1, dim2_2);
boxX2 = [250, 300];
boxY2 = [250, 300];
for k = 1:dim2_2
    img = vidFrames2_1(:, :, 3, k);
    box = double(img(boxY2(1):boxY2(2), boxX2(1):boxX2(2)));
    [row, col] = find(box == max(max(box)));
    y2(k) = mean(row) + boxY2(1);
    x2(k) = mean(col) + boxX2(1);
    boxX2 = [round(x2(k) - 20), round(x2(k) + 20)];
    boxY2 = [round(y2(k) - 20), round(y2(k) + 20)];
end

x3 = zeros(1, dim2_3);
y3 = zeros(1, dim2_3);
boxX3 = [310, 340];
boxY3 = [265, 295];
for k = 1:dim2_3
    img = vidFrames3_1(:, :, 3, k);
    box = double(img(boxY3(1):boxY3(2), boxX3(1):boxX3(2)));
    [row, col] = find(box == max(max(box)));
    y3(k) = mean(row) + boxY3(1);
    x3(k) = mean(col) + boxX3(1);
    boxX3 = [round(x3(k) - 15), round(x3(k) + 15)];
    boxY3 = [round(y3(k) - 15), round(y3(k) + 15)];
end

% %% Video1
% figure(1);
% for i = 1:length(img1)
%     imshow(img1{i}); 
%     hold on;
%     rectangle('position', [x1(i) - 10, y1(i) - 10, 20, 20], 'Linewidth', 2);
%     hold off;
%     pause(0.001);
% end
% %% Video2
% figure(2);
% for i = 1:length(img2)
%     imshow(img2{i});
%     hold on;
%     rectangle('position', [x2(i) - 10, y2(i) - 10, 20, 20], 'Linewidth', 2);
%     hold off;
%     pause(0.001)
% end
% %% Video3
% figure(3);
% for i = 1:length(img3)
%     imshow(img3{i}); 
%     hold on;
%     rectangle('position', [x3(i) - 15, y3(i) - 15, 30, 30], 'Linewidth', 2);
%     hold off;
%     pause(0.001)
% end

%% Force everything to be in the same size
x1; y1; % Reference
x2 = x2(11:dim2_1 + 10);
y2 = y2(11:dim2_1 + 10);
x3 = x3(1:dim2_1);
y3 = 480 - y3(1:dim2_1);
%% Plot
figure(4);
subplot(2,1,1);
plot(y1,'Linewidth', 3); hold on;
plot(y2,'Linewidth', 3)
plot(x3,'Linewidth', 3)
title('Y Coordinates of Can in Ideal Case');
xlabel('Timeframe');
ylabel('Displacement');
xlim([0 length(y1) + 50]);
legend('cam1(y1)','cam2(y2)','cam3(y3)');

subplot(2,1,2);
plot(x1,'Linewidth', 3); hold on;
plot(x2,'Linewidth', 3)
plot(y3,'Linewidth', 3)
title('X Coordinates of Can in Ideal Case');
xlabel('Timeframe');
ylabel('Displacement');
xlim([0 length(y1) + 50]);
legend('cam1(x1)','cam2(x2)','cam3(x3)');

%% Normalize the Data
figure(5)
subplot(2,1,1);
plot(y1 - mean(y1),'Linewidth', 3); hold on;
plot(y2 - mean(y2),'Linewidth', 3)
plot(x3 - mean(x3),'Linewidth', 3)
title('Y Coordinates of Can in Ideal Case(Normalized)');
xlabel('Time');
ylabel('Displacement');
xlim([0 length(y1) + 50]);
legend('cam1(y1)','cam2(y2)','cam3(y3)');

subplot(2,1,2);
plot(x1 - mean(x1),'Linewidth', 3); hold on;
plot(x2 - mean(x2),'Linewidth', 3)
plot(y3 - mean(y3),'Linewidth', 3)
title('X Coordinates of Can in Ideal Case(Normalized)');
xlabel('Time');
ylabel('Displacement');
legend('cam1(x1)','cam2(x2)','cam3(x3)');
xlim([0 length(y1) + 50]);

%% SVD
X = [x1 - mean(x1); y1 - mean(y1); x2 - mean(x2); y2 - mean(y2); ...
     x3 - mean(x3); y3 - mean(y3)];
[u, s, v] = svd(X, 'econ');

%% Plot
figure;
plot(diag(s)/sum(diag(s)),'o', 'Linewidth', 2);
title('Importance of Singular Values For All Directions in Ideal Case');
xlabel('Singular values');
ylabel('Energy');
