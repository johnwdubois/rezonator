function scr_contextOptions(optionSelected) {
	//contextOptions

	switch (optionSelected)
	{
		case "menu_above":// show/hide prior context
	
			with (obj_panelPane) {
				functionFilter_peek[0] = !functionFilter_peek[0];
			}
			obj_chain.focusPrior = !obj_chain.focusPrior;
		
			// Rerender filter
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter2();
				}
			}
		
			// Rerender quick filter
			if (obj_control.quickFilterGridActive) {
				with (obj_control) {
					scr_renderQuickFilter();
				}
			}
		
		break;
		case "menu_between":// show/hide tween context
	
			with (obj_panelPane) {
				functionFilter_peek[1] = !functionFilter_peek[1];
			}
		
			obj_chain.focusTween = !obj_chain.focusTween;
		
			// Rerender filter
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter2();
				}
			}
			
			// Rerender quick filter
			if (obj_control.quickFilterGridActive) {
				with (obj_control) {
					scr_renderQuickFilter();
				}
			}
		
		break;
	
		case "menu_below":// hide/show next context
	
			with (obj_panelPane) {
				functionFilter_peek[2] = !functionFilter_peek[2];
			}
		
			obj_chain.focusNext = !obj_chain.focusNext;
	
			// Rerender filter
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter2();
				}
			}	
			
			// Rerender quick filter
			if (obj_control.quickFilterGridActive) {
				with (obj_control) {
					scr_renderQuickFilter();
				}
			}
	
		break;
		default:
		break;
	
	}


}
