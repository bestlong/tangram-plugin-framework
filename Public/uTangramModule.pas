{------------------------------------
  ����˵����ģ�鵼����Ԫ
  �������ڣ�2011.01.04
  ���ߣ�wei
  ��Ȩ��wei
-------------------------------------}
unit uTangramModule;
{$weakpackageunit on}
interface

uses RegIntf,PluginBase;

procedure InstallModule(Reg:IRegistry);
procedure UnInstallModule(Reg:IRegistry);

function GetPluginClass:TPluginClass;
/////////////////////
procedure RegisterPluginClass(PluginClass:TPluginClass);

Exports
  InstallModule,
  UnInstallModule,
  GetPluginClass;


implementation
uses Dialogs;
var FPluginClass:TPluginClass;

procedure RegisterPluginClass(PluginClass:TPluginClass);
begin
  //����Ҳ��Ҫ�����ظ�ע�ᡣ����
  FPluginClass:=PluginClass;
end;

///////////////////////////////////////////////////////

procedure InstallModule(Reg:IRegistry);
begin
  showmessage('a');
  if FPluginClass<>nil then
    FPluginClass.RegisterModule(Reg);
end;

procedure UnInstallModule(Reg:IRegistry);
begin
  if FPluginClass<>nil then
    FPluginClass.UnRegisterModule(Reg);
end;

function GetPluginClass:TPluginClass;
begin
  Result:=FPluginClass;
end;

initialization
  FPluginClass:=nil;
finalization

end.
