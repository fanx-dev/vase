## vase

A cross-platform framework for creating GUI app.

### Feature
- Design for mobile with fat animation
- Cross-platform: Android/iOS/Windows/MacOS/Browser
- 3D Graphics by OpenGL/WebGL

### Screenshot

![image](https://raw.githubusercontent.com/fanx-dev/vase/master/res/snap.png)


### Desktop
  ```
  cd test/public/widget
  fan WidgetTest.fwt
  ```

### Android
  1. copy android jar:
  ```
  cp lib/*.jar env/lib/java/ext/
  ```
  2. build demo:
  ```
  cd demo
  sh build_android.sh
  ```

### iOS
  ```
  cd demo
  sh build_cordova.sh
  cd cordovaDemo
  cordova run ios
  ```

### Browser
  ```
  cd test
  sh runJs.sh
  ```
  Service started on http://localhost:8080/

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

