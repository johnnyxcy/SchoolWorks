function [ stim, spikeTrain, move_gabor] = generate_v1_white_noise_exp(exp_sec)

filter_radius = 10;
[x, y] = meshgrid(-filter_radius/2:filter_radius/2, -filter_radius/2:filter_radius/2);
x = (x/filter_radius)*pi/2;
y = (y/filter_radius)*pi/2;
wx = 0;
wy = 1.8;
mu_x = 0;
mu_y = 0;
sigmax = 0.3;
sigmay = 0.1;

fs = 60;
phase_Hz = 0.5;
seconds = 1;
t = 0:(1/fs):seconds-1/fs;
gabor_all = [];
phases = sin(phase_Hz*2*pi*t);
plot(phases)
gaussian = exp((-(x-mu_x).^2)/sigmax*2 - ((y-mu_y).^2)/sigmay*2);

for phase = phases
    sinusoid = sin(2*pi*(x*wx + y*wy + phase));
    gabor = gaussian.*sinusoid;
    gabor_all = cat(3, gabor_all, gabor);
end
mu = 0.15;
sigma = 0.05;
time_env = squeeze(exp(-0.5*((t-mu)/sigma).^2));
move_gabor = bsxfun(@times, gabor_all, reshape(time_env , 1, 1, length(time_env)));
%move_gabor = cat(3, zeros(length(x), length(y), round(fs/10)), move_gabor);

stim = normrnd(0, 5, length(x), length(y), exp_sec*fs);
%cv = convn(stim, move_gabor, 'same');
%resp = squeeze(cv(6, 6, :));
resp = ifft(fft(stim,[],3).*fft(move_gabor, exp_sec*fs, 3),[],3);
resp = squeeze(sum(sum(resp, 1),2));
thresh = std(resp)*1.5;
spikeTrain = resp>thresh;
spikeTrain(length(spikeTrain)-fs*2:end) = 0;
spikeTrain(1:fs*2) = 0;
end

