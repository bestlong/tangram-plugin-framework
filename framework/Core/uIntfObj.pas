{------------------------------------
  ����˵����ʵ��IInterface�ӿڣ�����ͬ��TInterfacedObject��
            ���ü���Ϊ0�����Զ��ͷ�
  �������ڣ�2011/04/02
  ���ߣ�WZW
  ��Ȩ��WZW
-------------------------------------}
unit uIntfObj;

interface

Type
  TIntfObj=Class(TObject,IInterface)
  private

  protected
    {IInterface}
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
  End;
implementation

{ TIntfObj }

function TIntfObj.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TIntfObj._AddRef: Integer;
begin
  Result:=-1;
end;

function TIntfObj._Release: Integer;
begin
  Result:=-1;
end;

end.
