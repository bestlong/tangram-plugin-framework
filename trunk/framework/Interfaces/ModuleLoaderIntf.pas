{------------------------------------
  ����˵����ģ����ؽӿڣ��û�����ͨ������ӿ����Ѽ���
            ģ�飬��ʹ�ÿ��Ĭ�ϵĴ�ע������ģ��
  �������ڣ�2011/02/24
  ���ߣ�wei
  ��Ȩ��wei
-------------------------------------}
unit ModuleLoaderIntf;
{$weakpackageunit on}
interface

Type
  IModuleLoader=Interface
    ['{04EBD77D-1313-4469-B522-1ABC2A40DD49}']
    procedure LoadBegin;
    procedure LoadModuleFromFile(const ModuleFile: string);
    procedure LoadModulesFromDir(const Dir:String='');
    procedure LoadFinish;
    procedure UnLoadModule(const ModuleFile:string);
    function ModuleLoaded(const ModuleFile:string):Boolean;
  End;

implementation

end.
