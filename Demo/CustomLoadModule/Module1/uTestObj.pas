unit uTestObj;

interface

uses sysUtils,Classes,Dialogs,SysFactory,uTestIntf;

Type
  TTestObj=Class(TInterfacedObject,ITest)
  private
  protected
  {ITest}
    procedure test;
  Public
  End;

implementation

procedure Create_TestObj(out anInstance: IInterface);
begin
  anInstance:=TTestObj.Create;
end;


{ TTestObj }

procedure TTestObj.test;
begin
  showmessage('��ã�');
end;

var Factory:TObject;
initialization
  Factory:=TIntfFactory.Create(ITest,@Create_TestObj);
finalization
  Factory.Free;//��̬ж��ģ��ǵ��ͷŹ�����
end.