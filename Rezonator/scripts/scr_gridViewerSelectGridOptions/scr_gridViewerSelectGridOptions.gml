
var optionSelected = argument0;

switch (optionSelected)
{
    //"Happy", "Sad", "Playful", "Serious",
    case "Unit":
        obj_gridViewer.grid = obj_control.unitGrid; // Unit Grid
        break;
    case "Line":
        obj_gridViewer.grid = obj_control.lineGrid; // Unit Grid
        break;
    case "Word":
        obj_gridViewer.grid = obj_control.wordGrid; // Unit Grid
        break;
    case "VizWord":
        obj_gridViewer.grid = obj_control.dynamicWordGrid; // Unit Grid
        break;
    default:
        break;
}
with(obj_dropDown){
    instance_destroy();
}



