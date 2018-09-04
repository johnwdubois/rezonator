currentCenterDisplayRow = 0;

gridSpaceHorizontal = 100;
gridSpaceVertical = 33.4;

speakerLabelMargin = 170;
speakerLabelMarginBuffer = 20;
wordLeftMargin = 170;
wordLeftMarginDest = 170;


c_ltblue = make_color_rgb(183, 183, 255);


shapeText = 0;
shapeBlock = 1;
shape = shapeBlock;


unitGridWidth = 9;
unitGrid_colUnitID = 0;
unitGrid_colUtteranceID = 1;
unitGrid_colWordIDList = 2;
unitGrid_colDiscoID = 3;
unitGrid_colpID = 4;
unitGrid_colParticipantName = 5;
unitGrid_colUnitStart = 6;
unitGrid_colUnitEnd = 7;
unitGrid_colParticipantColorIndex = 8;

unitGrid = ds_grid_create(unitGridWidth, 0);



wordGridWidth = 5;
wordGrid_colWordID = 0;
wordGrid_colUnitID = 1;
wordGrid_colWordSeq = 2;
wordGrid_colWordToken = 3;
wordGrid_colWordTranscript = 4;

wordGrid = ds_grid_create(wordGridWidth, 0);

wordIDCounter = 0;
unitIDCounter = 0;


wordTranscriptView = true;




lineGridWidth = 8;
lineGrid_colDisplayRow = 0;
lineGrid_colDiscoID = 1;
lineGrid_colUnitID = 2; //lineGrid_colUnit = 2;
lineGrid_colLineNumberLabel = 3;
lineGrid_colPixelY = 4; //lineGrid_colY = 3;
lineGrid_colLineState = 5;
lineGrid_colWordIDList = 6;
lineGrid_colAlignedWordID = 7;

lineGrid = ds_grid_create(lineGridWidth, 0);



searchGrid_colHitIDList = lineGrid_colWordIDList;

filterGrid = ds_grid_create(lineGridWidth, 0);
searchGrid = ds_grid_create(lineGridWidth, 0);



filterGridActive = false;
searchGridActive = false;

currentActiveLineGrid = lineGrid;



dynamicWordGridWidth = 8;
dynamicWordGrid_colWordID = 0;
dynamicWordGrid_colDisplayWordSeq = 1; //dynamicWordGrid_colLineWordSeq = 1;
dynamicWordGrid_colDisplayCol = 2; //dynamicWordGrid_colPositionCol = 2;
dynamicWordGrid_colPixelX = 3; //dynamicWordGrid_colX = 3; 
dynamicWordGrid_colWordState = 4;
dynamicWordGrid_colDisplayString = 5; //dynamicWordGrid_colStringDisplay = 5;
dynamicWordGrid_colInChainList = 6; //dynamicWordGrid_colInChains = 6;
dynamicWordGrid_colAligned = 7;

dynamicWordGrid = ds_grid_create(dynamicWordGridWidth, 0);



wordDrawGridWidth = 5;
wordDrawGrid_colBorder = 0;
wordDrawGrid_colBorderRounded = 1;
wordDrawGrid_colFillRect = 2;
wordDrawGrid_colTextColor = 3;
wordDrawGrid_colEffectColor = 4;
wordDrawGrid = ds_grid_create(wordDrawGridWidth, 0);





hitGridWidth = 7;
hitGrid_colWordID = 0;
hitGrid_colUnitID = 1;
hitGrid_colHitID = 2;
hitGrid_colWordState = 3;
hitGrid_colHitBool = 4;
hitGrid_colDisplayCol = 5;
hitGrid_colPixelX = 6;

hitGrid = ds_grid_create(hitGridWidth, 0);







participantList = ds_list_create();
participantColorList = ds_list_create();

scr_loadUnitGrid();
scr_loadDynamicWordGrid();


/*
ds_list_add(participantColorList,make_color_rgb(255, 107, 107));
ds_list_add(participantColorList,make_color_rgb(107, 134, 255));
ds_list_add(participantColorList,make_color_rgb(107, 255, 141));
ds_list_add(participantColorList,make_color_rgb(252, 255, 107));
ds_list_add(participantColorList,make_color_rgb(181, 107, 255));
ds_list_add(participantColorList,make_color_rgb(107, 247, 255));
ds_list_add(participantColorList,make_color_rgb(255, 178, 107));
ds_list_add(participantColorList,make_color_rgb(255, 107, 200));
*/

/*
for (var participantColorListLoop = 0; participantColorListLoop < ds_list_size(participantList); participantColorListLoop++)
{
	var hue = (255 / ds_list_size(participantList)) * participantColorListLoop;
	var newColor = make_color_hsv(hue, 200, 255);
	ds_list_add(participantColorList, newColor);
}
*/
randomise();
//ds_list_shuffle(participantColorList);

for (var participantColorLoop = 0; participantColorLoop < ds_list_size(participantList); participantColorLoop++)
{
	participantColor[participantColorLoop] = ds_list_find_value(participantColorList, min(ds_list_size(participantColorList) - 1, participantColorLoop));
}


cursorBox = 0;
cursorBoxX = 0;
cursorBoxY = 0;

drawRange = 30;


displayRowAscending = true;

holdUpArrowKey = 0;
holdDownArrowKey = 0;

wordColor = c_black;

alignment = 0;
//0 = left, 1 = center, 2 = right

gridView = false;

showDevVars = false;