function scr_aiRequest(prompt){
	
	// reset input box
	with (instInputBox_Prompt) {
		str = "";
		cursorIndex = 0;
		highlightIndex = 0;
	}
	
	// define url and request method
	var _url = "https://api.openai.com/v1/chat/completions";
	var _method = "POST";
	
	// create header map
	var _headerMap = ds_map_create();
	_headerMap[? "Content-Type"] = "application/json";
	_headerMap[? "Authorization"] = "Bearer " + string(global.aiChatAPIKey);

	// create body struct
	var _body = {
		"model": "gpt-3.5-turbo",
		"messages": [{"role": "user", "content": prompt}]
	};
	
	// cache request message
	scr_aiNewMessage(obj_aiControl.userAuthor, _body);

	// make http request
	var _bodyStr = json_stringify(_body, true);
	show_debug_message("scr_aiRequest, _bodyStr: " + string(_bodyStr) + "\nAPI key: " + string(global.aiChatAPIKey));
	httpRequestID = http_request(_url, _method, _headerMap, _bodyStr);

}