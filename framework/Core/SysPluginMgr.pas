{ ------------------------------------
  ����˵����ƽ̨�������
  �������ڣ�2010/05/11
  ���ߣ�wzw
  ��Ȩ��wzw
  ------------------------------------- }
unit SysPluginMgr;

interface

uses SysUtils, Classes, Windows, Contnrs,RegIntf, SplashFormIntf,
  ModuleInfoIntf,SvcInfoIntf,PluginBase,RegPluginIntf;

Type
  TRegisterPlugInPro=procedure (Reg:IRegPlugin);

  TPluginLoader = Class(TInterfacedObject,IRegPlugin)
  private
    FIntf:IInterface;
    FPackageHandle: HMODULE;
    FPackageFile: String;
    FPlugin: TPlugin;
    function GetContainPlugin: Boolean;
  protected
    {IRegPlugin}
    procedure RegisterPluginClass(PluginClass:TPluginClass);
  public
    Constructor Create(const PackageFile:String;Intf:IInterface);
    Destructor Destroy;override;

    property ContainPlugin:Boolean Read GetContainPlugin;
    property Plugin:TPlugin Read FPlugin;
    property PackageFile:String Read FPackageFile;
  End;

  TPluginMgr = Class(TObject, IInterface, IModuleInfo, ISvcInfo)
  private
    SplashForm: ISplashForm;
    Tick: Integer;
    FpluginList:TObjectList;
    procedure WriteErrFmt(const err: String; const Args: array of const );
    function FormatPath(const s: string): string;
    procedure GetPackageList(RegIntf: IRegistry; PackageList: TStrings;
      const Key: String);
    procedure LoadPackageFromFile(const PackageFile: string; Intf: IInterface);
  protected
    FRefCount: Integer;
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IModuleInfo }
    procedure GetModuleInfo(ModuleInfoGetter:IModuleInfoGetter);
    procedure PluginRegister(Flags: Integer; Intf: IInterface);
    { ISvcInfo }
    function GetModuleName: String;
    function GetTitle: String;
    function GetVersion: String;
    function GetComments: String;
  public
    Constructor Create;
    Destructor Destroy; override;

    procedure LoadPackage(Intf: IInterface);
    procedure Init;
    procedure final;
  end;

implementation

uses uConst, SysSvc, LogIntf, LoginIntf, StdVcl, AxCtrls, SysFactoryMgr,
  SysFactory;

{ TPluginLoader }

constructor TPluginLoader.Create(const PackageFile: String;Intf:IInterface);
var RegisterPlugIn:TRegisterPlugInPro;
begin
  FPlugin:=nil;
  FIntf:=Intf;
  FPackageFile:=PackageFile;
  FPackageHandle:=SysUtils.LoadPackage(PackageFile);
  @RegisterPlugIn:=GetProcAddress(FPackageHandle,'RegisterPlugIn');

  RegisterPlugIn(self);
end;

destructor TPluginLoader.Destroy;
begin
  if Assigned(FPlugin) then
    FPlugin.Free;

  SysUtils.UnloadPackage(FPackageHandle);
  inherited;
end;

function TPluginLoader.GetContainPlugin: Boolean;
begin
  Result:=self.FPlugin<>nil;
end;

procedure TPluginLoader.RegisterPluginClass(PluginClass: TPluginClass);
begin
  if PluginClass<>nil then
    FPlugin:=PluginClass.Create(FIntf);
end;

{ TPluginMgr }

function TPluginMgr.GetComments: String;
begin
  Result := '���ڻ�ȡ��ǰϵͳ���ذ�����Ϣ����ʼ������';
end;

function TPluginMgr.GetModuleName: String;
begin
  Result := ExtractFileName(SysUtils.GetModuleName(HInstance));
end;

function TPluginMgr.GetTitle: String;
begin
  Result := 'ϵͳ���ӿ�(ISysPackage)';
end;

function TPluginMgr.GetVersion: String;
begin
  Result := '20100512.001';
end;

constructor TPluginMgr.Create;
begin
  FpluginList := TObjectList.Create(True);
  TObjFactory.Create(IModuleInfo, self);
end;

destructor TPluginMgr.Destroy;
begin
  FpluginList.Free;
  inherited;
end;

function TPluginMgr.FormatPath(const s: string): string;
const
  Var_AppPath = '($APP_PATH)';
begin
  Result := StringReplace(s, Var_AppPath, ExtractFilePath(Paramstr(0)),
    [rfReplaceAll, rfIgnoreCase]);
end;

procedure TPluginMgr.GetPackageList(RegIntf: IRegistry; PackageList: TStrings;
  const Key: String);
var
  SubKeyList, ValueList, aList: TStrings;
  i: Integer;
  valueStr: string;
  valueName, vStr, PackageFile, Load: WideString;
begin
  SubKeyList := TStringList.Create;
  ValueList := TStringList.Create;
  aList := TStringList.Create;
  try
    RegIntf.OpenKey(Key, False);
    // ����ֵ
    RegIntf.GetValueNames(ValueList);
    for i := 0 to ValueList.Count - 1 do
    begin
      aList.Clear;
      valueName := ValueList[i];
      if RegIntf.ReadString(valueName, vStr) then
      begin
        valueStr := AnsiUpperCase(vStr);
        ExtractStrings([';'], [], pchar(valueStr), aList);
        PackageFile := FormatPath(aList.Values[Value_Package]);
        Load := aList.Values[Value_Load];
        if (PackageFile <> '') and (CompareText(Load, 'TRUE') = 0) then
          PackageList.Add(PackageFile);
      end;
    end;
    // ���²���
    RegIntf.GetKeyNames(SubKeyList);
    for i := 0 to SubKeyList.Count - 1 do
      GetPackageList(RegIntf, PackageList, Key + '\' + SubKeyList[i]); // �ݹ�
  finally
    SubKeyList.Free;
    ValueList.Free;
    aList.Free;
  end;
end;

procedure TPluginMgr.PluginRegister(Flags: Integer; Intf: IInterface);
var
  i: Integer;
  PluginLoader:TPluginLoader;
begin
  for i := 0 to FpluginList.Count - 1 do
  begin
    PluginLoader := TPluginLoader(FpluginList[i]);
    if not PluginLoader.ContainPlugin then Continue;

    try
      PluginLoader.Plugin.Register(Flags, Intf);
    except
      on E: Exception do
        WriteErrFmt('������Register��������([%s])��%s',
          [ExtractFileName(PluginLoader.PackageFile), E.Message]);
    end;
  end;
end;

procedure TPluginMgr.GetModuleInfo(ModuleInfoGetter: IModuleInfoGetter);
var
  i: Integer;
  PluginLoader:TPluginLoader;
  MInfo:TModuleInfo;
begin
  if ModuleInfoGetter=nil then exit;
  for i := 0 to FpluginList.Count - 1 do
  begin
    PluginLoader := TPluginLoader(FpluginList[i]);
    MInfo.PackageName:=PluginLoader.PackageFile;
    MInfo.Description:=GetPackageDescription(Pchar(MInfo.PackageName));
    ModuleInfoGetter.ModuleInfo(MInfo);
  end;
end;

procedure TPluginMgr.Init;
var
  i, CurTick, WaitTime: Integer;
  LoginIntf: ILogin;
  PluginLoader:TPluginLoader;
begin
  PluginLoader:=nil;
  for i := 0 to FpluginList.Count - 1 do
  begin
    Try
      PluginLoader:=TPluginLoader(FpluginList.Items[i]);
      if not PluginLoader.ContainPlugin then Continue;

      if Assigned(SplashForm) then
        SplashForm.loading(Format('���ڳ�ʼ����[%s]',
            [ExtractFileName(PluginLoader.PackageFile)]));

      PluginLoader.Plugin.Init;
    Except
      on E: Exception do
      begin
        WriteErrFmt('������Init��������([%s])������%s',
          [ExtractFileName(PluginLoader.PackageFile), E.Message]);
      end;
    End;
  end;
  // ����Splash����
  if Assigned(SplashForm) then
  begin
    CurTick := GetTickCount;
    WaitTime := CurTick - Tick;
    if WaitTime < SplashFormWaitTime then
    begin
      SplashForm.loading('��׼������ϵͳ�����Ե�...');
      sleep(SplashFormWaitTime - WaitTime);
    end;

    SplashForm.Hide;
    FactoryManager.UnRegistryFactory(ISplashForm);
    SplashForm := nil;
  end;
  // ����¼
  if SysService.QueryInterface(ILogin, LoginIntf) = S_OK then
    LoginIntf.CheckLogin;
end;

procedure TPluginMgr.LoadPackage(Intf: IInterface);
var
  aList: TStrings;
  i: Integer;
  RegIntf: IRegistry;
  PackageFile: String;
begin
  // ����������
  aList := TStringList.Create;
  try
    SplashForm := nil;
    RegIntf := SysService as IRegistry;
    GetPackageList(RegIntf, aList, key_LoadPackage);
    for i := 0 to aList.Count - 1 do
    begin
      PackageFile := aList[i];
      // ���ذ�
      if FileExists(PackageFile) then
        LoadPackageFromFile(PackageFile, Intf)
      else WriteErrFmt('�Ҳ�����[%s]���޷����أ�', [PackageFile]);

      if Assigned(SplashForm) then
        SplashForm.loading(Format('���ڼ��ذ�[%s]...',
            [ExtractFileName(PackageFile)]));
      // ��ʾFalsh����
      if SplashForm = nil then
      begin
        if SysService.QueryInterface(ISplashForm, SplashForm) = S_OK then
        begin
          Tick := GetTickCount;
          SplashForm.Show;
        end;
      end;
    end;
  finally
    aList.Free;
  end;
end;

procedure TPluginMgr.LoadPackageFromFile(const PackageFile: string;
  Intf: IInterface);
begin
  try
    FpluginList.Add(TPluginLoader.Create(PackageFile,Intf));
  Except
    on E: Exception do
    begin
      WriteErrFmt('���ذ�[%s]��������%s', [ExtractFileName(PackageFile), E.Message]);
    end;
  end;
end;

function TPluginMgr.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TPluginMgr.final;
var
  i: Integer;
  PluginLoader:TPluginLoader;
begin
  for i := 0 to FpluginList.Count - 1 do
  begin
    PluginLoader:=TPluginLoader(FpluginList.Items[i]);
    if PluginLoader.ContainPlugin then
      PluginLoader.Plugin.final;
  end;
end;

procedure TPluginMgr.WriteErrFmt(const err: String;
  const Args: array of const );
var
  Log: ILog;
begin
  if SysService.QueryInterface(ILog, Log) = S_OK then
    Log.WriteErrFmt(err, Args);
end;

function TPluginMgr._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TPluginMgr._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
end;

end.
