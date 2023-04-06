function scr_helpOptions(optionSelected) {
	//helpOptions
	if (room == rm_aiChat) exit;

	switch (optionSelected)
	{
		case "menu_help":
			obj_panelPane.functionHelp_collapsed = !obj_panelPane.functionHelp_collapsed;
			break;
		case "menu_guide":
			scr_createDialogBox(DIALOG_QUESTION_URLGUIDE, true);
			break;
		case "menu_about":
			scr_createDialogBox(DIALOG_QUESTION_URLABOUT, true);
			break;
		case "menu_check-updates":
			show_debug_message("Checking for update...");
			if (instance_exists(obj_firestore)) {
				with (obj_firestore) {
					var docPath = "Platforms/"+ string(BUILDTYPE);
					FirebaseFirestore(docPath).Read();
				}
				global.manualVersionCheck = true;
			}
			break;
		default:
			break;
	}



}
