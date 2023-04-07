/// @description Copy to clipboard from tag cell
if (global.ctrlHold && navWindowTaggingID == "") {
	hoverTextCopy = string(hoverTextCopy);
	if (hoverTextCopy != "") {
		show_debug_message(hoverTextCopy);
		clipboard_set_text(hoverTextCopy);
	}
}