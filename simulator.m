
clear all;

global curr_pose ;
global ts;
global Rpar;
global angular_vel; 
global table1;
global table2;


 % current position [ x, y, theta]
Rpar = [0.26;0.035;0.035]; % [wheel separation, right wheel radius, left wheel radius]  
ts = 0.01; % time stamp
angular_vel = []; %[right wheel angular vel, left wheel angular vel]
table1 =[];
table2 =[];
target = [[0.5; 0; 0],[0.5;0.5;0],[0.5;-0.5;-pi/2],...
    [0;0.5;-pi],[0;0;pi/2],[0;-0.5;0],...
    [-0.5;0.5;0],[-0.5;0;0],[-0.5;-0.5;-pi]];



follTarget2(target)
%atan2(0.5,1)

function follTarget(input_pose)
global curr_pose;
global table1;

for z = 1:length(input_pose) 
    curr_pose = [0;0;0];
    curr_x = curr_pose(1,1);
    curr_y = curr_pose(2,1);
    curr_theta = curr_pose(3,1);
    target = input_pose(:,z) + curr_pose;    
    input_x = input_pose(1,z);
    input_y = input_pose(2,z);
    targ_x = target(1,1);
    targ_y = target(2,1);
    alpha = -curr_theta + atan2(input_y, input_x);
    
    dX = targ_x - curr_x;
    dY = targ_y - curr_y;
    dist = sqrt((dX)^2 + (dY)^2);
    
    turn(alpha, 0.05); 
    forward(dist,0.5);

    
plot(table1(:,1), table1(:,2), 'o-')
end   
end

function follTarget2(input_pose)
global curr_pose;
global table1;
global Rpar; 
global ts;

k_rho = 0.3;
k_alpha = 0.8;
k_beta = -0.15;


for z = 1:length(input_pose)    
    curr_pose = [0;0;0];
    curr_x = curr_pose(1,1);
    curr_y = curr_pose(2,1);
    curr_theta = curr_pose(3,1);
    target = input_pose(:,z) + curr_pose;    
    input_x = input_pose(1,z);
    input_y = input_pose(2,z);
    targ_x = target(1,1);
    targ_y = target(2,1);
    targ_theta = target(3,1);
    
    ref_coord = [cos(targ_theta) sin(targ_theta); -sin(targ_theta) cos(targ_theta)]*[curr_x - targ_x; curr_y - targ_y];
    ref_theta = curr_theta - targ_theta;
    ref = [ref_coord;ref_theta];
    
    rho = sqrt((ref(1,1))^2 + (ref(2,1))^2);
    alpha = -curr_theta + atan2(ref(2,1), ref(1,1));
    beta = -curr_theta - alpha;
    
    vel = k_rho*rho;
    omega = k_alpha + k_beta*beta;
    
    cl_system = [-k_rho*rho*cos(alpha); k_rho*sin(alpha) - k_alpha*alpha - k_beta*beta; -k_rho*sin(alpha)]
    



    

end   
end


 
%%%%%%%%%% Function draws the star %%%%%%%%%%
function printStar()
global table1;
for v=1:5
    forward(3,1);
    turn(pi*4/5,0.05);
end

plot(table1(:,1), table1(:,2), 'o-')
end
%%%%%%%%%% Function draws the hexagon %%%%%%%%%%
function printHex()
global table1;
for v=1:6
    forward(3,1);
    turn(pi/3,0.05);
end

plot(table1(:,1), table1(:,2), 'o-')
end
%%%%%%%%%% Function draws the square %%%%%%%%%%
function printSquare()
global table1;

forward(5,5)
turn(pi/2, 0.05)
forward(5,5)
turn(pi/2, 0.05)
forward(5,5)
turn(pi/2, 0.05)
forward(5,5)

plot(table1(:,1), table1(:,2), 'o-')
end
%%%%%% Function makes move forward with given speed on given distance  %%%%%% 
function y=forward(dist, speed) % Arguments: dist - distance in metres; speed - linear speed for both wheels
global curr_pose ;
global Rpar; 
global ts;
global angular_vel;
global table1;


time = dist/speed; % how many seconds will move
angular_vel = [speed/Rpar(2,1);speed/Rpar(3,1)]; 
    for v=0:ts:time
        y = kinupdate(curr_pose,Rpar,ts, angular_vel);
        curr_pose = y;
        table1(end+1,:) = [y(1,1) y(2,1) y(3,1)];   % log table
    end
end
%%%%%% Function turns simulation on rad radians with speed velocity %%%%%%%
function y=turn(rads_turn, speed)  
global curr_pose ;
global Rpar; 
global ts;
global angular_vel;
global table1;
theta = curr_pose(3,1); % theta from global position
 %  turn angle constraint in radians
if rads_turn < 0
    rads = theta +  rads_turn
    angular_vel = [-speed/Rpar(2,1);speed/Rpar(3,1)];
    
    while theta > rads
        y = kinupdate(curr_pose,Rpar,ts, angular_vel);
        curr_pose = y;
        theta = curr_pose(3,1);
        table1(end+1,:) = [y(1,1) y(2,1) y(3,1)];   
    end
end
if rads_turn > 0
     rads = theta +  rads_turn
     angular_vel = [speed/Rpar(2,1);-speed/Rpar(3,1)]; 
     
    while theta < rads
        y = kinupdate(curr_pose,Rpar,ts, angular_vel);
        curr_pose = y;
        theta = curr_pose(3,1);
        table1(end+1,:) = [y(1,1) y(2,1) y(3,1)];   
    end
end




end
  
%%%%%% Function makes move on one time stamp %%%%%%%
function new_pose = kinupdate(pose,robotpar,ts,wheelspeed) % pose - global postion [ x, y, theta]
%robotpar - robots parameters [wheel separation, right wheel radius, left wheel radius] 
%ts -  timestamp
% wheelspeed - linear speed [right wheel, left wheel]

theta = pose(3,1);
angular_speedR = wheelspeed(1,1);
angular_speedL = wheelspeed(2,1);
w = robotpar(1,1);
rR = robotpar(2,1);
rL = robotpar(3,1);

rotation_matrix = [cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0; 0 0 1]; % rotation matrix
constraint_matrix = [ 1/2 1/2  0 ; 0 0 1 ; 1/w  -1/w  0]; % constraint matrix
wheel_speed = [angular_speedR*rR; angular_speedL*rL; 0] ; % wheel speed matrix
xi = inv(rotation_matrix)*constraint_matrix*wheel_speed; % positions using forward EULER solution.

new_pose = pose + xi*ts; % next position after timestamp

end

    
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
 



