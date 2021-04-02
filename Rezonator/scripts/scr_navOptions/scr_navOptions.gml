// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_navOptions(optionSelected){
	switch(optionSelected){

		case "menu_left":
			var navLeft = obj_panelPane.showNavLeft;
			navLeft = !navLeft;
			with(obj_panelPane){
				showNav = true;
				showNavLeft = navLeft;	
				if (!showNavRight && !showNavLeft) {
					showNav = false;
				}
			}
			break;
		
		case "menu_right":
			var navRight = obj_panelPane.showNavRight;
			navRight = !navRight;
			with(obj_panelPane){
				showNav = true;
				showNavRight = navRight;	
				if (!showNavRight && !showNavLeft) {
					showNav = false;
				}
			}
			break;
		
		case "menu_nav" :
		
			with(obj_panelPane){
				showNav = not showNav;
				if(showNav){
					showNavRight = true;	
					showNavLeft = true;
				}
				else{
					showNavRight = false;	
					showNavLeft = false;
				}
			}
			break;
		
		case "menu_tools" :

			obj_toolPane.showTool = !obj_toolPane.showTool;	
			
			with(obj_panelPane){
				if(showNavRight == false && showNavLeft == false && obj_toolPane.showTool == false){
					showNav = false;
				}
			}
		
		break;
		
		case "menu_all" :
		
			with(obj_panelPane){
				showNav = not showNav;
				if(showNav){
					showNavRight = true;	
					showNavLeft = true;
					obj_toolPane.showTool = true;
			
				}
				else{
					showNavRight = false;	
					showNavLeft = false;
					obj_toolPane.showTool = false;
				}
			}
		break;
	}
}