{------------------------------------
  ����˵����Sys���������
  �������ڣ�2010.04.23
  ���ߣ�WZW
  ��Ȩ��WZW
-------------------------------------}
unit SysPlugin;

interface

uses SysUtils,Classes,Windows,MenuRegIntf,PluginBase,RegIntf,uTangramModule;

Type
  TSysPlugin=Class(TPlugin)
  private
    procedure ExitApp(Sender: TObject);
    procedure ConfigToolClick(Sender: TObject);
    procedure SvcInfoClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
  protected
  public
    Constructor Create;override;
    Destructor Destroy;override;

    procedure Init; override;
    procedure final; override;
    //procedure Register(Flags: Integer; Intf: IInterface); override;
    class procedure RegisterModule(Reg:IRegistry);override;
    class procedure UnRegisterModule(Reg:IRegistry);override;

    Class procedure RegMenu(Reg:IMenuReg);
    Class procedure UnRegMenu(Reg:IMenuReg);
  end;

implementation

uses SysSvc,SysFactory,SysFactoryEx,ViewSvcInfo,MainFormIntf,
     MenuEventBinderIntf,MenuDispatcher,SysAbout;

const
  InstallKey='SYSTEM\LOADMODULE';
  ValueKey='Module=%s;load=True';

   Key_ExitApp     ='ID_52E96456-AB56-4425-9907-49BC58BCD521';
   Key_ConfigTool  ='ID_45E78B02-1029-4916-8D83-6C4381DDB255';
   Key_SvcInfo     ='ID_B5641F93-5CCC-4E58-8EBD-D39D3612374F';
   Key_Line        ='ID_633B5F92-82F9-419B-A3B4-0A5074914DCA';
   Key_About       ='ID_35E209E7-3934-4457-81D6-18C3178A91B2';
   
{ TSysPlugin }

class procedure TSysPlugin.RegisterModule(Reg: IRegistry);
var ModuleFullName,ModuleName,Value:String;
begin
  //ע��˵�
  self.RegMenu(Reg as IMenuReg);
  //ע���
  if Reg.OpenKey(InstallKey,True) then
  begin
    ModuleFullName:=SysUtils.GetModuleName(HInstance);
    ModuleName:=ExtractFileName(ModuleFullName);
    Value:=Format(ValueKey,[ModuleFullName]);
    Reg.WriteString(ModuleName,Value);
    Reg.SaveData;
  end;
end;

class procedure TSysPlugin.RegMenu(Reg: IMenuReg);
begin
  Reg.RegMenu(Key_Line,        '�ļ�\-');
  Reg.RegMenu(Key_ExitApp,     '�ļ�\�˳�ϵͳ');
  Reg.RegMenu(Key_SvcInfo,     '����\ϵͳ�ӿ�');
  Reg.RegMenu(Key_ConfigTool,  '����\���ù���');
  Reg.RegMenu(Key_About,       '����\����');
end;

class procedure TSysPlugin.UnRegisterModule(Reg: IRegistry);
var ModuleName:String;
begin
  //ȡ��ע��˵�
  self.UnRegMenu(Reg as IMenuReg);
  //ȡ��ע���
  if Reg.OpenKey(InstallKey) then
  begin
    ModuleName:=ExtractFileName(SysUtils.GetModuleName(HInstance));
    if Reg.DeleteValue(ModuleName) then
      Reg.SaveData;
  end;
end;

class procedure TSysPlugin.UnRegMenu(Reg: IMenuReg);
begin
  Reg.UnRegMenu(Key_Line);
  Reg.UnRegMenu(Key_ExitApp);
  Reg.UnRegMenu(Key_SvcInfo);
  Reg.UnRegMenu(Key_ConfigTool);
  Reg.UnRegMenu(Key_About);
end;

constructor TSysPlugin.Create;
begin
  TObjFactory.Create(IMenuEventBinder,TMenuDispatcher.Create,True);
end;

destructor TSysPlugin.Destroy;
begin

  inherited;
end;

procedure TSysPlugin.ConfigToolClick(Sender: TObject);
var ConfigTool:string;
begin
  ConfigTool:=ExtractFilepath(ParamStr(0))+'ConfigTool.exe';
  if FileExists(ConfigTool) then
    WinExec(pAnsichar(AnsiString(ConfigTool)),SW_SHOWDEFAULT)
  else Raise Exception.CreateFmt('ĩ�ҵ�%s��',[ConfigTool]);
end;

procedure TSysPlugin.ExitApp(Sender: TObject);
begin
  (SysService as IMainForm).ExitApplication;
end;

procedure TSysPlugin.final;
begin
  inherited;

end;

procedure TSysPlugin.Init;
var MenuEventBinder:IMenuEventBinder;
begin
  inherited;
  //�󶨲˵��¼�
  MenuEventBinder:=SysService as IMenuEventBinder;
  MenuEventBinder.RegMenuEvent(Key_ExitApp,self.ExitApp);
  MenuEventBinder.RegMenuEvent(Key_SvcInfo,self.SvcInfoClick);
  MenuEventBinder.RegMenuEvent(Key_ConfigTool,self.ConfigToolClick);
  MenuEventBinder.RegMenuEvent(Key_About,self.AboutClick);
end;

procedure TSysPlugin.SvcInfoClick(Sender: TObject);
begin
  frm_SvcInfo:=Tfrm_SvcInfo.Create(nil);
  frm_SvcInfo.ShowModal;
  frm_SvcInfo.Free;
end;

procedure TSysPlugin.AboutClick(Sender: TObject);
begin
  TFrm_About.Execute;
end;

initialization
  RegisterPluginClass(TSysPlugin);
finalization

end.
