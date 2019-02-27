/*
	scr_openXML();
	
	Last Updated: 2018-07-12
	
	Called from: obj_openingScreen
	
	Purpose: Opens up dialogue box for importing XML file
	
	Mechanism: Loop through entire text file and add each line to global.fileLineRipList
*/

if (directory_exists_ns(global.rezonatorDirString)) {
	xmlFile = get_open_filename_ext("XML file|*.xml", "", global.rezonatorDirString, "Import XML");
}
else {
	xmlFile = get_open_filename("XML file|*.xml|REZ file|*.rez", "");
}

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

if (ds_grid_value_exists(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, 0, global.fileLineRipGrid_colDiscoID, ds_grid_height(global.fileLineRipGrid), discoID))
{
	show_message("Duplicate file imported");
	exit;
}

var fileOpenRead = file_text_open_read(xmlFile);
var newLine = false;

var wordsInLine = 0;

var currentFileLineRipList = ds_list_create();

var linesInCurrentDisco = 0;

var participantList = ds_list_create();

while (not file_text_eof(fileOpenRead))
{	
	var lineInFile = file_text_readln(fileOpenRead);
	ds_list_add(global.fileLineRipList, lineInFile);
	
	ds_list_add(currentFileLineRipList, lineInFile);
	
	if (string_count("<u who=", lineInFile) > 0)
	{
		lineTotal++;
		linesInCurrentDisco++;
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
	
	var currentUnitParticipantName = scr_fileLineRipListSearch(ds_list_size(global.fileLineRipList) - 1, "u who=\"", "\"", global.fileLineRipList);
	if (ds_list_find_index(participantList, currentUnitParticipantName) == -1)
	{
		ds_list_add(participantList, currentUnitParticipantName);
	}
}

ds_list_delete(participantList, 0);

var colorList = ds_list_create();
for (var i = 0; i < ds_list_size(participantList); i++)
{
	var hue = (255 / ds_list_size(participantList) * i) + participantHueOffset;
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

ds_grid_sort(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, true);

file_text_close(fileOpenRead);