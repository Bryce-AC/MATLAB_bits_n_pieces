close all;
clear all;

%extract audio data and sampling frequency from two files
[sig_1,fs_1] = audioread('audio_1.wav');
[sig_2,fs_2] = audioread('audio_2.wav');

%perform fourier transform and circular shift
SIG_1 = fftshift(fft(sig_1(1:length(sig_1),1)));
SIG_2 = fftshift(fft(sig_2(1:length(sig_2),1)));

%generate digital freq axes
fd_1 = linspace(-0.5,0.5,length(SIG_1));
fd_2 = linspace(-0.5,0.5,length(SIG_2));

%multiply digital frequency by sampling frequency for plotting purposes
fd_1 = fd_1 * fs_1;
fd_2 = fd_2 * fs_2;

figure;
%major and minor gridlines
grid on;
grid minor;

hold on;
plot(fd_1,10*log(abs(SIG_1).^2), 'g');
plot(fd_2,10*log(abs(SIG_2).^2), 'r');

%limit to 0 ~ max sampling freq
xlim([0 max(fs_1, fs_2)/2])

%formatting
xlabel('f');
ylabel('power');
set(gca,'color','black');
set(gca,'Xcolor','white');
set(gca,'Ycolor','white');
set(gcf,'color','black');
legend('\color{white}Original','\color{white}Modified');
