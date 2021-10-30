
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.vaseWindow;

import java.util.Locale;
import android.speech.tts.TextToSpeech;
import android.speech.tts.UtteranceProgressListener;
import android.widget.Toast;
import android.content.Context;

public class SpeechPeer {
    TextToSpeech textToSpeech;
    static int count;
    static Context context;

    public static void init(Context ctx) {
        context = ctx.getApplicationContext();
    }

    public static SpeechPeer make(Speech self) {
        SpeechPeer peer = new SpeechPeer();
        return peer;
    }

    public void init(Speech self) {
        textToSpeech = new TextToSpeech(context, new TextToSpeech.OnInitListener() {
            @Override
            public void onInit(int status) {
                if (status == TextToSpeech.SUCCESS) {
                    int result = textToSpeech.setLanguage(Locale.getDefault());
                    if (result == TextToSpeech.LANG_MISSING_DATA
                            || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                        Toast.makeText(context, "Language not supported", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    Toast.makeText(context, "Init failed", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    public boolean speak(Speech self, String text) {
        return speak(self, text, null);
    }

    public boolean speak(Speech self, String text, fan.std.Map options) {
        if (options != null) {
            if (options.containsKey("pitch")) {
                double v = (Double)options.get("pitch");
                textToSpeech.setPitch((float)v);
            }
            if (options.containsKey("rate")) {
                double v = (Double)options.get("rate");
                textToSpeech.setSpeechRate((float)v);
            }
            if (options.containsKey("pitch")) {
                double v = (Double)options.get("pitch");
                textToSpeech.setPitch((float)v);
            }
        }
        int res = textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, null, count+"");
        ++count;
        return res == TextToSpeech.SUCCESS;
    }

    void finalize(Speech self) {
    }
}