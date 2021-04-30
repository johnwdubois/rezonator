function scr_contextOptions(optionSelected) {
	//contextOptions

	switch (optionSelected)
	{
		case "menu_above":// show/hide above context
	
			with (obj_panelPane) {
				functionFilter_peek[0] = !functionFilter_peek[0];
			}

			// Rerender filter
			if (obj_control.filterGridActive || obj_control.quickFilterGridActive) {
				with (obj_control) {
					scr_renderFilter2();
				}
			}
		
			break;
			
		case "menu_between":// show/hide between context
	
			with (obj_panelPane) {
				functionFilter_peek[1] = !functionFilter_peek[1];
			}
		
			// Rerender filter
			if (obj_control.filterGridActive || obj_control.quickFilterGridActive) {
				with (obj_control) {
					scr_renderFilter2();
				}
			}
			
			break;
	
		case "menu_below":// hide/show below context
	
			with (obj_panelPane) {
				functionFilter_peek[2] = !functionFilter_peek[2];
			}
	
			// Rerender filter
			if (obj_control.filterGridActive || obj_control.quickFilterGridActive) {
				with (obj_control) {
					scr_renderFilter2();
				}
			}	
			break;
			
		default:
			break;
	
	}


}
