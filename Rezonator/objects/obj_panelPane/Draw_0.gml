if (obj_control.gridView)
{
	exit;
}

draw_set_alpha(1);
draw_set_color(global.colorThemePaneBG);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

switch (currentFunction)
{
	case functionChainList:
		scr_panelPane_drawChainTabs();
		scr_panelPane_drawChainListLoop();
		if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = true;
		}
		if (mouse_check_button_pressed(mb_left) and not point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = false;
		}
		if(clickedIn == true) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
		}
		break;
	case functionChainContents:
		scr_panelPane_drawChainContentsLoop();
		if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = true;
		}
		if (mouse_check_button_pressed(mb_left) and not point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = false;
		}
		if(clickedIn == true) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
		}
		break;
	case functionFilter:
		scr_panelPane_drawFilter();
		break;
	case functionSort:
		scr_panelPane_drawSort();
		break;
	case functionSearch:
		scr_panelPane_drawSearch();
		break;
	case functionClique:
		scr_panelPane_drawClique();
		break;
	case functionHelp:
		scr_panelPane_drawHelp();
		break;
	default:
		break;
}


draw_set_alpha(1);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);


var mouseover = false;// Checks mouseover for all panelPane windows
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight))
{
	mouseover = true;
}




if (mouse_check_button_pressed(mb_left) and mouseover
and not obj_control.gridView and not currentFunction == functionChainList and not currentFunction == functionChainContents)
{
	with (obj_chain)
	{
		scr_chainDeselect();
	}
}