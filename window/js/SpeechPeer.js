
fan.vaseWindow.SpeechPeer = function(){}

fan.vaseWindow.SpeechPeer.prototype.init = function(self) {

}

fan.vaseWindow.SpeechPeer.prototype.speak = function(self, text, options) {
    var utter = new window.SpeechSynthesisUtterance(text);

    if (options) {
        var field = "volume"
        if (options.containsKey(field)) {
            utter[field] = options.get(field);
        }
        var field = "rate"
        if (options.containsKey(field)) {
            utter[field] = options.get(field);
        }
        var field = "volume"
        if (options.containsKey(field)) {
            utter[field] = options.get(field);
        }
    }

    window.speechSynthesis.speak(utter);
    return true;
}
