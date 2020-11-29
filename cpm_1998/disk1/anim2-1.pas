type img=record a:array[1..32,1..11]of char;end;
var f:text;c:char;v:array[1..100]of img;
    uu,u,i,x,y:integer;s:string[25];
    ex:boolean;
{$i prwindow.pas}
procedure load;begin
gotoxy(1,2);write('Please input filename:');readln(s);s:=s+'.mov';
gotoxy(1,2);write(' Loading file ...                        ');
assign(f,s);reset(f);window(4,15,16,48);
i:=1;repeat for x:=1 to 32 do
for y:=1 to 11 do read(f,v[i].a[x,y]);
i:=i+1;until (eof(f));close(f);end;
procedure show;begin
gotoxy(1,2);write('Playing...                      ');
for u:=1 to i-1 do begin
for x:=1 to 32 do for y:=1 to 11 do begin
if not((v[uu].a[x,y]=' ')and(v[u].a[x,y]=' '))then begin
gotoxy(x+16,y+5);if v[u].a[x,y]=chr(127) then
lowvideo;write(' ');highvideo;end;end;uu:=u;end;
gotoxy(1,24);end;begin clrscr;u:=0;repeat
gotoxy(1,1);write('                               ');
gotoxy(1,2);write('                               ');
gotoxy(1,1);lowvideo;write('1-LOAD 2-PLAY 3-EXIT');highvideo;
gotoxy(1,2);write('Ready for your command...');
window(4,15,16,48);read(kbd,c);if c='1' then load;
if c='2' then show;until c='3';clrscr;end.