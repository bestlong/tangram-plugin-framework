{------------------------------------
  ����˵�����������ĺ���
  �������ڣ�2008/11/19
  ���ߣ�wzw
  ��Ȩ��wzw
-------------------------------------}
unit PackageExport;
//{$weakpackageunit on}
interface

uses RegIntf;

Type
  TLoad=procedure (Intf:IInterface);//���ذ������
  TInit=procedure ;//��ʼ����(�������а�����ã�
  TFinal=procedure;//�����˳�ǰ����

  TInstallPackage=procedure (Reg:IRegistry);//��װ��
  TUnInstallPackage=procedure (Reg:IRegistry);//ж�ذ�

implementation

end.
