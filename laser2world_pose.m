function obs_coordinate = laser2world_pose(systempose_w, pos_l)
	
	theta_l = systempose_w(3);
	xy_lw = [systempose_w(1) systempose_w(2)]' ;

	R_trans = [cos(theta_l) -sin(theta_l); sin(theta_l) cos(theta_l)];
	
	for i = 1: 1: length(pos_l)
		obs_coordinate(:,i) = R_trans*pos_l(:,i)+xy_lw;
	end
end