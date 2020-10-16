function scr_contextOptions(argument0) {
	//contextOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Above":// show/hide prior context
	
			with (obj_panelPane) {
				functionFilter_peek[0] = !functionFilter_peek[0];
			}
			obj_chain.focusPrior = !obj_chain.focusPrior;
		
			// Rerender filter
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter();
				}
			}
		
		break;
		case "Between":// show/hide tween context
	
			with (obj_panelPane) {
				functionFilter_peek[1] = !functionFilter_peek[1];
			}
		
			obj_chain.focusTween = !obj_chain.focusTween;
		
			// Rerender filter
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter();
				}
			}
		
		break;
	
		case "Below":// hide/show next context
	
			with (obj_panelPane) {
				functionFilter_peek[2] = !functionFilter_peek[2];
			}
		
			obj_chain.focusNext = !obj_chain.focusNext;
	
			// Rerender filter
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter();
				}
			}	
	
		break;
		default:
		break;
	
	}


}
