//
//  vaseWindow_Video.m
//  vaseIOS
//
//  Created by yangjiandong on 2021/11/4.
//

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#include "fni_ext.h"
#include "pod_vaseWindow_native.h"
#import "VaseWindow.h"

NSString *vaseWindow_uriToPath(fr_Env env, fr_Obj uri);
VaseWindow* vase_Window_getWindow(fr_Env env, fr_Obj self);
extern float desityScale;

@interface VideoListener : UIResponder
@property(atomic,assign) fr_Obj video;
@property(atomic,strong)AVPlayerViewController *playerVC;
@end

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

struct Video {
    AVPlayerViewController *playerVC;
    VideoListener *listener;
    UIButton *returnButton;
};

fr_Bool vaseWindow_Video_play(fr_Env env, fr_Obj self, fr_Int loop, fr_Obj options) {
    struct Video *video = (struct Video *)getHandle(env, self);
    CMTime t = CMTimeMake(0, 1);
    [video->playerVC.player seekToTime:t];
    [video->playerVC.player play];
    return true;
}

void vaseWindow_Video_pause(fr_Env env, fr_Obj self) {
    struct Video *video = (struct Video *)getHandle(env, self);
    [video->playerVC.player pause];
}

@interface VideoListener ()
@end
@implementation VideoListener
- (instancetype)init:(fr_Obj)video player: (AVPlayerViewController *)playerVC {
    self = [super init];
    fr_Env env = fr_getEnv(NULL);
    self.video = fr_newGlobalRef(env, video);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerDidFinished:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:playerVC.player.currentItem];
    
    [playerVC.player.currentItem addObserver:self
                                        forKeyPath:@"status"
                                           options:NSKeyValueObservingOptionNew
                                           context:nil];
    return self;
}
- (void)playerDidFinished:(NSNotification *)notification {
    fr_Env env = fr_getEnv(NULL);
    fr_callOnObj(env, _video, "fireEvent", 1, fr_newStrUtf8(env, "completion"));
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    fr_Env env = fr_getEnv(NULL);
    fr_callOnObj(env, _video, "fireEvent", 1, fr_newStrUtf8(env, "prepared"));
}
- (void)dealloc {
    fr_Env env = fr_getEnv(NULL);
    fr_deleteGlobalRef(env, _video);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_playerVC.player.currentItem removeObserver:self forKeyPath:@"status"];
}
@end

void vaseWindow_Video_finalize(fr_Env env, fr_Obj self);

void vaseWindow_Video_doSetup(fr_Env env, fr_Obj self, fr_Obj win) {
    struct Video *video = (struct Video *)getHandle(env, self);
    if (video == NULL) {
        video = (struct Video *)calloc(1, sizeof(struct Video));
        fr_Obj uri = fr_getFieldS(env, self, "uri").h;
        NSString *npath = vaseWindow_uriToPath(env, uri);
        NSURL *url = [NSURL fileURLWithPath:npath];
        
        AVPlayerViewController *playerVC;
        playerVC = [[AVPlayerViewController alloc] init];
        playerVC.player = [AVPlayer playerWithURL:url];
        playerVC.showsPlaybackControls = fr_getFieldS(env, self, "controller").b;
        
        bool fullScreen = fr_getFieldS(env, self, "fullScreen").b;
        VaseWindow *window = vase_Window_getWindow(env, win);

        video->listener = [[VideoListener alloc]init:self player: playerVC];
        [window addSubview:playerVC.view];
        
        
        if (fullScreen) {
            playerVC.entersFullScreenWhenPlaybackBegins = YES;
            playerVC.exitsFullScreenWhenPlaybackEnds = YES;
            playerVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            
            UIImage *backButtonImage = [UIImage imageNamed:@"res/return.png"];
            UIButton *button = [[UIButton alloc]init];
            [button setBackgroundImage:backButtonImage forState:UIControlStateNormal];
            button.frame = CGRectMake(5, 5, 30, 30);
            [window addSubview:button];
            [button addTarget:window action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
            video->returnButton = button;
        }
        else {
            video->returnButton = NULL;
        }
        
        if (fr_getFieldS(env, self, "options").h != NULL) {
            playerVC.view.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1];
        }
        
        video->playerVC = playerVC;
        setHandle(env, self, (fr_Int)video);
        
        fr_Type type = fr_getObjType(env, self);
        fr_registerDestructor(env, type, vaseWindow_Video_finalize);
    }
    
    CGRect frame;
    frame.origin.x = (int)fr_getFieldS(env, self, "x").i / desityScale;
    frame.origin.y = (int)fr_getFieldS(env, self, "y").i / desityScale;
    frame.size.width = (int)fr_getFieldS(env, self, "w").i / desityScale;
    frame.size.height = (int)fr_getFieldS(env, self, "h").i / desityScale;
    video->playerVC.view.frame = frame;
}
void vaseWindow_Video_remove(fr_Env env, fr_Obj self) {
    struct Video *video = (struct Video *)getHandle(env, self);
    [video->playerVC.player pause];
    [video->playerVC.view removeFromSuperview];
    if (video->returnButton) {
        [video->returnButton removeFromSuperview];
    }
}
void vaseWindow_Video_finalize(fr_Env env, fr_Obj self) {
    struct Video *video = (struct Video *)getHandle(env, self);
    video->playerVC = nil;
    video->listener = nil;
    video->returnButton = nil;
    free(video);
    setHandle(env, self, 0);
}
