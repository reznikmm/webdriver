--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with League.JSON.Values;
with League.String_Vectors;

separate (WebDriver.Remote)
package body Sessions is

   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   function To_String
     (Strategy : WebDriver.Location_Strategy)
      return League.Strings.Universal_String;

   type Element_Access is access all Elements.Element;

   ------------------
   -- Find_Element --
   ------------------

   overriding function Find_Element
     (Self     : access Session;
      Strategy : WebDriver.Location_Strategy;
      Selector : League.Strings.Universal_String)
        return WebDriver.Elements.Element_Access
   is
      Result    : constant not null Element_Access := new Elements.Element;
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
      Using     : constant League.JSON.Values.JSON_Value :=
        League.JSON.Values.To_JSON_Value (To_String (Strategy));
      Value     : constant League.JSON.Values.JSON_Value :=
        League.JSON.Values.To_JSON_Value (Selector);
      Element   : League.JSON.Objects.JSON_Object;
   begin
      Command.Method := Post;
      Command.Path.Append ("/session/");
      Command.Path.Append (Self.Session_Id);
      Command.Path.Append ("/element");
      Command.Parameters.Insert (+"using", Using);
      Command.Parameters.Insert (+"value", Value);
      Response := Self.Executor.Execute (Command);
      Element := Response.Value (+"value").To_Object;
      Result.Session_Id := Self.Session_Id;
      Result.Element_Id := Element (+"ELEMENT").To_String;
      Result.Executor := Self.Executor;

      return WebDriver.Elements.Element_Access (Result);
   end Find_Element;

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

   ---------------
   -- To_String --
   ---------------

   function To_String
     (Strategy : WebDriver.Location_Strategy)
      return League.Strings.Universal_String
   is
      Image : constant Wide_Wide_String :=
        WebDriver.Location_Strategy'Wide_Wide_Image (Strategy);
      Text  : constant League.Strings.Universal_String := +Image;
      List  : constant League.String_Vectors.Universal_String_Vector :=
        Text.To_Lowercase.Split ('_');
   begin
      return List.Join (" ");
   end To_String;

end Sessions;
