function FirebaseREST_Firestore_getURL(path)
{
	return FirebaseFirestore_Path_Join(
		"https://firestore.googleapis.com/v1/projects/",
		"rezonator-13b47",
		"/databases/(default)/documents/",
		path)
}
