{------------------------------------
  ����˵����Custom��������Ԫ
  �������ڣ�2008.11.23
  ���ߣ�WZW
  ��Ȩ��WZW
-------------------------------------}
unit CustomExport;

interface

uses SysUtils,MainFormIntf,RegIntf,RegPluginIntf;

//Type

procedure InstallPackage(Reg:IRegistry);//��װ��
procedure UnInstallPackage(Reg:IRegistry);//ж�ذ�
procedure RegisterPlugIn(Reg:IRegPlugin);//ע����

exports
  InstallPackage,
  UnInstallPackage,
  RegisterPlugIn;

implementation

uses MenuRegIntf;

const InstallKey='SYSTEM\LOADPACKAGE';
      ValueKey='Package=%s;load=True';//($APP_PATH)\

procedure InstallPackage(Reg:IRegistry);
var ModuleFullName,ModuleName,Value:String;
begin
  if Reg.OpenKey(InstallKey,True) then
  begin
    ModuleFullName:=SysUtils.GetModuleName(HInstance);
    ModuleName:=ExtractFileName(ModuleFullName);
    Value:=Format(ValueKey,[ModuleFullName]);
    Reg.WriteString(ModuleName,Value);
    Reg.SaveData;
  end;
end;

procedure UnInstallPackage(Reg:IRegistry);
var ModuleName:String;
begin
  if Reg.OpenKey(InstallKey) then
  begin
    ModuleName:=ExtractFileName(SysUtils.GetModuleName(HInstance));
    if Reg.DeleteValue(ModuleName) then
      Reg.SaveData;
  end;
end;

procedure RegisterPlugIn(Reg:IRegPlugin);//ע����
begin

end;

initialization

finalization

end.

