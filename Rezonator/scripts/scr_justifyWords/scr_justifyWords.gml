function scr_justifyWords() {
	//Change the justification of the discourse text, either to a grid-like structure or to standard English left-justified

	if(obj_control.justify == obj_control.justifyLeft){
		obj_control.justify = obj_control.justifyCenter;
	}
	else if(obj_control.justify == obj_control.justifyCenter){
		obj_control.justify = obj_control.justifyRight;
	}
	else if(obj_control.justify == obj_control.justifyRight){
		obj_control.justify = obj_control.justifyLeft;
	}
	

}
