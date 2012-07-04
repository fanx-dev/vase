//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

package fan.fanWt;

import javax.swing.*;

import fan.sys.*;
import fan.fan2d.*;


public class WinPeer
{
  public static WinPeer make(Win self)
  {
    WinPeer peer = new WinPeer();
    return peer;
  }


  private static void createAndShowGUI() {
    //Create and set up the window.
    JFrame frame = new JFrame("HelloWorldSwing");
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setSize(200, 200);

    //Add the ubiquitous "Hello World" label.
    JLabel label = new JLabel("Hello World");
    frame.getContentPane().add(label);

    //Display the window.
    //frame.pack();
    frame.setVisible(true);
  }

  public void open(Win self) throws InterruptedException {
    javax.swing.SwingUtilities.invokeLater(new Runnable() {
        public void run() {
            createAndShowGUI();
        }
    });
    Thread.sleep(Long.MAX_VALUE);
  }

}