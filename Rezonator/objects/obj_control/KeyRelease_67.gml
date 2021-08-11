/// @description Insert description here
// You can write your code in this editor
if(keyboard_check(vk_control)){
	hoverTextCopy = string(hoverTextCopy);
	if(hoverTextCopy != ""){
		show_debug_message(hoverTextCopy);
		clipboard_set_text(hoverTextCopy);
	}
}