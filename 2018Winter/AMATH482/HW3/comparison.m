clc; clear all; close all;
%% Comparison
load('dt_1.mat'); load('nb_1.mat');
dt1 = acc_dt; nb1 = acc_nb;
load('dt_2.mat'); load('nb_2.mat');
dt2 = acc_dt; nb2 = acc_nb;
load('dt_3.mat'); load('nb_3.mat');
dt3 = acc_dt; nb3 = acc_nb;

dt1_mean = mean(dt1); dt1_var = var(dt1);
nb1_mean = mean(nb1); nb1_var = var(nb1);
dt2_mean = mean(dt2); dt2_var = var(dt2);
nb2_mean = mean(nb2); nb2_var = var(nb2);
dt3_mean = mean(dt3); dt3_var = var(dt3);
nb3_mean = mean(nb3); nb3_var = var(nb3);

dtmeans = [dt1_mean, dt2_mean, dt3_mean];
nbmeans = [nb1_mean, nb2_mean, nb3_mean];
dtvars = [dt1_var, dt2_var, dt3_var];
nbvars = [nb1_var, nb2_var, nb3_var];

figure
hb = bar([1, 2, 3], [dtmeans, nbmeans]);
set(hb(1), 'FaceColor','r')
set(hb(2), 'FaceColor','b')
set(hb(3), 'FaceColor','g')

%%
data = [[dt1_mean, nb1_mean]; [dt2_mean, nb2_mean]; [dt3_mean, nb3_mean]];
figure(1)
b = bar(data);
err = [[dt1_var, nb1_var]; [dt2_var, nb2_var]; [dt3_var, nb3_var]];
hold on;
title('Comparison Between Different Tests and Classifiers')
xlabel('Test #');
ylabel('Accuracy');
legend('Decision Tree', 'Naive Bayes');
grid on;