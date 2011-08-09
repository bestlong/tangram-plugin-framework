unit uEncdDecdPlugin;

interface

uses SysUtils,uTangramModule,SysModule,RegIntf;

Type
  TEncdDecdPlugin=Class(TModule)
  private
  public
    Constructor Create; override;
    Destructor Destroy; override;

    procedure Init; override;
    procedure final; override;
    procedure Notify(Flags: Integer; Intf: IInterface;Param:Cardinal); override;

    class procedure RegisterModule(Reg:IRegistry);override;
    class procedure UnRegisterModule(Reg:IRegistry);override;
  End;
implementation

const
  InstallKey='SYSTEM\LOADMODULE\UTILS';//����Ҫ�ĳ���Ӧ��KEY
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

procedure TEncdDecdPlugin.Notify(Flags: Integer; Intf: IInterface;Param:Cardinal);
begin
  inherited;

end;

class procedure TEncdDecdPlugin.RegisterModule(Reg: IRegistry);
begin
  //ע���
  DefaultRegisterModule(Reg,InstallKey);
end;

class procedure TEncdDecdPlugin.UnRegisterModule(Reg: IRegistry);
begin
  //ȡ��ע���
  DefaultUnRegisterModule(Reg,InstallKey);
end;

initialization
  RegisterModuleClass(TEncdDecdPlugin);
finalization
end.
