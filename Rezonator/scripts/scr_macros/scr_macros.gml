function scr_macros(){
	
	// this script holds macros used throughout the codebase
	
	#region BUILD SETTINGS
		// set BUILD to true when you want to load CJK fonts, set false if not
		#macro BUILD false
	
		// BUILDTYPE should be set to one of the following values:
		// "Windows_GitHub_Master", "Mac_GitHub_Master", "Windows_GitHub_Release"
		// "Mac_GitHub_Release", "Steam", "Windows_Website", "Mac_Website", "Web"
		#macro BUILDTYPE "Windows_Website"  
		#macro STEAMAPI true
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
	
	#region SPECIAL KEYBOARD KEYS
		#macro vk_rcommand 91
		#macro vk_lcommand 92
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
	
	#endregion

}