var dirName = filename_path(global.fileSaveName) + string_lettersdigits(filename_name(global.fileSaveName)) + " CSV";

if (not directory_exists_ns(dirName))
{
	directory_create_ns(dirName);
}

scr_gridToCSV(obj_control.wordGrid, dirName + "\\wordGrid.csv");
scr_gridToCSV(obj_control.dynamicWordGrid, dirName + "\\dynamicWordGrid.csv");
scr_gridToCSV(obj_chain.linkGrid, dirName + "\\linkGrid.csv");
scr_gridToCSV(obj_chain.cliqueGrid, dirName + "\\cliqueGrid.csv");
scr_gridToCSV(obj_chain.rezChainGrid, dirName + "\\rezChainGrid.csv");
scr_gridToCSV(obj_chain.trackChainGrid, dirName + "\\trackChainGrid.csv");
scr_gridToCSV(obj_chain.stackChainGrid, dirName + "\\stackChainGrid.csv");