unit uFrmSendEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmSendEmail = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSendEmail: TfrmSendEmail;

implementation

{$R *.dfm}

procedure TfrmSendEmail.Button1Click(Sender: TObject);
begin
  showmessage('��ֻ�Ǹ�������ʾ��û�з��͹��ܣ�');
end;

end.
