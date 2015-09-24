unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ExtCtrls,
  IdContext, IdCmdTCPClient, Jpeg;

type
  TForm1 = class(TForm)
    tcpClient: TIdTCPClient;
    screenImage: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure screenImageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  hello : String = '101,';  //����������� ��������
  coordMouse : String = '102,'; //�������� ��������� �����
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  idUsers: string;
begin
  tcpClient.Connect();
  tcpClient.Socket.WriteLn(hello+'1000000001');
  //idUsers:=tcpClient.Socket.ReadLn;
  Form1.Text:=idUsers;
end;



procedure TForm1.screenImageClick(Sender: TObject);
begin
Timer1.Enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  streamJpg: TMemoryStream;
  jpegImage: TJPEGImage;
  mouseCoord: TMouse;//*************
begin
if tcpClient.Connected=true then
begin
 mouseCoord:=TMouse.Create;   //**********************
 tcpClient.Socket.WriteLn(coordMouse+'1000000001,'+inttostr(mouseCoord.CursorPos.x)+'_'+inttostr(mouseCoord.CursorPos.y));//**********************
 //tcpClient.Socket.WriteLn('getImage,1000000001');
 streamJpg:=TMemoryStream.Create;
 tcpClient.Socket.ReadStream(streamJpg);
 streamJpg.Position:=0;
 jpegImage := TJPEGImage.Create;
 jpegImage.LoadFromStream(streamJpg);
 //jpegImage.SaveToFile('1a.jpeg');
 screenImage.Picture.Graphic:=jpegImage;
 jpegImage.Free;
 streamJpg.Clear;
 streamJpg.Free;

end
else
tcpClient.Connect();
end;

end.
