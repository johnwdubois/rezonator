function scr_aiNewMessage(author, msg, typein){
	
	// create map for this message
	var _msgMap = ds_map_create();	
	
	// save the unedited strings
	_msgMap[? "text"] = msg;
	_msgMap[? "author"] = author;
	_msgMap[? "selected"] = false;

	// add this message to our list of messages
	with (obj_aiControl) {
		ds_list_insert(msgList, 0, _msgMap);
		ds_list_mark_as_map(msgList, ds_list_size(msgList) - 1);
		scrollPlusY = 0;
		
		if (author != userAuthor) {
			aiCharAt = 1;
			alarm[0] = 3;
		}
	}

}