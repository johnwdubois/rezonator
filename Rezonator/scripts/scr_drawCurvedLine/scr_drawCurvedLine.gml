function scr_drawCurvedLine(x1, y1, x2, y2, color, width) {
	
	draw_set_color(color);
	draw_set_alpha(1);

	var curvex1 = x1;
	var curvey1 = y1;
                   
	// Set the midpoints of the curved line
	var curvex2 = (x1 - ((x1 - x2) / 2));
	var curvey2 = (y1 - ((y1 - y2) / 2));
                        
	var curvex3 = curvex1;
	var curvey3 = curvey2;

	// if we are in draw range, draw many small lines to make the illusion of a curve
	if (true) {
	
	    for (var pr = 0; pr <= 1; pr += 0.04) {
	        var Qx1 = (curvex3 - curvex1) * pr + curvex1;
	        var Qy1 = (curvey3 - curvey1) * pr + curvey1;
	        var Qx2 = (curvex2 - curvex3) * pr + curvex3;
	        var Qy2 = (curvey2 - curvey3) * pr + curvey3;
	        var QX = (Qx2 - Qx1) * pr + Qx1;
	        var QY = (Qy2 - Qy1) * pr + Qy1;
                            
	        if ((pr - 0.02) < 0) {
				var new_pr = 0;
			}
	        else {
				var new_pr = pr - 0.08;
			}
                            
	        var Qxx = (Qx2 - Qx1) * (new_pr) + Qx1;
	        var Qyy = (Qy2 - Qy1) * (new_pr) + Qy1;
                                
                              
	        draw_line_width(QX, QY, Qxx, Qyy, width);
                            
	    }
                            
	}
                        
	var curvex1_2 = x2;
	var curvey1_2 = y2;
                        
	var curvex2_2 = x2 + ((x1 - x2) / 2);
	var curvey2_2 = y2 + ((y1 - y2) / 2);
                        
	var curvex3_2 = curvex1_2;
	var curvey3_2 = curvey2_2;
                        
	// do this loop again to draw the second half of the curve
	if not (curvey1_2 < (-obj_control.gridSpaceVertical * 2) and curvey1_2 < (-obj_control.gridSpaceVertical * 2))
	and not (curvey2_2 > (camera_get_view_height(camera_get_active()) + obj_control.gridSpaceVertical * 2) and curvey2_2 > (camera_get_view_height(camera_get_active()) + obj_control.gridSpaceVertical * 2)) {                       
                        
	    for (var pr_2 = 0; pr_2 <= 1; pr_2 += 0.01) {
			var Qx1_2 = (curvex3_2 - curvex1_2) * pr_2 + curvex1_2;
			var Qy1_2 = (curvey3_2 - curvey1_2) * pr_2 + curvey1_2;
			var Qx2_2 = (curvex2_2 - curvex3_2) * pr_2 + curvex3_2;
			var Qy2_2 = (curvey2_2 - curvey3_2) * pr_2 + curvey3_2;
			var QX_2 = (Qx2_2 - Qx1_2) * pr_2 + Qx1_2;
			var QY_2 = (Qy2_2 - Qy1_2) * pr_2 + Qy1_2;
                            
			if ((pr_2 - 0.02) < 0) {
				var new_pr_2 = 0;
			}
			else {
				var new_pr_2 = pr_2 - 0.02;
			}
                            
			var Qxx_2 = (Qx2_2 - Qx1_2) * (new_pr_2) + Qx1_2;
			var Qyy_2 = (Qy2_2 - Qy1_2) * (new_pr_2) + Qy1_2;
                                    
			draw_line_width(QX_2, QY_2, Qxx_2, Qyy_2, width);
                         
	    }
	}


}
