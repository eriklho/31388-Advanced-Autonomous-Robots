clc; clear all; close all;

% obstacle = [3 -4 3 1]';
lines= [0 1 2.5 1; 2.5 1 2.5 5; 0 -1 3.5 -1; 3.5 -1 3.5 5]';

% Laser specification 
maxD= 4;
FOV = 180;
res = 0.36;


x_w = 1.5;
y_w = 0;
theta_w = pi/6;

world_pose = [x_w, y_w, theta_w]';

scan = laserscan2011(x_w, y_w, theta_w, lines, maxD, res,FOV);

% figure
%  polar(scan(1,:),scan(2,:))
% hold on
% figure
[x_l, y_l] = pol2cart(scan(1,:),scan(2,:));
laser_pose = [x_l; y_l];
plot(x_l,y_l)

hold on;
grid;
world_pose = laser2world_pose(world_pose, laser_pose);
plot(world_pose(1,:),world_pose(2,:))
legend('Robot view', 'World view');
axis([0,4,-4,4])



