const rob:integer=10;g:integer=0;
var r:array[1..100,1..3]of integer;i,rcs,j,xi,yi,x,y,k:integer;
    s:string[64];f:text;ok:boolean;m,n,px,py,h:integer;c:char;
    t:array[1..100,1..2]of integer;
{$i prclick.pas}
{$i prcursor.pas}
{$i prwindow.pas}
{$i priocrt.pas}
procedure win;begin for i:=5 downto 0 do begin port[254]:=63;
delay(i);port[254]:=7;delay(10-i);end;end;

procedure dead;begin for i:=0 to 40 do begin
port[254]:=63;delay(i);port[254]:=7;end;end;

procedure init;begin for i:=1 to 3+random(rob)do begin
xi:=random(40)+1;yi:=random(20)+1;t[i,1]:=xi;t[i,2]:=yi;end;
rcs:=i;for i:=1 to rob do begin r[i,3]:=1;repeat
xi:=random(40)+1;yi:=random(20)+1;ok:=true;for j:=1 to i-1 do
if (r[j,1]=xi)and(r[j,2]=yi) then ok:=false;
until ok;r[i,1]:=xi;r[i,2]:=yi;end;for i:=1 to rob do begin
ok:=true;repeat x:=random(40)+1;y:=random(20)+1;
if r[i,3]=1 then if (r[i,1]=x)and(r[i,2]=y)then
ok:=false;until ok;end;end;

procedure moverob;begin for i:=1 to rob do if r[i,3]=1 then begin
if x>r[i,1] then px:=h else px:=-h;
if y>r[i,2] then py:=h else py:=-h;
if h=0 then h:=1 else h:=0;
r[i,1]:=r[i,1]+px;r[i,2]:=r[i,2]+py;end;end;

procedure ckeck;begin k:=0;for i:=1 to rob do begin
if r[i,3]=1 then begin if (x=r[i,1])and(y=r[i,2])then g:=1;
for j:=1 to i-1 do if r[j,3]=1 then
if (r[i,1]=r[j,1])and(r[i,2]=r[j,2]) then
begin r[i,3]:=0;r[j,3]:=0;port[254]:=63;end;for j:=1 to rcs do
if (r[i,1]=t[j,1])and(r[i,2]=t[j,2]) then
begin r[i,3]:=0;r[j,3]:=0;port[254]:=63;end;end else k:=k+1;end;
if k=rob then g:=2;end;

procedure show;begin for i:=1 to rob do
if r[i,3]=1 then begin port[254]:=63;port[254]:=7;gotoxy(r[i,1]+1,
r[i,2]+1);write('');end;gotoxy(x+1,y+1);
write('+');for i:=1 to rcs do begin
gotoxy(t[i,1]+1,t[i,2]+1);write('*');end;end;

procedure cshow;begin for i:=1 to rob do begin gotoxy(r[i,1]+1,
r[i,2]+1);write(' ');end;gotoxy(x+1,y+1);
write(' ');end;

procedure clear;begin for i:=2 to 22 do begin gotoxy(2,i);
for j:=1 to 45 do write(' ');end;end;

begin clikoff;clrscr;
repeat
gotoxy(48,11);write('Level:');readln(rob);
rob:=rob+rob mod 2;
x:=7;for i:=1 to rob do r[i,3]:=1;
clear;gotoxy(17,24);
write('(C) 1996 TIM Software Power.');window(0,0,22,46);
g:=0;init;show;repeat hidek;
repeat gotoxy(1,1);c:=readkey;until c<>chr(0);cshow;
if c=chr(5) then if y>1 then y:=y-1;
if c=chr(24) then if y<20 then y:=y+1;
if c=chr(19) then if x>1 then x:=x-1;
if c=chr(4) then if x<40 then x:=x+1;
g:=0;moverob;show;ckeck;if g=1 then begin
window(9,25,13,38);gotoxy(30,12);write('Dead!');dead;
c:=chr(27);end;if g=2 then begin window(9,25,13,38);
gotoxy(31,12);write('Win!');win;c:=chr(27);end;showk;
until c=chr(27);c:=readkey;until c=chr(27);
clrscr;
end.