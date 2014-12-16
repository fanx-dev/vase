Fantom Graphics
=======

- Full feature Fantom 2D Graphics
- Cross platform support Java2D/SWT/Android/Javascript backend
- Lightweight GUI widget system
- Fantom OpenGL/WebGL binding


Setting LWJGL:
1. copy all .jar to fanHome/lib/java/ext/
2. modify fanHome/ect/sys/congif.proops:
  java.options=-Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows

Run WebGL on Chrome:
1. close all chrome process.
2. chrome.exe --ignore-gpu-blacklist --enable-webgl