function scr_aiRequest(prompt){
	
	scr_aiNewMessage(obj_aiControl.userAuthor, prompt, false);
	
	with (instInputBox_Prompt) {
		str = "";
		cursorIndex = 0;
		highlightIndex = 0;
	}
	
	var _url = "https://api.openai.com/v1/chat/completions";
	var _method = "POST";
	
	var _headerMap = ds_map_create();
	_headerMap[? "Content-Type"] = "application/json";
	_headerMap[? "Authorization"] = "Bearer " + string(global.aiChatAPIKey);

	var _bodyStruct = {
		"model": "gpt-3.5-turbo",
		"messages": [{"role": "user", "content": prompt}]
	};

	var _body = json_stringify(_bodyStruct, true);
	show_debug_message("scr_aiRequest, _body: " + string(_body) + "\nAPI key: " + string(global.aiChatAPIKey));
	httpRequestID = http_request(_url, _method, _headerMap, _body);

}