%% 
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/Avril');
training = dir('Avril*');
[y_1, Fs] = audioread(training(1).name);
disp('Part 1');
for j = 1:5
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:35
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 1;
row = row + 1;
end
end
Avril_train = (train);
Avril_actual = actual;
clear actual;
clear train;
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/Beatles');
training = dir('Beatles*');
display('Part 2');
for j = 1:length(training)
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:35
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
14
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 2;
row = row + 1;
end
end
Beatles_train = (train);
Beatles_actual = actual;
% cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3');
% display('saving train data');
% savefast('Beatles_train.mat', 'Beatles_train');
% display('saving class');
% savefast('Beatles_actual.mat', 'Beatles_actual');
clear actual;
clear train;
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/Beethoven');
training = dir('Beethoven*');
display('Part 3');
for j = 1:length(training)
display(['Working on song ', num2str(j)]);
starts = 101 * 5 * Fs + 1;
for i = 1:50
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 3;
row = row + 1;
end
end
Beeth_train = (train);
Beeth_actual = actual;
% cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3');
% display('saving train data');
% savefast('Beeth_train.mat', 'Beeth_train');
% display('saving class');
% savefast('Beeth_actual.mat', 'Beeth_actual');
%%
actual = [Avril_actual; Beatles_actual; Beeth_actual];
train = [Avril_train; Beatles_train; Beeth_train];
p = randperm(length(actual));
%%
train_t = train;
class_data = actual;
for i = 1:length(p)
train_t(i, :) = train(p(i), :);
class_data(i,1) = actual(p(i));
end
[u s v] = svd(train_t, 'econ');
%% cumulative energy
diag_s = diag(s)/sum(diag(s));
sum_s(1) = diag_s(1);
for i = 2:length(diag_s)
sum_s(i) = sum_s(i-1) + diag_s(i);
15
end
figure
plot(sum_s, 'ro','Linewidth', 2);
title('Energy of each sigularvalues from each direction of part 4 videos');
yticks(0:0.1:1);
line(1:550,linspace(0.9,0.9,550),'Linewidth', 2 );
set(gca,'Fontsize',20,'fontweight','bold');
set(gcf,'units','points','position',[150,150,800,700]);
xlabel('Singular values');
ylabel('Energy');
%% all data
clear acc_1 acc_2 acc_3;
clear total_1 total_2 total_3
test_modes = 50;
for train_modes=20:20:360
p = randperm(length(actual));
train_class = class_data(p(1:train_modes));
train_u = u(p(1:train_modes),:);
test_class = class_data(p((train_modes + 1 : train_modes + test_modes)));
test_u= u(p((train_modes + 1 : train_modes + test_modes)),:);
model_1 = svm.train(train_u,train_class);
model_2 = fitcnb(train_u,train_class);
model_3 = fitcknn(train_u,train_class);
clear total_nav_1 total_nav_2 total_nav_3
for i = 1:10
% svm
prediction_1=svm.predict(model_1,real(test_u));
Accuracy=mean(test_class==prediction_1)*100;
total_1(i,1) = Accuracy;
% fitNaiveBayes
prediction_2 = predict(model_2,test_u);
Accuracy=mean(test_class==prediction_2)*100;
total_2(i,1) = Accuracy;
[rows_1, cols_1] = find(test_class == 1);
nav_pred_1 = prediction_2(rows_1);
accuracy_nav_1 = mean(nav_pred_1 == 1)*100;
[rows_2, cols_2] = find(test_class == 2);
nav_pred_2 = prediction_2(rows_2);
accuracy_nav_2 = mean(nav_pred_2 == 2)*100;
[rows_3, cols_3] = find(test_class == 3);
nav_pred_3 = prediction_2(rows_3);
accuracy_nav_3 = mean(nav_pred_3 == 3)*100;
total_nav_1(i,1) = accuracy_nav_1;
total_nav_2(i,1) = accuracy_nav_2;
total_nav_3(i,1) = accuracy_nav_3;
% knn
prediction_3 = predict(model_3,test_u);
Accuracy=mean(test_class==prediction_3)*100;
total_3(i,1) = Accuracy;
end
16
sd_1(train_modes/20,1) = std(total_1);
sd_2(train_modes/20,1) = std(total_2);
sd_3(train_modes/20,1) = std(total_3);
acc_1(train_modes/20,1) = mean(total_1);
acc_2(train_modes/20,1) = mean(total_2);
acc_3(train_modes/20,1) = mean(total_3);
sd_nav_1(train_modes/20,1) = std(total_nav_1);
sd_nav_2(train_modes/20,1) = std(total_nav_2);
sd_nav_3(train_modes/20,1) = std(total_nav_3);
acc_nav_1(train_modes/20,1) = mean(total_nav_1);
acc_nav_2(train_modes/20,1) = mean(total_nav_2);
acc_nav_3(train_modes/20,1) = mean(total_nav_3);
display(['completing modes ', num2str(train_modes)])
end
%%
figure
% plot(acc_1,'-','Linewidth',6); hold on;
% plot(acc_2,'-','Linewidth',6)
% plot(acc_3,'-','Linewidth',6)
errorbar(acc_1,sd_1,'-','Linewidth',4); hold on
errorbar(acc_2,sd_2,'-','Linewidth',4);
errorbar(acc_3,sd_3,'-','Linewidth',4);
legend('Multi-class svm', 'Naive Bayes', 'K-Nearest Neighbor','Location','southeast');
title('Band Classification - Accuracy of different algorithms with 50 test data');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Number of training modes');
set(gcf,'units','points','position',[150,150,1200,1000]);
label_t = 0:1:19;
label = 0:20:380;
xticks(label_t);
xticklabels(label);
ylabel('Accuracy (%)');
%%
figure
plot(acc_nav_1,'-','Linewidth',6); hold on;
plot(acc_nav_2,'-','Linewidth',6)
plot(acc_nav_3,'-','Linewidth',6)
% errorbar(acc_svm_1,sd_svm_1,'-','Linewidth',4); hold on
% errorbar(acc_svm_2,sd_svm_2,'-','Linewidth',4);
% errorbar(acc_svm_3,sd_svm_3,'-','Linewidth',4);
legend('Avril', 'Beatles', 'Beethoven','Location','southeast');
title('Band Classification - Accuracy of different Categories with 50 test data');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Number of training modes');
set(gcf,'units','points','position',[150,150,1200,1000]);
label_t = 0:1:19;
label = 0:20:380;
label_y = 0:10:100;
xticks(label_t);
xticklabels(label);
yticks(label_y);
ylabel('Accuracy (%)');
row = 1;
17
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/Alice in chains');
training = dir('Alice*');
[y_1, Fs] = audioread(training(1).name);
display('Part 1');
for j = 1:length(training)
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:40
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 1;
row = row + 1;
end
end
alice_train = (train);
alice_actual = actual;
%%
% cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3');
% display('saving train data');
% savefast('alice_train.mat', 'alice_train');
% display('saving class');
% savefast('alice_actual.mat', 'alice_actual');
clear actual;
clear train;
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/Pearl Jam');
training = dir('Pearl*');
display('Part 2');
for j = 1:length(training)
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:40
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 2;
row = row + 1;
end
end
pearl_train = (train);
pearl_actual = actual;
% cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3');
% display('saving train data');
% savefast('pearl_train.mat', 'pearl_train');
% display('saving class');
% savefast('pearl_actual.mat', 'pearl_actual');
clear actual;
clear train;
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/Soundgarden');
training = dir('Sound*');
display('Part 3');
18
for j = 1:length(training)
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:40
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 3;
row = row + 1;
end
end
sound_train = (train);
sound_actual = actual;
%%
actual = [alice_actual; pearl_actual; sound_actual;];
train = [alice_train; pearl_train; sound_train;];
p = randperm(length(actual));
%%
train_t = train;
class_data = actual;
for i = 1:length(p)
train_t(i, :) = train(p(i), :);
class_data(i,1) = actual(p(i));
end
[u s v] = svd(train_t, 'econ');
%% cumulative energy
diag_s = diag(s)/sum(diag(s));
sum_s(1) = diag_s(1);
for i = 2:length(diag_s)
sum_s(i) = sum_s(i-1) + diag_s(i);
end
figure
plot(sum_s, 'ro','Linewidth', 2);
title('Energy of each sigularvalues from each direction of part 4 videos');
yticks(0:0.1:1);
line(1:550,linspace(0.9,0.9,550),'Linewidth', 2 );
set(gca,'Fontsize',20,'fontweight','bold');
set(gcf,'units','points','position',[150,150,900,800]);
xlabel('Singular values');
ylabel('Energy');
%% loop for first method
clear acc;
test_modes = 200;
for train_modes=20:20:300
for i = 1:5
test_p = randperm(length(actual));
% train_class = class_data(test_p(1:train_modes),:);
% train_u = u(test_p(1:train_modes),:);
train_class = class_data((2:train_modes+1));
train_u = u((2:train_modes+1),:);
test_class = class_data(test_p((1 : test_modes)));
test_u= u(test_p((1 : test_modes)),:);
% test
Model=svm.train(train_u,train_class);
prediction=svm.predict(Model,real(test_u));
19
Accuracy=mean(test_class==prediction)*100;
total(i,1) = Accuracy;
end
acc(train_modes/20,1) = mean(total);
end
figure
plot(acc,'-ro');
%% constant tes modes, vary train mode
clear acc_1 acc_2 acc_3;
clear total_1 total_2 total_3 sd_1 sd_2 sd_3
test_modes = 50;
for train_modes=20:20:360
p = randperm(length(actual));
train_class = class_data(p(1:train_modes));
train_u = u(p(1:train_modes),:);
test_class = class_data(p((train_modes + 1 : train_modes + test_modes)));
test_u= u(p((train_modes + 1 : train_modes + test_modes)),:);
model_1 = svm.train(train_u,train_class);
model_2 = fitcnb(train_u,train_class);
model_3 = fitcknn(train_u,train_class);
clear total_nav_1 total_nav_2 total_nav_3
for i = 1:10
% svm
prediction_1=svm.predict(model_1,real(test_u));
Accuracy=mean(test_class==prediction_1)*100;
total_1(i,1) = Accuracy;
% fitNaiveBayes
prediction_2 = predict(model_2,test_u);
Accuracy=mean(test_class==prediction_2)*100;
total_2(i,1) = Accuracy;
[rows_1, cols_1] = find(test_class == 1);
nav_pred_1 = prediction_2(rows_1);
accuracy_nav_1 = mean(nav_pred_1 == 1)*100;
[rows_2, cols_2] = find(test_class == 2);
nav_pred_2 = prediction_2(rows_2);
accuracy_nav_2 = mean(nav_pred_2 == 2)*100;
[rows_3, cols_3] = find(test_class == 3);
nav_pred_3 = prediction_2(rows_3);
accuracy_nav_3 = mean(nav_pred_3 == 3)*100;
total_nav_1(i,1) = accuracy_nav_1;
total_nav_2(i,1) = accuracy_nav_2;
total_nav_3(i,1) = accuracy_nav_3;
% knn
prediction_3 = predict(model_3,test_u);
Accuracy=mean(test_class==prediction_3)*100;
total_3(i,1) = Accuracy;
end
sd_1(train_modes/20,1) = std(total_1);
sd_2(train_modes/20,1) = std(total_2);
20
sd_3(train_modes/20,1) = std(total_3);
acc_1(train_modes/20,1) = mean(total_1);
acc_2(train_modes/20,1) = mean(total_2);
acc_3(train_modes/20,1) = mean(total_3);
sd_nav_1(train_modes/20,1) = std(total_nav_1);
sd_nav_2(train_modes/20,1) = std(total_nav_2);
sd_nav_3(train_modes/20,1) = std(total_nav_3);
acc_nav_1(train_modes/20,1) = mean(total_nav_1);
acc_nav_2(train_modes/20,1) = mean(total_nav_2);
acc_nav_3(train_modes/20,1) = mean(total_nav_3);
display(['completing modes ', num2str(train_modes)])
end
%% plot for first
figure
% plot(acc_1,'-','Linewidth',6); hold on;
% plot(acc_2,'-','Linewidth',6)
% plot(acc_3,'-','Linewidth',6)
errorbar(acc_1,sd_1,'-','Linewidth',4); hold on
errorbar(acc_2,sd_2,'-','Linewidth',4);
errorbar(acc_3,sd_3,'-','Linewidth',4);
legend('Multi-class svm', 'Naive Bayes', 'K-Nearest Neighbor','Location','southeast');
title('Seattle Band Classification - Accuracy of different algorithms with 50 test data');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Number of training modes');
set(gcf,'units','points','position',[150,150,1200,1000]);
label_t = 0:1:19;
label = 0:20:380;
xticks(label_t);
xticklabels(label);
ylabel('Accuracy (%)');
%% plot for second
figure
plot(acc_nav_1,'-','Linewidth',6); hold on;
plot(acc_nav_2,'-','Linewidth',6)
plot(acc_nav_3,'-','Linewidth',6)
% errorbar(acc_svm_1,sd_svm_1,'-','Linewidth',4); hold on
% errorbar(acc_svm_2,sd_svm_2,'-','Linewidth',4);
% errorbar(acc_svm_3,sd_svm_3,'-','Linewidth',4);
legend('Alice', 'Pearl', 'Sound','Location','southeast');
title('Seattle Band Classification - Accuracy of different Categories with 50 test data');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Number of training modes');
set(gcf,'units','points','position',[150,150,1200,1000]);
label_t = 0:1:19;
label = 0:20:380;
label_y = 0:10:100;
xticks(label_t);
xticklabels(label);
yticks(label_y);
ylabel('Accuracy (%)');
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/genres/rock');
21
training = dir('rock*');
[y_1, Fs] = audioread(training(1).name);
display('Part 1');
for j = 1:50
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:5
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 1;
row = row + 1;
end
end
rock_train = (train);
rock_actual = actual;
clear actual;
clear train;
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/genres/jazz');
training = dir('jazz*');
display('Part 4');
for j = 1:50
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:5
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 2;
row = row + 1;
end
end
jazz_train = (train);
jazz_actual = actual;
clear actual;
clear train;
row = 1;
cd('/Users/leoleung/Documents/MATLAB/Amath482/project 3/audio/genres/classical');
training = dir('classical*');
display('Part 5');
for j = 1:50
display(['Working on song ', num2str(j)]);
starts = 1;
for i = 1:5
sample = audioread(training(j).name, [starts (starts + 5 * Fs) - 1]);
starts = (starts + 5 * Fs) + 1;
spec1 = spectrogram(sample(:, 1));
siz = size(spec1);
train(row,:) = reshape(abs(spec1), 1, siz(1) * siz(2));
actual(row,1) = 3;
row = row + 1;
22
end
end
classical_train = (train);
classical_actual = actual;
%%
actual = [rock_actual; jazz_actual; classical_actual];
train = [rock_train; jazz_train; classical_train];
p = randperm(length(actual));
train_t = train;
class_data = actual;
for i = 1:length(p)
train_t(i, :) = train(p(i), :);
class_data(i,1) = actual(p(i));
end
[u s v] = svd(train_t, 'econ');
%% cumulative energy
diag_s = diag(s)/sum(diag(s));
sum_s(1) = diag_s(1);
for i = 2:length(diag_s)
sum_s(i) = sum_s(i-1) + diag_s(i);
end
figure
plot(sum_s, 'ro','Linewidth', 2);
title('Energy of each sigularvalues from each direction of part 4 videos');
yticks(0:0.1:1);
line(1:550,linspace(0.9,0.9,550),'Linewidth', 2 );
set(gca,'Fontsize',20,'fontweight','bold');
set(gcf,'units','points','position',[150,150,800,700]);
xlabel('Singular values');
ylabel('Energy');
%%
u = u(2:end,:);
class_data = class_data(2:end);
%% all data
clear acc_1 acc_2 acc_3;
clear total_1 total_2 total_3
test_modes = 50;
for train_modes=20:20:400
% p = randperm(length(class_data));
train_class = class_data((1:train_modes));
train_u = u((1:train_modes),:);
test_class = class_data(((train_modes + 1 : train_modes + test_modes)));
test_u= u(((train_modes + 1 : train_modes + test_modes)),:);
model_1 = svm.train(train_u,train_class);
model_2 = fitcnb(train_u,train_class);
model_3 = fitcknn(train_u,train_class);
clear total_nav_1 total_nav_2 total_nav_3
for i = 1:10
% svm
prediction_1=svm.predict(model_1,real(test_u));
Accuracy=mean(test_class==prediction_1)*100;
total_1(i,1) = Accuracy;
% fitNaiveBayes
23
prediction_2 = predict(model_2,test_u);
Accuracy=mean(test_class==prediction_2)*100;
total_2(i,1) = Accuracy;
[rows_1, cols_1] = find(test_class == 1);
nav_pred_1 = prediction_2(rows_1);
accuracy_nav_1 = mean(nav_pred_1 == 1)*100;
[rows_2, cols_2] = find(test_class == 2);
nav_pred_2 = prediction_2(rows_2);
accuracy_nav_2 = mean(nav_pred_2 == 2)*100;
[rows_3, cols_3] = find(test_class == 3);
nav_pred_3 = prediction_2(rows_3);
accuracy_nav_3 = mean(nav_pred_3 == 3)*100;
total_nav_1(i,1) = accuracy_nav_1;
total_nav_2(i,1) = accuracy_nav_2;
total_nav_3(i,1) = accuracy_nav_3;
% knn
prediction_3 = predict(model_3,test_u);
Accuracy=mean(test_class==prediction_3)*100;
total_3(i,1) = Accuracy;
end
sd_1(train_modes/20,1) = std(total_1);
sd_2(train_modes/20,1) = std(total_2);
sd_3(train_modes/20,1) = std(total_3);
acc_1(train_modes/20,1) = mean(total_1);
acc_2(train_modes/20,1) = mean(total_2);
acc_3(train_modes/20,1) = mean(total_3);
sd_nav_1(train_modes/20,1) = std(total_nav_1);
sd_nav_2(train_modes/20,1) = std(total_nav_2);
sd_nav_3(train_modes/20,1) = std(total_nav_3);
acc_nav_1(train_modes/20,1) = mean(total_nav_1);
acc_nav_2(train_modes/20,1) = mean(total_nav_2);
acc_nav_3(train_modes/20,1) = mean(total_nav_3);
display(['completing modes ', num2str(train_modes)])
end
%%
figure
% plot(acc_1,'-','Linewidth',6); hold on;
% plot(acc_2,'-','Linewidth',6)
% plot(acc_3,'-','Linewidth',6)
errorbar(acc_1,sd_1,'-','Linewidth',4); hold on
errorbar(acc_2,sd_2,'-','Linewidth',4);
errorbar(acc_3,sd_3,'-','Linewidth',4);
legend('Multi-class svm', 'Naive Bayes', 'K-Nearest Neighbor','Location','southeast');
title('Genre Classification - Accuracy of different algorithms with 50 test data');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Number of training modes');
set(gcf,'units','points','position',[150,150,1200,1000]);
label_t = 0:2:23;
label = 0:40:460;
xticks(label_t);
24
xticklabels(label);
ylabel('Accuracy (%)');
%%
figure
plot(acc_nav_1,'-','Linewidth',6); hold on;
plot(acc_nav_2,'-','Linewidth',6)
plot(acc_nav_3,'-','Linewidth',6)
% errorbar(acc_nav_1,sd_nav_1,'-','Linewidth',4); hold on
% errorbar(acc_nav_2,sd_nav_2,'-','Linewidth',4);
% errorbar(acc_nav_3,sd_nav_3,'-','Linewidth',4);
legend('Rock', 'Jazz', 'Classical','Location','southeast');
title('Genre Classification - Accuracy of different Categories with 50 test data');
set(gca,'Fontsize',24,'fontweight','bold');
xlabel('Number of training modes');
set(gcf,'units','points','position',[150,150,1200,1000]);
label_t = 0:1:19;
label = 0:20:380;
label_y = 0:10:100;
xticks(label_t);
xticklabels(label);
yticks(label_y);
ylabel('Accuracy (%)');
25