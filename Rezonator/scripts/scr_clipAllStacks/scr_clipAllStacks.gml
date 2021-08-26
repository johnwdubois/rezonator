// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_clipAllStacks(){
	var stackChainList = global.nodeMap[?"stackChainList"];
	var stackChainListSize = ds_list_size(stackChainList);
	if(stackChainListSize > 0){
	
		obj_control.clipStackDir = get_save_filename_ext("New Clip Folder|*.", "", program_directory, "Create Clip Folder");

		directory_create(obj_control.clipStackDir);
	
		for(var i = 0; i < stackChainListSize; i++){
			var currentStack = stackChainList[|i];
			var currentStackSubMap = global.nodeMap[? currentStack];

			obj_control.clipStackName = currentStackSubMap[? "name"];
			show_debug_message(obj_control.clipStackName);
			// get rid of any bad file name chars in this string
			if (string_count("\\", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, "\\", "");
			if (string_count("\/", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, "\/", "");
			if (string_count(":", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, ":", "");
			if (string_count("*", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, "*", "");
			if (string_count("?", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, "?", "");
			if (string_count("\"", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, "\"", "");
			if (string_count("<", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, "<", "");
			if (string_count(">", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, ">", "");
			if (string_count("|", obj_control.clipStackName) > 0) obj_control.clipStackName = string_replace_all(obj_control.clipStackName, "|", "");
			
			if(string_length(obj_control.clipStackName) < 1){
				obj_control.clipStackName = scr_get_translation("help_label_stack") + string(i);
			}
		
			scr_clipFromStack(currentStack);
		
		}
		
	}
	
	obj_control.clipStackDir = "";
	obj_control.clipStackName = "";

}