var wordRectX1 = argument0;
var wordRectY1 = argument1;
var wordRectX2 = argument2;
var wordRectY2 = argument3;
var drawWordLoop = argument4;
var currentWordIDListSize = argument5;
var currentWordGridRow = argument6;
var currentWordDisplayCol = argument7;


// Draw the Place chain box
draw_set_alpha(1);
draw_set_color(c_ltgray);
//draw_rectangle(wordRectX1 - 1, wordRectY1 - 1, wordRectX2 + 1, wordRectY2 + 1, true);
var wordMidY = (wordRectY2 - wordRectY1)/2 + wordRectY1;
var placeChainYSpacing = 2;
		
// Go through the rest of the line to find a word this one can link to
for(var loopRow = drawWordLoop + 1; loopRow < currentWordIDListSize - 1; loopRow++) {
		
	// Draw the double bond if the next token is a word
	var nextWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow + (loopRow - drawWordLoop));
	//draw_rectangle(wordRectX1 - 1, wordRectY1 - 1, wordRectX2 + 1, wordRectY2 + 1, true);
	
	if(string_length(string_letters(nextWordString)) > 0 or undefined) {
		// Based off of the prev word's x-pos, draw 2 lines
		if (shape != shapeText) {
			// Allow the PlaceChain lines to adapt to shifting display columns
			var nextWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow + (loopRow - drawWordLoop));
			var variance = (abs(nextWordDisplayCol - currentWordDisplayCol) * gridSpaceHorizontal);
			draw_line_width(wordRectX2, wordMidY + placeChainYSpacing, wordRectX1 + variance, wordMidY + placeChainYSpacing, 2);
			draw_line_width(wordRectX2, wordMidY - placeChainYSpacing, wordRectX1 + variance, wordMidY - placeChainYSpacing, 2); 
		}										   
		else {									   
			draw_line_width(wordRectX2, wordMidY + placeChainYSpacing, wordRectX2 + 8, wordMidY + placeChainYSpacing, 2);
			draw_line_width(wordRectX2, wordMidY - placeChainYSpacing, wordRectX2 + 8, wordMidY - placeChainYSpacing, 2); 
		}
		break;
	}
}