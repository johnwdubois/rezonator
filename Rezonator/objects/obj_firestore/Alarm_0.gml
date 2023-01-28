/// @description check version number
if (room == rm_openingScreen && !global.initialVersionCheck) {
	global.initialVersionCheck = true;
	var docPath = "Platforms/"+ string(global.buildType);
	show_debug_message("obj_firestore, checking version number at docPath:" + string(docPath));
	FirebaseFirestore(docPath).Read();
}