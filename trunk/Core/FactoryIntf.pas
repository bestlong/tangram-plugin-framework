{------------------------------------
  ����˵���������ӿ�
  �������ڣ�2010/03/29
  ���ߣ�WZW
  ��Ȩ��WZW
-------------------------------------}
unit FactoryIntf;
//{$weakpackageunit on}

interface

Type
  ISysFactory=Interface
  ['{1E82A603-712A-4FBB-8323-95AAD6736F15}']
    procedure CreateInstance(const IID : TGUID; out Obj);
    procedure ReleaseInstance;
    function Supports(IID:TGUID):Boolean;
  end;
implementation

end.
