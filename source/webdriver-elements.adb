--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

package body WebDriver.Elements is

   ---------------
   -- Send_Keys --
   ---------------

   procedure Send_Keys
     (Self : access Element'Class;
      Text : League.Strings.Universal_String)
   is
      List : League.String_Vectors.Universal_String_Vector;
   begin
      List.Append (Text);
      Self.Send_Keys (List);
   end Send_Keys;

end WebDriver.Elements;
