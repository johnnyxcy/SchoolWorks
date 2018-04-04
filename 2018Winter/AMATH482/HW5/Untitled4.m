clc; clear all; close all;
%%
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_labels = test_labels.';
train_labels = train_labels.';
%% Ax = b
A1=train_labels*pinv(train_images);
test_results=sign(A1*test_images);
accuracy1 = sum(test_results.' == test_labels)/numel(test_labels);
A2=lasso(train_images.',train_labels.','Lambda',0.1).';
test_results=sign(A2*test_images);
accuracy2 = sum(test_results.' == test_labels)/numel(test_labels);
figure(2)
subplot(1,2,1)
pic1=flipud(reshape(A1,28,28)); pcolor(pic1), colormap(gray),
axis off
figure(2)
subplot(1,2,2)
pic2=flipud(reshape(A2,28,28)); pcolor(pic2), colormap(gray),
axis off
%%
for i = 1:9
subplot(3,3,i), imshow(reshape(test_images(:,i+10),28,28));
end
%%
train_label_fixed = full(ind2vec(train_labels+1,10));
%%
net = patternnet(10,'trainscg');
net.layers{1}.transferFcn = 'tansig';
% net.layers{2}.transferFcn = 'poslin';
[net tr] = train(net,train_images,train_label_fixed,'useParallel','yes'); %,'showResources','yes'
y2 = (net(test_images));
[R,C] = max(y2);
% view(net);
accuracy = sum(C.' == (test_labels+1).')/numel(test_labels) * 100;
%%
clear mean_acc sd_acc;
for i = 5000:5000:60000
clear accuracy
for j = 1:5
net = patternnet(10,'trainscg');
net.layers{1}.transferFcn = 'tansig';
% net.layers{2}.transferFcn = 'poslin';
net = train(net,train_images(:,1:i),train_label_fixed(:,1:i),'useParallel','yes'); %,'showResources','6
y2 = (net(test_images));
[R,C] = max(y2);
% view(net);
accuracy(j) = sum(C.' == (test_labels+1).')/numel(test_labels) * 100;
disp(['Finished step 0.' num2str(j)]);
end
mean_acc(i/5000) = mean(accuracy);
sd_acc(i/5000) = std(accuracy);
disp(['Finished step' num2str(i/5000)]);
end
%%
errorbar(mean_acc,sd_acc,'-','Linewidth',4);
title('Neural Network with 10 layers');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Number of training modes');
set(gcf,'units','points','position',[150,150,1200,1000]);
label_t = 0:2:13;
label = 0:10000:60000;
label_y = 80:1:100;
xticks(label_t);
xticklabels(label);
yticks(label_y);
ylabel('Accuracy (%)');
y = net(train_images);
plotconfusion(train_images,train_label_fixed)
7