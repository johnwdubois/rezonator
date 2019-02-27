var driveStr = working_directory + "nsfs.dll";
var userStr = environment_get_variable("USERNAME");

global.documentsDirString = "C:\\Users\\" + userStr + "\\Documents";
global.rezonatorDirString = global.documentsDirString + "\\Rezonator";

if (directory_exists_ns(global.documentsDirString)) {
	if (directory_exists_ns(working_directory)) {
		
		if (!directory_exists_ns(global.rezonatorDirString)) {
			directory_copy_ns(working_directory, global.rezonatorDirString);
		}
	}
}