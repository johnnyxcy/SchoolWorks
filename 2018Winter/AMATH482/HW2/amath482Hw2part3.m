cd('/Users/leoleung/Documents/MATLAB/Amath482/project 2/part 3');
load('cam1_3.mat')
load('cam2_3.mat')
load('cam3_3.mat')
%%
[rows_1, cols_1, dimen1_1, dimen2_1] = size(vidFrames1_3);
[rows_2, cols_2, dimen1_2, dimen2_2] = size(vidFrames2_3);
[rows_3, cols_3, dimen1_3, dimen2_3] = size(vidFrames3_3);
%%
count = 0;
for j = 1:dimen2_1
    count = count + 1;
    img = vidFrames1_3(:,:,:,j);
    images_1{count} = img;
end
count = 0;

for j = 1:dimen2_2
    count = count + 1;
    img = vidFrames2_3(:,:,:,j);
    images_2{count} = img;
end

count = 0;
for j = 1:dimen2_3
    count = count + 1;
    img = vidFrames3_3(:,:,:,j);
    images_3{count} = img;
end
%% case 2
x1 = zeros(1, dimen2_1);
y1 = zeros(1, dimen2_1);
boxX = [315 330];
boxY = [280 295];
%310, 280, 20, 20
count = 0;
for j = 1:dimen2_1
    count = count + 1;
    img = vidFrames1_3(:,:,3,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [rows, cols] = find(imgBox == max(max(imgBox)));
    y1(j) = mean(rows + boxY(1));
    x1(j) = mean(cols + boxX(1));
    boxX = [round(x1(j) - 10), round(x1(j) + 10)];
    boxY = [round(y1(j) - 10), round(y1(j) + 10)];
end

x2 = zeros(1, dimen2_2);
y2 = zeros(1, dimen2_2);
boxX = [230 260];
boxY = [280 310];
%230, 280, 20, 20
count = 0;
for j = 1:dimen2_2
    count = count + 1;
    img = vidFrames2_3(:,:,3,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [rows, cols] = find(imgBox == max(max(imgBox)));
    y2(j) = mean(rows) + boxY(1);
    x2(j) = mean(cols) + boxX(1);
    boxX = [round(x2(j) - 10), round(x2(j) + 10)];
    boxY = [round(y2(j) - 10), round(y2(j) + 10)];
end


x3 = zeros(1, dimen2_3);
y3 = zeros(1, dimen2_3);
boxX = [345 375];
boxY = [220 250];
%[345, 220, 30, 30]
count = 0;
for j = 1:dimen2_3
    count = count + 1;
    img = vidFrames3_3(:,:,3,j);
    imgBox = double(img(boxY(1):boxY(2), boxX(1):boxX(2)));
    [rows, cols] = find(imgBox == max(max(imgBox)));
    y3(j) = mean(rows) + boxY(1);
    x3(j) = mean(cols) + boxX(1);
    boxX = [round(x3(j) - 20), round(x3(j) + 20)];
    boxY = [round(y3(j) - 20), round(y3(j) + 20)];
end
%% showing case 1
for i = 1:length(images_1)
   figure(1)
   imshow(images_1{i}); hold on;
   rectangle('position', [x1(i) - 15, y1(i) - 15, 30, 30], 'Edgecolor','r');
   pause(0.001)
end
%%
for i = 1:length(images_2)
   figure(1)
   imshow(images_2{i}); hold on;
   rectangle('position', [x2(i) - 15, y2(i) - 15, 30, 30], 'Edgecolor','r');
   pause(0.001)
end
%%
for i = 1:length(images_3)
   figure(1)
   imshow(images_3{i}); hold on;
   rectangle('position', [x3(i) - 15, y3(i) - 15, 30, 30], 'Edgecolor','r');
   pause(0.001)
end
%% showing rect
imshow(images_1{1});
hold on
rectangle('position', [316, 283, 10, 10])

%%
x1_shifted = x1(8:177 + 7);
y1_shifted = y1(8:177 + 7);
x2_shifted = x2(36:177+35);
y2_shifted = y2(36:177+35);
x3_shifted = x3(1:177);
y3_shifted = 480 - y3(1:177);
%%
figure(2)
subplot(2,1,1);
plot(y1_shifted - mean(y1_shifted),'Linewidth', 3); hold on;
plot(y2_shifted - mean(y2_shifted),'Linewidth', 3)
plot(x3_shifted - mean(x3_shifted),'Linewidth', 3)
title('Y coordinates of paint can of part 3 videos on normalized coordinate system');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Timeframe');
ylabel('Displacement');
xlim([0 length(y1_shifted) + 50]);
legend('cam1_3 (y1)','cam2_3 (y2)','cam3_3 (y3)');

subplot(2,1,2);
plot(x1_shifted - mean(x1_shifted),'Linewidth', 3); hold on;
plot(x2_shifted - mean(x2_shifted),'Linewidth', 3)
plot(y3_shifted - mean(y3_shifted),'Linewidth', 3)
title('X coordinates of paint can of part 3 videos on normalized coordinate system');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Timeframe');
ylabel('Displacement');
legend('cam1_3 (x1)','cam2_3 (x2)','cam3_3 x(3)');
xlim([0 length(y1_shifted) + 50]);
set(gcf,'units','points','position',[0,0,1400,1000]);
%% SVD
X = [x1_shifted- mean(x1_shifted); y1_shifted- mean(y1_shifted); x2_shifted- mean(x2_shifted); y2_shifted- mean(y2_shifted); y3_shifted- mean(y3_shifted); x3_shifted- mean(x3_shifted);];
[u, s, v] = svd(X, 'econ');
%%
figure(4)
plot(diag(s)/sum(diag(s)), 'ro','Linewidth', 8);
title('Energy of each sigularvalues from each direction of part 3 videos');
set(gca,'Fontsize',24,'fontweight','bold');
set(gcf,'units','points','position',[150,150,800,700]);
xlabel('Singular values');
ylabel('Energy');

