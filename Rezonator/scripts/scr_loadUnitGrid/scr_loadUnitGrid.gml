/*
	scr_loadUnitGrid();
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: loads the unitGrid all every pretaining information
	
	Mechanism: loop through every imported discourse, and then through every line ripped from that discourse
				and search for information
*/

var firstValidLineReached = false;

var currentUnitID = -1;
var currentUtteranceID = -1;
var currentUnitpID = -1;
var currentUnitParticipantName = "null";
var currentUnitStart = -1;
var currentUnitEnd = -1;

var linesWithWordsList = ds_list_create();

var participantsInCurrentDiscoList = ds_list_create();
var hueOffset = 0;

for (var fileLineRipGridLoop = 0; fileLineRipGridLoop < ds_grid_height(global.fileLineRipGrid); fileLineRipGridLoop++)
{
	var currentFileLineRipList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colFileLineRipList, fileLineRipGridLoop);
	var currentDiscoID = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, fileLineRipGridLoop);
	
	for (var i = 0; i < ds_list_size(currentFileLineRipList); i++)
	{
	
		var currentElement = ds_list_find_value(currentFileLineRipList, i);
	
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
			currentUtteranceID = real(scr_fileLineRipListSearch(i, "uID=\"u", "\"", currentFileLineRipList));

			//show_debug_message(string(currentUtteranceID) + "..... " + currentElement);
		}
	
		if (string_count("PID=", currentElement) > 0)
		{
			currentUnitpID = scr_fileLineRipListSearch(i, "PID=\"", "\"", currentFileLineRipList);
		}
	
		if (string_count("<u who=", currentElement) > 0)
		{
		
			currentUnitParticipantName = scr_fileLineRipListSearch(i, "u who=\"", "\"", currentFileLineRipList);

		}
	
		if (string_count("start=", currentElement) > 0)
		{
			currentUnitStart = real(scr_fileLineRipListSearch(i, "start=\"", "\"", currentFileLineRipList));
		}
	
		if (string_count("end=", currentElement) > 0)
		{
			currentUnitEnd = real(scr_fileLineRipListSearch(i, "end=\"", "\"", currentFileLineRipList));
		}
	
		if (string_count("</g>", currentElement) > 0)
		{
			ds_list_add(linesWithWordsList, i);
		}
	
	
	
		if (string_count("</u>", currentElement) > 0)
		{
			unitIDCounter++;
			currentUnitID = unitIDCounter;
			
		
			ds_grid_resize(unitGrid, unitGridWidth, ds_grid_height(unitGrid) + 1);
			var currentRowUnitGrid = ds_grid_height(unitGrid) - 1;
		
			ds_grid_set(unitGrid, unitGrid_colUnitID, currentRowUnitGrid, currentUnitID);
			ds_grid_set(unitGrid, unitGrid_colUtteranceID, currentRowUnitGrid, currentUtteranceID);
			ds_grid_set(unitGrid, unitGrid_colDiscoID, currentRowUnitGrid, currentDiscoID);
			ds_grid_set(unitGrid, unitGrid_colpID, currentRowUnitGrid, currentUnitpID);
			ds_grid_set(unitGrid, unitGrid_colParticipantName, currentRowUnitGrid, currentUnitParticipantName);
			ds_grid_set(unitGrid, unitGrid_colUnitStart, currentRowUnitGrid, currentUnitStart);
			ds_grid_set(unitGrid, unitGrid_colUnitEnd, currentRowUnitGrid, currentUnitEnd);

			if (ds_list_find_index(participantList, currentUnitParticipantName) == -1)
			{
				ds_list_add(participantsInCurrentDiscoList, currentUnitParticipantName);
				ds_list_add(participantList, currentUnitParticipantName);
			
				ds_grid_set(unitGrid, unitGrid_colParticipantColorIndex, currentRowUnitGrid, ds_list_size(participantList) - 1);
			
			}
			else
			{
				ds_grid_set(unitGrid, unitGrid_colParticipantColorIndex, currentRowUnitGrid, ds_list_find_index(participantList, currentUnitParticipantName));
			}
		
		
	
		
		
		
		
			var lineGridWordIDList = ds_list_create();
			var dbstr = "";
			
			show_message(scr_getStringOfList(linesWithWordsList));
		
			for (var j = 0; j < ds_list_size(linesWithWordsList); j++)
			{
				var lineNumber = ds_list_find_value(linesWithWordsList, j);
			
				wordIDCounter++;
				
				var wordToken = "";
			
				if (string_count("<g><w>", ds_list_find_value(currentFileLineRipList, lineNumber)) > 0)
				{
					wordToken = scr_fileLineRipListSearch(lineNumber, "<g><w>", "<", currentFileLineRipList);
				}

				var wordTranscript = scr_fileLineRipListSearch(lineNumber, "<ga type=\"dt\">", "<", currentFileLineRipList);
			
				
			
				if(wordToken == "" && j == ds_list_size(linesWithWordsList) - 1){
					show_message("end of line");
					wordToken = wordTranscript;
				}
			
				ds_grid_resize(wordGrid, wordGridWidth, ds_grid_height(wordGrid) + 1);
				var currentRowWordGrid = ds_grid_height(wordGrid) - 1;
			
				ds_grid_set(wordGrid, wordGrid_colWordID, currentRowWordGrid, wordIDCounter);
				ds_grid_set(wordGrid, wordGrid_colUnitID, currentRowWordGrid, currentUnitID);
				ds_grid_set(wordGrid, wordGrid_colUtteranceID, currentRowWordGrid, currentUtteranceID);
				//show_message(string(currentUtteranceID));
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
			ds_grid_set(lineGrid, lineGrid_colDiscoID, currentRowLineGrid, currentDiscoID);
			ds_grid_set(lineGrid, lineGrid_colLineNumberLabel, currentRowLineGrid, currentUtteranceID);
			ds_grid_set(lineGrid, lineGrid_colAlignedWordID, currentRowLineGrid, ds_list_find_value(lineGridWordIDList, 0));
			ds_grid_set(lineGrid, lineGrid_colUnitStart, currentRowLineGrid, currentUnitStart);
			ds_grid_set(lineGrid, lineGrid_colUnitEnd, currentRowLineGrid, currentUnitEnd);
			
			ds_grid_set(unitGrid, unitGrid_colWordIDList, currentRowUnitGrid, lineGridWordIDList);
			
			
			
			
	
			var unitInStackGridCurrentRow = ds_grid_height(obj_chain.unitInStackGrid);
			ds_grid_resize(obj_chain.unitInStackGrid, obj_chain.unitInStackGridWidth, unitInStackGridCurrentRow + 1);
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colUnitID, unitInStackGridCurrentRow, currentUnitID);
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitInStackGridCurrentRow, -1);
		}
	
	}
	
	for (var k = 0; k < ds_list_size(participantsInCurrentDiscoList); k++)
	{
		var hue = (255 / ds_list_size(participantsInCurrentDiscoList)) * k + hueOffset;
		var color = make_color_hsv(hue, 150, 150);
		ds_list_add(participantColorList, color);
	}
	hueOffset += 25;
	ds_list_clear(participantsInCurrentDiscoList);
}

ds_list_destroy(participantsInCurrentDiscoList);