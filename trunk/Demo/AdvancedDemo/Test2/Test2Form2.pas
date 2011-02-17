unit Test2Form2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,uBaseForm,AuthoritySvrIntf;

type
  TForm3 = class(TBaseForm)
    Button7: TButton;
    Button6: TButton;
    Button4: TButton;
    Button2: TButton;
    Button1: TButton;
    Button5: TButton;
    GroupBox1: TGroupBox;
    Button9: TButton;
    Button8: TButton;
    Button10: TButton;           
    Button11: TButton;
    Button12: TButton;
    Button3: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
  protected
    Class procedure RegAuthority(aIntf:IAuthorityRegistrar);override;
    procedure HandleAuthority(const Key:String;aEnable:Boolean);override;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
uses _sys,TestIntf,MainFormIntf,RegIntf,DialogIntf,ProgressFormIntf,LogIntf,
    EncdDecdIntf,SysSvc,SysInfoIntf;//,RemoteMethodIntf

const //Ȩ�޵�KEY
   Key1='{8453785E-7EB9-4DEE-B876-D0C3CD5EBC20}';
   Key2='{FA4E730C-5151-40AC-A883-8A1ADC554BF8}';
   Key3='{7CB68E4A-DA34-42E6-995A-A62F77D1376D}';
   Key4='{0D6F5C10-382E-4FA8-86D6-A8056B52CE3B}';
   Key5='{CFED4D84-DF9D-463A-A9FB-8F6A1860E343}';
   Key6='{D042AA96-EB1E-4F1A-A9C1-3271F9973883}';
   Key7='{E8178A33-D737-488A-9C29-5BFEC285E065}';
   Key8='{8C2578D4-C011-4085-8BAE-E2AB79B4F3B0}';
   Key9='{3F4C61E0-5462-4083-9983-84924C4C5E19}';
   Key10='{4A79957C-802E-42D0-B9A3-23899B8DECCD}';
   
{$R *.dfm}
procedure TForm3.Button1Click(Sender: TObject);
begin
  (SysService as ITest).Test;
end;

procedure TForm3.Button2Click(Sender: TObject);
var i:Integer;
    ProgressForm:IProgressForm;
begin
  ProgressForm:=SysService as IProgressForm;
  ProgressForm.ShowMsg('test');
  try
    for i := 0 to 2000 do
    begin
      ProgressForm.ShowMsg('���ڴ����['+inttostr(i)+']�����ݣ����Ե�...');
      ProgressForm.progress(2000,i);
    end;
  finally
    ProgressForm.Hide;
  end;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  if Sys.Dialogs.Ask('ѯ��','����ask') then
    Sys.Dialogs.ShowMessage('yes')
  else Sys.Dialogs.ShowMessage('no');
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  Sys.Log.WriteErr('����XXXX');
  Sys.Dialogs.ShowMessage('������־��д������Ŀ¼�µ�errorĿ¼�У�');
end;

procedure TForm3.Button6Click(Sender: TObject);
const Key='abc';
var str:string;
begin
  if sys.Dialogs.InputBox('���ܲ���','�������ַ�����',str) then
  begin
    str:=sys.EncdDecd.Encrypt(key,str);
    sys.Dialogs.ShowMessageFmt('���ܺ�%s',[str]);
    str:=sys.EncdDecd.Decrypt(key,str);
    sys.Dialogs.ShowMessageFmt('���ܺ�%s',[str]);
  end;
end;

procedure TForm3.Button7Click(Sender: TObject);
var str:string;
begin
  if Sys.Dialogs.InputBox('MD5����','�������ַ�����',str) then
  begin
    str:=sys.EncdDecd.MD5(str);
    Sys.Dialogs.ShowMessage(str);
  end;
end;

procedure TForm3.Button8Click(Sender: TObject);
const key='User\TestReadWrite';
      ValueName='test';
var reg:IRegistry;
    Value:Widestring;
begin
  reg:=SysService as IRegistry;
  if reg.OpenKey(key,True) then
  begin
    if reg.ReadString(Valuename,Value) then
      sys.Dialogs.ShowMessageFmt('�ղ���д���ֵ�ǣ�%s',[Value]);
  end;
end;

procedure TForm3.Button9Click(Sender: TObject);
const key='User\TestReadWrite';
      ValueName='test';
var reg:IRegistry;
    inPutStr:string;
begin
  if Sys.Dialogs.InputBox('ע����д����','������ֵ��',inPutStr) then
  begin
    reg:=SysService as IRegistry;
    if reg.OpenKey(key,True) then
    begin
      reg.WriteString(Valuename,inPutStr);
      reg.SaveData;
      sys.Dialogs.ShowMessage('����ɹ���');
    end;
  end;
end;


procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  //FEvenHandle:=sys.EventFactory.RegisterEvent(self,[Ev_Timer],1);
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  //sys.EventFactory.UnRegisterEvent(FEvenHandle);
end;


procedure TForm3.Button10Click(Sender: TObject);
var MainForm:IMainForm;
begin
  mainForm:=SysService as IMainForm;
  mainForm.ShowStatus(1,'��ʾʱ��');
  mainForm.ShowStatus(2,DateTimeToStr(now));
end;

procedure TForm3.Button11Click(Sender: TObject);
var s:String;
begin
  //ȡ������
  s:=GetPackageDescription(pchar(GetModuleName(HInstance)));
  sys.Dialogs.ShowMessage(s);
end;

procedure TForm3.Button12Click(Sender: TObject);
var s:String;
begin
  s:=(SysService as ISysInfo).RegistryFile;
  sys.Dialogs.ShowMessage(s);
end;

procedure TForm3.HandleAuthority(const Key: String; aEnable: Boolean);
begin
  if Key=Key1 then
    Button1.Enabled:=aEnable
  else if key=Key2 then
    Button2.Enabled:=aEnable
  else if Key=Key3 then
    Button4.Enabled:=aEnable
  else if Key=Key4 then
    Button6.Enabled:=aEnable
  else if Key=Key5 then
    Button7.Enabled:=aEnable
  else if Key=Key6 then
    Button5.Enabled:=aEnable
  else if Key=Key7 then
    Button9.Enabled:=aEnable
  else if key=key8 then
    Button8.Enabled:=aEnable
  else if Key=Key9 then
    Button10.Enabled:=aEnable
  else if key=key10 then
    Button12.Enabled:=aEnable;
end;

class procedure TForm3.RegAuthority(aIntf: IAuthorityRegistrar);
const Path='����Ȩ��\�ӿ�ʹ��';
begin
  aIntf.RegAuthorityItem(Key1,Path,'ʹ��test.bpl��ʵ�ֵĽӿ�ITest',True);
  aIntf.RegAuthorityItem(Key2,Path,'IProgressForm�ӿڲ���',True);
  aIntf.RegAuthorityItem(Key3,Path,'IDialog�ӿڲ���',True);
  aIntf.RegAuthorityItem(Key4,Path,'IEncdDecd�ӿ���ͨ���ܲ���',True);
  aIntf.RegAuthorityItem(Key5,Path,'IEncdDecd�ӿ�MD5���ܲ���',True);
  aIntf.RegAuthorityItem(Key6,Path,'д������־(ILog�ӿ�)',True);
  aIntf.RegAuthorityItem(Key7,Path,'ע���д',True);
  aIntf.RegAuthorityItem(Key8,Path,'ע����',True);
  aIntf.RegAuthorityItem(Key9,Path,'����������״̬��',True);
  aIntf.RegAuthorityItem(Key10,Path,'ע����ļ�',True);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  self.Caption:=Sys.SysInfo.LoginUserInfo^.UserName;
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
  (SysService as IFormMgr).CloseForm(self);
end;

procedure TForm3.Button14Click(Sender: TObject);
//var Method:IRemoteMethod;
//    c:Integer;
begin
{  c:=GetTickCount;
  Method:=SysService as IRemoteMethod;

  Method.MethodName:='TBusiness1.Return';
  Method.Param['s']:='�����й���abc';
  if Method.Execute then
  begin
    Button14.Caption:=inttostr(GetTickCount-c);
    showmessage(Method.Param['Result']);
    //Button14.Caption:=Method.Param['a'];

  end else Sys.Dialogs.ShowError(Method.Error);}
end;

procedure TForm3.Button15Click(Sender: TObject);
var test:Itest;
    i,c:Integer;
begin
  c:=GetTickCount;
  for i := 1 to 100000 do
  begin
    test:=SysService as Itest;
    test:=nil;
  end;
  //��20���ӿ�(IRemoteMethod�ǵ�19��)��ȡ10000�λ�200-219����
  Button15.Caption:='�ܻ�(����)'+inttostr(GetTickCount-c);
end;

end.
