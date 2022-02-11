//
//  vaseWindow_Audio.m
//  vaseIOS
//
//  Created by yangjiandong on 2021/10/30.
//

#import <AVFoundation/AVFoundation.h>

#include "fni_ext.h"
#include "pod_vaseWindow_native.h"

static fr_Int getHandle(fr_Env env, fr_Obj self) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    fr_getInstanceField(env, self, f, &val);
    return (val.i);
}

static void setHandle(fr_Env env, fr_Obj self, fr_Int r) {
    static fr_Field f = NULL;
    if (f == NULL) f = fr_findField(env, fr_getObjType(env, self), "handle");
    fr_Value val;
    val.i = (fr_Int)r;
    fr_setInstanceField(env, self, f, &val);
}

struct Sound {
    AVAudioPlayer *player;
};

fr_Bool vaseWindow_Sound_play(fr_Env env, fr_Obj self, fr_Int loop, fr_Obj options) {
    struct Sound *sound = (struct Sound*)getHandle(env, self);
    AVAudioPlayer *player = sound->player;
    
    if (options) {
        fr_Obj volumeObj = fr_callOnObj(env, options, "get", 1, fr_newStrUtf8(env, "volume")).h;
        if (volumeObj) {
            fr_Value value;
            fr_unbox(env, volumeObj, &value);
            float volume = value.f;
            player.volume = volume;
        }
    }
    
    player.numberOfLoops = loop;
    
    [player play];
    return true;
}
void vaseWindow_Sound_pause(fr_Env env, fr_Obj self) {
    struct Sound *sound = (struct Sound*)getHandle(env, self);
    AVAudioPlayer *player = sound->player;
    [player pause];
}

NSString *vaseWindow_uriToPath(fr_Env env, fr_Obj uri) {
    fr_Obj scheme = fr_callOnObj(env, uri, "scheme", 0).h;
    fr_Obj path;
    if (scheme == NULL) {
        path = fr_callOnObj(env, uri, "pathStr", 0).h;
    }
    else {
        const char *schemeStr = fr_getStrUtf8(env, scheme);
        if (strcmp(schemeStr, "fan") == 0) {
            fr_Obj file = fr_callOnObj(env, uri, "get", 0).h;
            if (fr_errOccurred(env)) {
                return nil;
            }
            path = fr_callOnObj(env, file, "osPath", 0).h;
        }
        else if (strcmp(schemeStr, "file") == 0) {
            path = fr_callOnObj(env, uri, "pathStr", 0).h;
        }
        else {
            path = fr_callOnObj(env, uri, "toStr", 0).h;
        }
    }
    if (fr_errOccurred(env)) {
        return nil;
    }

    const char *pathStr = fr_getStrUtf8(env, path);
    NSString *npath = [NSString stringWithUTF8String:pathStr];
    return npath;
}

void vaseWindow_Sound_doLoad(fr_Env env, fr_Obj self) {
    fr_Obj uri = fr_getFieldS(env, self, "uri").h;
    NSString *npath = vaseWindow_uriToPath(env, uri);
    NSURL *url = [NSURL fileURLWithPath:npath];
    
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player prepareToPlay];
    
    struct Sound *sound = calloc(1, sizeof(struct Sound));
    sound->player = player;
    
    setHandle(env, self, (fr_Int)sound);
}
void vaseWindow_Sound_release(fr_Env env, fr_Obj self) {
    struct Sound *sound = (struct Sound*)getHandle(env, self);
    AVAudioPlayer *player = sound->player;
    [player stop];
    sound->player = nil;
}
void vaseWindow_Sound_finalize(fr_Env env, fr_Obj self) {
    struct Sound *sound = (struct Sound*)getHandle(env, self);
    sound->player = nil;
    free(sound);
    setHandle(env, self, 0);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct Speech {
    AVSpeechSynthesizer *synth;
    AVSpeechSynthesisVoice *voice;
};

void vaseWindow_Speech_init(fr_Env env, fr_Obj self) {
    struct Speech *speech = calloc(1, sizeof(struct Speech));
    speech->synth = [[AVSpeechSynthesizer alloc]init];
    
    NSArray*languages = [NSLocale preferredLanguages];
    NSString*currentLanguage = [languages objectAtIndex:0];
    speech->voice = [AVSpeechSynthesisVoice voiceWithLanguage:currentLanguage];
    
    setHandle(env, self, (fr_Int)speech);
}

fr_Bool vaseWindow_Speech_speak(fr_Env env, fr_Obj self, fr_Obj text, fr_Obj options) {
    struct Speech *speech = (struct Speech *)getHandle(env, self);
    
    NSString *ntext = [NSString stringWithUTF8String:fr_getStrUtf8(env, text)];
    
    if (ntext.length == 0) {
        [speech->synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        return false;
    }
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:ntext];
    
    utterance.voice = speech->voice;
    [speech->synth speakUtterance:utterance];
    return true;
}

void vaseWindow_Speech_finalize(fr_Env env, fr_Obj self) {
    struct Speech *speech = (struct Speech *)getHandle(env, self);
    speech->synth = nil;
    speech->voice = nil;
    free(speech);
    setHandle(env, self, 0);
}
