{------------------------------------
  ����˵����ϵͳ��־�ӿ�
  �������ڣ�2008/11/20
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit LogIntf;
{$weakpackageunit on}
interface

uses SysUtils;

Type
  ILog=Interface
    ['{472FD4AD-F589-4D4D-9051-A20D37B7E236}']
    procedure WriteLog(const Str:String);
    procedure WriteLogFmt(const Str:String;const Args: array of const);
    function GetLogFileName:String;
  End;
  
implementation

end.
