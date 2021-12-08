// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_addtoTagSchemaList(){
	
	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	var tag_file_name = file_find_first( "IncludedFiles" + delimiter + "Schemas" + delimiter + "Tag" + delimiter + "tag*.json", 0 );		// find the first glossary file matching naming convention

	show_debug_message("tag_file_name: " + string(tag_file_name));
	if ( tag_file_name == "" )										// if file name does not follow convention, ignore it
	{
		show_error( "No tag files found!", true );
		return;
	}
	while ( tag_file_name != "" )									// if file name follows convention
	{

		var tag_file_name_full = "IncludedFiles" + delimiter + "Schemas" + delimiter + "Tag" + delimiter + tag_file_name;
		var filePath = filename_path(tag_file_name_full);

		
		if (file_exists(tag_file_name_full))										// return error message if there are issues within the glossary file
		{
			show_debug_message("Loading tag file: " + tag_file_name_full);
			scr_addToListOnce(global.includedTagSchemaFileList,tag_file_name_full);
		}
		tag_file_name = file_find_next();
	}

}