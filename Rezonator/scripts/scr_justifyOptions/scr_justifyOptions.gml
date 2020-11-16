function scr_justifyOptions(optionSelected) {
	//justifyOptions

	switch (optionSelected)
	{
		case "Left":// left justified
			if(obj_control.justify != obj_control.justifyLeft) {
				obj_control.justify = obj_control.justifyLeft;
			}
		break;
		case "Right":// right justified
			if(obj_control.justify != obj_control.justifyRight) {
				obj_control.justify = obj_control.justifyRight;
				var alignChains = (obj_control.justify == obj_control.justifyLeft);
			    ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.rezChainGrid), alignChains);
			    ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.trackChainGrid), false);
			}
		break;
		case "Center":// center justified
			if(obj_control.justify != obj_control.justifyCenter) {
				obj_control.justify = obj_control.justifyCenter;
				var alignChains = (obj_control.justify == obj_control.justifyLeft);
			    ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.rezChainGrid), alignChains);
			    ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.trackChainGrid), false);
			}
		break;
	
		default: 
		break;
	}


}
