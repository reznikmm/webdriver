--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with WebDriver.Sessions;

package WebDriver.Drivers is

   type Driver is limited interface;

   not overriding function New_Session
    (Self : access Driver) return WebDriver.Sessions.Session_Access
       is abstract;
   --  Create a new WebDriver session

end WebDriver.Drivers;
