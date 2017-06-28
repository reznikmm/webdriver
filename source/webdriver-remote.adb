--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with AWS.Client;

with League.JSON.Objects;

with WebDriver.Sessions;

package body WebDriver.Remote is

   type Method_Kinds is (Get, Post);

   type Command is record
      Method     : Method_Kinds;
      Path       : League.Strings.Universal_String;
      Session_Id : League.Strings.Universal_String;
      Parameters : League.JSON.Objects.JSON_Object;
   end record;

   type Response is record
      Session_Id : League.Strings.Universal_String;
      State      : League.Strings.Universal_String;
      Status     : Integer;
      Value      : League.JSON.Objects.JSON_Object;
   end record;

   package Executors is
      type HTTP_Command_Executor is tagged limited record
--         Server_URL : League.Strings.Universal_String;
         Server : AWS.Client.HTTP_Connection;
      end record;

      not overriding function Execute
        (Self    : access HTTP_Command_Executor;
         Command : Remote.Command) return Response;
   end Executors;

   package body Executors is separate;

   package Sessions is

      type Session is new WebDriver.Sessions.Session with record
         Session_Id : League.Strings.Universal_String;
         Executor   : access Executors.HTTP_Command_Executor;
      end record;

      overriding procedure Go
        (Self : access Session;
         URL  : League.Strings.Universal_String);

      overriding function Get_Current_URL
        (Self : access Session) return League.Strings.Universal_String;

   end Sessions;

   package body Sessions is separate;

   package Drivers is

      type Driver is limited new WebDriver.Drivers.Driver with record
         Executor   : aliased Executors.HTTP_Command_Executor;
      end record;

      overriding function New_Session
        (Self : access Driver) return WebDriver.Sessions.Session_Access;

   end Drivers;

   package body Drivers is separate;

   ------------
   -- Create --
   ------------

   function Create
     (URL : League.Strings.Universal_String)
      return WebDriver.Drivers.Driver'Class
   is
   begin
      return Result : Drivers.Driver do
         AWS.Client.Create
           (Result.Executor.Server,
            Host => URL.To_UTF_8_String);
      end return;
   end Create;

end WebDriver.Remote;
