{------------------------------------
  ����˵����ϵͳ��Ϣ�ӿ�
  �������ڣ�2008/11/12
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit SysInfoIntf;
{$weakpackageunit on}
interface
Type
  PLoginUserInfo=^TLoginUserInfo;
  TLoginUserInfo=Record
    UserID:Integer;
    UserName:String;
    RoleID:Integer;
    IsAdmin:Boolean;
  end;
  
  ISysInfo=Interface
    ['{E06C3E07-6865-405C-9EC6-6384BB4CB5DD}']
    function RegistryFile:string;//ע����ļ�
    function AppPath:string;//����Ŀ¼
    function ErrPath:string;//������־Ŀ¼

    function LoginUserInfo:PLoginUserInfo;
  End;
implementation

end.
