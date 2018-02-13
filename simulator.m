close all; clear all
phiL = 5.714;				% angular velocity left wheel
phiR = 0.714;				% % angular velocity right wheel
w = 2;						% Distance between the wheels
l = 2*w;					% Length
theta = 0;
ts = 0.1;					% Sample time
runtime = 5;


right_wheel_s = .2;
left_wheel_s = right_wheel_s;
robotpar = [w right_wheel_s left_wheel_s];

				% 
current_pose = [0; 0; 0]; % 

constraint_matrix = [1/2 1/2   0; 0 0 1; 1/w -1/w 0];

wheel_speed = [phiR phiL];
r_phi_dot = [robotpar(2)*wheel_speed(1); robotpar(3)*wheel_speed(2); 0]



plots = 1;
if(plots == 1)
	
	figure;
	hold on
	pbaspect([1 1 1])
end
%axis([0 150 -1 1])
positions = drive(current_pose, constraint_matrix, r_phi_dot, theta, ts, runtime);
plot(positions)


