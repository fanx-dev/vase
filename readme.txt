fogl: direct openGL/WebGL binding.
jsTest: examples for test.
math: math lib for 3d transformation.
lib: LWJGE is a java openGL port.
array: primary number array
gfx2: extending of gfx

setting LWJGE:
1. copy all .jar to fanHome/lib/java/ext/
2. modify fanHome/ect/sys/congif.proops:
  java.options=-Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows