function scr_macros(){
	
	// this script holds macros used throughout the codebase
	
	
	#region BUILD SETTINGS
		// set BUILD to true when you want to load CJK fonts, set false if not
		#macro BUILD true
	
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

}