/*
	scr_drawPlaceChains();
	
	Last Updated: 2020-10-26
	
	Called from: obj_control -> scr_drawLineWordIDListLoop
	
	Purpose: when Place Chains are active, draw connecting lines between adjacent words
	
	Mechanism: using the measurements of the current words, draw dynamic parallel lines
	
	Author: Terry DuBois, Georgio Klironomos, Brady Moore
*/
function scr_drawPlaceChains(wordRectX1, wordRectY1, wordRectX2, wordRectY2, drawWordLoop, currentWordIDListSize, currentWordGridRow, currentWordDisplayCol) {

	// Draw the Place chain box
	draw_set_alpha(1);
	draw_set_color(c_ltgray);
	var wordMidY = (wordRectY2 - wordRectY1)/2 + wordRectY1;
	var placeChainYSpacing = 2;
        
	// Go through the rest of the line to find a word this one can link to
	for(var loopRow = drawWordLoop + 1; loopRow < currentWordIDListSize - 1; loopRow++) {
        
	    // Draw the double bond if the next token is a word
	    var nextWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow + (loopRow - drawWordLoop));
    
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
}
