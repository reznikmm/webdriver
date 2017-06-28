--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with League.JSON.Values;

separate (WebDriver.Remote)
package body Sessions is

   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   ---------------------
   -- Get_Current_URL --
   ---------------------

   overriding function Get_Current_URL
     (Self : access Session) return League.Strings.Universal_String
   is
      Command  : WebDriver.Remote.Command;
      Response : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path.Append ("/session/");
      Command.Path.Append (Self.Session_Id);
      Command.Path.Append ("/url");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Current_URL;

   --------
   -- Go --
   --------

   overriding procedure Go
     (Self : access Session;
      URL  : League.Strings.Universal_String)
   is
      Command  : WebDriver.Remote.Command;
      Response : WebDriver.Remote.Response;
      Value    : constant League.JSON.Values.JSON_Value :=
        League.JSON.Values.To_JSON_Value (URL);
      pragma Unreferenced (Response);
   begin
      Command.Method := Post;
      Command.Path.Append ("/session/");
      Command.Path.Append (Self.Session_Id);
      Command.Path.Append ("/url");
      Command.Parameters.Insert (+"url", Value);
      Command.Session_Id := Self.Session_Id;
      Response := Self.Executor.Execute (Command);
   end Go;

end Sessions;
