function scr_aiNewMessage(author, msg){
	
	// verify we got a struct
	if (!is_struct(msg)) {
		show_debug_message("scr_aiNewMessage, ERROR msg is not a struct");
		exit;
	}
	
	var _text = "";
	var _chatID = "";
	if (author == obj_aiControl.userAuthor) {
		// VERIFY USER REQUEST
		
		// verify msg has messages variable
		if (!variable_struct_exists(msg, "messages")) {
			show_debug_message("scr_aiNewMessage, ERROR msg does not have 'messages'");
			exit;
		}
		
		// verify messages is an array
		var _messages = msg.messages;
		if (!is_array(_messages)) {
			show_debug_message("scr_aiNewMessage, ERROR _messages is not an array");
			exit;
		}
		
		// verify messages is not empty
		if (array_length(_messages) < 1) {
			show_debug_message("scr_aiNewMessage, ERROR _messages is empty");
			exit;
		}
		
		// get first message
		var _firstMessage = _messages[0];
		show_debug_message("scr_aiNewMessage, _firstMessage: " + string(_firstMessage));
		
		// verify first message is a struct
		if (!is_struct(_firstMessage)) {
			show_debug_message("scr_aiNewMessage, ERROR _firstMessage is not a struct");
			exit;
		}
	
		// verify message has content variable
		if (!variable_struct_exists(_firstMessage, "content")) {
			show_debug_message("scr_aiNewMessage, ERROR _firstMessage does not have 'content'");
			exit;
		}
		
		// get text from content
		_text = _firstMessage.content;
		
		with (obj_aiControl) {
			awaitingResponseTime = current_time;
			showAwaitingResponse = true;
		}
	}
	else if (author == "ChatGPT") {
		// VERIFY AI RESPONSE
		
		// verify msg has choices array
		if (!variable_struct_exists(msg, "choices")) {
			show_debug_message("scr_aiNewMessage, ERROR msg does not have 'choices'");
			exit;
		}
	
		// verify choices is an array
		var _choices = msg.choices;
		if (!is_array(_choices)) {
			show_debug_message("scr_aiNewMessage, ERROR choices is not an array");
			exit;
		}
	
		// verify choices is not empty
		if (array_length(_choices) < 1) {
			show_debug_message("scr_aiNewMessage, ERROR choices is empty");
			exit;
		}
	
		// get first choice
		var _firstChoice = _choices[0];
		show_debug_message("scr_aiNewMessage, _firstChoice: " + string(_firstChoice));
		
		// verify first choice is a struct
		if (!is_struct(_firstChoice)) {
			show_debug_message("scr_aiNewMessage, ERROR _firstChoice is not a struct");
			exit;
		}
	
		// verify first choice has message
		if (!variable_struct_exists(_firstChoice, "message")) {
			show_debug_message("scr_aiNewMessage, ERROR _firstChoice does not have 'message'");
			exit;
		}
	
		// verify message is a struct
		var _firstChoiceMessage = _firstChoice.message;
		if (!is_struct(_firstChoiceMessage)) {
			show_debug_message("scr_aiNewMessage, ERROR _firstChoiceMessage is not a struct");
			exit;
		}
	
		// verify message has content variable
		if (!variable_struct_exists(_firstChoiceMessage, "content")) {
			show_debug_message("scr_aiNewMessage, ERROR _firstChoiceMessage does not have 'content'");
			exit;
		}
		
		// get text from content
		_text = _firstChoiceMessage.content;
		
		// check if we can get chatID
		if (variable_struct_exists(msg, "id")) {
			if (is_string(msg.id)) _chatID = msg.id;
		}
		
		with (obj_aiControl) {
			awaitingResponseTime = current_time;
			showAwaitingResponse = false;
		}
	}
	
	
	// THE MESSAGE HAS BEEN VERIFIED!
	
	
	// create map for this message
	var _msgMap = ds_map_create();	
	
	// save fields
	_msgMap[? "text"] = _text;
	_msgMap[? "author"] = author;
	_msgMap[? "selected"] = false;
	_msgMap[? "msgOriginal"] = msg;
	_msgMap[? "chatID"] = _chatID;
	show_debug_message("_chatID: " + string(_chatID));

	// add this message to our list of messages
	with (obj_aiControl) {
		ds_list_insert(global.aiChatMsgList, 0, _msgMap);
		ds_list_mark_as_map(global.aiChatMsgList, ds_list_size(global.aiChatMsgList) - 1);
		
		if (author != userAuthor) {
			aiCharAt = 1;
			alarm[0] = 3;
		}
	}
	with (obj_aiChatDraw) aiHopToBottom = true;

}