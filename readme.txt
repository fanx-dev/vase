gui
  - fan2d: new fantom 2D graphics API
  - fanWt: woindow toolkit
  - fanWidget: widget system
  - fanAndroid: android impl

gfxExt
  - gfx2: extending of gfx
  - gfx2Imp: AWT, SWT, HTML5Canvas, Andorid implementions
  - touch: widget system for touch devices

openGL
  - fogl: direct openGL/WebGL binding
  - fan3d: fan 3D lib

common
  - math: math lib for 3d and 3d transformation
  - array: primary number array

lib
  - jwjgl: LWJGL is a java openGL port
  - android: android jar


Setting LWJGL:
1. copy all .jar to fanHome/lib/java/ext/
2. modify fanHome/ect/sys/congif.proops:
  java.options=-Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows

Run WebGL on Chrome:
1. close all chrome process.
2. chrome.exe --ignore-gpu-blacklist --enable-webgl