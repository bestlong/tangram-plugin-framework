{------------------------------------
  ����˵����ʵ��ILog�ӿ�
  �������ڣ�2008/11/21
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit uLog;

interface

uses SysUtils,DateUtils,LogIntf,SvcInfoIntf;

Type
  TLogObj=Class(TInterfacedObject,ILog,ISvcInfo)
  private

    FConsoleHandle : THandle;
    procedure WriteToFile(const Msg:string);
    procedure WriteToConsole(const Msg:string);
  protected
    {ILog}
    procedure WriteLog(const Str:String; const ToConsole : Boolean = False);

    procedure WriteLogFmt(const Str:String;const Args: array of const);
    function GetLogFileName:String;
    {ISvcInfo}
    function GetModuleName:String;
    function GetTitle:String;
    function GetVersion:String;
    function GetComments:String;
  public
    Constructor Create;
    Destructor Destroy;override;
  End;
  
implementation

uses SysSvc,SysFactory, Windows;

{ TLogObj }

function TLogObj.GetLogFileName: String;
var Logpath:String;
begin
  Logpath:=ExtractFilePath(ParamStr(0))+'Logs\';
  if not DirectoryExists(Logpath) then
    ForceDirectories(Logpath);

  Result:=Logpath+FormatDateTime('YYYY-MM-DD',Now)+'.log';
end;

constructor TLogObj.Create;
begin

end;

destructor TLogObj.Destroy;
begin

  inherited;
end;

function TLogObj.GetComments: String;
begin
  Result:='��װ��־��ز���';
end;

function TLogObj.GetModuleName: String;
begin
  Result:=ExtractFileName(SysUtils.GetModuleName(HInstance));
end;

function TLogObj.GetTitle: String;
begin
  Result:='��־�ӿ�(ILog)';
end;

function TLogObj.GetVersion: String;
begin
  Result:='20110417.002';
end;

procedure TLogObj.WriteLog(const Str: String; const ToConsole : Boolean = False);
begin
  if ToConsole then
    WriteToConsole(str)
  else
    WriteToFile(Str);
end;

procedure TLogObj.WriteLogFmt(const Str: String; const Args: array of const);
begin
  WriteToFile(Format(Str,Args));
end;

procedure TLogObj.WriteToConsole(const Msg: string);
var
  FMsg : PChar;
  FNum : Cardinal;
begin
  if FConsoleHandle <> 7 then
  begin
    AllocConsole();
    SetConsoleTitle('Tangram Debug Window');
    FConsoleHandle := GetStdHandle(STD_OUTPUT_HANDLE);
  end;
  FMsg := PChar(FormatDateTime('[YYYY-mm-dd HH:MM:SS.zzz]',now)+'  '+Msg + sLineBreak);
  WriteConsole(FConsoleHandle, FMsg, strlen(FMsg), FNum, nil);
  
end;

procedure TLogObj.WriteToFile(const Msg: string);
var FileName:String;
    FileHandle:TextFile;
begin
  FileName:=GetLogFileName;
  assignfile(FileHandle,FileName);
  try
    if FileExists(FileName) then
      append(FileHandle)//Reset(FileHandle)
    else ReWrite(FileHandle);

    WriteLn(FileHandle,FormatDateTime('[YYYY-mm-dd HH:MM:SS.zzz]',now)+'  '+Msg);
  finally
    CloseFile(FileHandle);
  end;
end;

function Create_LogObj(param:Integer):TObject;
begin
  Result:=TLogObj.Create;
end;

initialization
  TSingletonFactory.Create(ILog,@Create_LogObj);
finalization

end.
