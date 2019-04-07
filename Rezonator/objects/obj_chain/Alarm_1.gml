///@description CliqueRefresh
// Refresh the Clique grid rows
if (cliqueGridRowToRefresh < 0 or cliqueGridRowToRefresh >= ds_grid_height(cliqueGrid))
{
	exit;
}

scr_cliqueGridRefreshUnitIDList(cliqueGridRowToRefresh);
cliqueGridRowToRefresh = -1;