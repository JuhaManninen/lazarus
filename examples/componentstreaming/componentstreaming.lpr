program ComponentStreaming;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, MainUnit;

begin
  Application.Initialize;
  Application.CreateForm(TCompStreamDemoForm, CompStreamDemoForm);
  Application.Run;
end.

