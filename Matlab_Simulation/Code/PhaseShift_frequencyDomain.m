clear all;
close all;
clc;

N = 64; %number of samples
fs = 10; %sampling frequency
ts = 1/fs; %sample interval
tmax = (N-1)*ts;
t = 0:ts:tmax;
y = exp(1i*2*pi*t);
ycheck = cos(2*pi*t);

% plot test signals
figure
plot(t,y)
hold on
plot(t,ycheck,'r--')

% fft
Y = fft(y);
Ycheck = fft(ycheck);

% phase shift
Y = abs(Y).*exp(1i*angle(Y)-1i*pi/2); % -pi/4 shift
Ycheck = abs(Ycheck).*exp(1i*angle(Ycheck)-1i*pi/2); % -pi/2 shift

%ifft
u = ifft(Y);
ucheck = ifft(Ycheck);

% plot
figure
plot(t,real(u),'k')
hold on
plot(t,real(y),'r')
hold on
plot(t,real(ucheck),'g')
hold on
plot(t,ycheck,'b--')
legend('ifft(exp(1i*2*pi*t)) %-pi/2shift','real(cos(2*pi*t))','ifft(cos(2*pi*t)) %-pi/4 shift','cos(2*pi*t)')