{------------------------------------
  ����˵����
  �������ڣ�
  ���ߣ�
  ��Ȩ��
-------------------------------------}
unit BaseExport;

interface

uses RegIntf,RegPluginIntf;


procedure InstallPackage(Reg:IRegistry);//��װ��
procedure UnInstallPackage(Reg:IRegistry);//ж�ذ�
procedure RegisterPlugIn(Reg:IRegPlugin);//ע����

exports
  InstallPackage,
  UnInstallPackage,
  RegisterPlugIn;

implementation

uses _sys,DialogIntf;

procedure InstallPackage(Reg:IRegistry);//��װ��
begin

end;

procedure UnInstallPackage(Reg:IRegistry);//ж�ذ�
begin

end;

procedure RegisterPlugIn(Reg:IRegPlugin);//ע����
begin

end;

initialization

finalization

end.

