httpRequestID = -1;

instInputBox_ApiKey = instance_create_layer(0, 0, "InputBox", obj_inputBox);
with (instInputBox_ApiKey) {
	windowFocused = false;
	inputPrompt = "API Key";
	if (is_string(global.aiChatAPIKey) && global.aiChatAPIKey != "") {
		str = global.aiChatAPIKey;
	}
}
instInputBox_Prompt = instance_create_layer(0, 0, "InputBox", obj_inputBox);
with (instInputBox_Prompt) {
	windowFocused = false;
	inputPrompt = "AI Chat";
}

ds_list_clear(global.aiChatMsgList);
userAuthor = "Rezonator";

aiCharAt = 1;
msgSelectedList = ds_list_create();

aiImportTypeList = ds_list_create();
ds_list_add(aiImportTypeList, "all", "selected", "last");
aiImportType = aiImportTypeList[| 0];