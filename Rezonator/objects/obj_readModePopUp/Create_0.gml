/// @description Insert description here
// You can write your code in this editor

currentPopUp = 0;



mouseOverRightButton = false;
mouseOverLeftButton = false;
mouseOverExitButton = false;

allowedToChange = true;

draw_set_font(global.fontMain);
popUpText1 = "You are in Read Mode.";
popUpText2 = string_hash_to_newline("To mark up your text,#select one of the modes in the top right window:#Track mode (to mark coreference between mentions)#Rez mode (to mark resonance between words)");
rectX1 = mouse_x + 75;
rectY1 = mouse_y;
rectX2 = rectX1 + 40 + string_width("Track mode (to mark coreference between mentions)");
rectY2 = 40 + rectY1 + string_height(popUpText2) + (string_height(popUpText1)*2);

arrowX1 = camera_get_view_width(view_camera[0]) - 200;
arrowY1 = obj_menuBar.menuHeight + obj_toolPane.windowHeight + 75;
