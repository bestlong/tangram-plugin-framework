unit newKey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tfrm_newKey = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edt_KeyName: TEdit;
    cb_ParentKey: TComboBox;
    btn_Cancel: TBitBtn;
    btn_Ok: TBitBtn;
    procedure btn_OkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_newKey: Tfrm_newKey;

implementation

{$R *.dfm}

procedure Tfrm_newKey.btn_OkClick(Sender: TObject);
begin
  if cb_ParentKey.ItemIndex=-1 then
  begin
    showmessage('��ѡ�񸸽ڵ㣡');
    exit;
  end;
  if trim(edt_KeyName.Text)='' then
  begin
    showmessage('������ڵ����ƣ�');
    exit;
  end;
  if Pos(':',edt_KeyName.Text)>0 then
  begin
    showmessage('�ڵ����Ʋ��ܰ���'':''!');
    exit;
  end;
  self.ModalResult:=mrOK;
end;

end.
