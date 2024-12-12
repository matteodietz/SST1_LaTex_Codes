% signal parameters:
f = [ 440 880 1000 2000 ];      % frequencies   
M = 256;                        % signal length 
Fs = 5000;                      % sampling rate

% generate a signal by adding up sinusoids:
x = zeros(1,M);
n = 0:(M-1);
for fk = f 
    x = x + sin(2*pi*n*fk/Fs); 
end

t = (0:M-1)/Fs;    % time vector

% plot x(t) against time
figure;
plot(t, x);
title('Time-Domain Signal x(t)');
xlabel('Time (s)');
ylabel('Amplitude');

% filter parameters:
L = 257;    % filter length 
fc = 600;   % cutoff frequency 

% filter design:
hsupp = (-(L-1)/2:(L-1)/2);
hideal = (2*fc/Fs)*sinc(2*fc*hsupp/Fs);
h = hamming(L)' .* hideal; % h is our filter

% redefine the FFT length for linear convolution
Nfft = L + M - 1;

% zero pad x and h up to Nfft for linear convolution
xzp = [ x zeros(1, Nfft - M) ];
hzp = [ h zeros(1, Nfft - L) ];

% perform FFT-based convolution
X = fft(xzp, Nfft);
H = fft(hzp, Nfft);

Y = X .* H;  % element-wise multiplication in frequency domain

X_shifted = fftshift(X);
H_shifted = fftshift(H);
Y_shifted = fftshift(Y);

f = linspace(-Fs/2, Fs/2, length(H));
figure;
% plot X_shifted in the first subplot
subplot(3,1,1);
plot(f, abs(X_shifted), 'b');
title('Frequency Response of Signal X');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

% plot H_shifted in the second subplot
subplot(3,1,2);
plot(f, abs(H_shifted), 'r');
title('Frequency Response of Filter H');
xlabel('Frequency (Hz)');
ylabel('|H(f)|');
grid on;

% plot Y_shifted in the third subplot
subplot(3,1,3);
plot(f, abs(Y_shifted), 'k');
title('Frequency Response of Filtered Signal Y');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
grid on;

% inverse FFT to get the time-domain filtered signal
y = ifft(Y);

% take real part of y since y should be real valued
y = real(y);

% define the time vector to match the original signal duration
t_y = (0:length(y)-1)/Fs;

% plot y(t) against time
figure;
plot(t_y, y);
title('Filtered Time-Domain Signal y(t)');
xlabel('Time (s)');
ylabel('Amplitude');


