{------------------------------------
  功能说明：系统服务
  创建日期：2008/11/09
  作者：wzw
  版权：wzw
-------------------------------------}
unit SysSvc;

interface

uses SysUtils,Windows,Classes,FactoryIntf,SysSvcIntf,NotifyServiceIntf,
     ModuleLoaderIntf,ObjRefIntf;

Type
  TSysService=Class(TObject,IInterface,ISysService)
  private
    FRefCount: Integer;
  protected
    {IInterface}
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {ISysService}
    function Notify:INotifyService;
    function ModuleLoader:IModuleLoader;
    function GetObjRef(const IID:TGUID;out ObjRef:IObjRef):Boolean;
  public
   // Constructor Create;
   // Destructor Destroy;override;
  end;

  function SysService(const IntfName:string='';param:Integer=0):ISysService;

implementation

uses SysFactoryMgr;

var
  FSysService:ISysService;
  FIntfName:string;
  FParam:Integer;

function SysService(const IntfName:string='';param:Integer=0):ISysService;
begin
  FIntfName:=IntfName;
  FParam   :=param;
  if FSysService=nil then
    FSysService:=TSysService.Create;
    
  Result:=FSysService;
end;

{ TSysService }

function TSysService._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TSysService._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

function TSysService.QueryInterface(const IID: TGUID; out Obj): HResult;
var aFactory:TFactory;
begin
  Result:=E_NOINTERFACE;
  if self.GetInterface(IID,Obj) then
    Result:=S_OK
  else begin
    if FIntfName='' then
      FIntfName:=GUIDToString(IID);
    aFactory:=FactoryManager.FindFactory(FIntfName);
    if Assigned(aFactory) then
    begin
      aFactory.prepare(FParam);
      Result:=aFactory.GetIntf(IID,Obj);
    end;
  end;
end;

function TSysService.Notify: INotifyService;
begin
  Result:=Self as INotifyService;
end;

function TSysService.ModuleLoader: IModuleLoader;
begin
  Result:=Self as IModuleLoader;
end;

function TSysService.GetObjRef(const IID: TGUID;out ObjRef:IObjRef): Boolean;
var aFactory:TFactory;
begin
  Result:=False;
  if FIntfName='' then
    FIntfName:=GUIDToString(IID);
  aFactory:=FactoryManager.FindFactory(FIntfName);
  if Assigned(aFactory) then
  begin
    aFactory.prepare(FParam);
    ObjRef:=aFactory.GetObjRef;
    Result:=True;
  end;
end;

initialization
  FSysService:=nil;
finalization
  FSysService:=nil;
end.
