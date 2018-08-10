if (obj_control.gridView)
{
	exit;
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(c_black);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);

if (currentFunction == 0)
{
	scr_panelPane_drawChainTabs();
	scr_panelPane_drawChainListLoop();
}
else if (currentFunction == 1)
{
	scr_panelPane_drawChainContentsLoop();
}
else if (currentFunction == 2)
{
	scr_panelPane_drawFilter();
}