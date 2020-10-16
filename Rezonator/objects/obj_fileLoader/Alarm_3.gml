/// @description load backup linegrid when opening file
// You can write your code in this editor
show_debug_message("obj_fileLoader Alarm 3");

ds_grid_copy(obj_control.lineGridBackup, obj_control.lineGrid);

scr_loadINI();

scr_fontGlobalUpdate();
scr_setSpeakerLabelColWidth();
