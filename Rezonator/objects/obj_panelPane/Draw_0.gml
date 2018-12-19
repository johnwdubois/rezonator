if (obj_control.gridView)
{
	exit;
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

switch (currentFunction)
{
	case functionChainList:
		scr_panelPane_drawChainTabs();
		scr_panelPane_drawChainListLoop();
		break;
	case functionChainContents:
		scr_panelPane_drawChainContentsLoop();
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
	default:
		break;
}


draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);

if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)
and not obj_control.gridView)
{
	with (obj_chain)
	{
		scr_chainDeselect();
	}
}