function scr_macros(){
	
	// this script holds macros used throughout the codebase
	
	#region BUILD SETTINGS
		// set BUILD to true when you want to load CJK fonts, set false if not
		#macro BUILD false
	
		// BUILDTYPE should be set to one of the following values:
		// "Windows_GitHub_Master", "Mac_GitHub_Master", "Windows_GitHub_Release"
		// "Mac_GitHub_Release", "Steam", "Windows_Website", "Mac_Website", "Web"
		#macro BUILDTYPE "Windows_Website"
		
		// to set whether Steam is enabled, open the Steamworks extension in the Asset Browser
		// and set the platforms and App ID
	#endregion
	
	#region IMPORT TYPES
		#macro IMPORTTYPE_TRANSCRIPTION "import_type_transcription"
		#macro IMPORTTYPE_AICHAT "import_type_aichat"
		#macro IMPORTTYPE_SONG "import_type_song"
		#macro IMPORTTYPE_IGT "import_type_interlinear"
		#macro IMPORTTYPE_CONLLU "import_type_conllu"
		#macro IMPORTTYPE_WORD "import_type_word"
		#macro IMPORTTYPE_ELAN "import_type_elan"
		#macro IMPORTTYPE_PROSE "import_type_prose"
	#endregion
	
	#region NAV WINDOW TABS
		#macro NAVTAB_UNIT "tab_name_unit"
		#macro NAVTAB_STACK "tab_name_stack"
		#macro NAVTAB_TRACK "tab_name_track"
		#macro NAVTAB_RESONANCE "menu_resonance"
		#macro NAVTAB_CLIQUE "tab_name_clique"
		#macro NAVTAB_SHOW "tab_name_show"
		#macro NAVTAB_TREE "tab_name_tree"
		#macro NAVTAB_CHUNK "tab_name_chunk"
		#macro NAVTAB_TAG "tab_name_tag"
		#macro NAVTAB_SEARCH "tab_name_search"
		#macro NAVTAB_TRANSLATION "tab_name_translate"
	#endregion
	
	#region SPECIAL KEYBOARD KEYS
		#macro vk_rcommand 91
		#macro vk_lcommand 92
	#endregion
	
	#region TOOLTIP ARROW FACE DIRECTIONS
		#macro TOOLTIP_DIR_UP 0
		#macro TOOLTIP_DIR_RIGHT 1
		#macro TOOLTIP_DIR_DOWN 2
		#macro TOOLTIP_DIR_LEFT 3
	#endregion
	
	#region DIALOG BOX TYPES
		#macro DIALOG_VERSION_OUTOFDATE "dialog_version_outofdate"
		#macro DIALOG_VERSION_UPTODATE "dialog_version_uptodate"
		#macro DIALOG_AICHAT_ERROR "dialog_aichat_error"
		#macro DIALOG_QUESTION_URLABOUT "dialog_question_urlAbout"
		#macro DIALOG_QUESTION_URLGUIDE "dialog_question_urlGuide"
		#macro DIALOG_QUESTION_DELETERESONANCE "dialog_question_deleteResonance"
		#macro DIALOG_QUESTION_DELETETRAIL "dialog_question_deleteTrail"
		#macro DIALOG_QUESTION_DELETESTACK "dialog_question_deleteStack"
		#macro DIALOG_QUESTION_DELETECHUNK "dialog_question_deleteChunk"
		#macro DIALOG_QUESTION_DELETERESONANCEALL "dialog_question_deleteResonanceAll"
		#macro DIALOG_QUESTION_DELETETRAILALL "dialog_question_deleteTrailAll"
		#macro DIALOG_QUESTION_DELETESTACKALL "dialog_question_deleteStackAll"
		#macro DIALOG_QUESTION_DELETELINKALL "dialog_question_deleteLinkAll"
		#macro DIALOG_QUESTION_DELETECHUNKALL "dialog_question_deleteChunkAll"
		#macro DIALOG_QUESTION_DELETECHAIN "dialog_question_deleteChain"
		#macro DIALOG_QUESTION_DELETECHAINMULTI "dialog_question_deleteChainMulti"
		#macro DIALOG_QUESTION_CONFIRMSIDELINK "dialog_question_confirmSideLink"
		#macro DIALOG_QUESTION_MERGEUNIT "dialog_question_mergeUnit"
		#macro DIALOG_QUESTION_SWAPUNITUP "dialog_question_swapUnitUp"
		#macro DIALOG_QUESTION_SWAPUNITDOWN "dialog_question_swapUnitDown"
		#macro DIALOG_QUESTION_DELETETOKEN "dialog_question_deleteToken"
		#macro DIALOG_QUESTION_SPLITUNIT "dialog_question_splitUnit"
		#macro DIALOG_QUESTION_CLEARSHOW "dialog_question_clearShow"
		#macro DIALOG_QUESTION_MERGESTACKS "dialog_question_mergeStacks"
		#macro DIALOG_QUESTION_MERGETRAILS "dialog_question_mergeTrails"
		#macro DIALOG_QUESTION_MERGERESONANCES "dialog_question_mergeResonances"
		#macro DIALOG_QUESTION_REMOVETAG "dialog_question_removeTag"
		#macro DIALOG_QUESTION_REMOVETAGS "dialog_question_removeTags"
		#macro DIALOG_QUESTION_REMOVEFIELD "dialog_question_removeField"
		#macro DIALOG_QUESTION_REMOVESEARCH "dialog_question_removeSearch"
		#macro DIALOG_QUESTION_REMOVETREE "dialog_question_removeTree"
		#macro DIALOG_QUESTION_ACTIVATESTACKING "dialog_question_activateStacking"
		#macro DIALOG_QUESTION_SAVEBEFOREEXIT "dialog_question_saveBeforeExit"
		#macro DIALOG_QUESTION_SAVEBEFOREIMPORT "dialog_question_saveBeforeImport"
		#macro DIALOG_QUESTION_SAVEBEFOREAICHAT "dialog_question_saveBeforeAiChat"
		#macro DIALOG_QUESTION_SAVEBEFOREOPEN "dialog_question_saveBeforeOpen"
		#macro DIALOG_QUESTION_SAVEBEFOREGAMEEND "dialog_question_saveBeforeGameEnd"
		#macro DIALOG_QUESTION_MERGETOKEN "dialog_question_mergeToken"
		#macro DIALOG_INPUT_RENAMECLIQUE "dialog_rename_clique"
	#endregion
	
	#region DROPDOWN TYPES
	
		// tagging
		#macro DROPDOWN_TOKENTAGMAP "DROPDOWN_TOKENTAGMAP"
		#macro DROPDOWN_UNITTAGMAP "DROPDOWN_UNITTAGMAP"
		#macro DROPDOWN_CHAIN1TOMANY_FIELD "DROPDOWN_CHAIN1TOMANY_FIELD"
		#macro DROPDOWN_CHAIN1TOMANY_TAG "DROPDOWN_CHAIN1TOMANY_TAG"
		#macro DROPDOWN_CHAIN1TO1_FIELD "DROPDOWN_CHAIN1TOMANY_FIELD"
		#macro DROPDOWN_CHAIN1TO1_TAG "DROPDOWN_CHAIN1TOMANY_TAG"
		#macro DROPDOWN_UNITS1TOMANY_FIELD "DROPDOWN_UNITS1TOMANY_FIELD"
		#macro DROPDOWN_UNITS1TOMANY_REMOVEFROMTAGSET "DROPDOWN_UNITS1TOMANY_REMOVEFROMTAGSET"
		#macro DROPDOWN_UNITS1TO1_FIELD "DROPDOWN_UNITS1TO1_FIELD"
		#macro DROPDOWN_UNITS1TO1_REMOVEFROMTAGSET "DROPDOWN_UNITS1TO1_REMOVEFROMTAGSET"
	
		// menu bar and sub-menus
		#macro DROPDOWN_MENUBAR_FILE "DROPDOWN_MENUBAR_FILE"
		#macro DROPDOWN_MENUBAR_ADVANCED "DROPDOWN_MENUBAR_ADVANCED"
		#macro DROPDOWN_MENUBAR_VIEW "DROPDOWN_MENUBAR_VIEW"
		#macro DROPDOWN_MENUBAR_SEARCH "DROPDOWN_MENUBAR_SEARCH"
		#macro DROPDOWN_MENUBAR_ZOOM "DROPDOWN_MENUBAR_ZOOM"
		#macro DROPDOWN_MENUBAR_PANE "DROPDOWN_MENUBAR_PANE" // can pane and nav be combined?
		#macro DROPDOWN_MENUBAR_NAV "DROPDOWN_MENUBAR_NAV"
		#macro DROPDOWN_MENUBAR_JUSTIFY "DROPDOWN_MENUBAR_JUSTIFY"
		#macro DROPDOWN_MENUBAR_PROSE "DROPDOWN_MENUBAR_PROSE"
		#macro DROPDOWN_MENUBAR_HIDE "DROPDOWN_MENUBAR_HIDE"
		#macro DROPDOWN_MENUBAR_CONTEXT "DROPDOWN_MENUBAR_CONTEXT"
		#macro DROPDOWN_MENUBAR_CLEAR "DROPDOWN_MENUBAR_CLEAR"
		#macro DROPDOWN_MENUBAR_SETTINGS "DROPDOWN_MENUBAR_SETTINGS"
		#macro DROPDOWN_MENUBAR_TOOLS "DROPDOWN_MENUBAR_TOOLS"
		#macro DROPDOWN_MENUBAR_HELP "DROPDOWN_MENUBAR_HELP"
		#macro DROPDOWN_MENUBAR_AUTOSAVE "DROPDOWN_MENUBAR_AUTOSAVE"
		#macro DROPDOWN_MENUBAR_EDIT "DROPDOWN_MENUBAR_EDIT"
		
		// misc
		#macro DROPDOWN_CHAINNAVLIST "DROPDOWN_CHAINNAVLIST"
		#macro DROPDOWN_CHAINRECOLOR "DROPDOWN_CHAINRECOLOR"
		#macro DROPDOWN_PARTICIPANTLABEL "DROPDOWN_PARTICIPANTLABEL"
		#macro DROPDOWN_TOKENRIGHTCLICK "DROPDOWN_TOKENRIGHTCLICK"
		#macro DROPDOWN_NEWTOKEN "DROPDOWN_NEWTOKEN"
		#macro DROPDOWN_MAPPINGTAG "DROPDOWN_MAPPINGTAG"
		#macro DROPDOWN_DELETE "DROPDOWN_DELETE"
		#macro DROPDOWN_TOKENSELECTION "DROPDOWN_TOKENSELECTION"
		#macro DROPDOWN_UNITSELECTION "DROPDOWN_UNITSELECTION"
		#macro DROPDOWN_CREATESTACK "DROPDOWN_CREATESTACK"
		#macro DROPDOWN_SPECIALFIELDS "DROPDOWN_SPECIALFIELDS"
		#macro DROPDOWN_FILTER "DROPDOWN_FILTER"
		#macro DROPDOWN_FILTER_ADD "DROPDOWN_FILTER_ADD"
		#macro DROPDOWN_LANGUAGE "DROPDOWN_LANGUAGE"
		#macro DROPDOWN_IMPORTGRID "DROPDOWN_IMPORTGRID"
		#macro DROPDOWN_TEXTDIRECTION "DROPDOWN_TEXTDIRECTION"
		#macro DROPDOWN_SHOW_ADD "DROPDOWN_SHOW_ADD"
		#macro DROPDOWN_SHOW_LIST "DROPDOWN_SHOW_LIST"
		#macro DROPDOWN_TOOLBUTTON "DROPDOWN_TOOLBUTTON"
		#macro DROPDOWN_JUSTIFYPROSE "DROPDOWN_JUSTIFYPROSE"
		#macro DROPDOWN_1TO1 "DROPDOWN_1TO1"
		#macro DROPDOWN_TRANSLATION "DROPDOWN_TRANSLATION"
	#endregion

}