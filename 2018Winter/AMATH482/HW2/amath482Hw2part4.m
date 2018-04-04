clc; clear all; close all;
%%
load('cam1_4.mat')
load('cam2_4.mat')
load('cam3_4.mat')
%%
[rows_1, cols_1, dimen1_1, dimen2_1] = size(vidFrames1_4);
[rows_2, cols_2, dimen1_2, dimen2_2] = size(vidFrames2_4);
[rows_3, cols_3, dimen1_3, dimen2_3] = size(vidFrames3_4);
%%
count = 0;
for j = 1:dimen2_1
    count = count + 1;
    img = vidFrames1_4(:,:,:,j);
    images_1{count} = img;
end
count = 0;

for j = 1:dimen2_2
    count = count + 1;
    img = vidFrames2_4(:,:,:,j);
    images_2{count} = img;
end

count = 0;
for j = 1:dimen2_3
    count = count + 1;
    img = vidFrames3_4(:,:,:,j);
    images_3{count} = img;
end
%% case 2
% x1 = zeros(1, dimen2_1);
% y1 = zeros(1, dimen2_1);
clear x1; clear x2; clear x3; clear y1; clear y2; clear y3;
boxX = [430 460];
boxY = [260 290];
%430, 260, 30, 30
count = 0;
for j = 20:70
    count = count + 1;
    img = vidFrames1_4(:,:,3,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(imgBox)) == max(max(img)))
    	[rows, cols] = find(imgBox == max(max(imgBox)));
        y1(j) = mean(rows) + boxY(1);
        x1(j) = mean(cols) + boxX(1);
        pause(0.001);
        boxX = [round(x1(j) - 15), round(x1(j) + 15)];
        boxY = [round(y1(j) - 15), round(y1(j) + 15)];
    end
end

boxX = [340 370];
boxY = [320 350];
%340, 320, 30, 30
count = 0;
for j = 150:200
    count = count + 1;
    img = vidFrames1_4(:,:,3,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(imgBox)) == max(max(img)))
    	[rows, cols] = find(imgBox == max(max(imgBox)));
        y1(j) = mean(rows) + boxY(1);
        x1(j) = mean(cols) + boxX(1);
        boxX = [round(x1(j) - 15), round(x1(j) + 15)];
        boxY = [round(y1(j) - 15), round(y1(j) + 15)];
    else
    end
end
x1 = x1(y1>0);
y1 = y1(y1>0);


boxX = [255 285];
boxY = [180 210];
%255, 180, 20, 20
count = 0;
for j = 152:200
    count = count + 1;
    img = vidFrames2_4(:,:,3,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(imgBox)) == max(max(img)))
    	[rows, cols] = find(imgBox == max(max(imgBox)));
        y2(j) = mean(rows) + boxY(1);
        x2(j) = mean(cols) + boxX(1);
        boxX = [round(x2(j) - 15), round(x2(j) + 15)];
        boxY = [round(y2(j) - 15), round(y2(j) + 15)];
    end
end

boxX = [248 278];
boxY = [198 228];
% part 2 248, 198
count = 0;
for j = 235:274
    count = count + 1;
    img = vidFrames2_4(:,:,3,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(imgBox)) == max(max(img)))
    	[rows, cols] = find(imgBox == max(max(imgBox)));
        y2(j) = mean(rows) + boxY(1);
        x2(j) = mean(cols) + boxX(1);
        boxX = [round(x2(j) - 15), round(x2(j) + 15)];
        boxY = [round(y2(j) - 15), round(y2(j) + 15)];
    else
        y2(j) = y2(j-1);
        x2(j) = x2(j-1);
        boxX = [round(x2(j) - 50), round(x2(j) + 50)];
        boxY = [round(y2(j) - 50), round(y2(j) + 50)];
    end
end
x2 = x2(y2>0);
y2 = y2(y2>0);

boxX = [310 340];
boxY = [210 240];
%[310, 210, 30, 30]
count = 0;
for j = 50:100
    count = count + 1;
    img = vidFrames3_4(:,:,2,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [rows, cols] = find(imgBox == max(max(imgBox)));
    y3(j) = mean(rows) + boxY(1);
    x3(j) = mean(cols) + boxX(1);
    boxX = [round(x3(j) - 15), round(x3(j) + 15)];
    boxY = [round(y3(j) - 15), round(y3(j) + 15)];
end
boxX = [365 395];
boxY = [220 250];
%[365, 220, 30, 30]
count = 0;
for j = 120:170
    count = count + 1;
    img = vidFrames3_4(:,:,2,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [rows, cols] = find(imgBox == max(max(imgBox)));
    y3(j) = mean(rows) + boxY(1);
    x3(j) = mean(cols) + boxX(1);
    boxX = [round(x3(j) - 15), round(x3(j) + 15)];
    boxY = [round(y3(j) - 15), round(y3(j) + 15)];
end

%% showing case 1
% for i = 150:200
%    figure(1)
%    imshow(images_1{i}); hold on;
%    rectangle('position', [x1(i) - 15, y1(i) - 15, 30, 30], 'Edgecolor','r');
%    pause(0.0001)
% end
% %%
% for i = 152:200
%    figure(1)
%    imshow(images_2{i}); hold on;
%    rectangle('position', [x2(i) - 15, y2(i) - 15, 30, 30], 'Edgecolor','r');
%    pause(0.0001)
% end
% %%
% for i = 120:250
%    figure(1)
%    imshow(images_3{i}); hold on;
%    rectangle('position', [x3(i) - 15, y3(i) - 15, 30, 30], 'Edgecolor','r');
%    pause(0.0001)
% end
% %% showing rect
% subplot(1,2,1), imshow(images_1{71});
% title('Light rotating away from camera from frame 71');
% set(gca,'fontsize',24);
% subplot(1,2,2), imshow(images_1{149});
% set(gca,'fontsize',24);
% title('Light rotating towards from camera from frame 149');
% set(gcf,'units','points','position',[0,0,1500,1500]);
% % rectangle('position', [365, 220, 30, 30])
%%
y3 = y3(x3>0);
x3 = x3(x3>0);
y3 = [y3(10:40) y3(63:end)];
x3 = [x3(10:40) x3(63:end)];
x1_shifted = x1(5:length(x3));
y1_shifted = y1(5:length(x3));
x2_shifted = x2(1:length(x3) - 4);
y2_shifted = y2(1:length(x3) - 4);
x3_shifted = x3(5:length(x3));
y3_shifted = 480 - y3(5:length(x3));
%%
figure(2)
subplot(2,1,1);
plot(y1_shifted - mean(y1_shifted),'Linewidth', 3); hold on;
plot(y2_shifted - mean(y2_shifted),'Linewidth', 3)
plot(x3_shifted - mean(x3_shifted),'Linewidth', 3)
title('Y coordinates of paint can of part 4 videos on normalized coordinate system');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Timeframe');
ylabel('Displacement');
xlim([0 length(y1_shifted) + 10]);
legend('cam1_4 (y1)','cam2_4 (y2)','cam3_4 (y3)');

subplot(2,1,2);
plot(x1_shifted - mean(x1_shifted),'Linewidth', 3); hold on;
plot(x2_shifted - mean(x2_shifted),'Linewidth', 3)
plot(y3_shifted - mean(y3_shifted),'Linewidth', 3)
title('X coordinates of paint can of part 4 videos on normalized coordinate system');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Timeframe');
ylabel('Displacement');
legend('cam1_4 (x1)','cam2_4 (x2)','cam3_4 x(3)');
xlim([0 length(x1_shifted) + 10]);
set(gcf,'units','points','position',[0,0,1400,1000]);
%% SVD
X = [x1_shifted- mean(x1_shifted); y1_shifted- mean(y1_shifted); x2_shifted- mean(x2_shifted); y2_shifted- mean(y2_shifted); y3_shifted- mean(y3_shifted); x3_shifted- mean(x3_shifted);];
[u, s, v] = svd(X, 'econ');
%%
figure(4)
plot(diag(s)/sum(diag(s)), 'ro','Linewidth', 8);
title('Energy of each sigularvalues from each direction of part 4 videos');
set(gca,'Fontsize',20,'fontweight','bold');
set(gcf,'units','points','position',[150,150,800,700]);
xlabel('Singular values');
ylabel('Energy');
