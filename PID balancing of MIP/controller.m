
function u = controller(params, t, phi, phidot)
  % STUDENT FILLS THIS OUT
  % 
  % Initialize any added state like this:
  % 
  % persistent newstate
  % if isempty(newstate)
  %   % initialize
  %   newstate = 0;
  % end
  % 
  persistent last_time % this function ensures we keep track of the pevious time
  if isempty(last_time)
      last_time = t;
  end
  
  ei =(0-phi)*(t-last_time); % zero is the reference angle
  ki = 5000;
  kp=51;
  kd=2.5;  
  
  
  u = kp*(0-phi) + kd*(0-phidot) + ki *ei ;
  u=-u;
end

