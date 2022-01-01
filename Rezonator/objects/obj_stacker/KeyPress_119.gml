		with (obj_panelPane) {
			functionChainList_currentTab = functionChainList_tabStackBrush;
			if(obj_toolPane.currentMode = obj_toolPane.modeRead) {
				obj_toolPane.currentMode = obj_toolPane.modeTrack;
				if(obj_control.currentView == obj_control.searchView) {
						obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
				}
				else {
					obj_toolPane.setModeMain = obj_toolPane.modeTrack;
				}
			}
		}