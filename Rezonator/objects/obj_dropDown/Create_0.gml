// Instatiates drop down object
optionSpacing = 30;

windowWidth = 110;
if(obj_menuBar.menuClickedIn){
windowWidth = 200;
}
if(obj_control.wideDropDown){
	if(instance_exists(obj_dialogueBox)){
		if(obj_dialogueBox.stackShowWindowActive){
			windowWidth = 137;
		}
	}
	
	else{
		windowWidth = 150;
	}
}
ableToClick = false;
alarm[0] = 10;

obj_control.ableToCreateDropDown = false;
optionCurrent = -1;

mouseOverDropDown =  false;