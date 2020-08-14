if( string_digits(obj_control.inputText) == "" ){
	show_message( "Numbers only" );
}
else{
	if (grid != obj_chain.stackChainGrid){
		for(var i = 0; i < ds_list_size(listOfWordID);i++){
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(obj_control.inputText)));
		}
	}
	ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(obj_control.inputText)));
}