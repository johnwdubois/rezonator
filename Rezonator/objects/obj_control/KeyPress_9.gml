// Cycle between windows using Tab key

with(obj_panelPane){
	if (clickedIn == false and clickedInContents == false) {
		if(currentFunction == functionChainList){
			clickedIn = true;
		}
	}
	else if (currentFunction == functionChainList and clickedIn == true) {
		clickedIn = false;
		if(currentFunction == functionChainContents){
			clickedIn = true;
		}
	}
	else if (currentFunction == functionChainContents and clickedIn == true) {
		clickedIn = false;
	}
	
}