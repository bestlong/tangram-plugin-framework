{------------------------------------
  ����˵����ͳһ����Ϣ��ʾ��ӿ�
  �������ڣ�2008/11/19
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit DialogIntf;
{$weakpackageunit on}
interface

uses SysUtils;

Type
  IDialog=Interface
    ['{54C2C486-0AE0-403B-86E6-62914F7DCCCD}']
    procedure ShowMessage(const APrompt:String);
    procedure ShowMessageFmt(const APrompt:string;const Args: array of const);
    procedure ShowInfo(const APrompt:string);
    procedure ShowError(const APrompt:string);overload;
    procedure ShowError(E:Exception);overload;
    procedure ShowErrorFmt(const APrompt:string;const Args: array of const);
    procedure Warning(const APrompt:String);
    function  Confirm(const ACaption,APrompt:string):Boolean;
    function  Ask(const ACaption,APrompt:string):Boolean;
    function  InputBox(const ACaption,APrompt:string;var Value:string):Boolean;
  End;
  
implementation

end.
