package fan.vaseWindow;

import fan.vaseGraphics.*;

public class WtkPointArray implements PointArray {

  public int[] xa;
  public int[] ya;

  WtkPointArray(int size) {
    xa = new int[size];
    ya = new int[size];
  }

  @Override
  public long getX(long i) {
    return xa[(int)i];
  }

  @Override
  public void setX(long i, long v) {
    xa[(int)i] = (int)v;
  }

  @Override
  public long getY(long i) {
    return ya[(int)i];
  }

  @Override
  public void setY(long i, long v) {
    ya[(int)i] = (int)v;
  }

  @Override
  public long size() {
    return ya.length;
  }

}