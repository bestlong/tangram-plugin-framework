{ ------------------------------------
  ����˵����������ר��
  �������ڣ�2010.05.08
  ���ߣ�WZW
  ��Ȩ��WZW
  ------------------------------------- }
unit uNewPackageExpt;

interface

uses
  Classes, SysUtils, Windows, ToolsApi;

Type
  TNewPackageExpt = class(TInterfacedObject, IOTAWizard, IOTARepositoryWizard,
    IOTAProjectWizard, IOTACreator, IOTAProjectCreator, IOTAProjectCreator50) //
  private
  public
    constructor Create;
    destructor Destroy; override;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetPage: string;
    function GetGlyph: Cardinal;
    { IOTAWizard }
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    { IOTANotifier }
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;

    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    { IOTAProjectCreator }
    function GetFileName: string;
    { Return the option file name (C++ .bpr, .bpk, etc...) }
    function GetOptionFileName: string;
    { Return True to show the source }
    function GetShowSource: Boolean;
    { Called to create a new default module for this project }
    procedure NewDefaultModule;
    { Create and return the project option source. (C++) }
    function NewOptionSource(const ProjectName: string): IOTAFile;
    { Called to indicate when to create/modify the project resource file }
    procedure NewProjectResource(const Project: IOTAProject);
    { Create and return the Project source file }
    function NewProjectSource(const ProjectName: string): IOTAFile;
    { IOTAProjectCreator50 }
    { Called to create a new default module(s) for the given project.  This
      interface method is the preferred mechanism. }
    procedure NewDefaultProjectModule(const Project: IOTAProject);
  end;

  TPackageExportModule = Class(TInterfacedObject, IOTACreator,
    IOTAModuleCreator)
  private
  protected
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    function GetAncestorName: string;
    { IOTAModuleCreator }
    { Return the implementation filename, or blank to have the IDE create a new
      unique one. (C++ .cpp file or Delphi unit) NOTE: If a value is returned then it *must* be a
      fully qualified filename.  This also applies to GetIntfFileName and
      GetAdditionalFileName on the IOTAAdditionalFilesModuleCreator interface. }
    function GetImplFileName: string;
    { Return the interface filename, or blank to have the IDE create a new
      unique one.  (C++ header) }
    function GetIntfFileName: string;
    { Return the form name }
    function GetFormName: string;
    { Return True to Make this module the main form of the given Owner/Project }
    function GetMainForm: Boolean;
    { Return True to show the form }
    function GetShowForm: Boolean;
    { Return True to show the source }
    function GetShowSource: Boolean;
    { Create and return the Form resource for this new module if applicable }
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    { Create and return the Implementation source for this module. (C++ .cpp
      file or Delphi unit) }
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string)
      : IOTAFile;
    { Create and return the Interface (C++ header) source for this module }
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string)
      : IOTAFile;
    { Called when the new form/datamodule/custom module is created }
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  public

  end;

procedure RegNewPackageExpt;

implementation

uses uExptConst;

const
  PackageName = 'NewPackage.dpk';

procedure RegNewPackageExpt;
begin
  RegisterPackageWizard(TNewPackageExpt.Create as IOTAWizard);
end;

{ TNewPackageExpt }

procedure TNewPackageExpt.AfterSave;
begin

end;

procedure TNewPackageExpt.BeforeSave;
begin

end;

constructor TNewPackageExpt.Create;
begin

end;

destructor TNewPackageExpt.Destroy;
begin

  inherited;
end;

procedure TNewPackageExpt.Destroyed;
begin

end;

procedure TNewPackageExpt.Execute;
begin (BorlandIDEServices as IOTAModuleServices)
  .CreateModule(self);
end;

function TNewPackageExpt.GetAuthor: string;
begin
  Result := Author;
end;

function TNewPackageExpt.GetComment: string;
begin
  Result := 'ҵ�����';
end;

function TNewPackageExpt.GetCreatorType: string;
begin
  Result := sPackage;
end;

function TNewPackageExpt.GetExisting: Boolean;
begin
  Result := False;
end;

function TNewPackageExpt.GetFileName: string;
begin
  Result := GetCurrentDir + '\' + PackageName;
end;

function TNewPackageExpt.GetFileSystem: string;
begin
  Result := '';
end;

function TNewPackageExpt.GetGlyph: Cardinal;
begin
  Result := LoadIcon(HInstance, 'P');
end;

function TNewPackageExpt.GetIDString: string;
begin
  Result := '{4B61E286-3030-4BEB-A563-9682B8C14BB7}';
end;

function TNewPackageExpt.GetName: string;
begin
  Result := 'ҵ���';
end;

function TNewPackageExpt.GetOptionFileName: string;
begin
  Result := '';
end;

function TNewPackageExpt.GetOwner: IOTAModule;
var
  IModuleServices: IOTAModuleServices;
  IModule: IOTAModule;
  IProjectGroup: IOTAProjectGroup;
  i: Integer;
begin
  Result := nil;
  IModuleServices := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to IModuleServices.ModuleCount - 1 do
  begin
    IModule := IModuleServices.Modules[i];
    if IModule.QueryInterface(IOTAProjectGroup, IProjectGroup) = S_OK then
    begin
      Result := IProjectGroup;
      Break;
    end;
  end;
end;

function TNewPackageExpt.GetPage: string;
begin
  Result := PageName;
end;

function TNewPackageExpt.GetShowSource: Boolean;
begin
  Result := True;
end;

function TNewPackageExpt.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

function TNewPackageExpt.GetUnnamed: Boolean;
begin
  Result := True;
end;

procedure TNewPackageExpt.Modified;
begin

end;

procedure TNewPackageExpt.NewDefaultModule;
begin (BorlandIDEServices as IOTAModuleServices)
  .CreateModule(TPackageExportModule.Create);
end;

procedure TNewPackageExpt.NewDefaultProjectModule(const Project: IOTAProject);
begin
  // ��Ӱ�����������Ӳ���Ч����NewProjectResource��Ч....
  Project.AddFile('Core.dcp', False);
  Project.AddFile('Base.dcp', False);
end;

function TNewPackageExpt.NewOptionSource(const ProjectName: string): IOTAFile;
begin
  Result := nil;
end;

procedure TNewPackageExpt.NewProjectResource(const Project: IOTAProject);
begin
  // Project.AddFile('Core.dcp',False);
  // Project.AddFile('Base.dcp',False);
end;

function TNewPackageExpt.NewProjectSource(const ProjectName: string): IOTAFile;
var
  s: String;
begin
  s := 'package ' + ProjectName + ';' + #13#10 + #13#10 + '{$R *.res}' +
    #13#10 + '{$ALIGN 8}' + #13#10 + '{$ASSERTIONS ON}' + #13#10 +
    '{$BOOLEVAL OFF}' + #13#10 + '{$DEBUGINFO ON}' + #13#10 +
    '{$EXTENDEDSYNTAX ON}' + #13#10 + '{$IMPORTEDDATA ON}' + #13#10 +
    '{$IOCHECKS ON}' + #13#10 + '{$LOCALSYMBOLS ON}' + #13#10 +
    '{$LONGSTRINGS ON}' + #13#10 + '{$OPENSTRINGS ON}' + #13#10 +
    '{$OPTIMIZATION ON}' + #13#10 + '{$OVERFLOWCHECKS OFF}' + #13#10 +
    '{$RANGECHECKS OFF}' + #13#10 + '{$REFERENCEINFO ON}' + #13#10 +
    '{$SAFEDIVIDE OFF}' + #13#10 + '{$STACKFRAMES OFF}' + #13#10 +
    '{$TYPEDADDRESS OFF}' + #13#10 + '{$VARSTRINGCHECKS ON}' + #13#10 +
    '{$WRITEABLECONST OFF}' + #13#10 + '{$MINENUMSIZE 1}' + #13#10 +
    '{$IMAGEBASE $400000}' + #13#10 + '{$RUNONLY}' + #13#10 +
    '{$IMPLICITBUILD OFF}' + #13#10 + #13#10 + 'end.';
  Result := StringToIOTAFile(s);
end;

{ TPackageExportModule }

procedure TPackageExportModule.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TPackageExportModule.GetAncestorName: string;
begin
  Result := '';
end;

function TPackageExportModule.GetCreatorType: string;
begin
  Result := sUnit;
end;

function TPackageExportModule.GetExisting: Boolean;
begin
  Result := False;
end;

function TPackageExportModule.GetFileSystem: string;
begin
  Result := '';
end;

function TPackageExportModule.GetFormName: string;
begin
  Result := '';
end;

function TPackageExportModule.GetImplFileName: string;
begin
  Result := GetCurrentDir + '\Unit1.pas';
end;

function TPackageExportModule.GetIntfFileName: string;
begin
  Result := '';
end;

function TPackageExportModule.GetMainForm: Boolean;
begin
  Result := False;
end;

function TPackageExportModule.GetOwner: IOTAModule;
// var
// ModuleServices:IOTAModuleServices;
// ProjectGroup:IOTAProjectGroup;
// i:Integer;
begin
  // Result:=(BorlandIDEServices as IOTAModuleServices).FindModule(PackageName);
  Result := ToolsApi.GetActiveProject;
  if (Result = nil) then
    Result := GetFirstModuleSupporting(IOTAProject) as IOTAProject;
  {
    ModuleServices:=BorlandIDEServices as IOTAModuleServices;
    for i:=0 to ModuleServices.ModuleCount-1 do
    begin
    with ModuleServices.Modules[i] do
    begin
    if QueryInterface(IOTAProjectGroup,ProjectGroup)=S_OK then
    begin
    Result:=ProjectGroup.GetActiveProject;
    exit;
    end;
    end;
    end; }
end;

function TPackageExportModule.GetShowForm: Boolean;
begin
  Result := False;
end;

function TPackageExportModule.GetShowSource: Boolean;
begin
  Result := True;
end;

function TPackageExportModule.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TPackageExportModule.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TPackageExportModule.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
var
  s: String;
begin
  s := 'unit ' + ModuleIdent + ';' + #13#10 + #13#10 + 'interface' + #13#10 +
    #13#10 + 'uses SysUtils,RegIntf,RegPluginIntf;' + #13#10 + #13#10 +
    'procedure InstallPackage(Reg:IRegistry);//��װ��' + #13#10 +
    'procedure UnInstallPackage(Reg:IRegistry);//ж�ذ�' + #13#10 +
    'procedure RegisterPlugIn(Reg:IRegPlugin);//ע����'#13#10 + #13#10 +
    'exports' + #13#10 + '  InstallPackage,' + #13#10 +
    '  UnInstallPackage,' + #13#10 + '  RegisterPlugIn;' + #13#10 + #13#10 +
    'implementation' + #13#10 + #13#10 + 'uses MenuRegIntf;' + #13#10 +
    #13#10 + 'const' + #13#10 +
    '  InstallKey=''SYSTEM\LOADPACKAGE\USER'';//����Ҫ�ĳ���Ӧ��KEY' + #13#10 +
    '  ValueKey=''Package=%s;load=True'';' + #13#10 + #13#10 +
    'procedure InstallPackage(Reg:IRegistry);' + #13#10 +
    'var ModuleFullName,ModuleName,Value:String;' + #13#10 + 'begin' + #13#10 +
    '  //ע���' + #13#10 + '  if Reg.OpenKey(InstallKey,True) then' + #13#10 +
    '  begin' + #13#10 +
    '    ModuleFullName:=SysUtils.GetModuleName(HInstance);' + #13#10 +
    '    ModuleName:=ExtractFileName(ModuleFullName); ' + #13#10 +
    '    Value:=Format(ValueKey,[ModuleFullName]); ' + #13#10 +
    '    Reg.WriteString(ModuleName,Value);' + #13#10 + '    Reg.SaveData;' +
    #13#10 + '  end;' + #13#10 + 'end;' + #13#10 + #13#10 +
    'procedure UnInstallPackage(Reg:IRegistry);' + #13#10 +
    'var ModuleName:String;' + #13#10 + 'begin' + #13#10 + '  //ȡ��ע���' +
    #13#10 + '  if Reg.OpenKey(InstallKey) then' + #13#10 + '  begin' +
    #13#10 +
    '    ModuleName:=ExtractFileName(SysUtils.GetModuleName(HInstance)); ' +
    #13#10 + '    if Reg.DeleteValue(ModuleName) then' + #13#10 +
    '      Reg.SaveData;' + #13#10 + '  end;' + #13#10 + 'end;' + #13#10 +
    #13#10 + 'procedure RegisterPlugIn(Reg:IRegPlugin);' + #13#10 + 'begin' +
    #13#10 + '  //����ע����(TPlugin)��...' + #13#10 + 'end;' + #13#10 + #13#10 +
    #13#10 + 'initialization' + #13#10 + #13#10 + 'finalization' + #13#10 +
    #13#10 + 'end.';
  Result := StringToIOTAFile(s);
end;

function TPackageExportModule.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

initialization

finalization

end.
