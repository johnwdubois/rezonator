//show_message("tp alarm[1]")

if (tempReturnTool >= 0 and tempReturnTool < toolAmount) {
	currentTool = tempReturnTool;
}
scr_killEmptyChains(obj_chain.rezChainGrid);
scr_killEmptyChains(obj_chain.trackChainGrid);
scr_killEmptyChains(obj_chain.stackChainGrid);

tempReturnTool = -1;