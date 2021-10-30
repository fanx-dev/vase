//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.vaseWindow;

import java.io.File;
import java.io.IOException;

import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.Clip;
import javax.sound.sampled.UnsupportedAudioFileException;

public class SoundPeer {

    Clip clip;
    AudioInputStream audioStream;

    public static SoundPeer make(Sound self) {
        SoundPeer peer = new SoundPeer();
        return peer;
    }

    boolean play(Sound self, long loop, fan.std.Map options) {
        if (options != null) {
            if (options.containsKey("pos")) {
                long pos = (Long)options.get("pos");
                clip.setMicrosecondPosition((int)pos);
            }
        }
        if (loop == -1) {
            clip.loop(Clip.LOOP_CONTINUOUSLY);
        } else {
            clip.loop((int) loop);
        }
        clip.start();
        return true;
    }

    void pause(Sound self) {
        clip.stop();
    }

    void load(Sound self) {
        try {
//            audioStream = AudioSystem.getAudioInputStream(
//                    new File(fan.std.File.make(self.uri).osPath()));
            fan.std.InStream fin = null;
            if (self.uri.scheme() != null) {
              fin = ((fan.std.File) self.uri.get()).in();
            }
            else {
              fin = ((fan.std.File) self.uri.toFile()).in();
            }
            java.io.InputStream input = fanx.interop.Interop.toJava(fin);
            audioStream = AudioSystem.getAudioInputStream(input);
            
            // the reference to the clip 
            clip = AudioSystem.getClip();

            clip.open(audioStream);
            fin.close();
        } catch (Exception e) {
            throw new fan.sys.Err(e);
        }
    }

    void dispose(Sound self) {
        clip.stop();
        clip.close();
    }

    void finalize(Sound self) {
        clip.close();
    }
}
