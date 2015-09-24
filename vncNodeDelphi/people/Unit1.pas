unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ExtCtrls,
  IdContext, IdCmdTCPClient, Jpeg;

type
  TmainForm = class(TForm)
    tcpClient: TIdTCPClient;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  userId:string;

implementation

{$R *.dfm}

procedure TmainForm.FormCreate(Sender: TObject);
var testString:string;
    s:TStringStream;
begin
  TCPClient.Connect();
  TCPClient.Socket.WriteLn('hello,');
  userId:=TCPClient.Socket.ReadLn;
  mainForm.Text:='��� ��: '+userId;
end;

procedure TmainForm.Timer1Timer(Sender: TObject);
var
{//�����������
var
myFile : TextFile;
text   : string;
//������ � ���
AssignFile(myFile, 'Test.txt');
Append(myFile);
WriteLn(myFile, coordMouse);
CloseFile(myFile);
//-----------------------}
coordMouse: string;
//-----------------------
canvasDesktop: TCanvas;
memoryDesktop:TMemoryStream;
jpgimg: TJPEGImage;
bitMapDesktop: TBitmap;
//����������
ifCoord:string;
i:integer;
sLeftCoord, sRigthCoord:string;
begin
//���������� ���� )
tcpClient.Socket.WriteLn('getMouseCoord,'+userId);
coordMouse:=TCPClient.Socket.ReadLn;
i := pos('_', coordMouse);
if i > 0 then
begin
  sLeftCoord := copy(coordMouse, 0, i-1);
  sRigthCoord := copy(coordMouse, i + 1, Length(coordMouse) - i);
  SetCursorPos(StrToInt(sLeftCoord), StrToInt(sRigthCoord));
end;
//-----------------------
canvasDesktop:=TCanvas.Create;
        canvasDesktop.Handle:=GetDC(HWND_DESKTOP);
        bitMapDesktop:=TBitmap.Create;
        bitMapDesktop.Width:=Screen.Width;
        bitMapDesktop.Height:=Screen.Height;
        bitMapDesktop.Canvas.CopyRect(bitMapDesktop.Canvas.ClipRect, canvasDesktop, canvasDesktop.ClipRect);
        if not DrawIcon(bitMapDesktop.Canvas.Handle, Mouse.CursorPos.X, Mouse.CursorPos.Y, GetCursor) then
          begin
        end;
        jpgimg:=TJPEGImage.Create;
        jpgimg.Assign(bitMapDesktop);
        jpgImg.CompressionQuality:=50;
        memoryDesktop:=TMemoryStream.Create;
        jpgimg.SaveToStream(memoryDesktop);
        tcpClient.Socket.Write(memoryDesktop, 0, True);
        jpgimg.Free;
        memoryDesktop.Clear;
        memoryDesktop.Free;
//-----------------------
end;

end.
