program Project1;

uses
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  ListEmp in 'ListEmp.pas' {UniForm1: TUniForm},
  FrmLogin in 'FrmLogin.pas' {UniLoginForm2: TUniLoginForm},
  FrmCrtEmp in 'FrmCrtEmp.pas' {UniForm2: TUniForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
end.
