% Cyclic and Linear Convolution Visualization with N = 128
% We will observe Aliasing because N < P + L - 1

% define N
N = 128; 

% h[n] and x[n]
h = zeros(1, N);
x = zeros(1, N);

h(1:10) = 1;
x(1:30) = 1;
x(51:80) = 0.5;
x(101:125) = 1;

% linear convolution
linear_conv = conv(x, h);

% periodize x and h to length N
x_periodic = repmat(x, 1, 3); % periodized version of x[n] (3 repetitions)
h_periodic = repmat(h, 1, 3); % periodized version of h[n] (3 repetitions)

% cyclic convolution using FFT and IFFT
cyclic_conv = ifft(fft(x, N) .* fft(h, N), N);
cyclic_conv_extended = repmat(cyclic_conv, 1, 3); % extend cyclic convolution to 3 * 128 points

% visualization
figure;

% plot h[n]
subplot(5, 1, 1);
plot(0:N-1, h, 'r', 'LineWidth', 1.5);
title('h[n]');
xlabel('n');
ylabel('h[n]');
xlim([0, 150]);  % extended x-axis to 150

% plot x[n]
subplot(5, 1, 2);
plot(0:N-1, x, 'b', 'LineWidth', 1.5);
title('x[n]');
xlabel('n');
ylabel('x[n]');
xlim([0, 150]);  % extended x-axis to 150

% plot linear convolution (first 128 points only, extended x-axis)
subplot(5, 1, 3);
plot(0:(length(linear_conv) - 1), linear_conv, 'g', 'LineWidth', 1.5);
title('Linear Convolution of h[n] * x[n]');
xlabel('n');
ylabel('Amplitude');
xlim([0, 150]);  % extended x-axis to 150

% plot periodized x and h
subplot(5, 1, 4);
plot(0:(3 * N - 1), x_periodic, 'b', 'LineWidth', 1.5);
hold on;
plot(0:(3 * N - 1), h_periodic, 'r', 'LineWidth', 1.5);
title('Periodized x[n] and h[n]');
xlabel('n');
ylabel('Amplitude');
legend('x_N[n]', 'h_N[n]');
xlim([0, 3 * N - 1]);

% plot cyclic convolution (extended to 3 * 128 points)
subplot(5, 1, 5);
plot(0:(3 * N - 1), real(cyclic_conv_extended), 'k', 'LineWidth', 1.5);
title('Cyclic Convolution of h[n] * x[n]');
xlabel('n');
ylabel('Amplitude');
xlim([0, 3 * N - 1]);

sgtitle('Convolution Analysis: Linear and Cyclic with Aliasing');



% In this second example we choose N ≥ P + L - 1
% Thus we do not have Aliasing

% redefine N
N = 136; 

% h[n] and x[n]
h = zeros(1, N);
x = zeros(1, N);

h(1:10) = 1;
x(1:30) = 1;
x(51:80) = 0.5;
x(101:125) = 1;

% linear convolution
linear_conv = conv(x, h);

% periodize x and h to length N
x_periodic = repmat(x, 1, 3); % periodized version of x[n] (3 repetitions)
h_periodic = repmat(h, 1, 3); % periodized version of h[n] (3 repetitions)

% cyclic convolution using FFT and IFFT
cyclic_conv = ifft(fft(x, N) .* fft(h, N), N);
cyclic_conv_extended = repmat(cyclic_conv, 1, 3); % extend cyclic convolution to 3 * 128 points

% visualization
figure;

% plot h[n]
subplot(5, 1, 1);
plot(0:N-1, h, 'r', 'LineWidth', 1.5);
title('h[n]');
xlabel('n');
ylabel('h[n]');
xlim([0, 150]);  % extended x-axis to 150

% plot x[n]
subplot(5, 1, 2);
plot(0:N-1, x, 'b', 'LineWidth', 1.5);
title('x[n]');
xlabel('n');
ylabel('x[n]');
xlim([0, 150]);  % extended x-axis to 150

% plot linear convolution (first 128 points only, extended x-axis)
subplot(5, 1, 3);
plot(0:(length(linear_conv) - 1), linear_conv, 'g', 'LineWidth', 1.5);
title('Linear Convolution of h[n] * x[n]');
xlabel('n');
ylabel('Amplitude');
xlim([0, 150]);  % extended x-axis to 150

% plot periodized x and h
subplot(5, 1, 4);
plot(0:(3 * N - 1), x_periodic, 'b', 'LineWidth', 1.5);
hold on;
plot(0:(3 * N - 1), h_periodic, 'r', 'LineWidth', 1.5);
title('Periodized x[n] and h[n]');
xlabel('n');
ylabel('Amplitude');
legend('x_N[n]', 'h_N[n]');
xlim([0, 3 * N - 1]);

% plot cyclic convolution (extended to 3 * 128 points)
subplot(5, 1, 5);
plot(0:(3 * N - 1), real(cyclic_conv_extended), 'k', 'LineWidth', 1.5);
title('Cyclic Convolution of h[n] * x[n]');
xlabel('n');
ylabel('Amplitude');
xlim([0, 3 * N - 1]);

sgtitle('Convolution Analysis: Linear and Cyclic no Aliasing');

