
function xhat = EKFstudent(t, z)
  % In this exercise, you will batch-process this data: you are provided a vector of timestamps (of length T), and a 3xT matrix of observations, z.
  xhat = zeros(2,length(t));

  % Student completes this
  P = zeros(2,2,length(t)); %State covariance matrix
  Q = [0.1 0;0 0.1];
  R = [0.009 0 0;0 0.009 0;0 0 0.001];
  g = 1;
  xhat(:,1) = [2,0];
  P(:,:,1) = [.5 .5;.5 .5]; 
  
 

  for i=2:length(t)
      dt = t(i) - t(i-1);
      A = [1 dt;0 1]; %Transition matrix for velocity term
      
      %prediction
      xkp = A*xhat(:,i-1);
      Pkp = A*P(:,:,i-1)*A' + Q;
      
      %Setting the optimal Kalman Gain
      H = [g*cosd(xhat(1,i))*(pi/180) 0; -g*sind(xhat(1,i))*(pi/180) 0;0 1]; %%This is the Jacobian of h
      h = [g*sind(xkp(1)); g*cosd(xkp(1)); xkp(2)]; %xkp(1) is phi and xkp(2) is phi_dot. This is the non linear measurement
      K = Pkp*H'/(H*Pkp*H' + R);
      
      %Updating xhat and covariance values
      xhat(:,i) = xkp + K*(z(:,i) - h);
      P(:,:,i) = (eye(2) - K*H)*Pkp;      
     
  end
end