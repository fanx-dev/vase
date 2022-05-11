## vase

A cross-platform framework for building beautiful natively applications.

### Feature
- cross-platform: Android,iOS,Web,Desktop
- mobile-optimized widgets
- flexible style and layout
- async/await based Http client
- declarative programming

### Screenshot

![image](https://raw.githubusercontent.com/fanx-dev/vase/master/res/snap.png)


### Build
1. install [fanx runtime](https://github.com/fanx-dev/fanx/blob/master/doc/QuickStart.md) 
2. run build script：
```
   sh build.sh
```


### Desktop
  run demo:
  ```
  fan vaseDemo
  ```
  run script:
  ```
  cd test/public/widget
  fan WidgetTest.fwt
  ```

### Android
  1. add android jar:
  ```
  cp AndroidSDK/platforms/android-23/android.jar env/lib/java/ext/
  ```
  2. build demo:
  ```
  cd demo
  sh build_android.sh
  ```

### iOS
  1. generate c code
  ```
  fangen -r vaseDemo
  
  ```
  2. open in xcode
  ```
  open ios/vaseIOS.xcodeproj
  ```

### Web browser
  ```
  cd demo
  sh runJs.sh
  ```
  Windows:
  ```
  sh runJs_win.sh
  ```
  Service started on http://localhost:8080/Main



### Hot load tools
```
cd demo
sh fogViewer.sh
sh scriptViewer.sh
```


### How It Works

![image](https://raw.githubusercontent.com/fanx-dev/vase/master/res/architecture.png)



## OpenGL Wraps

### Setting LWJGL (OpenGL support)
1. copy all .jar to fanHome/lib/java/ext/
2. test3d/runJava.sh:
  ```
  FAN_HOME=/Users/yangjiandong/workspace/code/fanx/env
  jfan='java -Xmx512M -XstartOnFirstThread -cp '$FAN_HOME'/lib/java/fanx.jar -Dfan.home='$FAN_HOME/' fanx.tools.Fan'
  $jfan Textures.fwt
  ```

### WebGL
1. Get a browser that support WebGL
2. run test3d/runJs.sh
3. Go to http://localhost:8080/ with your browser.
