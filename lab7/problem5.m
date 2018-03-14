clc; clear all; close all;

% points = [5 5 5; 0 1 -4]; %x=5 gives alpha = 0 and r = 5
% points = [-3 0 1; 3 3 3]; %y=3 gives alpha = pi and r = 0.67
points = [-3 0 1; 0 -3 -4]; %x+y+3=0 gives alpha = -0.946 and r = 1.5

[alpha r] = lsqline(points);

plot(points(1,:), points(2,:))
axis([-3 6 -3 5])
grid