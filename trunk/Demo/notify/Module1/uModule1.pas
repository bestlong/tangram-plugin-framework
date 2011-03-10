unit uModule1;

interface

uses SysUtils,Classes,uTangramModule,SysModule,RegIntf;

Type
  TUserModule=Class(TModule)
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

uses SysSvc,notifyIntf,uFrmSendEmail;

const
  InstallKey='SYSTEM\LOADMODULE\USER';
  ValueKey='Module=%s;load=True';

{ TUserModule }

constructor TUserModule.Create;
begin 
  inherited;
  //��ǰģ����غ�ִ�У���Ҫ������ȡ�ӿ�...
end;

destructor TUserModule.Destroy;
begin
  //��ǰģ��ж��ǰִ�У���Ҫ������ȡ�ӿ�...
  inherited;
end;

procedure TUserModule.Init;
begin
  //��ʼ��������ģ�������ɺ��ִ�е��������ȡ�ӿ��ǰ�ȫ��...
  inherited;
end;

procedure TUserModule.final;
begin
  //��ʼ����ж��ģ��ǰ��ִ�е��������ȡ�ӿ��ǰ�ȫ��...
  inherited;
end;

procedure TUserModule.Notify(Flags: Integer; Intf: IInterface);
begin
  if Flags=NotifyFlag then
  begin
    (Intf as IClsRegister).RegCls('���ʼ�',TfrmSendEmail);
  end;
end;

class procedure TUserModule.RegisterModule(Reg: IRegistry);
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

class procedure TUserModule.UnRegisterModule(Reg: IRegistry);
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
  RegisterModuleClass(TUserModule);
finalization

end.
