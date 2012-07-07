//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

@Js
class Event
{
  Bool consumed := false
  Void consume() { consumed = true }

  DateTime time := DateTime.now
  Obj? src
  Obj? data

  Int id := -1
}

@Js
class EventListeners
{
  ** Get the list of registered callback functions.
  |Event|[] list() { return listeners.ro }

  ** Return if `size` is zero.
  Bool isEmpty() { return listeners.isEmpty }

  ** Return number of registered callback functions.
  Int size() { return listeners.size }

  ** Add a listener callback function
  Void add(|Event| cb) { listeners.add(cb); modified }

  ** Remove a listener callback function
  Void remove(|Event| cb) { listeners.remove(cb); modified }

  ** Fire the event to all the listeners
  Void fire(Event? event)
  {
    listeners.each | |Event| cb |
    {
      try
      {
        if (event == null || !event.consumed)
          cb(event)
      }
      catch (Err e)
      {
        echo("event: $event")
        e.trace
      }
    }
  }

  ** Fire internal modified event
  internal Void modified()
  {
    try
      onModify?.call(this)
    catch (Err e)
      e.trace
  }

  ** List of listeners
  private |Event|[] listeners := |Event|[,]

  ** Callback when list of listeners is modified
  internal |EventListeners|? onModify
}