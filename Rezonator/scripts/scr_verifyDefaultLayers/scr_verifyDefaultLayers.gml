function scr_verifyDefaultLayers(){
	
	// for each type of layer, make sure that there is a default layer
	if (obj_control.activeResonanceLayer == "") scr_createNewLayer("_Default", "resonance");
	if (obj_control.activeTrailLayer == "") scr_createNewLayer("_Default", "trail");
	if (obj_control.activeStacking == "") scr_createNewLayer("_Default", "stack", "Stack", "");

}