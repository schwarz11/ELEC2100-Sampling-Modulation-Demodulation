%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 1 
% x(t) = 8 cos(2pi*1000t) + 4 cos(5pi*1000t) +2 cos(12pi*1000t)
% or x(t) = 8 cos(2pi*1000t)+ 4 cos(2pi*2500t) + 2 cos(2pi*6000t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs1 = 8e3; 			%fs1 = 8kHz, N1 = 100000
N1 = 100000;
n1 = 0: N1-1;
x1 = 8*cos(2*pi*1000*n1/fs1) + 4*cos(2*pi*2500*n1/fs1) + 2*cos(2*pi*6000*n1/fs1);

fs2 = 20e3; 			%fs2 = 20kHz, N2 = 100000
N2 = 100000;
n2 = 0: N2-1;
x2 = 8*cos(2*pi*1000*n2/fs2) + 4*cos(2*pi*2500*n2/fs2) + 2*cos(2*pi*6000*n2/fs2);

f1 = [-N1/2 : (N1/2 -1)]*(fs1/N1);
f2 = [-N2/2 : (N2/2 -1)]*(fs2/N2);

figure(1)
subplot(211); plot(f1, abs(fftshift(fft(x1))/length(x1)));	%plot X1
ylabel('|X1|'); xlabel('f1(Hz)');
subplot(212); plot(f2, abs(fftshift(fft(x2))/length(x2)));	%plot X2
ylabel('|X2|'); xlabel('f2(Hz)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[s, fs] = audioread('m1.wav');				%fs = 88200
s = s';
f = [-length(s)/2 : (length(s)/2 -1)]*(fs/length(s));	%from -fs/2 to fs/2
t = [0:length(s)-1]/fs;

figure(2);
subplot(311); plot(f, abs(fftshift(fft(s)))); ylabel('X(f)');

c1 = cos(2*pi*18e3*t);
x =  s.*c1;				%shifting the higher freq = 18kHz

subplot(312); plot(f, abs(fftshift(fft(x)))); ylabel('Xh(f)');

[B,A] = butter(16, 0.091); %set N = 16
y = filter(B,A,x);

subplot(313); plot(f, abs(fftshift(fft(y)))); ylabel('Xlpf(f)'); xlabel('freq(Hz)');
soundsc(y, fs);
