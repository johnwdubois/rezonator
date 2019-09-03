draw_set_font(fnt_main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var buttonWidth = 200;
var buttonHeight = 60;

var newProjectButtonX1 = (camera_get_view_width(view_camera[0]) / 2) - (buttonWidth / 2);
var newProjectButtonY1 = (camera_get_view_height(view_camera[0]) * 0.45);
var newProjectButtonX2 = newProjectButtonX1 + buttonWidth;
var newProjectButtonY2 = newProjectButtonY1 + buttonHeight;

if (point_in_rectangle(mouse_x, mouse_y, newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2))
{
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, false);
	
	if (device_mouse_check_button_released(0, mb_left))
	{
		global.menuOpen = false;
	}
}

draw_set_color(global.colorThemeBorders);
draw_rectangle(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(mean(newProjectButtonX1, newProjectButtonX2), mean(newProjectButtonY1, newProjectButtonY2), "Research");




var openProjectButtonX1 = newProjectButtonX1
var openProjectButtonY1 = newProjectButtonY2 + 30;
var openProjectButtonX2 = newProjectButtonX2;
var openProjectButtonY2 = openProjectButtonY1 + buttonHeight;

if (point_in_rectangle(mouse_x, mouse_y, openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2))
{
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, false);
	
	if (device_mouse_check_button_released(0, mb_left))
	{
		global.menuOpen = false;
		global.newProject = false;
		global.openProject = true;
		global.games = true;
		global.wheresElmo = true;
	}
}

draw_set_color(global.colorThemeBorders);
draw_rectangle(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(mean(openProjectButtonX1, openProjectButtonX2), mean(openProjectButtonY1, openProjectButtonY2), "Games");

var openTutorialButtonX1 = openProjectButtonX1
var openTutorialButtonY1 = openProjectButtonY2 + 30;
var openTutorialButtonX2 = openProjectButtonX2;
var openTutorialButtonY2 = openTutorialButtonY1 + buttonHeight;

if (point_in_rectangle(mouse_x, mouse_y, openTutorialButtonX1, openTutorialButtonY1, openTutorialButtonX2, openTutorialButtonY2))
{
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(openTutorialButtonX1, openTutorialButtonY1, openTutorialButtonX2, openTutorialButtonY2, false);
	
	if (device_mouse_check_button_released(0, mb_left))
	{
		global.menuOpen = false;
		global.newProject = false;
		global.openProject = true;
		global.tutorial = true;
	}
}

draw_set_color(global.colorThemeBorders);
draw_rectangle(openTutorialButtonX1, openTutorialButtonY1, openTutorialButtonX2, openTutorialButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(mean(openTutorialButtonX1, openTutorialButtonX2), mean(openTutorialButtonY1, openTutorialButtonY2), "Tutorial");



var userSignInBoxX1 = openTutorialButtonX1
var userSignInBoxY1 = openTutorialButtonY2 + 50;
var userSignInBoxX2 = openTutorialButtonX2;
var userSignInBoxY2 = userSignInBoxY1 + 30;



draw_set_color(global.colorThemeBorders);
draw_rectangle(userSignInBoxX1, userSignInBoxY1, userSignInBoxX2, userSignInBoxY2, true);
draw_set_color(global.colorThemeText);
draw_text(mean(userSignInBoxX1, userSignInBoxX2), userSignInBoxY1 - 15, "User Sign In");

draw_text(mean(userSignInBoxX1, userSignInBoxX2)+10, userSignInBoxY2 + 16, "Remember Me");




	draw_rectangle(mean(userSignInBoxX1, userSignInBoxX2)-70, userSignInBoxY2 + 10, mean(userSignInBoxX1, userSignInBoxX2)-60, userSignInBoxY2 + 20, true);
	if (global.rememberMe) {
		draw_rectangle(mean(userSignInBoxX1, userSignInBoxX2)-70, userSignInBoxY2 + 10, mean(userSignInBoxX1, userSignInBoxX2)-60, userSignInBoxY2 + 20, false);	
	}

	// current chain boolean switch
	if (point_in_rectangle(mouse_x, mouse_y,mean(userSignInBoxX1, userSignInBoxX2)-70, userSignInBoxY2 + 10, mean(userSignInBoxX1, userSignInBoxX2)-60, userSignInBoxY2 + 20)){
			if (device_mouse_check_button_released(0, mb_left)) {
				global.rememberMe = !global.rememberMe;	
			}
	}
	



if(global.menuOpen){
	//code for keyboard input into user sign in
	// Variables
	var ctext = "";
	// Clipboard
	if(keyboard_check(vk_control) && keyboard_check(ord("V")) && clipboard_has_text()) {
		ctext = clipboard_get_text();
	}
	if(ctext!="" && (keyboard_check_pressed(ord("V")) || keyboard_check_pressed(vk_control))) { 
		obj_openingScreen.inputText = string_insert(ctext, obj_openingScreen.inputText, obj_openingScreen.cursorPos);
		obj_openingScreen.cursorPos += string_length(ctext);
	}

	// Backspace
	if (keyboard_check_pressed(vk_backspace)) {
		obj_openingScreen.inputText = string_delete(obj_openingScreen.inputText, obj_openingScreen.cursorPos-1, 1);
		if (obj_openingScreen.cursorPos >=2) {
			obj_openingScreen.cursorPos-=1;
		}
		else {
			obj_openingScreen.cursorPos = 2;
		}
	}
	if (keyboard_string != "" && global.menuOpen  && keyboard_string != "-" && keyboard_string != "+") {
		//show_message(keyboard_string);
		var t = keyboard_string;
		obj_openingScreen.inputText = string_insert(t, obj_openingScreen.inputText, obj_openingScreen.cursorPos);
		obj_openingScreen.cursorPos += string_length(t);
		keyboard_string = "";
		obj_openingScreen.cursorViz = true;
		obj_openingScreen.cursorTimer = 20;
	}

	// Cursor
	if(keyboard_check_pressed(vk_left)) {
		if (obj_openingScreen.cursorPos >=2) {
			obj_openingScreen.cursorPos-=1;
		}
		else {
			obj_openingScreen.cursorPos = 1;
		}
	}
	if(keyboard_check_pressed(vk_right)) {
		if (obj_openingScreen.cursorPos <= string_length(obj_openingScreen.inputText)){
			obj_openingScreen.cursorPos+=1;
		}
		else{
			if (string_length(obj_openingScreen.inputText) > 0) {
				obj_openingScreen.cursorPos = string_length(obj_openingScreen.inputText) +1;
			}
			else {
				obj_openingScreen.cursorPos = 1;
			}
		}
	}

	var displayText = obj_openingScreen.inputText;

	if (obj_openingScreen.cursorTimer >=0){
		obj_openingScreen.cursorTimer --;
	}
	else{
		obj_openingScreen.cursorViz = !obj_openingScreen.cursorViz;
		obj_openingScreen.cursorTimer =30;
	}


	if(obj_openingScreen.cursorViz){
		displayText = string_insert("|", obj_openingScreen.inputText, obj_openingScreen.cursorPos);
	}
	else{
		displayText = string_delete(displayText, obj_openingScreen.cursorPos, 0);
	}

	draw_set_halign(fa_middle);
	draw_text(mean(userSignInBoxX1, userSignInBoxX2), mean(userSignInBoxY1,userSignInBoxY2) , displayText);
	
	global.userName = obj_openingScreen.inputText;
}
