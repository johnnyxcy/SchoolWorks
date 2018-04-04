function [dat, Fs] = importData(myDir)

musics = dir(fullfile(myDir));
musics = musics(3:end, :);
n = length(musics);

dat = [];

for i = 1:n
    [song, Fs] = audioread(fullfile(myDir, musics(i).name));
    vectorSong = song(:,1);
    dat = [dat; vectorSong];
end

% Get the number of frames in 5 seconds
nIn5 = Fs*5;

% Get the number of 5-second clips
nClips = floor(length(dat)/nIn5);

% Trim the data matrix
dat = dat(1:nIn5*nClips);

% Reshape the data matrix
dat = reshape(dat,[nIn5, nClips]);

end