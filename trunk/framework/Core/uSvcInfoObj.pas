{------------------------------------
  ����˵�����ӿ�˵������
  �������ڣ�2010/06/07
  ���ߣ�WZW
  ��Ȩ��WZW
-------------------------------------}
unit uSvcInfoObj;

interface

uses sysUtils,Classes,SysFactory,SvcInfoIntf;

Type
  TSvcInfoObj=Class(TInterfacedObject,ISvcInfoEx,ISvcInfo)
  private
  protected
  {ISvcInfo}
    function GetModuleName:String;
    function GetTitle:String;
    function GetVersion:String;
    function GetComments:String;
  {ISvcInfoEx}
    procedure GetSvcInfo(Intf:ISvcInfoGetter);
  Public
  End;

implementation

uses SysFactoryMgr,FactoryIntf;

{procedure Create_SvcInfoObj(out anInstance: IInterface);
begin
  anInstance:=TSvcInfoObj.Create;
end;}

{ TSvcInfoObj }

function TSvcInfoObj.GetComments: String;
begin
  Result:='���ڻ�ȡ��ǰϵͳ���нӿ���Ϣ';
end;

function TSvcInfoObj.GetModuleName: String;
begin
  Result:=ExtractFileName(SysUtils.GetModuleName(HInstance));
end;

function TSvcInfoObj.GetTitle: String;
begin
  Result:='�ӿ�˵������(ISvcInfoEx)';
end;

function TSvcInfoObj.GetVersion: String;
begin
  Result:='20100607.001';
end;

procedure TSvcInfoObj.GetSvcInfo(Intf: ISvcInfoGetter);
var i:integer;
    FIntf:ISysFactory;
    SvcInfoEx:ISvcInfoEx;
begin
  if Intf=nil then exit;

  for i:=0 to FactoryManager.FactoryList.Count-1 do
  begin
    FIntf:=FactoryManager.FactoryList.Items[i];
    if FIntf.QueryInterface(ISvcInfoEx,SvcInfoEx)=S_OK then
      SvcInfoEx.GetSvcInfo(Intf);
  end;
end;

initialization
  //TIntfFactory.Create(ISvcInfoEx,@Create_SvcInfoObj);
finalization
end.