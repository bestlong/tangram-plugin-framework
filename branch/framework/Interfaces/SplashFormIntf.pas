{ ------------------------------------
  ����˵����Fash����ӿ�
  �������ڣ�2008/11/29
  ���ߣ�wzw
  ��Ȩ��wzw
  ------------------------------------- }
unit SplashFormIntf;
{$WEAKPACKAGEUNIT on}

interface

Type
  ISplashForm = Interface
    ['{AE9B77A3-1D67-400B-A03B-428F3A79444D}']
    procedure Show;
    procedure loading(const msg: String);
    function GetWaitTime:Cardinal;
    procedure Hide;
  End;

implementation

end.
