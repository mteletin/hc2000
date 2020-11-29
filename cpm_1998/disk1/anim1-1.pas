type img=record a:array[1..32,1..11]of char;end;
var f:text;c:char;v:array[1..100]of img;
    uu,u,i,x,y:integer;s:string[25];
{$i prwindow.pas}
begin
clrscr;write('Input filename:');readln(s);
assign(f,s);reset(f);window(4,15,16,48);
repeat i:=1;repeat for x:=1 to 32 do
for y:=1 to 11 do read(f,v[i].a[x,y]);
i:=i+1;until (eof(f))or(i>=99);u:=1;
for u:=1 to i-1 do begin for x:=1 to 32 do
for y:=1 to 11 do begin
if not((v[uu].a[x,y]=' ')and(v[u].a[x,y]=' '))then begin
gotoxy(x+16,y+5);if v[u].a[x,y]=chr(127) then
lowvideo;write(v[u].a[x,y]);highvideo;end;
end;uu:=u;end;until eof(f);close(f);repeat
for u:=1 to i-1 do begin for x:=1 to 32 do
for y:=1 to 11 do begin
if not((v[uu].a[x,y]=' ')and(v[u].a[x,y]=' '))then begin
gotoxy(x+16,y+5);if v[u].a[x,y]=chr(127) then
lowvideo;write(v[u].a[x,y]);highvideo;end;
end;uu:=u;end;
gotoxy(1,24);write('Again:');read(kbd,c);
c:=upcase(c);until c='N';clrscr;end.