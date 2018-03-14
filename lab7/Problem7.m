clc;
clear all;
close all;

line1 = [0 0.6895 1.362;1.151 0.762 0.368];
line2 = [2.724 1.9645 1.233; 0.7176 -0.5976 -1.864];
line3 = [0 0.6165 1.233; -1.159 -1.5115 -1.864]

[alpha, r] = lsqline(line3)
%% Line 1 - alpha = 1.0491, r = 1
[alpha, r] = lsqline(line1)

%% Line 2 - alpha = -0.5237, r = 2
[alpha, r] = lsqline(line2)

%% Line 3 - alpha = -2.0902, r = 1.0061
[alpha, r] = lsqline(line3)