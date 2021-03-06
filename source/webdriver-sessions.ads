--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with League.Strings;
with WebDriver.Elements;

package WebDriver.Sessions is

   type Session is limited interface;

   type Session_Access is access all Session'Class
     with Storage_Size => 0;

   not overriding procedure Go
     (Self : access Session;
      URL  : League.Strings.Universal_String) is abstract;
   --  Load a new web page in the current browser window.

   not overriding function Get_Current_URL
    (Self : access Session) return League.Strings.Universal_String
       is abstract;
   --  Gets the URL the browser is currently displaying.

   not overriding function Find_Element
     (Self     : access Session;
      Strategy : WebDriver.Location_Strategy;
      Selector : League.Strings.Universal_String)
      return WebDriver.Elements.Element_Access is abstract;

end WebDriver.Sessions;
