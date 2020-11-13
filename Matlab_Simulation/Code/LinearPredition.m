 
  noise = randn(500,1);  % Normalized white Gaussian noise
  x = filter(1,[1 1/2 1/3 1/4],noise);
  a = lpc(x,3);
  est_x = filter([0 -a(2:end)],1,x);  % Estimated signal
  e = x - est_x;                      % Prediction error
  [acs,lags] = xcorr(e,'coeff');      % ACS of prediction error
 
%   Compare the predicted signal to the original signal
 plot(1:97,x(4001:4097),1:97,est_x(4001:4097),'--');
 title('Original Signal vs. LPC Estimate');
 xlabel('Sample Number'); ylabel('Amplitude'); grid;
 legend('Original Signal','LPC Estimate')