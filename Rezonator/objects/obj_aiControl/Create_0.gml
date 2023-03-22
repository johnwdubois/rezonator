httpRequestID = -1;

instInputBox_ApiKey = instance_create_layer(0, 0, "InputBox", obj_inputBox);
with (instInputBox_ApiKey) {
	windowFocused = false;
	inputPrompt = "API Key";
}
instInputBox_Prompt = instance_create_layer(0, 0, "InputBox", obj_inputBox);
with (instInputBox_Prompt) {
	windowFocused = false;
	inputPrompt = "AI Chat";
}

msgList = ds_list_create();
userAuthor = "Rezonator";

aiCharAt = 1;
msgSelectedList = ds_list_create();