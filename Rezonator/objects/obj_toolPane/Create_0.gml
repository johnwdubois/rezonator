/*
	obj_toolPane: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of the toolPane object
	
	Purpose: Instantiate all variables used by the toolPane object
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

windowWidth = 100;
windowHeight = 150;

x = room_width - windowWidth;
y = 0;

toolAmount = 4;
toolPointer = 0;
toolRezBrush = 1;
toolTrackBrush = 2;
toolStackBrush = 3;
toolNewWord = 4;

currentTool = toolRezBrush;



progressBarX = room_width - 100;
progressBarY = 150 - 32;
progressBarWidth = 100;
progressBarHeight = 32;
progressBarBackColor = c_gray;
progressBarFrontColor = c_blue;
progressBarFont = fnt_mainBold;