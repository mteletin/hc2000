PROGRAM minesweeper;
VAR a:array[0..21,0..21]of integer;
    s,u,o,n,i,x,y:integer;c:char;ex:boolean;
PROCEDURE cursor(var x,y:integer);
BEGIN
repeat
gotoxy(x,y);read(kbd,c);
c:=upcase(c);
if (c='Q')and(y>1) then y:=y-1;
if (c='A')and(y<n) then y:=y+1;
if (c='O')and(x>1) then x:=x-1;
if (c='P')and(x<n) then x:=x+1;
gotoxy(x,y);
until c='M';
END;
FUNCTION win:boolean;
VAR s1,s2,x,y:integer;
BEGIN
s1:=0;s2:=0;
for x:=1 to n do for y:=1 to n do
if a[x,y]=137 then s1:=s1+1;
for x:=1 to n do for y:=1 to n do
if a[x,y]<128 then s2:=s2+1;
if s1+s2=n*n then win:=true else win:=false;
END;
PROCEDURE list;
VAR x,y:integer;
BEGIN
gotoxy(1,23);lowvideo;
write('Minesweeper');highvideo;write(' (C) 1997 TIM SOFTware Power ');
gotoxy(1,1);for x:=1 to n do for y:=1 to n do
BEGIN gotoxy(x,y);
if a[x,y]<128 then write(a[x,y]) else write(chr(127));
END;highvideo;END;

BEGIN
repeat
clrscr;gotoxy(1,23);write('Introdu latura n:');read(n);clrscr;
for x:=0 to n+1 do
for y:=0 to n+1 do a[x,y]:=128;
for i:=1 to n+n div 2 do BEGIN
x:=random(n)+1;y:=random(n)+1;
a[x,y]:=137;END;
for x:=1 to n do
for y:=1 to n do
if a[x,y]<>137 then BEGIN
s:=0;
for u:=-1 to 1 do
for o:=-1 to 1 do
BEGIN
if a[x+u,y+o]=137 then s:=s+1;
END;
a[x,y]:=s+128;
END;
x:=1;y:=1;
repeat
list;cursor(x,y);
if a[x,y]>=128 then a[x,y]:=a[x,y]-128;
if win then x:=-1;
until ((x<0)or(y<0))or(a[x,y]=9);gotoxy(12,1);
if a[x,y]=9 then writeln('You''ve lost');
if win then writeln('YOU''VE WIN!!!');
gotoxy(20,20);write('AGAIN?:');read(kbd,c);
c:=upcase(c);if c='N' then ex:=true else ex:=false;
until ex;
END.