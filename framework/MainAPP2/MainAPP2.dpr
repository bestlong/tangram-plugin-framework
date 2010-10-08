program MainAPP2;

uses
  FastMM4,//ע�⣺��Delphi7���������FastMM4�㴰���ϵ�"�ر�"��Ť�ر�ҳǩ���ܻ��һ��abstract error����
          //Ŀǰ��ʱû�ҵ�ԭ����˽��鵽��������FastMM4
  Forms,
  sysUtils,
  Windows,
  MainFormIntf,
  uMain in 'uMain.pas' { frm_Main } ,
  ExceptionHandle in 'ExceptionHandle.pas' { frm_Exception } ,
  PackageExport in '..\Public\PackageExport.pas';
{$R *.res}

var
  CorePackageFile: String[255]; // ������������ɳ��ַ�����(string)FastMM���⵽���ڴ�й©
  ProLoad: TLoad;
  ProInit: TInit;
  ProFinal: TFinal;
  FCorePackageHandle: HMODULE;

begin
  Application.Initialize;
  {$IFDEF VER210}
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.Title := '���������';
  Application.HintHidePause := 1000 * 30;
  Application.CreateForm(Tfrm_Main, frm_Main);
  // ���غ��İ�
  CorePackageFile := ShortString(ExtractFilePath(Paramstr(0)) + 'Core.bpl');
  if FileExists(String(CorePackageFile)) then
  begin
    FCorePackageHandle := LoadPackage(String(CorePackageFile));
    @ProLoad := GetProcAddress(FCorePackageHandle, 'Load');
    @ProInit := GetProcAddress(FCorePackageHandle, 'Init');

    if assigned(ProLoad) then
    begin
      Try
        ProLoad(frm_Main);
      Except
        on E: Exception do
          Application.ShowException(E);
      End;
    end;

    if assigned(ProInit) then
    begin
      try
        ProInit;
      Except
        on E: Exception do
          Application.ShowException(E);
      end;
    end;

    Application.Run;
    // �ȹص����д򿪵��Ӵ��壬��Ȼ���ͷŰ��ᱨ��ַ��
    frm_Main.ReleaseForms;
    // �������
    @ProFinal := GetProcAddress(FCorePackageHandle, 'Final');
    if assigned(ProFinal) then
    begin
      try
        ProFinal;
      Except
        on E: Exception do
          Application.ShowException(E);
      end;
    end;
    // �ͷŰ�
    UnLoadPackage(FCorePackageHandle);
  end
  else
    Application.MessageBox(pchar('�Ҳ�����ܺ��İ�[' + String(CorePackageFile)
          + ']�������޷�������'), '��������', MB_OK + MB_ICONERROR);

end.
