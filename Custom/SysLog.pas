{------------------------------------
  ����˵����ʵ��ILog�ӿ�
  �������ڣ�2008/11/21
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit SysLog;

interface

uses SysUtils,LogIntf,SvcInfoIntf;

Type
  TLogObj=Class(TInterfacedObject,ILog,ISvcInfo)
  private
    function ErrFileName:String;
  protected
    {ILog}
    procedure WriteLog(const Str:String);
    procedure WriteLogFmt(const Str:String;const Args: array of const);
    procedure WriteErr(const err:String);overload;
    procedure WriteErrFmt(const err:String;const Args: array of const);
    {ISvcInfo}
    function GetModuleName:String;
    function GetTitle:String;
    function GetVersion:String;
    function GetComments:String;
  public

  End;
  
implementation

uses _sys,SysSvc,SysFactory,SysInfoIntf;

{ TLogObj }

function TLogObj.ErrFileName: String;
begin
  Result:=(SysService as ISysInfo).ErrPath+'\'+FormatDateTime('YYYY-MM-DD',Now)+'.txt';
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
  Result:='20100421.001';
end;

procedure TLogObj.WriteErr(const err: String);
var FileName:String;
    FileHandle:TextFile;
begin
  FileName:=ErrFileName;
  assignfile(FileHandle,FileName);
  try
    if FileExists(FileName) then
      append(FileHandle)//Reset(FileHandle)
    else ReWrite(FileHandle);
    WriteLn(FileHandle,FormatDateTime('[HH:MM:SS]',now)+'  '+err);
  finally
    CloseFile(FileHandle);
  end;
end;

procedure TLogObj.WriteErrFmt(const err: String; const Args: array of const);
begin
  WriteErr(Format(err,Args));
end;

procedure TLogObj.WriteLog(const Str: String);
begin
  //�������Ҫд�����ݱ�����
  Raise Exception.Create('δʵ�֡�����');
end;

procedure TLogObj.WriteLogFmt(const Str: String; const Args: array of const);
begin
  //�������Ҫд�����ݱ�����
  Raise Exception.Create('δʵ�֡�����');
end;

procedure Create_LogObj(out anInstance: IInterface);
begin
  anInstance:=TLogObj.Create;
end;

initialization
  TIntfFactory.Create(ILog,@Create_LogObj);
finalization

end.
