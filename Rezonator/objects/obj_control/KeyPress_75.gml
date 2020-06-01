// change justification left/center/right
if (keyboard_check(vk_control)) {
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
	ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.rezChainGrid), alignChains);
	ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.trackChainGrid), false);
}