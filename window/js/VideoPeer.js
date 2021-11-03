fan.vaseWindow.VideoPeer = function(){}


fan.vaseWindow.VideoPeer.prototype.doSetup = function(self, window) {
    if (!self.video) {
        var src = fan.vaseWindow.GfxUtil.uriToImageSrc(self.m_uri)
        self.video = document.createElement("video");
        self.video.preload = true;
        self.video.src = src;
        self.video.controls = true;

        self.video.oncanplay=function(){ self.fireEvent("prepared"); };
        self.video.onended=function(){ self.fireEvent("completion"); };

        if (!self.video.parentNode) {
            window.shell.appendChild(self.video);
        }
    }
    var style = self.video.style;
    style.position = "absolute";
    style.border = "0";
    style.outline = "0";
    style.left = self.m_x + "px";
    style.top = self.m_y + "px";
    style.width = self.m_w + "px";
    style.height = self.m_h + "px";
    style.margin = 0;
    style.padding = 0;
    self.video.width = self.m_w;
}

fan.vaseWindow.VideoPeer.prototype.play = function(self, loop, options) {
    if (options) {
        if (options.containsKey("pos")) {
            self.video.currentTime = options.get("pos");
        }
    }
    
    self.video.loop = loop;
    self.video.play();
    return true;
}

fan.vaseWindow.VideoPeer.prototype.pause = function(self) {
    remove();
}

fan.vaseWindow.VideoPeer.prototype.remove = function(self) {
    self.video.pause();
    if (self.video.parentNode)
        self.video.parentNode.removeChild(self.video);
}