{------------------------------------
  ����˵����ģ�鵼����Ԫ
  �������ڣ�2011.01.04
  ���ߣ�wei
  ��Ȩ��wei
-------------------------------------}
unit uTangramModule;
{$weakpackageunit on}
interface

uses RegIntf,SysModule;

procedure InstallModule(Reg:IRegistry);
procedure UnInstallModule(Reg:IRegistry);

function GetModuleClass:TModuleClass;
/////////////////////
procedure RegisterModuleClass(ModuleClass:TModuleClass);

Exports
  InstallModule,
  UnInstallModule,
  GetModuleClass;


implementation

var FModuleClass:TModuleClass;

procedure RegisterModuleClass(ModuleClass:TModuleClass);
begin
  //����Ҳ��Ҫ�����ظ�ע�ᡣ����
  FModuleClass:=ModuleClass;
end;

///////////////////////////////////////////////////////

procedure InstallModule(Reg:IRegistry);
begin
  if FModuleClass<>nil then
    FModuleClass.RegisterModule(Reg);
end;

procedure UnInstallModule(Reg:IRegistry);
begin
  if FModuleClass<>nil then
    FModuleClass.UnRegisterModule(Reg);
end;

function GetModuleClass:TModuleClass;
begin
  Result:=FModuleClass;
end;

//initialization
//  FModuleClass:=nil;
//finalization

end.
