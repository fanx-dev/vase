package fan.fgfxFwt;

import fan.fgfxGraphics.*;

public class SwtPointArray implements PointArray {

  public int[] array;

  SwtPointArray(int size) {
    array = new int[size+size];
  }

  @Override
  public long getX(long i) {
    return array[(int)i*2];
  }

  @Override
  public void setX(long i, long v) {
    array[(int)i*2] = (int)v;
  }

  @Override
  public long getY(long i) {
    return array[(int)i*2+1];
  }

  @Override
  public void setY(long i, long v) {
    array[(int)i*2+1] = (int)v;
  }

  @Override
  public long size() {
    return array.length/2;
  }

}