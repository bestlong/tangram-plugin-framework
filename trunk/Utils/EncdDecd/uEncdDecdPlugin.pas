unit uEncdDecdPlugin;

interface

uses SysUtils,uTangramModule,PluginBase,RegIntf;

Type
  TEncdDecdPlugin=Class(TPlugin)
  private
  public
    Constructor Create; override;
    Destructor Destroy; override;

    procedure Init; override;
    procedure final; override;
    procedure Notify(Flags: Integer; Intf: IInterface); override;

    class procedure RegisterModule(Reg:IRegistry);override;
    class procedure UnRegisterModule(Reg:IRegistry);override;
  End;
implementation
const
  InstallKey='SYSTEM\LOADPACKAGE\UTILS';//����Ҫ�ĳ���Ӧ��KEY
  ValueKey='Package=%s;load=True';
{ TEncdDecdPlugin }

constructor TEncdDecdPlugin.Create;
begin
  inherited;

end;

destructor TEncdDecdPlugin.Destroy;
begin

  inherited;
end;

procedure TEncdDecdPlugin.final;
begin
  inherited;

end;

procedure TEncdDecdPlugin.Init;
begin
  inherited;

end;

procedure TEncdDecdPlugin.Notify(Flags: Integer; Intf: IInterface);
begin
  inherited;

end;

class procedure TEncdDecdPlugin.RegisterModule(Reg: IRegistry);
var ModuleFullName,ModuleName,Value:String;
begin
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

class procedure TEncdDecdPlugin.UnRegisterModule(Reg: IRegistry);
var ModuleName:String;
begin
  //ȡ��ע���
  if Reg.OpenKey(InstallKey) then
  begin
    ModuleName:=ExtractFileName(SysUtils.GetModuleName(HInstance));
    if Reg.DeleteValue(ModuleName) then
      Reg.SaveData;
  end;
end;

end.
