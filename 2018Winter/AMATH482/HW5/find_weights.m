function [w]=find_weights(times, modes)
data = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
data = data(:, 1:modes*10000);
% -----user-defined parameters-----
pattern=10;element=size(data, 2);pixel=size(data, 1);
alpha=0.1;% Learing rate
% -----user-defined parameters-----

% --------initialization--------
w=zeros(pattern,pixel);%weights
e=ones(pattern,element);%error
d=0;% desired output
% --------initialization--------
for count=1:times
    for j=1:pattern
        for i=1:element
            y=sign(data(:,i)'*w(j,:)');
            if mod(j,10)==labels(i)
                d=1;
            else
                d=-1;
            end
            e(j,i)=d-y;
            w(j,:) = w(j,:)+alpha.*e(j,i).*data(:,i)';
        end
    end
end

end