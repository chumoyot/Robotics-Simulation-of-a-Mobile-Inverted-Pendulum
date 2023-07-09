# Robotics-UPenn
Coursera Robotics Specialization 
The capstone project was divided into six weeks. I will summarize what I did week by week.
Week 1: I learned how to use MATLAB to solve ODEs.For practice, we modeled the Duffing equation, which is a second-order non-linear differential equation that is used to model slightly complex damped oscillations. Ones that are highly sensitive to initial conditions. Here is the plot.

![ODE45 of Duffing equation](https://github.com/chumoyot/Robotics-UPenn/assets/135506318/3639eb2d-0490-4a9b-9482-09d715fe23d2)

Week 2: I learned about PD control of second-order systems. This involved driving the error function exponentially to zero with appropriate values of Kp and Kv. Kp and Kv are the controller constants. The proportional control acts as a spring (capacitance) while the derivative acts as a viscous dashpot (resistance). Large derivative gains make the system overdamped and converges slowly while the higher the proportional term is, the system becomes springy and tends to overshoot. We also reviewed a bit of kinematics, where forward kinematics is when the joint angles are known and the position of the end effector is to be determined while backward kinematics is the reverse. Robotic problems usually feature finding the position of the end effector, since joints are built into the system and can be measured easily. Basic trigonometric identities are used to find the joint angles. You can also use the Jacobian to find joint angles. A Jacobian matrix maps joint angle velocities with the end effector velocities. 
The programming assignment was divided into two parts: (1) This involved basically tracking a reference trajectory. Easy? The only catch here is that a force limit was introduced which limits the effectiveness of high-gain controllers making it tricky to tune. I had to find an approximation to use in finding the derivative of the error function plus week 1's ODE solution of the Duffing equation. If not for the insanely brilliant folks at the discussion forum, it would have taken me ages to figure them out. Here is the MATLAB output ...

 ![untitled](https://github.com/chumoyot/Robotics-UPenn/assets/135506318/4feb1a3d-8f43-435c-b350-cedcb5774b95)

The second (2) assignment involved PD tracking of a Revolute-Revolute manipulator arm. This involved writing code for the forward kinematics. The tip of the last joint should track the reference trajectory. This introduced the concept of 'natural motion control'. This is basically how I understand it, it is reducing high-dimensional problems to easier-to-solve, lower dimensions. This is by focusing only on the position and velocity of the joint angles to guide the end effector as compared to figuring out all the changes required in every degree of freedom

![RR manipulation](https://github.com/chumoyot/Robotics-UPenn/assets/135506318/4086ccd6-27be-4d25-9df6-66fe77efe418)

Week 3: We learned about using EKF [Extended Kalman Filter] to get scalar orientation from an IMU. The advantage of EKF over KF is that it is good at solving non-linear problems which are abundant in the real world. Kalman filter is designed for linear Gaussian problems, where noise is assumed to be Gaussian. Taylor expansion is used to approximate linearity. The first assignment involved estimating the roll angle by filtering noisy gyroscope readings. Code started by defining constants like Q, which is the noise covariance matrix, and R, the measurement covariance matrix. The code block involved 4 major steps: prediction, setting of the Kalman Gain, and updating the state and covariance values using the Kalman gain. In finding the Kalman gain, we had to find the Jacobian of the nonlinear measurement. Here is the output showing the filtered data vs the raw data.

![untitled](https://github.com/chumoyot/Robotics-UPenn/assets/135506318/90b4134f-71e8-43cc-a533-bf960a41f250)

Week 4: We began by reviewing the Lagrangian mechanics. They are a formulation that gives an alternative way to write Newton's equations of motion. The major advantage it has over Newtonian laws is it is easy to automate in software. For systems that are not acted upon by external forces, we take the kinetic energy, subtract the potential energy and apply the Euler Lagrangian operator and set the result to zero. We then used the Lagrangian to derive the dynamic model of an inverted pendulum.

Week 5: We dealt with local linearization of MIP about the position we want to get, which is upright. We figured out how to find if the MIP is controllable, and then proceeding to sk MATLAB to find an optimal controller [LQR] that will achieve this upright goal. The drawback of using LQR controller for MIP is that you need all the sensory inputs of all the degrees of freedoms and their derivatives for it to be implemented. This will be a problem on a physical system as you'll need several sensors. The first assignment involved LQR stabilization of MIP. After finding out the Jacobian linearization we used the control system's toolbox to find the controllabillity and susequently the value of constant K. Which is the LQR gain matrix. Which we then substituted it in the controller.

![untitled](https://github.com/chumoyot/Robotics-UPenn/assets/135506318/dba25f81-8826-47a6-8d96-0d9a1af95133)

The second assignment involved PID balancing of MIP. Only the body angle was balanced and the wheel angle ignored. The codes were similar to PD controller. Only new addtions was using the persistent variable in MATLAB to compute the integral error. The persistent variable keeps track of its value between calls to the function. The hard part was finding kp, kd and ki values as it was through trial and error. Although there is an easier way with the Ziegler-Nichols tuning method. But I didn't have any energy left to learn that.
The output is similar to that of the LQR controller above.





