%% Import Data-------------------------------------------------------------
%% uncropped images
path = 'data\yalefaces';
Files = dir(path);
for i = 3:length(Files)
    img_src = [path, '\', Files(i).name];
    img = imread(img_src);
    img = double(img);
    size_uncropped = size(img);
    data_uncropped(:, i) = reshape(img, size_uncropped(1) * size_uncropped(2), 1);
end

%% cropped images
path = 'data\CroppedYale';
Files_in_main = dir(path);
Files_in_sub = dir([path, '\', Files_in_main(3).name]);
index = 1;
% The "real" folder starts with index of 3
for i = 3:length(Files_in_main)
    subpath = [path, '\', Files_in_main(i).name];
    Files_in_sub = dir(subpath);
    for j = 3:length(Files_in_sub)
        img_src = [subpath, '\', Files_in_sub(j).name];
        img = imread(img_src);
        img = double(img);
        size_cropped = size(img);
        data_cropped(:, index) = reshape(img, size_cropped(1) * size_cropped(2), 1);
        index = index + 1;
    end
end

%% svd analysis------------------------------------------------------------
% substract mean
data_cropped = bsxfun(@minus, data_cropped, mean(data_cropped, 2));
data_uncropped = bsxfun(@minus, data_uncropped, mean(data_uncropped, 2));
% SVD
[u_cropped, s_cropped, v_cropped] = svd(data_cropped, 'econ');
[u_uncropped, s_uncropped, v_uncropped] = svd(data_uncropped, 'econ');

%% Diagonalstic------------------------------------------------------------
figure(2), plot(diag(s_cropped)/sum(diag(s_cropped)), 'ro', 'MarkerSize', 4)

%% Reconstruction----------------------------------------------------------
number = 50; % choose of image
% cropped images
r2 = recons(2, data_cropped, u_cropped, s_cropped, v_cropped, size_cropped, number);
r4 = recons(4, data_cropped, u_cropped, s_cropped, v_cropped, size_cropped, number);
r10 = recons(10, data_cropped, u_cropped, s_cropped, v_cropped, size_cropped, number);
r50 = recons(50, data_cropped, u_cropped, s_cropped, v_cropped, size_cropped, number);
r100 = recons(100, data_cropped, u_cropped, s_cropped, v_cropped, size_cropped, number);

% plot
figure(3);
subplot(2, 3, 1), imshow(r2), title('r = 2');
subplot(2, 3, 2), imshow(r4), title('r = 4');
subplot(2, 3, 3), imshow(r10), title('r = 10');
subplot(2, 3, 4), imshow(r50), title('r = 50');
subplot(2, 3, 5), imshow(r100), title('r = 100');
subplot(2, 3, 6), imshow(reshape(uint8(data_cropped(:, number)), ...
    size_cropped(1), size_cropped(2))), title('Original');

% uncropped images
r2 = recons(2, data_uncropped, u_uncropped, s_uncropped, v_uncropped, size_uncropped, number);
r4 = recons(4, data_uncropped, u_uncropped, s_uncropped, v_uncropped, size_uncropped, number);
r10 = recons(10, data_uncropped, u_uncropped, s_uncropped, v_uncropped, size_uncropped, number);
r50 = recons(50, data_uncropped, u_uncropped, s_uncropped, v_uncropped, size_uncropped, number);
r100 = recons(100, data_uncropped, u_uncropped, s_uncropped, v_uncropped, size_uncropped, number);

% plot
figure(4);
subplot(2, 3, 1), imagesc(r2), title('r = 2'), colormap(gray);
set(gca, 'Xtick', [], 'Ytick', []);
subplot(2, 3, 2), imagesc(r4), title('r = 4'), colormap(gray);
set(gca, 'Xtick', [], 'Ytick', []);
subplot(2, 3, 3), imagesc(r10), title('r = 10'), colormap(gray);
set(gca, 'Xtick', [], 'Ytick', []);
subplot(2, 3, 4), imagesc(r50), title('r = 50'), colormap(gray);
set(gca, 'Xtick', [], 'Ytick', []);
subplot(2, 3, 5), imagesc(r100), title('r = 100'), colormap(gray);
set(gca, 'Xtick', [], 'Ytick', []);
subplot(2, 3, 6), imagesc(reshape(uint8(data_uncropped(:, number)), ...
    size_uncropped(1), size_uncropped(2))), title('Original'), colormap(gray);
set(gca, 'Xtick', [], 'Ytick', []);

function img = recons(rank, data, u, s, v, siz, num)
    mean_value = mean(data, 2);
    r = u(:, 1:rank) * s(1:rank, 1:rank) * v(:, 1:rank).';
    r = r + mean_value;
    img = r(:, num);
    img = reshape(uint8(img), siz(1), siz(2));
end