with Ada.Wide_Wide_Text_IO;

with League.Strings;
with League.JSON.Arrays;
with League.JSON.Objects;
with League.JSON.Values;

with WebDriver.Drivers;
with WebDriver.Elements;
with WebDriver.Remote;
with WebDriver.Sessions;

procedure Test is
   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   function Headless return League.JSON.Values.JSON_Value;

   --------------
   -- Headless --
   --------------

   function Headless return League.JSON.Values.JSON_Value is
      Cap      : League.JSON.Objects.JSON_Object;
      Options  : League.JSON.Objects.JSON_Object;
      Args     : League.JSON.Arrays.JSON_Array;
   begin
      Args.Append (League.JSON.Values.To_JSON_Value (+"--headless"));
      Args.Append (League.JSON.Values.To_JSON_Value (+"--disable-extensions"));
      Args.Append (League.JSON.Values.To_JSON_Value (+"--no-sandbox"));
      Options.Insert (+"args", Args.To_JSON_Value);
      Cap.Insert (+"chromeOptions", Options.To_JSON_Value);
      return Cap.To_JSON_Value;
   end Headless;

   Web_Driver : aliased WebDriver.Drivers.Driver'Class
     := WebDriver.Remote.Create (+"http://127.0.0.1:9515");
   Session    : constant WebDriver.Sessions.Session_Access :=
     Web_Driver.New_Session (Headless);
begin
   Session.Go (+"http://www.ada-ru.org/");

   Ada.Wide_Wide_Text_IO.Put_Line
     (Session.Get_Current_URL.To_Wide_Wide_String);

   declare
      Body_Element : constant WebDriver.Elements.Element_Access :=
        Session.Find_Element
          (Strategy => WebDriver.Tag_Name,
           Selector => +"body");
   begin
      Ada.Wide_Wide_Text_IO.Put_Line
        ("Selected=" & Boolean'Wide_Wide_Image (Body_Element.Is_Selected));
      Ada.Wide_Wide_Text_IO.Put_Line
        ("itemtype=" &
           Body_Element.Get_Attribute (+"itemtype").To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
        ("height=" &
           Body_Element.Get_CSS_Value (+"height").To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
        ("tag=" & Body_Element.Get_Tag_Name.To_Wide_Wide_String);
   end;
end Test;
