var f:text;c:char;x,y:integer;s:string[25];
    a:array[1..32,1..11]of char;ex:boolean;
PROCEDURE cursor(var x,y:integer;VAR c:char);
begin repeat gotoxy(x,y);
ex:=false;read(kbd,c);c:=upcase(c);
if c='O' then if x>1 then x:=x-1;
if c='P' then if x<32 then x:=x+1;
if c='Q' then if y>1 then y:=y-1;
if c='A' then if y<11 then y:=y+1;
if (((c='X')or(c='M'))or(c='N'))or(c='S')then ex:=true;
gotoxy(x,y);highvideo;until ex;end;
PROCEDURE init;
begin for x:=1 to 32 do for y:=1 to 11 do a[x,y]:=' ';
assign(f,s);rewrite(f);x:=16;y:=5;end;
PROCEDURE save;
var x,y:integer;begin for x:=1 to 32 do for y:=1 to 11 do
write(f,a[x,y]);end;
PROCEDURE exit;
begin close(f);clrscr;writeln('Animation COMPLETED...');end;

begin
write('Input filename:');readln(s);
init;
clrscr;
gotoxy(1,23);write('Animator1-0');
repeat
cursor(x,y,c);ex:=false;
if c='X' then ex:=true;
if c='S' then save;
c:=upcase(c);
if c='M' then begin a[x,y]:=chr(127);gotoxy(x,y);
lowvideo;write('');highvideo;end;
if c='N' then begin a[x,y]:=' ';gotoxy(x,y);write(' ');end;
until ex;exit;end.