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

import android.media.SoundPool;
import android.content.Context;
import android.media.AudioManager;
import android.media.SoundPool.OnLoadCompleteListener;

public class SoundPeer {
    public static String cacheDir;
    static SoundPool soundPool;

    int id;

    public static void init(Context context) {
        cacheDir = context.getCacheDir().toString();
        soundPool = new SoundPool(4, AudioManager.STREAM_MUSIC, 0);
        soundPool.setOnLoadCompleteListener(new OnLoadCompleteListener(){
            public void onLoadComplete (SoundPool soundPool, 
                int sampleId, 
                int status) {
                //TODO;
            }
        });
    }

    public static SoundPeer make(Sound self) {
        SoundPeer peer = new SoundPeer();
        return peer;
    }

    boolean play(Sound self, long loop, fan.std.Map options) {
        float volume = 1.0f;
        if (options != null) {
            if (options.containsKey("volume")) {
                double pos = (Double)options.get("volume");
                volume = (float)pos;
            }
        }
        int res = soundPool.play(id, volume, volume, 1, (int)loop, 1.0f);
        return res != 0;
    }

    void pause(Sound self) {
        soundPool.stop(id);
    }

    void doLoad(Sound self) {
        fan.std.Uri uri = self.uri;
        fan.std.File tempDir = null;
        if (cacheDir != null) {
            tempDir = fan.std.File.os(cacheDir);
        }
        fan.std.File dstFile = fan.std.File.os(cacheDir+"/res/"+uri.pathStr());

        fan.std.File srcFile;
        if (uri.scheme() != null) {
          srcFile = ((fan.std.File) uri.get());
        }
        else {
          srcFile = ((fan.std.File) uri.toFile());
        }

        fan.std.Map op = fan.std.Map.make();
        op.set("overwrite", false);
        srcFile.copyTo(dstFile, op);

        id = soundPool.load(dstFile.osPath(), 1);
    }

    void dispose(Sound self) {
        soundPool.unload(id);
    }

    void finalize(Sound self) {
        soundPool.unload(id);
    }
}
