var dirName = filename_path(global.fileSaveName) + string_lettersdigits(filename_name(global.fileSaveName)) + " CSV";

if (not directory_exists_ns(dirName)) {
	directory_create_ns(dirName);
}

scr_gridToCSV(obj_control.wordGrid, dirName + "\\word.csv");
scr_gridToCSV(obj_control.unitGrid, dirName + "\\unit.csv");
scr_gridToCSV(obj_control.dynamicWordGrid, dirName + "\\dynaWord.csv");
scr_gridToCSV(obj_chain.linkGrid, dirName + "\\link.csv");
scr_gridToCSV(obj_chain.vizLinkGrid, dirName + "\\vizLink.csv");
scr_gridToCSV(obj_chain.cliqueGrid, dirName + "\\clique.csv");
scr_gridToCSV(obj_chain.rezChainGrid, dirName + "\\rez.csv");
scr_gridToCSV(obj_chain.trackChainGrid, dirName + "\\track.csv");
scr_gridToCSV(obj_chain.stackChainGrid, dirName + "\\stack.csv");