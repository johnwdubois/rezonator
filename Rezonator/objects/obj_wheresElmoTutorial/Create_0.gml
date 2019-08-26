calloutBubbleGridWidth = 2;
calloutBubbleGrid_colString = 0;
calloutBubbleGrid_colWordID = 1;
calloutBubbleGrid = ds_grid_create(calloutBubbleGridWidth, 4);

calloutBubbleGridCurrentRow = 0;


ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colString, 0, "yoooo  its the#first string!");
ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colWordID, 0, 10);
ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colString, 1, "now its string# number toooooo");
ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colWordID, 1, 20);
ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colString, 2, "its me string 3#CHECK IT OUT!#its really cool");
ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colWordID, 2, 25);
ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colString, 3, "its string 4#im at the door#lets go to Pour");
ds_grid_set(calloutBubbleGrid, calloutBubbleGrid_colWordID, 3, 37);



bubbleDirRight = 0;
bubbleDirDown = 1;
bubbleDirLeft = 2;
bubbleDirUp = 3;