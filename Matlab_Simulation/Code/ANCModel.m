
%% Matlab initialization.
% Clearing all signals and plots

clc
clear all
close all
TRUE  = 1;
FALSE = 0;
color = ['b' 'r' 'g' 'y' 'o'];
%load Wz.mat


%% Global variable initializations
%Initialising signal attributes and  control signals

Fn            = 1000;                    % Frequency of noise required
Fp            = 10;                     % Primary signal frequency
SecPathMdl    = 0.05*ones(1,128);        % Secondary path model
Time          = 5;                       % Total time of the sample signal to process in Sec               
Fs            = 1000;                    % Sampling frequency
Ts            = 1/Fs;                    % Sampling time
FiltOrder     = 128;                     % Filter order
t             = 0:Ts:Time-Ts;            % Impulse train
SigSize       = length(t);               % Signal size for testing
mu            = 0.01;                    % Adaptive algorithm coefficient.
Control       = [1 5];                   % 1 = LMS, 2 = LMS+PID, 3 = FxLMS, 4 = FxLMS + PID, 5 = NLMS, 6 = FxNLMS
AntiPhaseF    = 0.25;                    % Anti - phase factor
Wz            = -0.001 * ones(1,FiltOrder);% Initial filter coefficients ; ones(1,FiltOrder);(0.001*(0:FiltOrder-1));


%Generic session control
DisplayPrimary        = TRUE;           % Display primary signal and noise. 1 = show, 0 = do not show
DisplayPrimDiffSig    = FALSE;           % Display signal difference between signal and noise.
SigAntiphase          = FALSE;           % Primary signal is added with anti - phase of primary noise 
SigPrediction         = FALSE;           % Primary future error will predict based on history


%% Generate the Primary signal ( Audio signal )
% This is the model sigal coming from Audio device

%PrimSig = 0.2 * ( 2*wgn(1,SigSize,0) + randn(1,SigSize));
PrimSig = 0.3 * sin(2*pi*t*Fp);
DesiredSig = PrimSig;
if DisplayPrimary == TRUE
figure
plot(t,PrimSig)
title('Primary signal');xlabel('Time Sec');ylabel('Amplitude');
end 



%% Generate the Primary noise signal
% This is the model sigal coming from primary noise microphone

PrimNoise = 0.015 * ( 3.8 * wgn(1,SigSize,0) + 5 * randn(1,SigSize)  + 15*sin(2*pi*t*Fn));
if DisplayPrimary == TRUE
figure
plot(t,PrimNoise)
title('Noise signal');xlabel('Time Sec');ylabel('Amplitude');
end


%% Generate the difference of noise with primary signal
% For visual inspection

PrimDiffSig = PrimSig - PrimNoise;
if DisplayPrimDiffSig == TRUE
figure
plot(t,PrimSig, 'b');
hold on
plot(t,PrimDiffSig, 'g');
hold off
end

%%
%Primary signal needs to pass through many electronic components so require
%a transfer function ( H ) multiplication to find the desired signal

Tf_num = [8 18 32];
Tf_den = [2 6 14 56];
H = tf(Tf_num, Tf_den, Fs);


%% ANC implementation
% Based on control signal various options will be enabled.

% Anti phase signal
if SigAntiphase == TRUE
    PrimSig = PrimSig - AntiPhaseF * PrimNoise;
end

% Initialse buffer
e = zeros(1, SigSize);                   % Initialise error to zero
Signal = [zeros(1,FiltOrder),PrimSig + PrimNoise];   % Make signal length depend on filter order for calculation
temp = [zeros(1,FiltOrder),PrimSig];

%% ESTIMATE SECONDARY PATH SIGNAL USING LMS %
Sz = SecPathMdl/2;
%run known signal through filter
yp=conv(Sz,PrimSig);
%initalize Sz hat values
Szh=zeros(FiltOrder,1);

%% Signal processing

for i = 1:length(Control)
    % FxLMS init
    if Control(i) == 3 || Control(i) == 6
        Szh=0.01 *ones(1,FiltOrder);
        for n = 1:SigSize
            yvec = Signal(n +FiltOrder -1 : -1 : n); %input has to be in reverse order
            e(n)=yp(n)-Szh*yvec'; %update error
            Szh=Szh+mu*yvec*(e(n)); %update filter coefficient
        end
        SzhInv = abs(ifft(1./abs(fft(Szh))));
    end
    for n = 1:SigSize
        
        %Reversing the signal. Need to treat latest signal value with the
        %leftmost coeffient
        SigVector = Signal( n +FiltOrder -1 : -1 : n); 
        %Normalsed filter coefficient adaption
        if Control(i) == 5 || Control(i) ==6
            mu_n = mu/(0.001 +(SigVector * SigVector'));
        end
        e(n) = DesiredSig(n) - Wz * SigVector';% Update the error
        
        if e(n) > 10
            e(n) =10;
        end
        if e(n) < -10
            e(n) =-10;
        end
        if Control(i) == 1
        Wz = Wz + mu * e(n) * SigVector;
        end
        if Control(i) == 5
            Wz = Wz + mu_n * e(n) * SigVector;
        end
        if Control(i) == 3
            %filter input by learned filter to get x prime
            %FxLMSFilt = conv(0.0005*Szh,SigVector);
            Wz = Wz + 0.0005*mu * SzhInv * e(n);
        end
        if Control(i) == 6
            %FxLMSFilt = conv(0.0005*Szh,SigVector);
            Wz = Wz + 0.0005*mu * SzhInv * e(n);
        end
    end
    %error = Y-(PrimSig + PrimNoise);
    % Quality of the filter is to produce the minimum average error
    Q = mean(abs(e));
    
    %% Display the output
    if Control(i) == 1
        fprintf('Quality of LMS filter is       = %d.\n',Q);
        figure
        plot(t,e); title('Error LMS');xlabel('Time Sec');ylabel('Amplitude');
        hold on
        %plot(t,PrimNoise, 'r');
        hold off
    end
    if Control(i) == 2
        fprintf('Quality of LMS+PID filter is   = %d.\n',Q);
        figure
        plot(t,e); title('Error LMS+PID');xlabel('Time Sec');ylabel('Amplitude');
        hold on
        plot(t,PrimNoise, 'r');
        hold off
    end
    if Control(i) == 3
        fprintf('Quality of FxLMS+PID filter is = %d.\n',Q);
        figure
        plot(t,e); title('Error FxLMS');xlabel('Time Sec');ylabel('Amplitude');
    end
    if Control(i) == 4
        fprintf('Quality of FxLMS+PID filter is = %d.\n',Q);
        figure
        plot(t,e); title('Error FxLMS+PID');xlabel('Time Sec');ylabel('Amplitude');
    end
    if Control(i) == 5
        fprintf('Quality of NLMS filter is = %d.\n',Q);
        figure
        plot(t,e); title('Error NLMS');xlabel('Time Sec');ylabel('Amplitude');
    end
    if Control(i) == 6
        fprintf('Quality of FxNLMS filter is = %d.\n',Q);
        figure
        plot(t,e); title('Error FxNLMS');xlabel('Time Sec');ylabel('Amplitude');
    end
    
end
%%

