unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ExtCtrls,
  IdContext, IdCmdTCPClient, Jpeg;

type
  TmainForm = class(TForm)
    tcpClient: TIdTCPClient;
    timerSendDescImage: TTimer;
    timerMouseCoord: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure timerSendDescImageTimer(Sender: TObject);
    procedure timerMouseCoordTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  hello : String = '100,';    //����������� �����
  compressImage : Integer = 75; //�������� ������
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
  TCPClient.Socket.WriteLn(hello);
  userId:=TCPClient.Socket.ReadLn;
  mainForm.Text:='��� ��: '+userId;
end;

procedure TmainForm.timerSendDescImageTimer(Sender: TObject);
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

//-----------------------
canvasDesktop: TCanvas;
memoryDesktop:TMemoryStream;
jpgimg: TJPEGImage;
bitMapDesktop: TBitmap;

begin

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
        jpgImg.CompressionQuality:=compressImage;
        memoryDesktop:=TMemoryStream.Create;
        jpgimg.SaveToStream(memoryDesktop);
        tcpClient.Socket.Write(memoryDesktop, 0, True);
        bitMapDesktop.Free;
        jpgimg.Free;
        memoryDesktop.Clear;
        memoryDesktop.Free;
//-----------------------
end;

procedure TmainForm.timerMouseCoordTimer(Sender: TObject);
var
fullReadString:string;
commandServer:string;
coordMouse: string;
//coord var
ifCoord:string;
i:integer;
sLeftCoord, sRigthCoord:string;
begin
//in mouse coord
//tcpClient.Socket.WriteLn('getMouseCoords,'+userId);
fullReadString:=TCPClient.Socket.ReadLn;
commandServer:=copy(fullReadString, 0, 3);
if (commandServer='102') then begin
  i := pos('_', fullReadString);
  if i > 0 then
  begin
    sLeftCoord := copy(fullReadString, 4, i-4);
    sRigthCoord := copy(fullReadString, i + 1, Length(fullReadString) - i);
    SetCursorPos(StrToInt(sLeftCoord), StrToInt(sRigthCoord));
    mainForm.caption:= sLeftCoord+'_'+sLeftCoord;
  end;
end;
end;

end.
