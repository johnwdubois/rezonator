

function scr_createFlyout(flyoutX, flyoutY, optionList, optionListType, sprite, drawBG) {
	
	var dropDownHeight = ds_list_size(optionList) * string_height("0") * 1.25;
	var camViewHeight = camera_get_view_height(view_get_camera(0));
	if (flyoutY + dropDownHeight > camViewHeight) {
		var adjustedHeight = ds_list_size(optionList) * string_height("0") * 1.25;
		flyoutY -= adjustedHeight;	
	}
	flyoutY = clamp(flyoutY, 0, camViewHeight);
	
	var flyoutInst = instance_create_depth(flyoutX, flyoutY, -999, obj_flyout);
	flyoutInst.optionList = optionList;
	flyoutInst.optionListType = optionListType;
	flyoutInst.sprite = sprite;
	flyoutInst.drawBG = drawBG;
	
}