/// @description Insert description here
// You can write your code in this editor



scr_gridSwapCols(wordGrid, wordGrid_colUnitID, wordGrid_colWordID);
var tempCol = wordGrid_colUnitID; 
wordGrid_colUnitID = wordGrid_colWordID;
wordGrid_colWordID = tempCol;