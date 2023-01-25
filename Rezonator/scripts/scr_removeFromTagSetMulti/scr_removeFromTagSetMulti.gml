function scr_removeFromTagSetMulti() {
	
	var selectedListSize = ds_list_size(obj_control.selectedTagList);

	for (var i = 0; i < selectedListSize; i++) {		
		with (obj_panelPane) {
			var currentTag = obj_control.selectedTagList[|i];
			if (fieldPaneSwitchButton == fieldPaneTokenMode) {
				obj_control.tokenFieldToChange = functionField_tokenFieldSelected;
				scr_removeFromTagSetOptions(string(currentTag), "token");
			}
			
			else if (fieldPaneSwitchButton == fieldPaneUnitMode) {
				obj_control.unitFieldToChange = functionField_unitFieldSelected;
				scr_removeFromTagSetOptions(string(currentTag), "unit");
			}
			
			else if (fieldPaneSwitchButton == fieldPaneEntryMode) {
				obj_control.chain1toManyFieldToChange = functionField_entryFieldSelected;
				scr_removeFromTagSetOptions(string(currentTag), "entry");
			}
			
			else if (fieldPaneSwitchButton == fieldPaneChainMode) {
				obj_control.chain1to1FieldToChange = functionField_chainFieldSelected;
				scr_removeFromTagSetOptions(string(currentTag), "chain");
			}

			else if (fieldPaneSwitchButton == fieldPaneChunkMode) {
				obj_control.tokenFieldToChange = functionField_chunkFieldSelected;
				scr_removeFromTagSetOptions(string(currentTag), "chunk");
			}
							
			else if (fieldPaneSwitchButton == fieldPaneLinkMode) {
				obj_control.tokenFieldToChange = functionField_linkFieldSelected;
				scr_removeFromTagSetOptions(string(currentTag), "link");
			}
			
		}
	}
	ds_list_clear(obj_control.selectedTagList);
}