program PackageRequires;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�����ò鿴����';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
