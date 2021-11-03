package fan.vaseWindow;

import android.media.MediaPlayer;
import android.widget.MediaController;
import android.widget.VideoView;
import android.app.Activity;
import fan.vaseAndroid.*;
import android.widget.FrameLayout;
import android.os.Handler;
import android.view.View;

public class VideoPeer {
    VideoView videoView;
    android.view.ViewGroup parent;

    public static VideoPeer make(Video self) {
        VideoPeer peer = new VideoPeer();
        return peer;
    }

    private static VideoView init(Activity context, Video self) {
        VideoPeer videoPeer = (VideoPeer)self.peer;
        if (videoPeer.videoView != null) return videoPeer.videoView;

        VideoView videoView = new VideoView(context);
        videoPeer.videoView = videoView;

        String path = AndUtil.uriToPath(self.uri);
        videoView.setVideoPath(path);
        videoView.setMediaController(new MediaController(context));
        videoView.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            @Override
            public void onPrepared(MediaPlayer mp) {
                self.fireEvent("prepared");
            }
        });
        videoView.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            @Override
            public void onCompletion(MediaPlayer mp) {
                self.fireEvent("completion");
            }
        });

        videoView.seekTo(1);

        return videoView;
    }

    boolean play(Video self, long loop, fan.std.Map options) {
        //if (loop == -1) videoView.setLooping(true);
        videoView.start();
        return true;
    }

    void pause(Video self) {
        videoView.pause();
    }

    void doSetup(Video self, Window win) {
        fan.vaseAndroid.AndWindow awin = (fan.vaseAndroid.AndWindow)win;
        VideoView view = VideoPeer.init(awin.context, self);
        if (view.getParent() == null) {
          awin.shell.addView(view);
          parent = awin.shell;
        }


        FrameLayout.LayoutParams param = new FrameLayout.LayoutParams(
                (int)self.w, (int)self.h);
        param.setMargins((int)self.x, (int)self.y, 0, 0);
        view.setLayoutParams(param);
        view.invalidate();
    }

    void remove(Video self) {
        videoView.stopPlayback();
        videoView.setVisibility(View.GONE);
        if (videoView.getParent() != null) {
          new Handler().post(new Runnable() {
              public void run()
              {
                parent.removeView(videoView);
              }
            });
        }
    }

    void finalize(Video self) {
        remove(self);
    }
}