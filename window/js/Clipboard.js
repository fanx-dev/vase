


fan.fanvasWindow.JSClipboard = fan.sys.Obj.$extend(fan.fanvasWindow.Clipboard);
fan.fanvasWindow.JSClipboard.prototype.$ctor = function() {}

fan.fanvasWindow.JSClipboard.prototype.getText = function(callback)
{
  navigator.clipboard.readText()
  .then(text => {
    // `text` contains the text read from the clipboard
    callback(text);
  })
  .catch(err => {
    // maybe user didn't grant access to read from clipboard
    console.log('Something went wrong', err);
    callback(null);
  });
}

fan.fanvasWindow.JSClipboard.prototype.setText = function(text) {
  navigator.clipboard.writeText('Hello Alligator!')
  .then(() => {
    // Success!
  })
  .catch(err => {
    console.log('Something went wrong', err);
  });
}
