// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_conlluExport(){
	// Get the default name for the C folder
	var filenameNoExt = filename_change_ext(global.fileSaveName, "");
	if(global.fileSaveName == "undefined" or is_undefined(global.fileSaveName)){
		filenameNoExt = filename_change_ext(global.importFilename, "");
	}
	var exportDirDefault = filenameNoExt + " CONLL-U Export";
	show_debug_message("scr_conlluExport() ... exportDirDefault: " + string(exportDirDefault));
	
	// User will specify a name and a location for the CSV folder
	var filePath = get_save_filename_ext("CONLL-U File|", exportDirDefault, program_directory, scr_get_translation("msg_save_csv"));
	show_debug_message("scr_conlluExport() ... filePath: " + string(filePath));
	
	// Check if exportDir is valid, or if the user exited the window
	if (filePath == "" or filePath == "undefined") {
		filePath = "undefined";
		show_message(scr_get_translation("save_error"));
		exit;
	}

	var file = file_text_open_write(filePath + ".txt");
	file_text_write_string(file, "# newdoc id = " + string(filenameNoExt));
	file_text_writeln(file);

	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var tokenList = discourseSubMap[?"tokenList"];
	var unitList = discourseSubMap[?"unitList"];
	
	var unitListSize = ds_list_size(unitList);
	var unitFieldList = obj_control.unitFieldList;
	var unitFieldListSize = ds_list_size(unitFieldList);
	
	
	for(var i = 0; i < unitListSize; i++){
		
		// Get access to unit data structures
		var currentUnit = unitList[|i];
		show_debug_message("Current Unit ID = " + currentUnit);
		var currentUnitSubmap = global.nodeMap[?currentUnit];
		var currentUnitTagmap = currentUnitSubmap[?"tagMap"];
		var currentUnitEntryList = currentUnitSubmap[?"entryList"];
		
		//Iterate through unit tagmap to get header fields
		//var tagMapKey = ds_map_find_first(currentUnitTagmap);
		var writeStr = "";
		for(var j = 0; j < unitFieldListSize; j++){
			var tagMapKey = unitFieldList[|j];
			var currentTagValue = currentUnitTagmap[?tagMapKey];
			show_debug_message("Current Tag Value: " + string(currentTagValue));
			
			writeStr = "# " + string(tagMapKey) + " = " + string(currentTagValue);
			file_text_write_string(file, writeStr);
			file_text_writeln(file);
		}
		
		var entryListSize = ds_list_size(currentUnitEntryList);
		
		
		for(var j = 0; j < entryListSize; j++){
			
			writeStr = "";
			
			var currentEntry = currentUnitEntryList[|j];
			var currentEntrySubmap = global.nodeMap[?currentEntry];
			var currentTokenID = currentEntrySubmap[?"token"];
			var currentTokenSubmap = global.nodeMap[?currentTokenID];
			var currentTokenTagmap = currentTokenSubmap[?"tagMap"];
			
			var tokenOrderValue = currentTokenSubmap[?"tokenOrder"];
			
			var textFieldValue = "";
			if(ds_map_exists(currentTokenTagmap, "text")){
				textFieldValue = currentTokenTagmap[?"text"];
			}
			else{
				textFieldValue = currentTokenTagmap[?global.displayTokenField];	
			}
			
			writeStr += string(tokenOrderValue) +"\t" + string(textFieldValue) + "\t";
			
			for(var k = 0; k < 7; k++){ // change k to 6 when implementing final column
				
				writeStr += "_\t";	
			}
			writeStr += "_";
			show_debug_message("Token write string: "+writeStr);
			file_text_write_string(file, writeStr);
			file_text_writeln(file);
		}
		
		file_text_writeln(file);
	}
	
	file_text_close(file);
	
	//show_debug_message("reached conllu export script");
	
	//var tempConlluHeaderList = ds_list_create();
	//ds_list_add(tempConlluHeaderList, "ID", "FORM", "LEMMA", "UPOS", "XPOS", "FEATS", "HEAD", "DEPREL", "DEPS", "MISC");
}