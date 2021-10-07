if (obj_panelPane.showNav) exit;
rectHeight = (camera_get_view_height(view_camera[0])*0.2);
draw_set_alpha(1);

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox);
draw_set_halign(fa_center);

// set up drawing & BG
x = obj_control.wordLeftMargin;
y = obj_menuBar.y;
obj_control.wordTopMargin = y + rectHeight * 1.1;
var bgColor = merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5);
draw_set_color(bgColor);
draw_rectangle(0, obj_menuBar.menuHeight, camWidth, y + rectHeight, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(0, obj_menuBar.menuHeight, camWidth, y + rectHeight, true);

// get stack, make sure it exists
var stackID = "";
if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabShow && obj_panelPane.functionChainContents_showID != "" ){
	var currentShowSubMap = global.nodeMap[? obj_panelPane.functionChainList_playShowID];
	if (scr_isNumericAndExists(currentShowSubMap,ds_type_map)) {
		//get setlist of playing show
		var setList = currentShowSubMap[? "setIDList"];	
		if (scr_isNumericAndExists(setList, ds_type_list)) {		
			stackID = setList[| obj_panelPane.currentChainIndex];
		}
	}
}
var stackSubMap = global.nodeMap[? stackID];
if (!scr_isNumericAndExists(stackSubMap, ds_type_map)) exit;

// level name and caption text
draw_set_color(global.colorThemeText);
var stackName = string(stackSubMap[? "name"])
var nameTextY = y + rectHeight * 0.4;
var scoreTextX = floor(camWidth * 0.2);
var movesTextX = floor(camWidth * 0.8);
var textY = floor(mean(y, y + rectHeight));
var strHeight = string_height("0");
scr_adaptFont("", "L", false);
draw_text(floor(camWidth * 0.5), nameTextY, stackName);
scr_adaptFont("", "M", false);
draw_text_ext(floor(camWidth * 0.5), textY + strHeight, string(stackSubMap[? "caption"]), strHeight, movesTextX - scoreTextX - string_width("Score Moves "));

var lineY = nameTextY + (strHeight * 0.65);
var nameWidth = string_width(stackName) * 1.5;
draw_set_color(global.colorThemeBorders);
draw_line_width(floor((camWidth * 0.5) - (nameWidth * 0.5)), lineY, floor((camWidth * 0.5) + (nameWidth * 0.5)), lineY, 4);

// score and par text
var movesMade = stackSubMap[? "movesMade"];
var par = stackSubMap[? "par"];
var stackScore = stackSubMap[? "score"];
var stackTotalScore = stackSubMap[? "totalScore"];
draw_set_color(global.colorThemeText);
scr_adaptFont("", "L", false);
draw_text(scoreTextX, textY, "Score");
draw_set_color(stackScore >= stackTotalScore ? c_green : global.colorThemeText);
draw_text(scoreTextX, textY + strHeight, string(stackScore) + " / " + string(stackTotalScore));
draw_set_color(global.colorThemeText);
draw_text(movesTextX, textY, "Moves");
draw_set_color(movesMade >= par ? c_red : global.colorThemeText);
draw_text(movesTextX, textY + strHeight, string(movesMade) + " / " + string(par));

if (movesMade >= par) {
	draw_set_halign(fa_center);
	draw_text(floor(camWidth * 0.5), floor(y + rectHeight - (strHeight)), "Out of moves!");
}

if (movesMade >= par) {
	global.delayInput = 5;
	scr_chainDeselect();
}

// reset button
var resetButtonX = camWidth * 0.075;
var resetButtonY = textY + (strHeight / 2);
var resetButtonWidth = camWidth * 0.1;
var resetButtonHeight = strHeight * 1.5;
var resetButtonX1 = resetButtonX - (resetButtonWidth / 2);
var resetButtonY1 = resetButtonY - (resetButtonHeight / 2);
var resetButtonX2 = resetButtonX + (resetButtonWidth / 2);
var resetButtonY2 = resetButtonY + (resetButtonHeight / 2);
var mouseoverReset = point_in_rectangle(mouse_x, mouse_y, resetButtonX1, resetButtonY1, resetButtonX2, resetButtonY2) && !mouseoverCancel;
var resetColor = merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.75);
draw_set_color(mouseoverReset ? global.colorThemeSelected1 : resetColor);
draw_rectangle(resetButtonX1, resetButtonY1, resetButtonX2, resetButtonY2, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(resetButtonX1, resetButtonY1, resetButtonX2, resetButtonY2, true);
draw_text(floor(resetButtonX), floor(resetButtonY), "Reset");
if (mouseoverReset && mouse_check_button_released(mb_left)) {
	scr_deleteAllChains(global.nodeMap[? "resonanceList"]);
	stackSubMap[? "movesMade"] = 0;
}


// next level button
var nextButtonX = camWidth * (1 - 0.075);
var nextButtonY = textY + (strHeight / 2);
var nextButtonWidth = camWidth * 0.1;
var nextButtonHeight = strHeight * 1.5;
var nextButtonX1 = nextButtonX - (nextButtonWidth / 2);
var nextButtonY1 = nextButtonY - (nextButtonHeight / 2);
var nextButtonX2 = nextButtonX + (nextButtonWidth / 2);
var nextButtonY2 = nextButtonY + (nextButtonHeight / 2);
var mouseoverNext = point_in_rectangle(mouse_x, mouse_y, nextButtonX1, nextButtonY1, nextButtonX2, nextButtonY2) && !mouseoverCancel;
var nextColor = merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.75);
draw_set_color(mouseoverNext ? global.colorThemeSelected1 : nextColor);
draw_rectangle(nextButtonX1, nextButtonY1, nextButtonX2, nextButtonY2, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(nextButtonX1, nextButtonY1, nextButtonX2, nextButtonY2, true);
draw_text(floor(nextButtonX), floor(nextButtonY), "Next level");
if (mouseoverNext && mouse_check_button_released(mb_left)) {
	#region
	var showID = obj_panelPane.functionChainContents_showID;
	var showSubMap = global.nodeMap[? showID];
	if (!scr_isNumericAndExists(showSubMap, ds_type_map)) exit;
	var setList = showSubMap[? "setIDList"];
	if (!scr_isNumericAndExists(setList, ds_type_list)) exit;
	var setListSize = ds_list_size(setList);
	
	if(obj_panelPane.currentChainIndex < setListSize-1 && obj_panelPane.currentChainIndex != -1){
		with (obj_panelPane) currentChainIndex++;

		scr_setValueForAllChains("stack","filter", false);
									
		// Filter the first current stack
		var currentStackID = setList[| obj_panelPane.currentChainIndex];

		if(ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1){
			if(currentStackID != undefined){
				ds_list_add(obj_chain.filteredStackChainList,currentStackID);
				var chainSubMap = global.nodeMap[? currentStackID];
				if (scr_isNumericAndExists(chainSubMap,ds_type_map)) {
					chainSubMap[? "filter"] = true;
				}
			}
			with (obj_control) {
				scr_renderFilter2();
			}
		}
	}
	else{

		scr_setValueForAllChains("stack","filter", false);
		with(obj_panelPane){
			functionChainList_playShowID = "";
		}
		with (obj_control) {
			scr_disableFilter();
		}
	}
	#endregion
}