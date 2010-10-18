unit Test2Export;

interface

uses sysutils, MainFormIntf, _sys, RegIntf, RegPluginIntf;

procedure InstallPackage(Reg: IRegistry); // ��װ��
procedure UnInstallPackage(Reg: IRegistry); // ж�ذ�
procedure RegisterPlugIn(Reg: IRegPlugin); // ע����

exports
  InstallPackage,
  UnInstallPackage,
  RegisterPlugIn;

implementation

uses Test2Plugin, MenuRegIntf;

const
  InstallKey = 'SYSTEM\LOADPACKAGE\USER';
  ValueKey = 'Package=%s;load=True';

procedure InstallPackage(Reg: IRegistry);
var
  ModuleFullName, ModuleName, Value: String;
begin
  // MessageBox(GetActiveWindow,'�Ѿ���װ���ˣ�','aa',MB_OK+MB_ICONWARNING);
  // ע��˵�
  TTest2Plugin.RegMenu(Reg as IMenuReg);

  if Reg.OpenKey(InstallKey, True) then
  begin
    ModuleFullName := sysutils.GetModuleName(HInstance);
    ModuleName := ExtractFileName(ModuleFullName);
    Value := Format(ValueKey, [ModuleFullName]);
    Reg.WriteString(ModuleName, Value);
    Reg.SaveData;
  end;
end;

procedure UnInstallPackage(Reg: IRegistry);
var
  ModuleName: String;
begin
  // ȡ��ע��˵�
  TTest2Plugin.UnRegMenu(Reg as IMenuReg);

  if Reg.OpenKey(InstallKey) then
  begin
    ModuleName := ExtractFileName(sysutils.GetModuleName(HInstance));
    if Reg.DeleteValue(ModuleName) then
      Reg.SaveData;
  end;
end;

procedure RegisterPlugIn(Reg:IRegPlugin);//ע����
begin
  Reg.RegisterPluginClass(TTest2Plugin);
end;


initialization

finalization

end.
