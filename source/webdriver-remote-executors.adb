--  Copyright (c) 2017 Maxim Reznik <reznikmm@gmail.com>
--
--  SPDX-License-Identifier: MIT
--  License-Filename: LICENSE
-------------------------------------------------------------

with AWS.Response;
with League.JSON.Documents;

separate (WebDriver.Remote)
package body Executors is

   -------------
   -- Execute --
   -------------

   not overriding function Execute
     (Self    : access HTTP_Command_Executor;
      Command : Remote.Command) return Response
   is
      Reply : AWS.Response.Data;
      JSON  : League.JSON.Documents.JSON_Document;
   begin
      case Command.Method is
         when Get =>
            AWS.Client.Get
              (Self.Server,
               URI    => Command.Path.To_UTF_8_String,
               Result => Reply);
         when Post =>
            declare
               Text : constant League.Strings.Universal_String :=
                 Command.Parameters.To_JSON_Document.To_JSON;
            begin
               AWS.Client.Post
                 (Self.Server,
                  URI    => Command.Path.To_UTF_8_String,
                  Data   => Text.To_UTF_8_String,
                    Content_Type => "application/json; charset=utf-8",
                  Result => Reply);
            end;
      end case;

      JSON := League.JSON.Documents.From_JSON
        (AWS.Response.Message_Body (Reply));

      return
        (Session_Id => League.Strings.Empty_Universal_String,  --  FIXME
         State      => League.Strings.Empty_Universal_String,  --  FIXME
         Status     => 0,  --  FIXME
         Value      => JSON.To_JSON_Object);
   end Execute;

end Executors;
