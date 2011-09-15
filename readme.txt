fogl: direct openGL/WebGL binding.
math: math lib for 3d transformation.
lib: LWJGE is a java openGL port.
array: primary number array
gfx2: extending of gfx
gfx2Imp: AWT, SWT, HTML5Canvas implementions
jsTest: examples for test.

Setting LWJGE:
1. copy all .jar to fanHome/lib/java/ext/
2. modify fanHome/ect/sys/congif.proops:
  java.options=-Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows

Run WebGL on Chrome:
1. close all chrome progress.
2. chrome.exe --ignore-gpu-blacklist --enable-webgl