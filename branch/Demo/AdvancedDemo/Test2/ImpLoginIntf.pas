{------------------------------------
  ����˵����ʵ��IlogIn�ӿ�
  �������ڣ�2008/12/31
  ���ߣ�WZW
  ��Ȩ��WZW
-------------------------------------}
unit ImpLoginIntf;


interface

uses SysUtils,Controls,LoginIntf,SvcInfoIntf;

Type
  TLogin=Class(TInterfacedObject,ILogin,ISvcInfo)
  private
  protected
    {ILogin}
    function Login:Boolean;
    procedure ChangeUser;
    procedure LockSystem;
    {ISvcInfo}
    function GetModuleName:String;
    function GetTitle:String;
    function GetVersion:String;
    function GetComments:String;
  public
  End;

implementation

uses SysSvc,LoginForm,SysFactory,MainFormIntf;

{ TLogin }

function TLogin.GetComments: String;
begin
  Result:='��¼��ӿڡ�����ϵͳʱ����¼�ã�Ҳ��������ϵͳ���л��û���';
end;

function TLogin.GetModuleName: String;
begin
  Result:=ExtractFileName(SysUtils.GetModuleName(HInstance));
end;

function TLogin.GetTitle: String;
begin
  Result:='��¼��ӿ�(ILogin)';
end;

function TLogin.GetVersion: String;
begin
  Result:='20100421.001';
end;

procedure TLogin.ChangeUser;
begin
 // sys.Dialogs.ShowError('ILogin.ChangeUser����δʵ�֣�');
end;

procedure TLogin.LockSystem;
begin
  //sys.Dialogs.ShowError('ILogin.LockSystem����δʵ�֣�');
end;

function TLogin.Login:Boolean;
begin
  frm_Login:=Tfrm_Login.Create(nil);
  try
    Result:=frm_Login.ShowModal=mrOk;
  finally
    frm_Login.Free;
  end;
end;

function Create_LoginObj(param:Integer):TObject;
begin
  Result:=TLogin.Create;
end;

initialization
  TIntfFactory.Create(ILogin,@Create_LoginObj);
finalization

end.

