{------------------------------------
  ����˵����ģ�鰲װ�ӿ�
  �������ڣ�2011/04/19
  ���ߣ�wei
  ��Ȩ��wei
-------------------------------------}
unit ModuleInstallerIntf;
{$weakpackageunit on}
interface

Type
  IModuleInstaller=Interface
    ['{97E777E9-0541-47DD-BCD3-4DB2BCB3145D}']
    procedure InstallModule(const ModuleFile:String);
    procedure UninstallModule(const ModuleFile:string);
  End;
implementation

end.
