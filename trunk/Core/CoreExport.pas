{------------------------------------
  ����˵����ϵͳ���İ�������Ԫ
  �������ڣ�2008/11/19
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit CoreExport;

interface

uses Classes,SysUtils,RegIntf;

procedure Load(Intf:IInterface);//���ذ������
procedure Init;//�������а������
procedure Final;//�����˳�ǰ����

procedure InstallPackage(Reg:IRegistry);//��װ��
procedure UnInstallPackage(Reg:IRegistry);//ж�ذ�

exports
  Load,
  Init,
  final,

  InstallPackage,
  UnInstallPackage;
  
implementation

uses SysSvc,SysFactoryMgr,SysPluginMgr;

var PluginMgr:TPluginMgr;

procedure Load(Intf:IInterface);
begin
  PluginMgr:=TPluginMgr.Create;
  PluginMgr.LoadPackage(Intf);
end;

procedure Init;
begin
  PluginMgr.Init;
end;

procedure Final;
begin
  PluginMgr.final;
  //�ͷŹ��������ʵ��
  FactoryManager.ReleaseInstances;

  PluginMgr.Free;
end;

procedure InstallPackage(Reg:IRegistry);//��װ��
begin

end;

procedure UnInstallPackage(Reg:IRegistry);//ж�ذ�
begin

end;

initialization

finalization

end.

