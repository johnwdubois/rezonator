function scr_tagPaneOptions(optionSelected){
	
	with(obj_panelPane){
		if(optionSelected == fieldPaneTokenMode){
			fieldPaneSwitchButton = fieldPaneTokenMode;
		}
		else if(optionSelected == fieldPaneUnitMode){
			fieldPaneSwitchButton = fieldPaneUnitMode;
		}
		else if(optionSelected == fieldPaneChainMode){
			fieldPaneSwitchButton = fieldPaneChainMode;
		}
		else if(optionSelected == fieldPaneEntryMode){
			fieldPaneSwitchButton = fieldPaneEntryMode;
		}
		else if(optionSelected == fieldPaneChunkMode){
			fieldPaneSwitchButton = fieldPaneChunkMode;
		}
		else if(optionSelected == fieldPaneLinkMode){
			fieldPaneSwitchButton = fieldPaneLinkMode;
		}

	}
	
	with(obj_dropDown){
		instance_destroy(obj_dropDown);
	}
}