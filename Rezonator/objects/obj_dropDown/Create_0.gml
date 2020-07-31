// Instatiates drop down object
optionSpacing = 30;

windowWidth = 110;

c_ltblue = make_color_rgb(183, 183, 255);


if (room == rm_mainScreen) {
	if (obj_menuBar.menuClickedIn) {
		windowWidth = 200;
	}
	if (obj_control.wideDropDown) {
		if(instance_exists(obj_dialogueBox)){
			if(obj_control.stackShowWindowActive){
				windowWidth = 137;
			}
		}
		else{
			windowWidth = 150;
		}
	}
}
ableToClick = false;
alarm[0] = 10;
if (room == rm_mainScreen) {
	obj_control.ableToCreateDropDown = false;
}
optionCurrent = -1;

mouseOverDropDown =  false;