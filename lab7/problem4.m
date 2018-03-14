clc; clear all; close all;

% obstacle = [3 -4 3 1]';
lines = [0 2.5 0 3.5; 1 1 -1 -1; 2.5 2.5 3.5 3.5; 1 5 -1 5];

% Laser specification 
maxD= 4;
FOV = 180;
res = 0.36;


pose1 = [0 0 0];
pose2 = [1.0, 0,0];
pose3 = [1.5,0,pi/6];

scan1 = laserscan2011(pose1(1), pose1(2), pose1(3), lines, maxD, res,FOV);
scan2 = laserscan2011(pose2(1), pose2(2), pose2(3), lines, maxD, res,FOV);
scan3 = laserscan2011(pose3(1), pose3(2), pose3(3), lines, maxD, res,FOV);

% polar(scan3(1,:),scan3(2,:))

world_pose1 = laser2world_pose(pose1, polar2cart(scan1));
world_pose2 = laser2world_pose(pose2, polar2cart(scan2));
world_pose3 = laser2world_pose(pose3, polar2cart(scan3));

figure
plot(world_pose1(1,:), world_pose1(2,:), '.b', world_pose2(1,:), world_pose2(2,:), '.r', world_pose3(1,:), world_pose3(2,:), '.g')
grid
hold on

figure
subplot(2,2,1)
plot(world_pose1(1,:), world_pose1(2,:), '.b')
grid
subplot(2,2,2)
plot(world_pose2(1,:), world_pose2(2,:), '.r')
grid
subplot(2,2,3)
plot(world_pose3(1,:), world_pose3(2,:), '.g')
grid





