function FirebaseREST_Firestore_getURL(path)
{
	return FirebaseFirestore_Path_Join(
		"https://firestore.googleapis.com/v1/projects/",
		global.firebaseProjectID,
		"/databases/(default)/documents/",
		path)
}
