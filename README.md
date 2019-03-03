## Fanvas

A cross-platform Fantom framework for creating GUI or game on mobile and desktop.

### Feature
- Full features 2D Graphics API
- Lightweight GUI widget system
- Fantom OpenGL/WebGL binding
- Cross-platform support Java/Android/Javascript


### Run on Android
II. compile fanGx lib and Android Demo
  1.copy android jar
  copy fanGfx/lib/*.jar file to fan/lib/java/ext/

  2.build project
  fan/bin/fan /Users/yangjiandong/workspace/code/fanGfx/build.fan

  3.pack to jar file
  fan/bin/fan /Users/yangjiandong/workspace/code/fanGfx/androidDemo/build.fan dist

  4.run Android project from Eclipse ADT from fanGfx/androidDemo/android/

### Setting LWJGL
1. copy all .jar to fanHome/lib/java/ext/
2. modify test3d/runJava.sh:
  java.options=-Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows

### Run Javascript
1. Get a browser that support WebGL
2. run /test3d/runJs.sh
3. Go to http://localhost:8080/ with your browser.

