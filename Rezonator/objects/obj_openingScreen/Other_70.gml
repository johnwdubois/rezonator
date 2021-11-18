var ID = async_load[? "id"];
var clipboard = async_load[? "clipboard"];

if (ID == "webclipboardID" && clipboard != "") {
	global.levelStr = clipboard;
	global.newProject = false;
	global.openProject = true;
	global.rezzlesDefaultLevel = false;
}