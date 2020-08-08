/// @description Insert description here
// You can write your code in this editor

currentPopUp = 0;



mouseOverRightButton = false;
mouseOverLeftButton = false;
mouseOverExitButton = false;

allowedToChange = true;


popUpText1 = string_hash_to_newline("You are in Read Mode.# To mark up the #discourse data, choose #either Track Mode or #Rez mode.");
rectX1 = camera_get_view_width(view_camera[0]) - 245;
rectY1 = obj_menuBar.menuHeight + obj_toolPane.windowHeight + 50;
rectX2 = camera_get_view_width(view_camera[0]) - 45;
rectY2 = 180 + rectY1;
