if (keyboard_check(vk_control) and keyboard_check_pressed(ord("S")) and ableToHotkey)
{
	ableToHotkey = false;
	//scr_exportREZ();
	scr_saveREZ();
}
else if (keyboard_check(vk_control) and keyboard_check_pressed(ord("O")) and ableToHotkey)
{
	ableToHotkey = false;
	//scr_importLinks();
	scr_loadREZ();
}
if (not keyboard_check(vk_control) and not ableToHotkey)
{
	ableToHotkey = true;
}