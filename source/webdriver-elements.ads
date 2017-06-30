--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with League.Strings;
with League.String_Vectors;

package WebDriver.Elements is

   type Element is limited interface;

   type Element_Access is access all Element'Class
     with Storage_Size => 0;

   not overriding function Is_Selected
     (Self : access Element) return Boolean is abstract;
   --  Determines if the referenced element is selected or not.

   not overriding function Is_Enabled
     (Self : access Element) return Boolean is abstract;
   --  Determines if the referenced element is enabled or not.

   not overriding function Get_Attribute
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String is abstract;
   --  Returns the attribute of a web element.

   not overriding function Get_Property
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String is abstract;
   --  Returns the result of getting a property of an element.

   not overriding function Get_CSS_Value
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String is abstract;
   --  Retrieves the computed value of the given CSS property of the given
   --  web element.

   not overriding function Get_Text
     (Self : access Element)
        return League.Strings.Universal_String is abstract;
   --  Returns an element’s text "as rendered".

   not overriding function Get_Tag_Name
     (Self : access Element)
        return League.Strings.Universal_String is abstract;
   --  Returns the qualified element name of the given web element.

   not overriding procedure Click (Self : access Element) is abstract;
   --  Scrolls into view the element if it is not already pointer-interactable,
   --  and clicks its in-view center point.

   not overriding procedure Clear (Self : access Element) is abstract;
   --  Scrolls into view an editable or resettable element and then attempts
   --  to clear its selected files or text content.

   not overriding procedure Send_Keys
     (Self : access Element;
      Text : League.String_Vectors.Universal_String_Vector) is abstract;
   --  Scrolls into view the form control element and then sends the provided
   --  keys to the element.

   procedure Send_Keys
     (Self : access Element'Class;
      Text : League.Strings.Universal_String);

end WebDriver.Elements;
