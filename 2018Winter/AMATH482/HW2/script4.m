clc; clear all; close all;
%% horizontal displacement and rotation
load('cam1_4.mat')
load('cam2_4.mat')
load('cam3_4.mat')
%% 
[row1, col1, dim1_1, dim2_1] = size(vidFrames1_4);
[row2, col2, dim1_2, dim2_2] = size(vidFrames2_4);
[row3, col3, dim1_3, dim2_3] = size(vidFrames3_4);
%%
for k = 1:dim2_1
    img1{k} = vidFrames1_4(:, :, :, k);
end
for k = 1:dim2_2
    img2{k} = vidFrames2_4(:, :, :, k);
end

for k = 1:dim2_3
    img3{k} = vidFrames3_4(:, :, :, k);
end
%%
boxX = [430 460];
boxY = [260 290];
for i = 20:70
    img = vidFrames1_4(:,:,3,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(box)) == max(max(img)))
        [row, col] = find(box == max(max(box)));
        y1(i) = mean(row) + boxY(1);
        x1(i) = mean(col) + boxX(1);
        boxX = [round(x1(i) - 15), round(x1(i) + 15)];
        boxY = [round(y1(i) - 15), round(y1(i) + 15)];
    end
end

boxX = [340 370];
boxY = [320 350];
for i = 150:200
    img = vidFrames1_4(:,:,3,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(box)) == max(max(img)))
    	[row, col] = find(box == max(max(box)));
        y1(i) = mean(row) + boxY(1);
        x1(i) = mean(col) + boxX(1);
        boxX = [round(x1(i) - 15), round(x1(i) + 15)];
        boxY = [round(y1(i) - 15), round(y1(i) + 15)];
    end
end
x1 = x1(y1>0);
y1 = y1(y1>0);

%%
boxX = [255 285];
boxY = [180 210];
for i = 152:200
    img = vidFrames2_4(:,:,3,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(box)) == max(max(img)))
    	[row, col] = find(box == max(max(box)));
        y2(i) = mean(row) + boxY(1);
        x2(i) = mean(col) + boxX(1);
        boxX = [round(x2(i) - 15), round(x2(i) + 15)];
        boxY = [round(y2(i) - 15), round(y2(i) + 15)];
    end
end

boxX = [248 278];
boxY = [198 228];
for i = 235:274
    img = vidFrames2_4(:,:,3,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    if (max(max(box)) == max(max(img)))
    	[row, col] = find(box == max(max(box)));
        y2(i) = mean(row) + boxY(1);
        x2(i) = mean(col) + boxX(1);
        boxX = [round(x2(i) - 15), round(x2(i) + 15)];
        boxY = [round(y2(i) - 15), round(y2(i) + 15)];
    else
        y2(i) = y2(i-1);
        x2(i) = x2(i-1);
        boxX = [round(x2(i) - 50), round(x2(i) + 50)];
        boxY = [round(y2(i) - 50), round(y2(i) + 50)];
    end
end
x2 = x2(y2>0);
y2 = y2(y2>0);
%%
boxX = [310 340];
boxY = [210 240];
for i = 50:100
    img = vidFrames3_4(:,:,2,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [row, col] = find(box == max(max(box)));
    y3(i) = mean(row) + boxY(1);
    x3(i) = mean(col) + boxX(1);
    boxX = [round(x3(i) - 15), round(x3(i) + 15)];
    boxY = [round(y3(i) - 15), round(y3(i) + 15)];
end
boxX = [365 395];
boxY = [220 250];
for i = 120:170
    img = vidFrames3_4(:,:,2,i);
    box = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [row, col] = find(box == max(max(box)));
    y3(i) = mean(row) + boxY(1);
    x3(i) = mean(col) + boxX(1);
    boxX = [round(x3(i) - 15), round(x3(i) + 15)];
    boxY = [round(y3(i) - 15), round(y3(i) + 15)];
end
y3 = x3(x3>0);
x3 = x3(x3>0);
y3 = [y3(10:40) y3(63:end)];
x3 = [x3(10:40) x3(63:end)];
%%
x1 = x1(5:length(x3));
y1 = y1(5:length(x3));
x2 = x2(1:length(x3) - 4);
y2 = y2(1:length(x3) - 4);
x3 = x3(5:length(x3));
y3 = 480 - y3(1:length(x3));
%%
figure(2)
subplot(2,1,1);
plot(y1 - mean(y1),'Linewidth', 3); hold on;
plot(y2 - mean(y2),'Linewidth', 3)
plot(x3 - mean(x3),'Linewidth', 3)
title('Y Coordinates of Can in Horizontal Displacement and Rotation Case(Normalized)');
xlabel('Time');
ylabel('Displacement');
xlim([0 length(y1) + 10]);
legend('cam1(y1)','cam2(y2)','cam3(y3)');

subplot(2,1,2);
plot(x1 - mean(x1),'Linewidth', 3); hold on;
plot(x2 - mean(x2),'Linewidth', 3)
plot(y3 - mean(y3),'Linewidth', 3)
title('X Coordinates of Can in Horizontal Displacement and Rotation Case(Normalized)');
xlabel('Time');
ylabel('Displacement');
legend('cam1(x1)','cam2(x2)','cam3(x3)');
xlim([0 length(y1) + 10]);
%% SVD
X = [x1- mean(x1); y1- mean(y1); x2- mean(x2); y2- mean(y2); y3- mean(y3); x3- mean(x3);];
[u, s, v] = svd(X, 'econ');
%%
figure(3)
plot(diag(s)/sum(diag(s)), 'o','Linewidth', 2);
title('Importance of Singular Values For All Directions in Noisy Case');
xlabel('Singular values');
ylabel('Energy');