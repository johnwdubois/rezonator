// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_navOptions(optionSelected){
	switch(optionSelected){

		case "Left":
			with(obj_panelPane){
				
				if(not showNav){
					showNav = true;
				}
				showNavLeft = not showNavLeft;	
				
				if(showNavRight == false && showNavLeft == false && obj_toolPane.showTool == false){
					showNav = false;
				}
			}
			
		break;
		
		case "Right" :

			with(obj_panelPane){
				if(not showNav){
					showNav = true;
				}
				showNavRight = not showNavRight;	
			
				if(showNavRight == false && showNavLeft == false && obj_toolPane.showTool == false){
					showNav = false;
				}
			}
		
		break;		
		case "Tools" :
			with(obj_panelPane){
				
				if(not showNav){
					showNav = true;
				}
			}
			obj_toolPane.showTool = !obj_toolPane.showTool;	
			
			with(obj_panelPane){
				if(showNavRight == false && showNavLeft == false && obj_toolPane.showTool == false){
					showNav = false;
				}
			}
		
		break;
		
		case "All" :
		
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