/// @description Insert description here
// You can write your code in this editor
if(currentPopUp == 0){
	
		//mouse over the whole popUp
		if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) - 295, 0, camera_get_view_width(view_camera[0]) - 105,200)) {
			obj_control.mouseoverPanelPane = true;


		// mouse over advance tutorial button
		mouseOverRightButton = false;
			if (allowedToChange && point_in_rectangle(mouse_x, mouse_y,mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105), 175, camera_get_view_width(view_camera[0]) - 105,200)) {
				mouseOverRightButton = true;
				if (mouse_check_button_released(mb_left)) {
					currentPopUp =1;
					allowedToChange = false;
					alarm[0] = 3;
				}
			}
			
			
			
			
		// mouse over exit tutorial button
		mouseOverExitButton = false;
			if (allowedToChange && point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) - 135, 10, camera_get_view_width(view_camera[0]) - 115,30)) {
				mouseOverExitButton = true;
				if (mouse_check_button_released(mb_left)) {				
					currentPopUp = -1;
					allowedToChange = false;
					alarm[0] = 3;
				}
			}
			



		}
		else{
			obj_control.mouseoverPanelPane = false;
		}

}

else if(currentPopUp == 1){
	

		if (point_in_rectangle(mouse_x, mouse_y,secondPopUpX1, 0, secondPopUpX2,200)) {
			obj_control.mouseoverPanelPane = true;
			
			
			
		// mouse over advance tutorial button	
		mouseOverRightButton = false;
			if (allowedToChange && point_in_rectangle(mouse_x, mouse_y,mean(secondPopUpX1 ,secondPopUpX2 ), 175,secondPopUpX2 ,200)) {
				mouseOverRightButton = true;
				if (mouse_check_button_released(mb_left)) {
					currentPopUp = 2;
					allowedToChange = false;
					alarm[0] = 3;
				}
			}
			
		// mouse over reverse tutorial button
		mouseOverLeftButton = false;
			if (allowedToChange && point_in_rectangle(mouse_x, mouse_y,  secondPopUpX1, 175, mean(secondPopUpX1 ,secondPopUpX2 ) ,200)) {
				
				mouseOverLefttButton = true;
				if (mouse_check_button_released(mb_left)) {


					currentPopUp = 0;
					allowedToChange = false;
					alarm[0] = 3;
				}
			}
			
			
								// mouse over exit tutorial button
		mouseOverExitButton = false;
			if (allowedToChange && point_in_rectangle(mouse_x, mouse_y, secondPopUpX2-30, 10, secondPopUpX2-10, 30)) {
				mouseOverExitButton = true;
				if (mouse_check_button_released(mb_left)) {				
					currentPopUp = -1;
					allowedToChange = false;
					alarm[0] = 3;
				}
			}

	

		}
		else{
			obj_control.mouseoverPanelPane = false;
		}

}

else if(currentPopUp == 2){
	
		//mouse over the whole popUp
		if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) - 295, 0, camera_get_view_width(view_camera[0]) - 105,200)) {
			obj_control.mouseoverPanelPane = true;


		// mouse over reverse tutorial button
		mouseOverLeftButton = false;
			if (allowedToChange && point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) - 295, 175, mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105),200)) {
				mouseOverLeftButton = true;
				if (mouse_check_button_released(mb_left)) {
					currentPopUp =1;
					allowedToChange = false;
					alarm[0] = 3;
				}
			}
			
			
					// mouse over exit tutorial button
		mouseOverExitButton = false;
			if (allowedToChange && point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) - 135, 10, camera_get_view_width(view_camera[0]) - 115,30)) {
				mouseOverExitButton = true;
				if (mouse_check_button_released(mb_left)) {				
					currentPopUp = -1;
					allowedToChange = false;
					alarm[0] = 3;
				}
			}



		}
		else{
			obj_control.mouseoverPanelPane = false;
		}

}



/*

			if (mouse_check_button_pressed(mb_left)) {

			}
			
*/