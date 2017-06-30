--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

------------------------------------------------------------------------------
--  WebDriver is a remote control interface that enables introspection and
--  control of user agents.
--
--  See more details on https://www.w3.org/TR/webdriver/

package WebDriver is
   pragma Pure;

   type Location_Strategy is
     (CSS_Selector,
      Link_Text,
      Partial_Link_Text,
      Tag_Name,
      XPath);
   --  An element location strategy is an enumerated attribute deciding what
   --  technique should be used to search for elements in the current browsing
   --  context.

end WebDriver;
