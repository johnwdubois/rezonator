

show_debug_message("Object_loader alarm6 STARTING ...");
var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
instLoading.loadSprite = spr_saving;

if (directory_exists(global.importGroupOutputDir) && global.importGroupOutputDir != "") {
	scr_saveREZ(true);
}