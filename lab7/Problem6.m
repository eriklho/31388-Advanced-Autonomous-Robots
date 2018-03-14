%% problem 6
clc; clear all; close all;

line1 = [0.44 0.9875 1.874 2.351; 1 1 1 1];
line2 = [0.6614 1.62 2.436 3.145;-1 -1 -1 -1];
line3 = [3.5 3.5 3.5 3.5;-0.6449 -0.1761 0.4869 1.13];

%% line 1: alpha = pi/2, r = 1
[alpha r] = lsqline(line1);
%% line 2: alpha = -pi/2, r = 1
[alpha r] = lsqline(line2);

%% line 3: alpha = 0, r = 3.5
[alpha r] = lsqline(line3);