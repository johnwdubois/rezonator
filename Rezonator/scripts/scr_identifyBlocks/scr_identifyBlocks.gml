// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_identifyBlocks(){
	
	var lineExitedOn = 0;
	show_debug_message("starting scr_identifyBlocks... time is: " + scr_printTime());
	
	global.exitOut = false;

	var prevException = false;
	var nextException = false;
	var blockLineList = ds_list_create();
	var importTXTGridHeight = ds_grid_height(global.importTXTLineGrid);
	for (var i = 0; i < importTXTGridHeight; i++) {
		
		if (global.exitOut) {
			continue;
		}
		
		var exception = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i);
		nextException = false;
		if (i < importTXTGridHeight - 1) {
			nextException = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colException, i + 1);
		}
		
		if (exception) {
			
			// Continue the exception block
			ds_list_add(blockLineList, i);
			var line = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i);
			
			// Create a new exception block
			if (!nextException || i == importTXTGridHeight - 1) {
				
				
				// Check if there is an existing header Block Type
				var headerBlockTypeRow = ds_grid_value_y(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, 0, global.blockTypeGrid_colBlockCategory, ds_grid_height(global.blockTypeGrid), global.blockCategoryHeader);
				if (headerBlockTypeRow >= 0) {
					// Get Block Type of existing header Block Type
					blockType = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockType, headerBlockTypeRow);
				}
				else {
					// Create a new Block Type of category header
					blockType = ds_grid_height(global.blockTypeGrid) + 1;
					ds_grid_resize(global.blockTypeGrid, global.blockTypeGridWidth, ds_grid_height(global.blockTypeGrid) + 1);
					ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colDefault, ds_grid_height(global.blockTypeGrid) - 1, true);
					ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, ds_grid_height(global.blockTypeGrid) - 1, global.blockCategoryHeader);
					ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockType, ds_grid_height(global.blockTypeGrid) - 1, blockType);
					ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, ds_grid_height(global.blockTypeGrid) - 1, 0);
					ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colLinesPerBlock, ds_grid_height(global.blockTypeGrid) - 1, -1);
					ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colFieldList, ds_grid_height(global.blockTypeGrid) - 1, ds_list_create());
					headerBlockTypeRow = ds_grid_height(global.blockTypeGrid) - 1;
				}
						 
						 
				// Increment Block Count for this Block Type
				var blockCount = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, headerBlockTypeRow);
				ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, headerBlockTypeRow, blockCount + 1);
								
				// Add row to the Block Grid of this Block Type
				ds_grid_resize(global.blockGrid, global.blockGridWidth, ds_grid_height(global.blockGrid) + 1);
				var blockID = irandom(9999999999);
				while (ds_list_find_index(global.blockIDList, blockID) >= 0) {
					blockID = irandom(9999999999);
				}
				var blockLineListCopy = ds_list_create();
				ds_list_copy(blockLineListCopy, blockLineList);
				ds_grid_set(global.blockGrid, global.blockGrid_colBlockID, ds_grid_height(global.blockGrid) - 1, blockID);
				ds_grid_set(global.blockGrid, global.blockGrid_colBlockType, ds_grid_height(global.blockGrid) - 1, blockType);
				ds_grid_set(global.blockGrid, global.blockGrid_colLineList, ds_grid_height(global.blockGrid) - 1, blockLineListCopy);
								
				// Clear BlockLineList
				ds_list_clear(blockLineList);

			}
			
		}
		else {
			
			// Remove \n and \r from the line
			var line = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i);
			
			// Check if this line consists of only whitespace
			var isLineOnlyWhitespace = scr_isStrOnlyWhitespace(line);
			
			// If this line consists only of whitespace, or this is the final line in the file,
			// or if the next line is an exception, this could be the end of a block
			if (isLineOnlyWhitespace || i == importTXTGridHeight - 1 || nextException) {
				
				// If this is the last line in the file, and it is not only whitespace,
				// let's add it to the blockLineList
				if (!isLineOnlyWhitespace && (i == importTXTGridHeight - 1 || nextException)) {
					ds_list_add(blockLineList, i);
				}
				
				
				
				var blockLineListSize = ds_list_size(blockLineList);
				if (blockLineListSize > 0) {
					
					 var blockType = -1;
					// Check if either all lines have field markers or
					// if no lines have field markers. We will store all of the field
					// markers in fieldList
					var fieldList = ds_list_create();
					for (var j = 0; j < blockLineListSize; j++) {
						var currentLine = ds_list_find_value(blockLineList, j);
						var currentLineStr = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, currentLine);
						var currentField = scr_stringGetField(currentLineStr);
						if (string_length(currentField) > 0) {
							ds_list_add(fieldList, currentField);
						}
					}
					var fieldMarkerAll = (ds_list_size(fieldList) == blockLineListSize);
					var fieldMarkerNone = (ds_list_size(fieldList) == 0);
						 
					if (fieldMarkerAll || fieldMarkerNone) {
							 
						// Check if there is a Block Type of category Unit with
						// this amount of lines per block and marked as Default
						var unitBlockTypeRow = scr_findInGridThreeParameters(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, global.blockCategoryUnit, global.blockTypeGrid_colLinesPerBlock, blockLineListSize, global.blockTypeGrid_colDefault, true);
						if (unitBlockTypeRow >= 0) {
								 
							// Check if there are any field markers that differ from the field list of the found Block Type
							if (fieldMarkerAll) {
								var unitBlockFieldList = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colFieldList, unitBlockTypeRow);
								if (scr_compareLists(fieldList, unitBlockFieldList)) {
									blockType = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockType, unitBlockTypeRow);
								}
								else {
									// Create a new Block Type of category Unit
									blockType = ds_grid_height(global.blockTypeGrid) + 1;
									var fieldListCopy = ds_list_create();
									ds_list_copy(fieldListCopy, fieldList);
									ds_grid_resize(global.blockTypeGrid, global.blockTypeGridWidth, ds_grid_height(global.blockTypeGrid) + 1);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colDefault, ds_grid_height(global.blockTypeGrid) - 1, false);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, ds_grid_height(global.blockTypeGrid) - 1, global.blockCategoryUnit);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockType, ds_grid_height(global.blockTypeGrid) - 1, blockType);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, ds_grid_height(global.blockTypeGrid) - 1, 0);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colLinesPerBlock, ds_grid_height(global.blockTypeGrid) - 1, blockLineListSize);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colFieldList, ds_grid_height(global.blockTypeGrid) - 1, fieldListCopy);
								}
							}
							else {
								blockType = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockType, unitBlockTypeRow);
							}
						}
						else {
								
							if (fieldMarkerAll) {
									  
								// Create a new Block Type of category Unit
								blockType = ds_grid_height(global.blockTypeGrid) + 1;
								var fieldListCopy = ds_list_create();
								ds_list_copy(fieldListCopy, fieldList);
								ds_grid_resize(global.blockTypeGrid, global.blockTypeGridWidth, ds_grid_height(global.blockTypeGrid) + 1);
								ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colDefault, ds_grid_height(global.blockTypeGrid) - 1, true);
								ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, ds_grid_height(global.blockTypeGrid) - 1, global.blockCategoryUnit);
								ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockType, ds_grid_height(global.blockTypeGrid) - 1, blockType);
								ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, ds_grid_height(global.blockTypeGrid) - 1, 0);
								ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colLinesPerBlock, ds_grid_height(global.blockTypeGrid) - 1, blockLineListSize);
								ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colFieldList, ds_grid_height(global.blockTypeGrid) - 1, fieldListCopy);
									   
							}
							else if (fieldMarkerNone) {
								// if this is a new Block Type without any field markers,
								// check if the block has exactly 2, 3, or 4 lines (to match Scription format)
								if (blockLineListSize == 2 || blockLineListSize == 3 || blockLineListSize == 4) {
									if (blockLineListSize == 2) {
										ds_list_add(fieldList, "\\txn", "\\tln");
									}
									else if (blockLineListSize == 3) {
										ds_list_add(fieldList, "\\m", "\\gl", "\\tln");
									}
									else if (blockLineListSize == 4) {
										ds_list_add(fieldList, "\\txn", "\\m", "\\gl", "\\tln");
									}
									// Create a new Block Type of category Unit
									blockType = ds_grid_height(global.blockTypeGrid) + 1;
									var fieldListCopy = ds_list_create();
									ds_list_copy(fieldListCopy, fieldList);
									ds_grid_resize(global.blockTypeGrid, global.blockTypeGridWidth, ds_grid_height(global.blockTypeGrid) + 1);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colDefault, ds_grid_height(global.blockTypeGrid) - 1, true);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCategory, ds_grid_height(global.blockTypeGrid) - 1, global.blockCategoryUnit);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockType, ds_grid_height(global.blockTypeGrid) - 1, blockType);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, ds_grid_height(global.blockTypeGrid) - 1, 0);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colLinesPerBlock, ds_grid_height(global.blockTypeGrid) - 1, blockLineListSize);
									ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colFieldList, ds_grid_height(global.blockTypeGrid) - 1, fieldListCopy);
								}
								else {
									global.exitOut = true;
									lineExitedOn = i;
									show_message("Invalid IGT file. Unmarked block found that does not match default Scription block format. Error found on line: " + string(lineExitedOn));
								}
							}
						}
							
						var rowInBlockTypeGrid = ds_grid_value_y(global.blockTypeGrid, global.blockTypeGrid_colBlockType, 0, global.blockTypeGrid_colBlockType, ds_grid_height(global.blockTypeGrid), blockType);
						if (rowInBlockTypeGrid >= 0) {
							// Increment Block Count for this Block Type
							var blockCount = ds_grid_get(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, rowInBlockTypeGrid);
							ds_grid_set(global.blockTypeGrid, global.blockTypeGrid_colBlockCount, rowInBlockTypeGrid, blockCount + 1);
								
							// Add row to the Block Grid of this Block Type
							ds_grid_resize(global.blockGrid, global.blockGridWidth, ds_grid_height(global.blockGrid) + 1);
							var blockID = irandom(9999999999);
							while (ds_list_find_index(global.blockIDList, blockID) >= 0) {
								blockID = irandom(9999999999);
							}
							var blockLineListCopy = ds_list_create();
							ds_list_copy(blockLineListCopy, blockLineList);
							ds_grid_set(global.blockGrid, global.blockGrid_colBlockID, ds_grid_height(global.blockGrid) - 1, blockID);
							ds_grid_set(global.blockGrid, global.blockGrid_colBlockType, ds_grid_height(global.blockGrid) - 1, blockType);
							ds_grid_set(global.blockGrid, global.blockGrid_colLineList, ds_grid_height(global.blockGrid) - 1, blockLineListCopy);
								
							// Clear BlockLineList
							ds_list_clear(blockLineList);
						}
						else {
							if (!global.exitOut) {
								global.exitOut = true;	
								lineExitedOn = i;
								show_message("Error, unable to find Block Type " + string(blockType)+  "  Error found on line: " + string(lineExitedOn));
							}
						}
					}
					else {
						if (!global.exitOut) {
							global.exitOut = true;	
							lineExitedOn = i;
							show_message("Invalid IGT file. Block found with inconsistent field marking" +  "  Error found on line: " + string(lineExitedOn)); // future dev: change to custom dialogue box, show incorrect Block to user
						}
					}
				}
			}
			else {
				ds_list_add(blockLineList, i);
			}
			
			
		}
		
		prevException = exception;
	}
	
	show_debug_message("end of scr_identifyBlocks... time is: " + scr_printTime());
	
	if (global.exitOut) {
		show_debug_message("scr_identifyBlocks() ... INVALID FILE, exiting...");
	}
}