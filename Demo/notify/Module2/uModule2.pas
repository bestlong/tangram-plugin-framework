unit uModule2;

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

uses SysSvc,notifyIntf,uFrmWebbrowser,uFrmOptions;

const
  InstallKey='SYSTEM\LOADMODULE\USER';

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
    (Intf as IClsRegister).RegCls('�����',TFrmWebbrowser);
    (Intf as IClsRegister).RegCls('ѡ    ��',TFrmOptions);
  end;
end;

class procedure TUserModule.RegisterModule(Reg: IRegistry);
begin
  DefaultRegisterModule(Reg,InstallKey);
end;

class procedure TUserModule.UnRegisterModule(Reg: IRegistry);
begin 
  DefaultUnRegisterModule(Reg,InstallKey);
end; 

initialization
  RegisterModuleClass(TUserModule);
finalization

end.
