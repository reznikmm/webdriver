--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with League.JSON.Arrays;
with League.JSON.Values;

separate (WebDriver.Remote)
package body Elements is

   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   function To_Path
     (Self : access Element;
      Command : Wide_Wide_String;
      Suffix  : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return League.Strings.Universal_String;

   -----------
   -- Clear --
   -----------

   overriding procedure Clear (Self : access Element) is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
      pragma Unreferenced (Response);
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/clear");
      Response := Self.Executor.Execute (Command);
   end Clear;

   -----------
   -- Click --
   -----------

   overriding procedure Click (Self : access Element) is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
      pragma Unreferenced (Response);
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/click");
      Response := Self.Executor.Execute (Command);
   end Click;

   -------------------
   -- Get_Attribute --
   -------------------

   overriding function Get_Attribute
     (Self : access Element;
      Name : League.Strings.Universal_String)
         return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/attribute", Name);
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Attribute;

   -------------------
   -- Get_CSS_Value --
   -------------------

   overriding function Get_CSS_Value
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/css", Name);
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_CSS_Value;

   ------------------
   -- Get_Property --
   ------------------

   overriding function Get_Property
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/property", Name);
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Property;

   ------------------
   -- Get_Tag_Name --
   ------------------

   overriding function Get_Tag_Name
     (Self : access Element) return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/name");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Tag_Name;

   --------------
   -- Get_Text --
   --------------

   overriding function Get_Text
     (Self : access Element) return League.Strings.Universal_String
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/text");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_String;
   end Get_Text;

   ----------------
   -- Is_Enabled --
   ----------------

   overriding function Is_Enabled (Self : access Element) return Boolean is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/enabled");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_Boolean;
   end Is_Enabled;

   -----------------
   -- Is_Selected --
   -----------------

   overriding function Is_Selected (Self : access Element) return Boolean is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
   begin
      Command.Method := Get;
      Command.Path := To_Path (Self, "/selected");
      Response := Self.Executor.Execute (Command);

      return Response.Value (+"value").To_Boolean;
   end Is_Selected;

   ---------------
   -- Send_Keys --
   ---------------

   overriding procedure Send_Keys
     (Self : access Element;
      Text : League.String_Vectors.Universal_String_Vector)
   is
      Command   : WebDriver.Remote.Command;
      Response  : WebDriver.Remote.Response;
      List      : League.JSON.Arrays.JSON_Array;
      pragma Unreferenced (Response);
   begin
      Command.Method := Post;
      Command.Path := To_Path (Self, "/value");

      for J in 1 .. Text.Length loop
         List.Append (League.JSON.Values.To_JSON_Value (Text.Element (J)));
      end loop;

      Command.Parameters.Insert (+"value", List.To_JSON_Value);
      Response := Self.Executor.Execute (Command);
   end Send_Keys;

   -------------
   -- To_Path --
   -------------

   function To_Path
     (Self    : access Element;
      Command : Wide_Wide_String;
      Suffix  : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
      return League.Strings.Universal_String
   is
      Result : League.Strings.Universal_String;
   begin
      Result.Append ("/session/");
      Result.Append (Self.Session_Id);
      Result.Append ("/element/");
      Result.Append (Self.Element_Id);
      Result.Append (Command);

      if not Suffix.Is_Empty then
         Result.Append ("/");
         Result.Append (Suffix);
      end if;

      return Result;
   end To_Path;

end Elements;
