procedure set1;var a,b,c:char;begin
a:=chr(27);b:=chr(113);write(a,b);end;
procedure set2;var a,b,c:char;begin
a:=chr(27);b:=chr(112);write(a,b);end;

procedure window(x,y,xx,yy:integer);var k:integer;a:char;
s:string[66];begin if x<xx then if y<yy then begin set2;s:='';
x:=x+1;y:=y+1;xx:=xx+1;yy:=yy+1;
for k:=y+1 to yy-1 do s:=s+' ';gotoxy(y,x);a:=chr(42);
write(a);a:=chr(39);for k:=y+1 to yy-1 do begin gotoxy(k,x);
write(a);gotoxy(k,xx);write(a);end;a:=chr(34);gotoxy(yy,x);
write(a);a:=chr(32);for k:=x+1 to xx-1 do begin gotoxy(y,k);
set2;write(a);set1;write(s);set2;gotoxy(yy,k);write(a);end;
a:=chr(35);gotoxy(y,xx);write(a);a:=chr(41);gotoxy(yy,xx);
write(a);set1;end;end;