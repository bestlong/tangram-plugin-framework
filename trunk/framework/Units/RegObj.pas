{ ------------------------------------
  ����˵����ʵ�ֶ�ע���Ķ�д����Ϊ�ⲿҲ����
  �����ע������Է�װ��һ��DLL
  �������ڣ�2008/11/14
  ���ߣ�wzw
  ��Ȩ��wzw
  ------------------------------------- }
unit RegObj;

interface

uses SysUtils, Classes, RegIntf, XMLDoc, XMLIntf, Variants, ActiveX,
  SvcInfoIntf, MenuRegIntf;

Type
  TRegObj = Class(TInterfacedObject, IRegistry, ILoadRegistryFile, ISvcInfo,
    IMenuReg)
  private
    FRegFile: String;
    FXMLDoc: IXMLDocument;
    FCurrNode: IXMLNode;
    function GetNode(const key: Widestring; CanCreate: Boolean): IXMLNode;
    function ReadValue(const aName: Widestring; out Value: OleVariant): Boolean;
    procedure WriteValue(const aName: Widestring; Value: OleVariant);
  protected
    { IRegistry }
    function OpenKey(const key: Widestring;
      CanCreate: Boolean = False): Boolean;
    function DeleteKey(const key: Widestring): Boolean;
    function KeyExists(const key: Widestring): Boolean;
    procedure GetKeyNames(Strings: TStrings);
    procedure GetValueNames(Strings: TStrings);
    function DeleteValue(const aName: Widestring): Boolean;
    function ValueExists(const ValueName: Widestring): Boolean;

    function ReadBool(const aName: Widestring; out Value: Boolean): Boolean;
    function ReadDateTime(const aName: Widestring;
      out Value: TDateTime): Boolean;
    function ReadFloat(const aName: Widestring; out Value: Double): Boolean;
    function ReadInteger(const aName: Widestring; out Value: Integer): Boolean;
    function ReadString(const aName: Widestring;
      out Value: Widestring): Boolean;

    function ReadBoolDef(const aName: Widestring; Default: Boolean): Boolean;
    function ReadDateTimeDef(const aName: Widestring;
      Default: TDateTime): TDateTime;
    function ReadFloatDef(const aName: Widestring; Default: Double): Double;
    function ReadIntegerDef(const aName: Widestring; Default: Integer): Integer;
    function ReadStringDef(const aName: Widestring;
      Default: Widestring): Widestring;

    procedure WriteBool(const aName: Widestring; Value: Boolean);
    procedure WriteDateTime(const aName: Widestring; Value: TDateTime);
    procedure WriteFloat(const aName: Widestring; Value: Double);
    procedure WriteInteger(const aName: Widestring; Value: Integer);
    procedure WriteString(const aName, Value: Widestring);

    procedure SaveData;

    { ILoadRegistryFile }
    procedure LoadRegistryFile(const FileName: Widestring);
    { ISvcInfo }
    function GetModuleName: String;
    function GetTitle: String;
    function GetVersion: String;
    function GetComments: String;
    { IMenuReg }
    procedure RegMenu(const key, Path: Widestring);
    procedure UnRegMenu(const key: Widestring);
    procedure RegToolItem(const key, aCaption, aHint: Widestring);
    procedure UnRegToolItem(const key: Widestring);
  public
    constructor Create;
    Destructor Destroy; override;
  End;

  ERegistryException = Class(Exception);

implementation

//uses msxmldom,xmldom;

const
  MenuKey = 'SYSTEM\MENU';
  ToolKey = 'SYSTEM\TOOL';

constructor TRegObj.Create;
begin
  CoInitialize(nil);

  {try
    //�������������ڽ������DLL��No matching DOM Vendor: ""���������
    //����msxmldom,xmldom����Ԫ
    MSXML_DOM:=TMSDOMImplementationFactory.Create;
    RegisterDOMVendor(MSXML_DOM);
  Except
  end;  }
end;

function TRegObj.DeleteKey(const key: Widestring): Boolean;
var
  Node: IXMLNode;
begin
  Result := False;
  if Trim(key) = '' then
    exit;
  Node := GetNode(key, False);
  if assigned(Node) then
    Result := Node.ParentNode.ChildNodes.Remove(Node) <> -1;
end;

function TRegObj.DeleteValue(const aName: Widestring): Boolean;
var
  Node: IXMLNode;
begin
  Result := False;
  if Trim(aName) = '' then
    exit;
  if assigned(FCurrNode) then
  begin
    Node := FCurrNode.AttributeNodes.FindNode(WideUpperCase(aName));
    if assigned(Node) then
      Result := FCurrNode.AttributeNodes.Remove(Node) <> -1;
  end;
end;

destructor TRegObj.Destroy;
begin
  FXMLDoc := nil;
  FCurrNode := nil;
  CoUninitialize;
  inherited;
end;

function TRegObj.GetComments: String;
begin
  Result := '���ע������ӿڣ����ڲ������ע���';
end;

procedure TRegObj.GetKeyNames(Strings: TStrings);
var
  i: Integer;
begin
  if Strings = Nil then
    exit;
  if assigned(FCurrNode) then
  begin
    if FCurrNode.HasChildNodes then
    begin
      for i := 0 to FCurrNode.ChildNodes.Count - 1 do
        Strings.Add(FCurrNode.ChildNodes[i].NodeName);
    end;
  end;
end;

function TRegObj.GetModuleName: String;
begin
  Result := ExtractFileName(SysUtils.GetModuleName(HInstance));
end;

function TRegObj.GetNode(const key: Widestring; CanCreate: Boolean): IXMLNode;
// �ڲ�����
  function InnerGetNode(const NodeStr: Widestring; FromNode: IXMLNode;
    aCanCreate: Boolean): IXMLNode;
  begin
    Result := Nil;
    if Trim(NodeStr) = '' then
      exit;
    if FromNode = Nil then
      exit;
    if aCanCreate then
      Result := FromNode.ChildNodes[NodeStr]
    else
      Result := FromNode.ChildNodes.FindNode(NodeStr);
  end;

var
  aList: TStrings;
  ParentNode, FoundNode: IXMLNode;
  i: Integer;
  tmpKey: String;
begin
  tmpKey := UpperCase(Trim(key)); // WideUpperCase
  if tmpKey = '' then
  Begin
    Result := FXMLDoc.DocumentElement;
    exit;
  End;
  ParentNode := FXMLDoc.DocumentElement;
  aList := TStringList.Create;
  try
    ExtractStrings(['\'], [], pchar(tmpKey), aList);
    for i := 0 to aList.Count - 1 do
    begin
      FoundNode := InnerGetNode(aList[i], ParentNode, CanCreate);
      if FoundNode = Nil then
        exit;
      ParentNode := FoundNode;
    end;
    Result := FoundNode; // ͬ��
  Finally
    aList.Free;
  end;
end;

function TRegObj.GetTitle: String;
begin
  Result := 'ע���ӿ�(IRegistry)';
end;

procedure TRegObj.GetValueNames(Strings: TStrings);
var
  i: Integer;
begin
  if Strings = Nil then
    exit;
  if assigned(FCurrNode) then
  begin
    for i := 0 to FCurrNode.AttributeNodes.Count - 1 do
      Strings.Add(FCurrNode.AttributeNodes[i].NodeName);
  end;
end;

function TRegObj.GetVersion: String;
begin
  Result := '20100421.001';
end;

function TRegObj.KeyExists(const key: Widestring): Boolean;
var
  tmpNode: IXMLNode;
begin
  tmpNode := GetNode(key, False);
  Result := tmpNode <> Nil;
end;

procedure TRegObj.LoadRegistryFile(const FileName: Widestring);
begin
  Try
    FRegFile := FileName;
    if FileExists(FRegFile) then
      FXMLDoc := LoadXMLDocument(FileName)
    else begin
      FXMLDoc:=NewXMLDocument;
      FXMLDoc.DocumentElement:=FXMLDoc.CreateNode('Doc');
      FXMLDoc.SaveToFile(FRegFile);
    end;
  Except
    on E: Exception do
      Raise ERegistryException.CreateFmt('��ע������%s', [E.Message]);
  End;
end;

function TRegObj.OpenKey(const key: Widestring; CanCreate: Boolean): Boolean;
begin
  FCurrNode := GetNode(key, CanCreate);
  Result := assigned(FCurrNode);
end;

function TRegObj.ReadBool(const aName: Widestring; out Value: Boolean): Boolean;
var
  tmpValue: OleVariant;
begin
  Result := ReadValue(aName, tmpValue);
  if VarIsNull(tmpValue) then
    Value := False
  else
    Value := tmpValue;
end;

function TRegObj.ReadBoolDef(const aName: Widestring;
  Default: Boolean): Boolean;
begin
  if not self.ReadBool(aName,Result) then
    Result:=Default;
end;

function TRegObj.ReadDateTime(const aName: Widestring;
  out Value: TDateTime): Boolean;
var
  tmpValue: OleVariant;
begin
  Result := ReadValue(aName, tmpValue);
  if VarIsNull(tmpValue) then
    Value := 0
  else
    Value := tmpValue;
end;

function TRegObj.ReadDateTimeDef(const aName: Widestring;
  Default: TDateTime): TDateTime;
begin
  if not self.ReadDateTime(aName,Result) then
    Result:=Default;
end;

function TRegObj.ReadFloat(const aName: Widestring; out Value: Double): Boolean;
var
  tmpValue: OleVariant;
begin
  Result := ReadValue(aName, tmpValue);
  if VarIsNull(tmpValue) then
    Value := 0.0
  else
    Value := tmpValue;
end;

function TRegObj.ReadFloatDef(const aName: Widestring; Default: Double): Double;
begin
  if not self.ReadFloat(aName,Result) then
    Result:=Default;
end;

function TRegObj.ReadInteger(const aName: Widestring;
  out Value: Integer): Boolean;
var
  tmpValue: OleVariant;
begin
  Result := ReadValue(aName, tmpValue);
  if VarIsNull(tmpValue) then
    Value := 0
  else
    Value := tmpValue;
end;

function TRegObj.ReadIntegerDef(const aName: Widestring;
  Default: Integer): Integer;
begin
  if not self.ReadInteger(aName,Result) then
    Result:=Default;
end;

function TRegObj.ReadString(const aName: Widestring;
  out Value: Widestring): Boolean;
var
  tmpValue: OleVariant;
begin
  Result := ReadValue(aName, tmpValue);
  if VarIsNull(tmpValue) then
    Value := ''
  else
    Value := tmpValue;
end;

function TRegObj.ReadStringDef(const aName: Widestring;
  Default: Widestring): Widestring;
begin
  if not self.ReadString(aName,Result) then
    Result:=Default;
end;

function TRegObj.ReadValue(const aName: Widestring;
  out Value: OleVariant): Boolean;
var
  Node: IXMLNode;
begin
  Result := False;
  if assigned(FCurrNode) then
  begin
    Node := FCurrNode.AttributeNodes.FindNode(WideUpperCase(aName));
    if assigned(Node) then
    begin
      Value := Node.NodeValue;
      Result := True;
    end;
  end;
end;

procedure TRegObj.RegMenu(const key, Path: Widestring);
begin
  if key = '' then
    exit;
  if self.OpenKey(MenuKey, True) then
    self.WriteString(key, Path);
end;

procedure TRegObj.RegToolItem(const key, aCaption, aHint: Widestring);
var
  S: Widestring;
begin
  if key = '' then
    exit;
  if self.OpenKey(ToolKey, True) then
  begin
    S := 'Caption=' + aCaption + ',Hint=' + aHint;
    self.WriteString(key, S);
  end;
end;

procedure TRegObj.SaveData;
begin
  if FXMLDoc.Modified then
    FXMLDoc.SaveToFile(FRegFile);
end;

procedure TRegObj.UnRegMenu(const key: Widestring);
begin
  if key = '' then
    exit;
  if self.OpenKey(MenuKey) then
    self.DeleteValue(key);
end;

procedure TRegObj.UnRegToolItem(const key: Widestring);
begin
  if key = '' then
    exit;
  if self.OpenKey(ToolKey) then
    self.DeleteValue(key);
end;

function TRegObj.ValueExists(const ValueName: Widestring): Boolean;
begin
  Result := False;
  if assigned(FCurrNode) then
    Result := FCurrNode.AttributeNodes.FindNode(WideUpperCase(ValueName))
      <> Nil;
end;

procedure TRegObj.WriteBool(const aName: Widestring; Value: Boolean);
begin
  WriteValue(aName, Value);
end;

procedure TRegObj.WriteDateTime(const aName: Widestring; Value: TDateTime);
begin
  WriteValue(aName, Value);
end;

procedure TRegObj.WriteFloat(const aName: Widestring; Value: Double);
begin
  WriteValue(aName, Value);
end;

procedure TRegObj.WriteInteger(const aName: Widestring; Value: Integer);
begin
  WriteValue(aName, Value);
end;

procedure TRegObj.WriteString(const aName, Value: Widestring);
begin
  WriteValue(aName, Value);
end;

procedure TRegObj.WriteValue(const aName: Widestring; Value: OleVariant);
begin
  if assigned(FCurrNode) then
    FCurrNode.Attributes[WideUpperCase(aName)] := Value;
end;

initialization

// CoInitialize(nil);
finalization

// CoUninitialize;
end.
