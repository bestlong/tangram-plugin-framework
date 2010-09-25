{------------------------------------
  ����˵����ʵ��ϵͳ��Ϣ
  �������ڣ�2008/11/12
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit ImpSysInfoIntf;

interface

uses sysUtils,SysInfoIntf,uConst,SysFactory,SvcInfoIntf;

Type
  TSysInfoObj=Class(TInterfacedObject,ISysInfo,ISvcInfo)
  private
    FLoginUserInfo:TLoginUserInfo;
  protected
    {ISysInfo}
    function RegistryFile:string;//ע����ļ�
    function AppPath:string;//����Ŀ¼
    function ErrPath:string;//������־Ŀ¼
    {ISvcInfo}
    function GetModuleName:String;
    function GetTitle:String;
    function GetVersion:String;
    function GetComments:String;

    function LoginUserInfo:PLoginUserInfo;
  public
  End;

implementation

uses IniFiles;

{ TSysInfoIntfObj }

function TSysInfoObj.AppPath: string;
begin
  Result:=ExtractFilePath(Paramstr(0));
end;

function TSysInfoObj.ErrPath: string;
begin
  Result:=AppPath+'error';
  if not DirectoryExists(Result) then
    ForceDirectories(Result);
end;

function TSysInfoObj.GetComments: String;
begin
  Result:='ͨ��������ȡ��ϵͳһЩ��Ϣ�����������־����Ŀ¼��ע����ļ����Լ���ǰ��¼�û��ȡ�';
end;

function TSysInfoObj.GetModuleName: String;
begin
  Result:=ExtractFileName(SysUtils.GetModuleName(HInstance));
end;

function TSysInfoObj.GetTitle: String;
begin
  Result:='ϵͳ��Ϣ�ӿ�(ISysInfo)';
end;

function TSysInfoObj.GetVersion: String;
begin
  Result:='20100421.001';
end;

function TSysInfoObj.LoginUserInfo: PLoginUserInfo;
begin
  Result:=@FLoginUserInfo;
end;

function TSysInfoObj.RegistryFile: string;
var IniFile:string;
    ini:TIniFile;
begin
  IniFile:=self.AppPath+'Root.ini';
  ini:=TiniFile.Create(IniFile);
  try
    Result:=self.AppPath+ini.ReadString('Default','Reg','');
  finally
    ini.Free;
  end;
end;

procedure CreateSysInfoObj(out anInstance: IInterface);
begin
  anInstance:=TSysInfoObj.Create;
end;

initialization
  TSingletonFactory.Create(ISysInfo,@CreateSysInfoObj);
finalization
end.
