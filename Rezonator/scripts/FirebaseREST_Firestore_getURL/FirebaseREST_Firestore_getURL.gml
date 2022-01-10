function FirebaseREST_Firestore_getURL(path)
{
	return FirebaseFirestore_Path_Join(
		"https://firestore.googleapis.com/v1/projects/",
		Firebase_ProjectID,
		"/databases/(default)/documents/",
		path)
}
