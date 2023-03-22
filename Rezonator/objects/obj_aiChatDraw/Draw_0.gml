// draw BG
var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(0, 0, camWidth, camHeight, false);


var _instInputBox_Prompt = obj_aiControl.instInputBox_Prompt;


var strHeight = string_height("A");
var plusY = 0;
var textX = _instInputBox_Prompt.textBoxX;
var authorX = _instInputBox_Prompt.textBoxX - string_width("  ");
var textY = _instInputBox_Prompt.textBoxY - (strHeight * 1.5);
var maxTextWidth = _instInputBox_Prompt.windowWidth;
var messageVBuffer = strHeight * 0.5;

var _msgList = obj_aiControl.msgList;
var msgListSize = ds_list_size(_msgList);
for (var i = 0; i < msgListSize; i++) {
	
	// get current message text & author
	var _msgMap = _msgList[| i];
	var _author = _msgMap[? "author"];
	var _text = _msgMap[? "text"];
	var _selected = _msgMap[? "selected"];
	var _msgY = textY + plusY + scrollPlusY + messageVBuffer;
	
	var _textWrapped = scr_wordWrap(_text, maxTextWidth, false);
	
	// draw background for this message
	var _msgY1 = _msgY - string_height(_textWrapped) - messageVBuffer;
	var _msgY2 = _msgY + messageVBuffer;
	
	draw_set_color(merge_color(global.colorThemeBG, global.colorThemeText, _author == obj_aiControl.userAuthor ? 0.1 : 0.15));
	draw_rectangle(0, _msgY1, camWidth, _msgY2, false);
	if (_selected) {
		draw_set_color(global.colorThemeRezPurple);
		draw_roundrect(textX - (messageVBuffer / 2), _msgY1 + (messageVBuffer / 2), textX + maxTextWidth + (messageVBuffer / 2), _msgY2 - (messageVBuffer / 2), true);
	}
	
	// mouseover message
	var mouseoverText = point_in_rectangle(mouse_x, mouse_y, textX, _msgY1, textX + maxTextWidth, _msgY2) && mouse_y < _instInputBox_Prompt.textBoxY - messageVBuffer;
	if (mouseoverText) {
		draw_set_color(global.colorThemeText);
		draw_set_alpha(0.1);
		draw_roundrect(textX - (messageVBuffer / 2), _msgY1 + (messageVBuffer / 2), textX + maxTextWidth + (messageVBuffer / 2), _msgY2 - (messageVBuffer / 2), false);
		draw_set_alpha(1);
		
		// click on message to toggle selection
		if (mouse_check_button_released(mb_left)) {
			_selected = !_selected;
			_msgMap[? "selected"] = _selected;
		}
	}
	
	// draw author
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	draw_set_color(global.colorThemeText);
	draw_text(textX - string_width("   "), _msgY1 + messageVBuffer, _author);
	
	// draw text
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	draw_set_color(global.colorThemeText);
	draw_text(textX, _msgY, _textWrapped);

	// adjust y coordinate for next message
	plusY -= string_height(_textWrapped) + (messageVBuffer * 2);
}

// scroll messages
if (mouse_wheel_up() || keyboard_check(vk_up)) scrollPlusY += 16;
else if (mouse_wheel_down() || keyboard_check(vk_down)) scrollPlusY -= 16;
scrollPlusY = clamp(scrollPlusY, 0, -(plusY + textY));