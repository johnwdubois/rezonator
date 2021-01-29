// change justification left/center/right
if (keyboard_check(vk_control)) {
	
	// toggle justification
	if (justify == justifyLeft) {
		justify = justifyCenter;
	}
	else if (justify == justifyCenter) {
		justify = justifyRight;
	}
	else if (justify == justifyRight) {
		justify = justifyLeft;
	}
	
	// if we are not justifying left, let's not try to align chains
	var alignChains = (obj_control.justify == obj_control.justifyLeft);
	scr_setValueForAllChains("rezChain", "alignChain", alignChains);
	scr_setValueForAllChains("trackChain", "alignChain", alignChains);
}