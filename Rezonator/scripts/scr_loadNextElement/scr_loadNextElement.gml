if (string_count("<u who=", currentElement) == 0)
{
	if (not firstValidLineReached)
	{
		exit;
	}
}
else
{
	firstValidLineReached = true;
}

	
if (string_length(currentElement) == 0)
{
	exit;
}
	
	

	
if (string_count("uID=", currentElement) > 0)
{
	currentUtteranceID = real(scr_fileLineRipListSearch(fileLineRipListElement, "uID=\"u", "\"", fileLineRipList));

	//show_debug_message("LOADED: uID " + string(currentUtteranceID) + "..... " + currentElement);
}
	
if (string_count("PID=", currentElement) > 0)
{
	currentUnitpID = scr_fileLineRipListSearch(fileLineRipListElement, "PID=\"", "\"", fileLineRipList);
}
	
if (string_count("<u who=", currentElement) > 0)
{
		
	currentUnitParticipantName = scr_fileLineRipListSearch(fileLineRipListElement, "u who=\"", "\"", fileLineRipList);

}
	
if (string_count("start=", currentElement) > 0)
{
	currentUnitStart = real(scr_fileLineRipListSearch(fileLineRipListElement, "start=\"", "\"", fileLineRipList));
}
	
if (string_count("end=", currentElement) > 0)
{
	currentUnitEnd = real(scr_fileLineRipListSearch(fileLineRipListElement, "end=\"", "\"", fileLineRipList));
}
	
if (string_count("</g>", currentElement) > 0)
{
	ds_list_add(linesWithWordsList, fileLineRipListElement);
}

if (string_count("/>", currentElement) > 0)
{
	unitIDCounter++;
	currentUnitID = unitIDCounter;
			
		
	ds_grid_resize(obj_control.unitGrid, obj_control.unitGridWidth, ds_grid_height(obj_control.unitGrid) + 1);
	var currentRowUnitGrid = ds_grid_height(obj_control.unitGrid) - 1;
		
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitID, currentRowUnitGrid, currentUnitID);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, currentRowUnitGrid, currentUtteranceID);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colDiscoID, currentRowUnitGrid, currentDiscoID);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colpID, currentRowUnitGrid, currentUnitpID);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentRowUnitGrid, currentUnitParticipantName);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, currentRowUnitGrid, currentUnitStart);
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, currentRowUnitGrid, currentUnitEnd);

	if (ds_list_find_index(obj_control.participantList, currentUnitParticipantName) == -1)
	{
		ds_list_add(participantsInCurrentDiscoList, currentUnitParticipantName);
		ds_list_add(obj_control.participantList, currentUnitParticipantName);
		var participantColor = ds_list_find_value(global.participantColorList, ds_list_size(obj_control.participantList) - 1);
		ds_list_add(obj_control.participantColorList, participantColor);
		
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentRowUnitGrid, participantColor);
			
	}
	else
	{
		var colorIndex = ds_list_find_index(obj_control.participantList, currentUnitParticipantName);
		var participantColor = ds_list_find_value(obj_control.participantColorList, colorIndex);
		
		ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentRowUnitGrid, participantColor);
	}
		
		
	
		
		
		
		
	var lineGridWordIDList = ds_list_create();
	var dbstr = "";
		
	for (var j = 0; j < ds_list_size(linesWithWordsList); j++)
	{
		var lineNumber = ds_list_find_value(linesWithWordsList, j);
			
		wordIDCounter++;
			
		if (string_count("<g><w>", ds_list_find_value(fileLineRipList, lineNumber)) > 0)
		{
			var wordToken = scr_fileLineRipListSearch(lineNumber, "<g><w>", "<", fileLineRipList);
		}
		else
		{
			var wordToken = "";
		}
		var wordTranscript = scr_fileLineRipListSearch(lineNumber, "<ga type=\"dt\">", "<", fileLineRipList);
			
			
		ds_grid_resize(obj_control.wordGrid, obj_control.wordGridWidth, ds_grid_height(obj_control.wordGrid) + 1);
		var currentRowWordGrid = ds_grid_height(obj_control.wordGrid) - 1;
			
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordID, currentRowWordGrid, wordIDCounter);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentRowWordGrid, j);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentRowWordGrid, wordToken);
		ds_grid_set(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentRowWordGrid, wordTranscript);
			
		ds_list_add(lineGridWordIDList, wordIDCounter);
		dbstr += string(wordIDCounter);
		
		scr_loadDynamicWordGridIndividual();
	}
		
		
	ds_list_clear(linesWithWordsList);


	var currentLineY = room_height + obj_control.gridSpaceVertical;
		
	ds_grid_resize(obj_control.lineGrid, obj_control.lineGridWidth, ds_grid_height(obj_control.lineGrid) + 1);
	var currentRowLineGrid = ds_grid_height(obj_control.lineGrid) - 1;
		
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, currentRowLineGrid, currentRowLineGrid);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, currentRowLineGrid, lineGridWordIDList);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, currentRowLineGrid, 0);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitID, currentRowLineGrid, currentUnitID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colPixelY, currentRowLineGrid, currentLineY);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colDiscoID, currentRowLineGrid, currentDiscoID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, currentRowLineGrid, currentUtteranceID);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colAlignedWordID, currentRowLineGrid, ds_list_find_value(lineGridWordIDList, 0));
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, currentRowLineGrid, currentUnitStart);
	ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colUnitEnd, currentRowLineGrid, currentUnitEnd);
			
	ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentRowUnitGrid, lineGridWordIDList);
}

if (string_count("<Link>", currentElement) > 0)
{
	scr_importLinks(fileLineRipListElement);
}