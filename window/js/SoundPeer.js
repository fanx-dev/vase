
fan.vaseWindow.SoundPeer = function(){}


fan.vaseWindow.SoundPeer.prototype.load = function(self) {
    var src = fan.vaseWindow.GfxUtil.uriToImageSrc(self.m_uri)
    self.audio = new Audio();
    self.audio.preload = true;
    self.audio.src = src;
}

fan.vaseWindow.SoundPeer.prototype.play = function(self, loop, options) {
    if (options) {
        if (options.containsKey("pos")) {
            self.audio.currentTime = options.get("pos");
        }
    }
    
    self.audio.loop = loop
    self.audio.play();
    return true;
}

fan.vaseWindow.SoundPeer.prototype.pause = function(self) {
    self.audio.pause();
}

fan.vaseWindow.SoundPeer.prototype.release = function(self) {
    self.audio.pause();
}