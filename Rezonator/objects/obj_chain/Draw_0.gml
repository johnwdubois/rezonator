// Draw all chains within view
if (not obj_control.gridView) {
	scr_drawRezChain();
	scr_drawTrackChain();
	scr_drawChunk();
}

scr_unfocusOtherChains(obj_toolPane.toolStackBrush);