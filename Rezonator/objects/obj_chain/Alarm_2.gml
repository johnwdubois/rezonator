///@description CliqueBreakCheck
// Check cliqueGrid rows for breaks
if (cliqueGridRowToCheckBreak < 0 or cliqueGridRowToCheckBreak >= ds_grid_height(cliqueGrid)) {
	exit;
}

scr_cliqueGridCheckForBreak(cliqueGridRowToCheckBreak);
//cliqueGridRowToCheckBreak = -1;