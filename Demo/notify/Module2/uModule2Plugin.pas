unit uModule2Plugin;

interface

uses SysUtils,Classes,uTangramModule,PluginBase,RegIntf;

Type
  TUserPlugin=Class(TPlugin)
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

uses SysSvc,notifyIntf,uFrmWebbrowser,uFrmOptions;

const
  InstallKey='SYSTEM\LOADMODULE\USER';
  ValueKey='Module=%s;load=True';

{ TUserPlugin }

constructor TUserPlugin.Create;
begin 
  inherited;
  //��ǰģ����غ�ִ�У���Ҫ������ȡ�ӿ�...
end;

destructor TUserPlugin.Destroy;
begin
  //��ǰģ��ж��ǰִ�У���Ҫ������ȡ�ӿ�...
  inherited;
end;

procedure TUserPlugin.Init;
begin
  //��ʼ��������ģ�������ɺ��ִ�е��������ȡ�ӿ��ǰ�ȫ��...
  inherited;
end;

procedure TUserPlugin.final;
begin
  //��ʼ����ж��ģ��ǰ��ִ�е��������ȡ�ӿ��ǰ�ȫ��...
  inherited;
end;

procedure TUserPlugin.Notify(Flags: Integer; Intf: IInterface);
begin
  if Flags=NotifyFlag then
  begin
    (Intf as IClsRegister).RegCls('�����',TFrmWebbrowser);
    (Intf as IClsRegister).RegCls('ѡ    ��',TFrmOptions);
  end;
end;

class procedure TUserPlugin.RegisterModule(Reg: IRegistry);
var ModuleFullName,ModuleName,Value:String;
begin
  //ע��ģ��
  if Reg.OpenKey(InstallKey,True) then 
  begin 
    ModuleFullName:=SysUtils.GetModuleName(HInstance);
    ModuleName:=ExtractFileName(ModuleFullName);
    Value:=Format(ValueKey,[ModuleFullName]); 
    Reg.WriteString(ModuleName,Value); 
    Reg.SaveData; 
  end;
end;

class procedure TUserPlugin.UnRegisterModule(Reg: IRegistry);
var ModuleName:String; 
begin 
  //ȡ��ע��ģ��
  if Reg.OpenKey(InstallKey) then
  begin 
    ModuleName:=ExtractFileName(SysUtils.GetModuleName(HInstance));
    if Reg.DeleteValue(ModuleName) then 
      Reg.SaveData;
  end;
end; 

initialization
  RegisterPluginClass(TUserPlugin);
finalization

end.
