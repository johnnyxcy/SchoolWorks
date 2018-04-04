exp_sec = input('How many seconds to run the white noise experiment? \n  Enter a number, at least 10:  ');
[stim, spikeTrain] = generate_v1_white_noise_exp(exp_sec);
frame_rate = 60;
time_between_samples = 1/frame_rate;
