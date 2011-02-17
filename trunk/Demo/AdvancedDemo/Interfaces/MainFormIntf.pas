{------------------------------------
  ����˵����������ӿڵ�Ԫ
  �������ڣ�2008/11/09
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit MainFormIntf;
{$weakpackageunit on}
interface

uses Forms,Classes,Graphics;

Type
  //����(ѡ��)�����
  IShortCutClick=Interface
    ['{AEC846D1-8E5D-4EAE-993C-12616927C754}']
    //ע���ݲ˵����
    procedure RegPanel(FrameClass:TCustomFrameClass);
  End;
  //ѡ���ݲ˵�
  TShortCutClick=procedure(pIntf:IShortCutClick) of object;

  //������ʵ�ֵĽӿ�
  IMainForm=Interface
    ['{C3DF922D-4AA5-4874-B0A3-72699DA671C8}']
    //������ͨ�˵�
    function CreateMenu(const Path:string;MenuClick:TNotifyEvent):TObject;
    //ȡ��ע��˵�
    procedure DeleteMenu(Const Path:string);
    //����������
    function CreateToolButton(const aCaption:String;onClick:TNotifyEvent;Hint:String=''):TObject;
    //ע���ݲ˵�
    procedure RegShortCut(const aCaption:string;onClick:TShortCutClick);
    //��ʾ״̬
    procedure ShowStatus(PnlIndex:Integer;const Msg:string);
    //�˳�����
    procedure ExitApplication;
    //��ImageList���ͼ��
    function AddImage(Img:TGraphic):Integer;
  End;

  //ϵͳ����ӿ�
  IFormMgr=Interface
    ['{074BA876-C5DA-4689-BA11-48EB3CF22CF6}']
    function FindForm(const FormClassName:string):TForm;
    //FormClass:Ҫ�����Ĵ�����  SingleInstance:�Ƿ�ֻ����һ��ʵ��
    function CreateForm(FormClass:TFormClass;SingleInstance:Boolean=True):TForm;
    procedure CloseForm(aForm:TForm);
  End;

implementation

end.
