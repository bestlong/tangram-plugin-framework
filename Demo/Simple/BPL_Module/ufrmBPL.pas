unit ufrmBPL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmBPL = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBPL: TfrmBPL;

implementation

uses SysSvc,uIntf;
{$R *.dfm}

procedure TfrmBPL.Button1Click(Sender: TObject);
var Intf:IIntf2;
begin
  Intf:=SysService as IIntf2; //��ȡIIntf2�ӿڣ�IIntf2��DLLģ��ʵ��
  Intf.ShowDLlForm;
end;

procedure TfrmBPL.Button2Click(Sender: TObject);
var Intf:IIntf1;
    s:String;
begin
  Intf:=SysService as IIntf1;//��ȡIIntf1�ӿ�,IIntf1��������ʵ�ֵ�
  s:=InputBox('�豸�����ڱ���','�������������','abcde');
  Intf.SetMainFormCaption(s);
end;

end.
