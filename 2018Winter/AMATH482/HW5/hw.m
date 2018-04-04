clc; clear all; close all;
%% Import test data
test_img = loadMNISTImages('t10k-images.idx3-ubyte');
test_lab = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_lab = test_lab';
%% A using weight bias algorithm
tic
acc = zeros(6, 1);
for n = 1:6
    w =find_weights(5, n);
    % Test
    pattern=10;element=size(test_img, 2);pixel=size(test_img, 1);
    e=ones(pattern,element);
    for j=1:pattern
        for i=1:element
            y=sign(test_img(:,i)'*w(j,:)');
            if mod(j,10)==test_lab(i)
                d=1;
            else
                d=-1;
            end
            e(j,i)=d-y;
        end
    end
    sum=0;
    for j=1:pattern
        for i=1:element
            if e(j,i)~=0
                sum=sum+1;
            end
        end
    end
    % Find accuracy
    acc(n) = sum/element;
end
toc
%%
plot(1:6, acc * 100, 'LineWidth', 2);
title('Training Modes vs. Test Accuracy');
xlabel('Number of Training Modes in 10^4');
ylabel('Accuracy in Percentage');