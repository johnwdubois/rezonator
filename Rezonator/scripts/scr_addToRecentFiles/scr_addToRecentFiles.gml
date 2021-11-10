// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_addToRecentFiles(filePath){
	
	var fileName = filename_name(filePath);
	//update key list
	scr_addToListOnce(global.recentFilesList,string(fileName), true);
	var recentFilesListSize = ds_list_size(global.recentFilesList);
	while(recentFilesListSize > 20){
		
		ds_map_delete(global.recentFilesMap,global.recentFilesList[|recentFilesListSize-1]);
		ds_list_delete(global.recentFilesList,recentFilesListSize-1);
		recentFilesListSize = ds_list_size(global.recentFilesList);
	}
	
	
	//update map for new info
	var fileMap = ds_map_create();

	

	var dateString = string(string(current_month)+"/"+string(current_day)+"/"+ string(current_year));
	var timeString = string(string(current_hour)+":"+string(current_minute)+"."+ string(current_second));
	show_debug_message(dateString);
	show_debug_message(timeString);
	fileMap[?"Date"] = "Last edited... " + dateString + " "+ timeString;
	fileMap[?"FileName"] = fileName;
	fileMap[?"FilePath"] = filePath;
	
	var col = make_color_hsv(random_range(0, 255), random_range(125, 255), random_range(200, 255));
	col = merge_color(col, c_white, 0.5);
	
	fileMap[?"Color"] = col;
		
	ds_map_add_map(global.recentFilesMap, fileName, fileMap);
	
	show_debug_message(string(fileName)+ ":    file exists " + string(file_exists(fileName)));
	
}