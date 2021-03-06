--  Copyright (c) 2017-2020 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with League.JSON.Values;

separate (WebDriver.Remote)
package body Drivers is

   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   Capabilities_Key : constant Wide_Wide_String := "desiredCapabilities";

   type Session_Access is access all Sessions.Session;

   -----------------
   -- New_Session --
   -----------------

   overriding function New_Session
     (Self         : access Driver;
      Capabilities : League.JSON.Values.JSON_Value :=
        League.JSON.Values.Empty_JSON_Value)
          return WebDriver.Sessions.Session_Access
   is
      Result   : constant not null Session_Access := new Sessions.Session;
      Command  : WebDriver.Remote.Command;
      Response : WebDriver.Remote.Response;
   begin
      Command.Method := Post;
      Command.Path.Append ("/session");
      Command.Parameters.Insert (+Capabilities_Key, Capabilities);
      Response := Self.Executor.Execute (Command);

      Result.Session_Id := Response.Value (+"sessionId").To_String;
      Result.Executor := Self.Executor'Unchecked_Access;
      return WebDriver.Sessions.Session_Access (Result);
   end New_Session;

end Drivers;
