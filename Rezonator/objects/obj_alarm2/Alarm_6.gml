/// @description refresh display col for specific unit
if (instance_exists(obj_control)) {
	scr_refreshDisplayColUnit(obj_control.refreshDisplayColUnit);
	scr_refreshPrevTokenUnit(obj_control.refreshDisplayColUnit);
	obj_control.refreshDisplayColUnit = "";
}