/// @description check version number

initialVersionCheck = true;
var docPath = "Platforms/"+ string(global.buildType);
show_debug_message("Read, docPath:" + string(docPath));
FirebaseFirestore(docPath).Read();