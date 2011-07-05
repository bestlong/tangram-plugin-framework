unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uTestIntf,ModuleLoaderIntf;

type
  TFrmMain = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
var intf:ITest;
begin
  if SysService.QueryInterface(Itest,intf)=S_OK then
    intf.test
  else showmessage('ȡ����Itest�ӿڣ�ģ��δ���أ�');
end;

procedure TFrmMain.Button2Click(Sender: TObject);
var ModuleLoader:IModuleLoader;
    ModuleFile:String;
begin
  ModuleLoader:=SysService as IModuleLoader;
  ModuleFile:=ExtractFilePath(ParamStr(0))+'Module1.dll';
  ModuleLoader.UnLoadModule(ModuleFile);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var ModuleLoader:IModuleLoader;
begin
  //�����ڹ����ļ�����Application.LoadModuleFromRegistry:=False;
  // ������ܾͲ����Զ�����ģ����

  ModuleLoader:=SysService as IModuleLoader; //��ȡIModuleLoader�ӿ�
  ModuleLoader.LoadBegin;//����ǰ�ǵ��ȵ�LoadBegin
  ModuleLoader.LoadModulesFromDir();//��ָ��Ŀ¼����ģ�飬���Ŀ¼Ϊ�գ���ӵ�ǰ����Ŀ¼����ģ��
  ModuleLoader.LoadFinish;//������ɺ󣬼ǵõ�LoadFinish������TPlugin.Init�Żᱻִ��
end;

end.
