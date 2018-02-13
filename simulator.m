
global curr_pose ;
curr_pose = [0;0;0]; % current position [ x, y, theta]
global Rpar 
Rpar = [0.26;0.035;0.035]; % [wheel separation, right wheel radius, left wheel radius]  
global ts
ts = 0.001; % time stamp
global angular_vel 
 angular_vel = [5.714;5.714]; %[right wheel angular vel, left wheel angular vel]
global table1;
table1 =[]
global table2;
table2 =[]

% 
% for v=0:0.01:2
%     angular_vel = [2.86; -2.86];
%      y = kinupdate(curr_pose,Rpar,t, angular_vel)
%     curr_pose = y
%     table2(end+1,:) = [y(1,1) y(2,1) y(3,1)];    
% end


%forward(5,5)
forward(5,5)
turn(1.57, 0.05)
forward(5,5)
turn(1.57, 0.05)
forward(5,5)
turn(1.57, 0.05)
forward(5,5)



function y=forward(dist, speed)
global curr_pose ;
global Rpar; 
global ts;
global angular_vel;
global table1;

time = dist/speed;
angular_vel = [speed;speed];
    for v=0:ts:time
        y = kinupdate(curr_pose,Rpar,ts, angular_vel);
        curr_pose = y;
        table1(end+1,:) = [y(1,1) y(2,1) y(3,1)];    
    end
end

function y=turn(rads_turn, speed)
   
global curr_pose ;
global Rpar; 
global ts;
global angular_vel;
global table2;
theta = curr_pose(3,1);
rads = theta + rads_turn;

angular_vel = [speed;-speed];
    while theta < rads
        y = kinupdate(curr_pose,Rpar,ts, angular_vel);
        curr_pose = y;
        theta = curr_pose(3,1);
        table2(end+1,:) = [y(1,1) y(2,1) y(3,1)];    
    end
end
  


function new_pose = kinupdate(pose,robotpar,ts,wheelspeed)

theta = pose(3,1);
omegaR = wheelspeed(1,1);
omegaL = wheelspeed(2,1);
w = robotpar(3,1);

rotation_matrix = [cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0; 0 0 1];
constraint_matrix = [ 1/2 1/2  0 ; 0 0 1 ; 1/w  -1/w  0];
wheel_speed = [omegaR; omegaL; 0] ;
xi = inv(rotation_matrix)*constraint_matrix*wheel_speed;

new_pose = pose + xi*ts;

end

    
% 
% 
% 
% 
% % distance by time and timestamps
% for v=0:ts:time
%          rotation_matrix = [cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0; 0 0 1]; 
%          xi = inv(rotation_matrix)*constraint_matrix*wheel_speed;
%          
%         next_pose = current_pose + xi*ts;
%         x = current_pose(1,1);
%         y = current_pose(2,1);
%         theta = current_pose(3,1);
%         x_next = next_pose(1,1);
%         y_next = next_pose(2,1);
%         theta_next = next_pose(3,1);
%         
%         distance = distance + sqrt((x_next-x)^2 +(y_next-y)^2); 
%          
%         table1(end+1,:) = [x y theta distance];
%         
%         current_pose = next_pose;
%         
% end
% 
% 
% while (theta < 1.57 && theta > -1.57) 
%     
%     rotation_matrix = [cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0; 0 0 1]; 
% 	xi = inv(rotation_matrix)*constraint_matrix*wheel_speed;
%     
%     current_pose = current_pose + xi*ts;
%     x = current_pose(1,1);
%     y = current_pose(2,1);
%     theta = current_pose(3,1);
%     
%     table2(end+1,:) = [x y theta];
%   
% end
% 
% figure;
% hold on
% for i=1:length(table1)
%     plot(table1(i), table1(i,2), '-o')
%      
% end
% 
% disp(length(table1))
% disp(current_pose)
% disp(distance)
% disp(table1(i))
% disp(table1(i,2))

