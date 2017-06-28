--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with League.Strings;
with WebDriver.Drivers;

package WebDriver.Remote is

   function Create
     (URL : League.Strings.Universal_String)
        return WebDriver.Drivers.Driver'Class;
   --  Connect to server ("Remote end")

end WebDriver.Remote;
