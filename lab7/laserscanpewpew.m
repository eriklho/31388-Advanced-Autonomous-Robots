clc; clear all; close all;

obstacle = [3 -4 3 1]';

% Laser specification 
maxD= 4;
FOV = 180;
res = 0.36;


x_w = 0;
y_w = 0;
theta_w = 0;

world_pose = [x_w, y_w, theta_w]';

scan = laserscan2011(x_w, y_w, theta_w, obstacle, maxD, res,FOV);

% figure
%  polar(scan(1,:),scan(2,:))
% hold on
% figure
[x_l, y_l] = pol2cart(scan(1,:),scan(2,:));
laser_pose = [x_l; y_l];
% plot(x_l,y_l)
% grid;

hi = laser2world_pose(world_pose, laser_pose);
plot(hi(1,: ),hi(2,:))


