/// @description Insert description here
// You can write your code in this editor
show_debug_message("Async Social Called");

if (async_load[? "type"] == "FirebaseFirestore_Document_Read") {
	// DOC READ
	if (async_load[?"status"] == 200) {
		var value = async_load[? "value"];
		show_debug_message("document read: " + string(value));
		coolMap = json_decode(value);

		newestVersionNum = coolMap[? "Version"];

			
		if(is_string(newestVersionNum)){
			if(string_length(newestVersionNum) > 0 ){
			var newVersionString = "Version " + string(newestVersionNum);
			show_debug_message("global.versionString: " + string(global.versionString) + " , newestVersionNum: " + newVersionString); 
				
				if(newVersionString != global.versionString){
					//reccomend downloading new version
					show_debug_message("CHECK OUT MY NEW REZONATOR PLEASE");
							
					with (obj_openingScreen) showDownloadDialogue = true;
	
				}
				
			}
		}
		
		
	}
	else{
		show_debug_message("ERROR IN LOADING: " + string(async_load[? "errorMessage"]));
	}
}