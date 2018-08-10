/*
var firstValidLineReached = false;

var currentUnitID = -1;
var currentUnitpID = -1;
var currentUnitParticipantName = "null";
var currentUnitStart = -1;
var currentUnitEnd = -1;

var linesWithWordsList = ds_list_create();

for (var i = 0; i < ds_list_size(global.fileLineRipList); i++)
{
	
	var currentElement = ds_list_find_value(global.fileLineRipList, i);
	
	if (string_count("<u who=", currentElement) == 0)
	{
		if (not firstValidLineReached)
		{
			continue;
		}
	}
	else
	{
		firstValidLineReached = true;
	}

	
	if (string_length(currentElement) == 0)
	{
		continue;
	}
	
	

	
	if (string_count("uID=", currentElement) > 0)
	{
		currentUnitID = real(scr_fileLineRipListSearch(i, "uID=\"u", "\""));

		show_debug_message(string(currentUnitID) + "..... " + currentElement);
	}
	
	if (string_count("PID=", currentElement) > 0)
	{
		currentUnitpID = scr_fileLineRipListSearch(i, "PID=\"", "\"");
	}
	
	if (string_count("<u who=", currentElement) > 0)
	{
		
		currentUnitParticipantName = scr_fileLineRipListSearch(i, "u who=\"", "\"");

	}
	
	if (string_count("start=", currentElement) > 0)
	{
		currentUnitStart = real(scr_fileLineRipListSearch(i, "start=\"", "\""));
	}
	
	if (string_count("end=", currentElement) > 0)
	{
		currentUnitEnd = real(scr_fileLineRipListSearch(i, "end=\"", "\""));
	}
	
	if (string_count("</g>", currentElement) > 0)
	{
		ds_list_add(linesWithWordsList, i);
	}
	
	
	
	if (string_count("</u>", currentElement) > 0)
	{
		
		ds_grid_resize(unitGrid, unitGridWidth, ds_grid_height(unitGrid) + 1);
		var currentRowUnitGrid = ds_grid_height(unitGrid) - 1;
		
		ds_grid_set(unitGrid, unitGrid_colUnitID, currentRowUnitGrid, currentUnitID);
		ds_grid_set(unitGrid, unitGrid_colpID, currentRowUnitGrid, currentUnitpID);
		ds_grid_set(unitGrid, unitGrid_colParticipantName, currentRowUnitGrid, currentUnitParticipantName);
		ds_grid_set(unitGrid, unitGrid_colUnitStart, currentRowUnitGrid, currentUnitStart);
		ds_grid_set(unitGrid, unitGrid_colUnitEnd, currentRowUnitGrid, currentUnitEnd);

		if (ds_list_find_index(participantList, currentUnitParticipantName) == -1)
		{
			ds_list_add(participantList, currentUnitParticipantName);
			
			ds_grid_set(unitGrid, unitGrid_colParticipantColorIndex, currentRowUnitGrid, ds_list_size(participantList) - 1);
			
		}
		else
		{
			ds_grid_set(unitGrid, unitGrid_colParticipantColorIndex, currentRowUnitGrid, ds_list_find_index(participantList, currentUnitParticipantName));
		}
		
		
	
		
		
		
		
		var lineGridWordIDList = ds_list_create();
		var dbstr = "";
		
		for (var j = 0; j < ds_list_size(linesWithWordsList); j++)
		{
			var lineNumber = ds_list_find_value(linesWithWordsList, j);
			
			wordIDCounter++;
			
			if (string_count("<g><w>", ds_list_find_value(global.fileLineRipList, lineNumber)) > 0)
			{
				var wordToken = scr_fileLineRipListSearch(lineNumber, "<g><w>", "<");
			}
			else
			{
				var wordToken = "";
			}
			var wordTranscript = scr_fileLineRipListSearch(lineNumber, "<ga type=\"dt\">", "<");
			
			
			ds_grid_resize(wordGrid, wordGridWidth, ds_grid_height(wordGrid) + 1);
			var currentRowWordGrid = ds_grid_height(wordGrid) - 1;
			
			ds_grid_set(wordGrid, wordGrid_colWordID, currentRowWordGrid, wordIDCounter);
			ds_grid_set(wordGrid, wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
			ds_grid_set(wordGrid, wordGrid_colWordSeq, currentRowWordGrid, j);
			ds_grid_set(wordGrid, wordGrid_colWordToken, currentRowWordGrid, wordToken);
			ds_grid_set(wordGrid, wordGrid_colWordTranscript, currentRowWordGrid, wordTranscript);
			
			ds_list_add(lineGridWordIDList, wordIDCounter);
			dbstr += string(wordIDCounter);
		}
		
		
		ds_list_clear(linesWithWordsList);


		var currentLineY = room_height + gridSpaceVertical;
		
		ds_grid_resize(lineGrid, lineGridWidth, ds_grid_height(lineGrid) + 1);
		var currentRowLineGrid = ds_grid_height(lineGrid) - 1;
		
		ds_grid_set(lineGrid, lineGrid_colDisplayRow, currentRowLineGrid, currentRowLineGrid);
		ds_grid_set(lineGrid, lineGrid_colWordIDList, currentRowLineGrid, lineGridWordIDList);
		ds_grid_set(lineGrid, lineGrid_colLineState, currentRowLineGrid, 0);
		ds_grid_set(lineGrid, lineGrid_colUnitID, currentRowLineGrid, currentUnitID);
		ds_grid_set(lineGrid, lineGrid_colPixelY, currentRowLineGrid, currentLineY);
	}
	
}