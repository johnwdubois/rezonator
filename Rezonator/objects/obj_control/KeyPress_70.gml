// Activates and deactivates the search grid
if (searchGridActive)
{
	searchGridActive = false;
	filterGridActive = false;
	currentActiveLineGrid = lineGrid;
	wordLeftMarginDest = 170;
}
else
{
	scr_searchForWord();
}