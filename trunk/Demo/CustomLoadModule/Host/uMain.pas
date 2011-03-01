unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uTestIntf,ModuleLoaderIntf;

type
  TFrmMain = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses SysSvc;

{$R *.dfm}

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  (SysService as Itest).test;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var ModuleLoader:IModuleLoader;
begin
  //�����ڹ����ļ�����Application.LoadModuleFromRegistry:=False;
  // ������ܾͲ����Զ�����ģ����

  ModuleLoader:=SysService as IModuleLoader; //��ȡIModuleLoader�ӿ�

  ModuleLoader.LoadModulesFromDir();//��ָ��Ŀ¼����ģ�飬���Ŀ¼Ϊ�գ���ӵ�ǰ����Ŀ¼����ģ��
  ModuleLoader.LoadFinish;//������ɺ󣬼ǵõ�LoadFinish������TPlugin.Init�Żᱻִ��
end;

end.
