unit uIntf;
{$weakpackageunit on}

interface

uses Forms,Graphics;

Type
  //������ʵ�ֵĽӿ�
  IIntf1=Interface
    ['{11BD3D1F-D178-4F84-A939-5C9D25CAD73F}']
    procedure SetMainFormCaption(const str:String);
    procedure SetMainFormColor(aColor:TColor);
  End;
  //DLLģ����ʵ�ֵĽӿ�
  IIntf2=Interface
    ['{91B01582-4C31-4874-ABB3-90E811929CA0}']
    procedure ShowDLlForm;
  End;
  //BPLģ����ʵ�ֵĽӿ�
  IIntf3=Interface
    ['{BE99F519-6CB0-427A-A849-E7E12D377442}']
    procedure ShowBPLform;
  End;
implementation

end.
