/// @description Toggle context

// check if the user has any context on, and if they do turn it off
// if they don't have any context, turn on the between context
var currentContext = obj_panelPane.functionFilter_peek[0] || obj_panelPane.functionFilter_peek[1] || obj_panelPane.functionFilter_peek[2];
if (currentContext) {
	with (obj_panelPane) {
		functionFilter_peek[0] = false;
		functionFilter_peek[1] = false;
		functionFilter_peek[2] = false;
	}
}
else {
	with (obj_panelPane) {
		functionFilter_peek[0] = false;
		functionFilter_peek[1] = true;
		functionFilter_peek[2] = false;
	}
}

// Rerender filter
if (currentView == filterView || currentView == quickFilterView) {
	scr_renderFilter2();
}