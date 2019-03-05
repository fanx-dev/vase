## Fanvas

A cross-platform framework for creating GUI or game on mobile and desktop.

### Feature
- Lightweight GUI widget
- 3D Graphics by OpenGL/WebGL
- Cross-platform support Java/Android/Javascript

### Run on Android
  1.copy android jar:
  copy lib/*.jar file to fantom/lib/java/ext/

  2.build project:
  fan build.fan

  3.pack to jar file:
  fan androidDemo/build.fan dist

  4.run Android project from Eclipse ADT from androidDemo/android/

### Setting LWJGL
1. copy all .jar to fanHome/lib/java/ext/
2. test3d/runJava.sh:
  * java options: -Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows
  * etc/build/config.props: javacParams=-source 1.8 -target 1.8
  * add -XstartOnFirstThread on Mac OS

### Run Javascript
1. Get a browser that support WebGL
2. run test3d/runJs.sh or test/runJs.sh
3. Go to http://localhost:8080/ with your browser.

