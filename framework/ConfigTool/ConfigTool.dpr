program ConfigTool;

uses
  uTangramFrameWork,
  uMain in 'uMain.pas' {frm_Main},
  ABOUT in 'ABOUT.pas' {AboutBox},
  editValue in 'editValue.pas' {frm_EditValue},
  newKey in 'newKey.pas' {frm_newKey},
  ModuleMgr in 'ModuleMgr.pas' {frm_ModuleMgr},
  MenuEditor in 'MenuEditor.pas' {Frm_MenuEditor},
  MenuRegIntf in '..\Interfaces\MenuRegIntf.pas',
  ToolEditor in 'ToolEditor.pas' {frm_ToolEditor};

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF VER210}
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.LoadModuleFromRegistry:=False;
  Application.HintHidePause:=1000*30;
  Application.Title := '框架配置工具';
  Application.CreateForm(Tfrm_Main, frm_Main);
  Application.Run;
end.
