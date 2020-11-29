const rob:integer=10;g:integer=0;
var r:array[1..100,1..3]of real;i,rcs,j,xi,yi,x,y,k:integer;
    s:string[64];f:text;ok:boolean;o,n,px,py:real;c:char;
    t:array[1..100,1..2]of real;
    m:array[1..64,1..24]of byte;
{$i prcolors.pas}
{$i prclick.pas}
{$i prcursor.pas}
{$i prwindow.pas}
{$i priocrt.pas}
{$i prplot1.pas}
procedure intro;var x,y:integer;f:file of byte;c:byte;begin
assign(f,'robo1.ams');reset(f);clrscr;for x:=1 to 64 do
for y:=1 to 23 do read(f,m[x,y]);for x:=1 to 64 do
for y:=1 to 23 do plot(x,y,m[x,y]);
delay(2000);clrscr;
end;

procedure win;begin for i:=5 downto 0 do begin port[254]:=63;
delay(i);port[254]:=7;delay(10-i);end;end;

procedure dead;begin for i:=0 to 40 do begin
port[254]:=63;delay(i);port[254]:=7;end;end;

procedure init;begin for i:=1 to 3+random(rob)do begin
xi:=random(40)+1;yi:=random(20)+1;t[i,1]:=xi;t[i,2]:=yi;end;
rcs:=i;for i:=1 to rob do begin r[i,3]:=1;repeat
xi:=random(40)+1;yi:=random(20)+1;ok:=true;for j:=1 to i-1 do
if (round(r[j,1])=xi)and(round(r[j,2])=yi) then ok:=false;
until ok;r[i,1]:=xi;r[i,2]:=yi;end;for i:=1 to rob do begin
ok:=true;repeat x:=random(40)+1;y:=random(20)+1;
if r[i,3]=1 then if (round(r[i,1])=x)and(round(r[i,2])=y)then
ok:=false;until ok;end;end;

procedure moverob;begin for i:=1 to rob do if r[i,3]=1 then begin
o:=sqrt((x-round(r[i,1]))*(x-round(r[i,1]))+(y-round(r[i,2]))*(y-round(r[i,2])));
if o=0 then o:=O+0.000001;port[254]:=63;port[254]:=7;
px:=(x-round(r[i,1]))/o/1.5;py:=(y-round(r[i,2]))/o/1.5;
r[i,1]:=r[i,1]+px;r[i,2]:=r[i,2]+py;end;end;

procedure ckeck;begin k:=0;for i:=1 to rob do begin
if r[i,3]=1 then begin if (x=round(r[i,1]))and(y=round(r[i,2]))then g:=1;
for j:=1 to i-1 do if r[j,3]=1 then
if (round(r[i,1])=round(r[j,1]))and(round(r[i,2])=round(r[j,2])) then
begin r[i,3]:=0;r[j,3]:=0;port[254]:=63;end;for j:=1 to rcs do
if (round(r[i,1])=round(t[j,1]))and(round(r[i,2])=round(t[j,2])) then
begin r[i,3]:=0;r[j,3]:=0;port[254]:=63;end;end else k:=k+1;end;
if k=rob then g:=2;end;

procedure show;begin for i:=1 to rob do
if r[i,3]=1 then begin port[254]:=63;port[254]:=7;gotoxy(round(r[i,1]+1),
round(r[i,2])+1);write('');end;gotoxy(round(x)+1,round(y)+1);
write('+');for i:=1 to rcs do begin
gotoxy(round(t[i,1]+1),round(t[i,2])+1);write('*');end;end;

procedure cshow;begin for i:=1 to rob do begin gotoxy(round(r[i,1]+1),
round(r[i,2])+1);write(' ');end;gotoxy(round(x)+1,round(y)+1);
write(' ');end;

procedure clear;begin for i:=2 to 22 do begin gotoxy(2,i);
for j:=1 to 45 do write(' ');end;end;

begin clikoff;
intro;ink(0);paper(7);clrscr;repeat
window(9,25,13,38);window(0,0,22,46);
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
paper(7);ink(0);clrscr;
end.