
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.vaseWindow;

public class SpeechPeer {
    public static SpeechPeer make(Speech self) {
        SpeechPeer peer = new SpeechPeer();
        return peer;
    }

    public void init(Speech self) {
    }

    public boolean speak(Speech self, String text) {
        return speak(self, text, null);
    }

    public boolean speak(Speech self, String text, fan.std.Map options) {
        System.out.println("speak: "+text);
        return false;
    }

    void finalize(Speech self) {
    }
}