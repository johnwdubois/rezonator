/// @description check version number
// You can write your code in this editor

var docPath = "Platforms/"+ string(global.buildType);

show_debug_message("Read, docPath:" + string(docPath));

FirebaseFirestore(docPath).Read();
