{------------------------------------
  ����˵����ģ����Ϣ�ӿ�
  �������ڣ�2010/05/12
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit ModuleInfoIntf;
{$weakpackageunit on}
interface

Type
  TModuleInfo=Record
    PackageName:string;
    Description:string;
  end;
  IModuleInfoGetter=Interface
  ['{BA827AC8-B432-49F5-9F4B-6D0383CDF47F}']
    procedure ModuleInfo(ModuleInfo:TModuleInfo);
  End;

  IModuleInfo=Interface
  ['{6911685D-171C-4262-9506-702080533F4C}']
    procedure GetModuleInfo(ModuleInfoGetter:IModuleInfoGetter);
    procedure ModuleNotify(Flags:Integer;Intf:IInterface);
  End;
implementation

end.
