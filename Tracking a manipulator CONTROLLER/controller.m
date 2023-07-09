
function u = controller(params, t, X)
  %u=[0; 0];
  % 1. write out the forward kinematics, such that p = FK(theta1, theta2)
  % 2. Let e = p - params.traj(t) be the task-space error
  % 3. Calculate the manipulator Jacobian J = d p / d theta
  % 4. Use a "natural motion" PD controller, u = - kp * J^T * e - kd * [dth1; dth2]
  
  p = [0,0]';
  l=params.l;
  p(1) = l*cos(X(1)) + l*cos(X(1)+X(2));
  p(2) = l*sin(X(1)) + l*sin(X(1)+X(2));
  J = [-l*sin(X(1)) - l*sin(X(1)+X(2)) , -l*sin(X(1)+X(2));
    l*cos(X(1)) + l*cos(X(1)+X(2)) ,  l*cos(X(1)+X(2))];

  e = p - params.traj(t);
  f=100;z=200;
  Kp = 1000; %(2*pi*f)^2;
  Kd =  5;%4*pi*f*z;
  q_dot = [X(3);X(4)];
  u = -Kp*J'*(e)-Kd*q_dot;
  
  
  
end

