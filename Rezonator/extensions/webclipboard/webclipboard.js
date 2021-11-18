function webClipboard() {
    navigator.clipboard.readText()
    .then(text => {
      console.log("Clipboard content good : " + text);
      var map = {};
      map["id"] = "webclipboardID";
      map["clipboard"] = text;
      GMS_API.send_async_event_social(map);
    })
    .catch(err => {
      console.log("Clipboard content fails : " + err);
  
    });
  }