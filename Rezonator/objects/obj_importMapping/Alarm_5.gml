// check if there has been a token level field identified from the schema
// if there has, we will select the schema column by default
// otherwise, we will select the predicted column by default
var tokenLevelRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevelSchema, 0, global.tagInfoGrid_colLevelSchema, ds_grid_height(global.tagInfoGrid), global.levelToken);
if (tokenLevelRow > -1) {
	levelEstimateColumnSelected = global.tagInfoGrid_colLevelSchema;
}
else {
	levelEstimateColumnSelected = global.tagInfoGrid_colLevelPredict;
}