var filename = argument0;
global.importFilename = filename;

var fileOpenRead = file_text_open_read(filename);


var widthOfImportGrid = 0;
while (not file_text_eof(fileOpenRead)) {
	
	var lineInFile = file_text_readln(fileOpenRead);
	var listOfColumns = ds_list_create();
	listOfColumns = scr_splitString(lineInFile,chr(9));
	for(var i = 0; i <= ds_list_size(listOfColumns); i++){
		if(ds_list_find_value(listOfColumns,i) == "" or ds_list_find_value(listOfColumns,i) == " "){
			ds_list_delete(listOfColumns,i);
			i -= 1;
		}
	}
	if(widthOfImportGrid <= ds_list_size(listOfColumns)){
		widthOfImportGrid = ds_list_size(listOfColumns);
		global.importGridWidth = widthOfImportGrid
		ds_grid_resize(global.importGrid, widthOfImportGrid, ds_grid_height(global.importGrid));
	}
	ds_grid_resize(global.importGrid, global.importGridWidth, ds_grid_height(global.importGrid)+1);
	
	for(var i = 0; i <= ds_list_size(listOfColumns); i++){
		
		var fullColString = string(ds_list_find_value(listOfColumns,i));
		var colStringList = ds_list_create();
		colStringList = scr_splitString(fullColString, " ");
		
		if(ds_list_size(colStringList) > 1){
			ds_grid_set(global.importGrid, i , ds_grid_height(global.importGrid) -1, colStringList);
		}
		ds_grid_set(global.importGrid, i , ds_grid_height(global.importGrid) -1, fullColString);
	}
	
	
	//show_message(scr_getStringOfList(listOfColumns));
	
}
global.plainText = true;
global.tabDeliniatedText = true;
