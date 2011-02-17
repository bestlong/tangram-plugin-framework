{------------------------------------
  ����˵����ʵ��IMessageBox�ӿ�
  �������ڣ�2008/11/20
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit SysDialogs;

interface

uses SysUtils,Forms,Windows,Dialogs,DialogIntf,SvcInfoIntf;

Type
  TDialogs=Class(TInterfacedObject,IDialog,ISvcInfo)
  private
  protected
    {IMessageBox}
    procedure ShowMessage(const APrompt:String);
    procedure ShowMessageFmt(const APrompt:string;const Args: array of const);
    procedure ShowInfo(const APrompt:string);
    procedure ShowError(const APrompt:string);overload;
    procedure ShowError(E:Exception);overload;
    procedure ShowErrorFmt(const APrompt:string;const Args: array of const);
    procedure Warning(const APrompt:String);
    function  Confirm(const ACaption,APrompt:string):Boolean;
    function  Ask(const ACaption,APrompt:string):Boolean;
    function  InputBox(const ACaption,APrompt:string;var Value:string):Boolean;
    {ISvcInfo}
    function GetModuleName:String;
    function GetTitle:String;
    function GetVersion:String;
    function GetComments:String;
  public
    Destructor Destroy;override;
  End;

implementation

uses SysFactory;

{ TMessageBox }

function TDialogs.InputBox(const ACaption, APrompt: string;
  var Value: string): Boolean;
begin
  Result:=InputQuery(aCaption,APrompt,Value);
end;

function TDialogs.Ask(const ACaption, APrompt: string): Boolean;
begin
  Result:=application.MessageBox(pchar(APrompt),pchar(ACaption),MB_YESNO+MB_ICONQUESTION)=IDYES;
end;

function TDialogs.Confirm(const ACaption, APrompt: string): Boolean;
begin
  Result:=application.MessageBox(pchar(APrompt),pchar(ACaption),MB_OKCANCEL+MB_ICONQUESTION)=IDOK;
end;

procedure TDialogs.ShowError(E: Exception);
begin
  self.ShowError(E.Message);
end;

procedure TDialogs.ShowError(const APrompt: string);
begin
  application.MessageBox(pchar(APrompt),'����',MB_ICONERROR);
end;

procedure TDialogs.ShowErrorFmt(const APrompt: string;
  const Args: array of const);
begin
  self.ShowError(format(APrompt,Args));
end;

procedure TDialogs.ShowInfo(const APrompt: string);
begin
  application.MessageBox(pchar(APrompt),pchar(application.Title),MB_ICONINFORMATION);
end;

procedure TDialogs.ShowMessage(const APrompt: String);
begin
  application.MessageBox(pchar(APrompt),pchar(application.Title));
end;

procedure TDialogs.ShowMessageFmt(const APrompt: string;
  const Args: array of const);
begin
  self.ShowMessage(format(APrompt,Args));
end;

procedure TDialogs.Warning(const APrompt: String);
begin
  application.MessageBox(pchar(APrompt),pchar(application.Title),MB_ICONWARNING);
end;

destructor TDialogs.Destroy;
begin
  inherited;
end;

procedure Create_DialogObj(out anInstance: IInterface);
begin
  anInstance:=TDialogs.Create;
end;

function TDialogs.GetComments: String;
begin
  Result:='ϵͳ�Ի���ʵ��ͳһ�ĶԻ�����ʽ';
end;

function TDialogs.GetModuleName: String;
begin
  Result:=ExtractFileName(SysUtils.GetModuleName(HInstance));
end;

function TDialogs.GetTitle: String;
begin
  Result:='ϵͳ�Ի���ӿ�(IDialog)';
end;

function TDialogs.GetVersion: String;
begin
  Result:='20100421.001';
end;

initialization
  TIntfFactory.Create(IDialog,@Create_DialogObj);
finalization

end.
