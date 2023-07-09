
function u = controllerNoisy(params, t, obs)
  % This is the starter file for the week5 assignment
  % Now you only receive noisy measurements for phi, and must use your EKF from week 3 to filter the data and get an estimate of the state
  % obs = [ay; az; gx] with a* in units of g's, and gx in units of rad/s

  % This template code calls the function EKFupdate that you must complete below
  xhat = EKFupdate(params, t, obs);
  phi = xhat(1);
  phidot = xhat(2);

  % The rest of this function should ideally be identical to your solution in week 4
  % Student completes this
  persistent last_time % this function ensures we keep track of the pevious time
  if isempty(last_time)
      last_time = t;
  end
  
  ei =(0-phi)*(t-last_time); % zero is the reference angle
  ki = 1000;
  kp=50;
  kd=1;
  
  
  u = kp*(0-phi) + kd*(0-phidot) + ki *ei ;
 
  u=-u;
  
  
end

function xhatOut = EKFupdate(params, t, z)
  % z = [ay; az; gx] with a* in units of g's, and gx in units of rad/s
  % You can borrow most of your week 3 solution, but this must only implement a single predict-update step of the EKF
  % Recall (from assignment 5b) that you can use persistent variables to create/update any additional state that you need.

  % Student completes this
  Q = diag([0.01 0.01]);
  R = diag([0.1 0.1 0.1]);
  xhat = [0;0];
  P = eye(2);
  
    persistent  time_ekf
    if isempty(time_ekf)
      %P = eye(2);
      time_ekf = 0;
      %xhat = [0;0];
    end
 
  
  dt = t - time_ekf;
  A = [1 dt; 0 1];
  xhat = A*xhat;
  P = A*P*A' + Q;
  
  phi = xhat(1);
  phidot = xhat(2);
  
  H = [cos(phi) -sin(phi) 0; 0 0 1]'; 
  K = P*H'/(H*P*H' + R);
  
  h = [sin(phi) cos(phi) phidot]';
  xhat = xhat + K*(z - h);
  P = (eye(2) - K*H)*P;
  
  time_ekf = t;
  xhatOut = xhat;
end