Program Host;

uses
  uTangramFramework,
  uMain in 'uMain.pas' {FrmMain},
  uTestIntf in '..\Interfaces\uTestIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.LoadModuleFromRegistry:=False;//ȡ���Զ�����ģ��(��Ҫ�û����Ѽ���)
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
