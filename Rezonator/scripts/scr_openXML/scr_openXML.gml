/*
	scr_openXML();
	
	Last Updated: 2018-07-12
	
	Called from: obj_openingScreen
	
	Purpose: Opens up dialogue box for importing XML file
	
	Mechanism: Loop through entire text file and add each line to global.fileLineRipList
*/
//show_message(string(global.previousImportDirectory));

if(global.previousImportDirectory == ""){
	
var discourseDirString = global.rezonatorDirString + "\\Data\\SBCorpus\\Transcript";
	if (os_type == os_macosx) {
		discourseDirString = global.currentDirString + "/Data/SBCorpus/Transcript";
	}

}
else{
	var discourseDirString = global.previousImportDirectory;
	
	var charAt = string_length(discourseDirString);
	while (string_char_at(discourseDirString, charAt) == " " and charAt > 0) {
		charAt--;
	}
	discourseDirString = string_delete(discourseDirString, charAt, string_length(discourseDirString) - charAt);

}

//show_message(string(discourseDirString) + "   Does exist : " + string(directory_exists(discourseDirString)));
openedFile = get_open_filename_ext("TXT file|*.txt|XML file|*.xml|CSV file|*.csv|JSON file|*.json", "", discourseDirString, "Import File");

if (openedFile == "" or not file_exists(openedFile)) {
	exit;
}
else{
	global.previousImportDirectory = filename_path(openedFile);
}

var fileName = filename_name(openedFile);
var fileExt = filename_ext(openedFile);
var fileExtCharAt = string_pos(fileExt, fileName);

if (fileExtCharAt > 0) {
	fileName = string_delete(fileName, fileExtCharAt, string_length(fileExt));
}

if (string_count("csv", fileExt) > 0) {
	scr_importCSV(openedFile);
	exit;
}

if (string_count("txt", fileExt) > 0) {
	scr_importTXT(openedFile);
	exit;
}



var xmlFile = (string_count("xml", fileExt) > 0);
var jsonFile = (string_count("json", fileExt) > 0);

var discoID = fileName;

if (ds_grid_value_exists(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, 0, global.fileLineRipGrid_colDiscoID, ds_grid_height(global.fileLineRipGrid), discoID)) {
	show_message("Cannot import the same file twice");
	exit;
}

var fileOpenRead = file_text_open_read(openedFile);

var wordsInLine = 0;

var currentFileLineRipList = ds_list_create();

var linesInCurrentDisco = 0;

var participantList = ds_list_create();
var participantIDList = ds_list_create();

while (not file_text_eof(fileOpenRead)) {	
	var lineInFile = file_text_readln(fileOpenRead);
	ds_list_add(global.fileLineRipList, lineInFile);
	
	ds_list_add(currentFileLineRipList, lineInFile);
	
	if (xmlFile) {
		if (string_count("<u who=", lineInFile) > 0) {
			lineTotal++;
			linesInCurrentDisco++;
		}
	
		if (string_count("</g>", lineInFile) > 0) {
			wordsInLine++;
			wordTotal++;
		}
	
		if (string_count("</u>", lineInFile) > 0) {
			ds_list_add(wordAmountList, wordsInLine);
			wordsInLine = 0;
		}
	
		var currentUnitParticipantName = scr_fileLineRipListSearch(ds_list_size(global.fileLineRipList) - 1, "u who=\"", "\"", global.fileLineRipList);
		var currentUnitParticipantID = scr_fileLineRipListSearch(ds_list_size(global.fileLineRipList) - 1, "PID=\"", "\"", global.fileLineRipList);
		if (string_count("<", lineInFile) > 0) {
			if (ds_list_find_index(participantIDList, currentUnitParticipantID) == -1) {
				ds_list_add(participantIDList, currentUnitParticipantID);
				ds_list_add(participantList, currentUnitParticipantName);
			}
		}
	}
	else if (jsonFile) {
		if (string_count("\"words\"", lineInFile) > 0) {
			lineTotal++;
			linesInCurrentDisco++;
		}
	}
}

if (ds_list_size(participantList) < 1) {
	ds_list_add(participantList, "Speaker");
	ds_list_add(participantList, "Speaker");
}
if (ds_list_size(participantIDList) < 1) {
	ds_list_add(participantIDList, 0);
	ds_list_add(participantIDList, 0);
}

ds_list_delete(participantList, 0);
ds_list_delete(participantIDList, 0);


var colorList = ds_list_create();
var participantIDListSize = ds_list_size(participantIDList);
for (var i = 0; i < participantIDListSize; i++) {
	var hue = (255 / participantIDListSize * i) + participantHueOffset;
	var color = make_color_hsv(hue, random_range(100, 200),  random_range(100, 200));
	ds_list_add(colorList, color);
}

participantHueOffset += 20;
 
ds_grid_resize(global.fileLineRipGrid, global.fileLineRipGripWidth, ds_grid_height(global.fileLineRipGrid) + 1);
var currentFileLineRipGridRow = ds_grid_height(global.fileLineRipGrid) - 1;
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, currentFileLineRipGridRow, discoID);
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colFileLineRipList, currentFileLineRipGridRow, currentFileLineRipList);
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colUnitAmount, currentFileLineRipGridRow, linesInCurrentDisco);
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colParticipantList, currentFileLineRipGridRow, participantList);
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colColorList, currentFileLineRipGridRow, colorList);
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colParticipantIDList, currentFileLineRipGridRow, participantIDList);

ds_grid_sort(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, true);

file_text_close(fileOpenRead);