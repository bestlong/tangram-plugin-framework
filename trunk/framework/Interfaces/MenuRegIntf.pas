{------------------------------------
  ����˵����ע��˵��ӿ�
  �������ڣ�2010/04/23
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit MenuRegIntf;
{$weakpackageunit on}
interface

Type
  IMenuReg=Interface
  ['{89934683-EC0C-4DE8-ABA8-057C9DF63599}']
    procedure RegMenu(const Key,Path:WideString);
    procedure UnRegMenu(const Key:WideString);

    procedure RegToolItem(const Key,aCaption,aHint:WideString);
    procedure UnRegToolItem(const Key:WideString);
  end;
implementation

end.
