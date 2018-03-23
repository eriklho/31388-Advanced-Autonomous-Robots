clc; clear all;

map=zeros(10,10);
map(1:7,3)=ones(7,1); 
map(3:10)=ones(8,1);
goal=[2,2]; 
start=[9,9];
xaxis = [1 10];
yaxis = [1 10];

[path, cost] = makewave(start, goal,xaxis, yaxis, map)