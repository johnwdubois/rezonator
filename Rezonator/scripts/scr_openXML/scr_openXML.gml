/*
	scr_openXML();
	
	Last Updated: 2018-07-12
	
	Called from: obj_openingScreen
	
	Purpose: Opens up dialogue box for importing XML file
	
	Mechanism: Loop through entire text file and add each line to global.fileLineRipList
*/


xmlFile = get_open_filename("XML file|*.xml|REZ file|*.rez", "");

if (xmlFile == "")
{
	exit;
}

var fileName = filename_name(xmlFile);
var fileExt = filename_ext(xmlFile);
var fileExtCharAt = string_pos(fileExt, fileName);

if (fileExtCharAt > 0)
{
	fileName = string_delete(fileName, fileExtCharAt, string_length(fileExt));
}

var discoID = fileName;

var fileOpenRead = file_text_open_read(xmlFile);
var newLine = false;

var wordsInLine = 0;

var currentFileLineRipList = ds_list_create();

while (not file_text_eof(fileOpenRead))
{
	var lineInFile = file_text_readln(fileOpenRead);
	ds_list_add(global.fileLineRipList, lineInFile);
	
	ds_list_add(currentFileLineRipList, lineInFile);
	
	if (string_count("<u who=", lineInFile) > 0)
	{
		lineTotal++;
	}
	
	if (string_count("</g>", lineInFile) > 0)
	{
		wordsInLine++;
		wordTotal++;
	}
	
	if (string_count("</u>", lineInFile) > 0)
	{
		ds_list_add(wordAmountList, wordsInLine);
		wordsInLine = 0;
	}
}

ds_grid_resize(global.fileLineRipGrid, global.fileLineRipGripWidth, ds_grid_height(global.fileLineRipGrid) + 1);
var currentFileLineRipGridRow = ds_grid_height(global.fileLineRipGrid) - 1;
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, currentFileLineRipGridRow, discoID);
ds_grid_set(global.fileLineRipGrid, global.fileLineRipGrid_colFileLineRipList, currentFileLineRipGridRow, currentFileLineRipList);

file_text_close(fileOpenRead);