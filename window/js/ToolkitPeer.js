
fan.vaseWindow.ToolkitPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseWindow.ToolkitPeer.prototype.$ctor = function(self) {}

fan.vaseWindow.ToolkitPeer.m_instance = null;
fan.vaseWindow.ToolkitPeer.instance = function() { return fan.vaseWindow.ToolkitPeer.m_instance; }