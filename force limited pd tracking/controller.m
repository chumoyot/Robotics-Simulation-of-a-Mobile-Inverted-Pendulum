function u = controller(params, t, x, xd)
  % x = current position
  % xd = current velocity

  % Use params.traj(t) to get the reference trajectory
  % e.g. (x - params.traj(t)) represents the instaneous trajectory error

  % params can be initialized in the initParams function, which is called before the simulation starts
  
  % SOLUTION GOES HERE -------------
  kp = -3000;
  kv = -150;
 
  gamma = 2; 
   beta = 2;
   omega = 1;
   alpha=5;
  delta = 700;
  
  errT = x - params.traj(t);
 
  
  vt =-delta*xd-alpha*(x-params.traj(t))-beta*(x-params.traj(t))^3+gamma*cos(omega*t);%This is x double dot from duffing's equation
  
  u =  vt + kv*(xd) + kp* errT; % (kv * xd) is a good approximation than finding the derivative of errT_dot
end