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
  IEnumKey=Interface
    ['{BCF06768-CF57-41C8-AC40-C17135A80089}']
    procedure EnumKey(const IIDStr:String);
  End;
  ISysFactory=Interface
  ['{1E82A603-712A-4FBB-8323-95AAD6736F15}']
    procedure CreateInstance(const IID : TGUID; out Obj);
    procedure ReleaseInstance;
    function Supports(IID:TGUID):Boolean;
    procedure EnumKeys(Intf:IEnumKey);
  end;
implementation

end.
