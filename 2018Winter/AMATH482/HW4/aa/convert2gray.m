function [camx_x] = convert2gray(camx_xrgb)
% convert2gray Pass in a 4d video in RGB, function
% returns a 3D black and white video

% Convert to grayscale
numframes = size(camx_xrgb, 4);

for k = numframes:-1:1
    camx_x(:, :, k) = double(rgb2gray(camx_xrgb(:, :,:, k)));
end

end