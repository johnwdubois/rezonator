alarm[4] = 30;

if (ds_list_size(recentlyMovedWords) > 0)
{
	ds_list_delete(recentlyMovedWords, 0);
}