Fantom Graphics
=======

- Full features 2D Graphics API
- Lightweight GUI widget system
- Fantom OpenGL/WebGL binding
- Cross platform support Java2D/SWT/Android/Javascript


Run on Android
-------
1. Clone my fork https://bitbucket.org/chunquedong/fan-1.0
2. Bootstrap compile (http://fantom.org/doc/docTools/Bootstrap#script)
3. Bootstrap compile again using the new compiler.
4. Build app as a single JAR
5. Call fanjardist.Main.boot() to init Fantom Env in java.

Setting LWJGL
-------
1. copy all .jar to fanHome/lib/java/ext/
2. modify fanHome/ect/sys/congif.proops:
  java.options=-Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows

Run WebGL on Chrome
-------
1. close all chrome process.
2. chrome.exe --ignore-gpu-blacklist --enable-webgl



