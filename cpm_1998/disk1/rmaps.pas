const np=10;kl=2;
var m:array[0..65,0..24]of byte;
    x,y,a,b,i,j:integer;
    c:char;
{$i prcolors.pas}
procedure save;
var f:file of byte;s:string[40];
begin
gotoxy(1,24);write('                                             ');
gotoxy(1,24);write('Input drive and name:');read(s);
gotoxy(1,24);write('                                             ');
assign(f,s);rewrite(f);for x:=1 to 64 do
for y:=1 to 23 do write(f,m[x,y]);close(f);
end;
procedure lev(n:integer);
begin
for x:=1 to 64 do
for y:=1 to 23 do
if m[x,y]>=n then
for a:=-1 to 1 do
for b:=-1 to 1 do
if (m[x+a,y+b]<n)and(random(kl)=0)then m[x,y]:=n;end;
procedure plot(x,y,c:integer);
begin
if x mod 2=1 then begin gotoxy(x,y);lowvideo;
ink(m[x,y]);paper(m[x+1,y]);write(' ');highvideo;end
else begin gotoxy(x,y);ink(m[x-1,y]);paper(m[x,y]);write(' ');end;
end;
procedure init;
begin for x:=1 to 64 do for y:=1 to 24 do m[x,y]:=7;
for a:=1 to np do m[random(64)+1,random(24)+1]:=0;end;
begin
clrscr;write('Input a gene(0-32767):');readln(x);
for y:=1 to x do a:=random(kl);
gotoxy(1,24);write('Press ~S~ to save image or else.');
init;gotoxy(1,1);write('WAIT to create image...');
for i:=0 to 7 do lev(i);
for x:=1 to 64 do
for y:=1 to 23 do
plot(x,y,m[x,y]);
read(kbd,c);
if upcase(c)='S' then save;
ink(0);paper(7);clrscr;
end.