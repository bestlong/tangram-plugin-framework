{------------------------------------
  ����˵����ע�����ӿ�
  �������ڣ�2010/07/17
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit RegPluginIntf;
{$weakpackageunit on}
interface

Uses PluginBase;

Type
  IRegPlugin=Interface
    ['{B99EE19D-906E-4C58-B62A-C7D2DA0F28DA}']
    procedure RegisterPluginClass(PluginClass:TPluginClass);
  End;
implementation

end.
