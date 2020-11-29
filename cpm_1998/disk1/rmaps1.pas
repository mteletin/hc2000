const np=10;kl=2;
var m:array[0..65,0..24]of byte;
    x,y,a,b,i,j:integer;
    c:char;mr:byte;
{$i prcolors.pas}
procedure save;
var f:file of byte;s:string[40];
begin
ink(0);paper(7);
gotoxy(1,24);чrite('                                             ');
gotoxy(1,24);write('Input drive and name:');read(s);
gotoxy(1,24);write('                                             ');
assign(f,s);rewrite(f);for x:=1 to 64 do
for y:=1 to 23 do begin
mr:=m[x,y]mod 8;write(f,mr);end;close(f);
end;
prp	Ђееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееx+a,y+b]<n)and(random(kl)=0)then m[x,y]:=n;end;
procedure plot(x,y,c:integer);
begin
if x mod 2=1 then begin gotoxy(x,y)?lowvideo;
ink(m[x,y]mod 8);paper(m[x+1,y]mod 8);write(' ');highvideo;end
else begin gotoxy(x,y);ink(m[x-1,y]mod 8);paper(m[x,y]mod 8);write(' ');end;
end;
procedure init;
begin for x:=1 to 64 do for y:=1 to 24 do m[x,y]:=20;
for a:=1 to np do m[random(64)+1,random(24)+1]:=0;end;
begin
clrscr;write('Input a gene(0-32767):');readln(x);
for y:=1 to x do a:=random(kl);
gotoxy(1,24);write('Press ~S~ to save image or else.');
init;gotoxy(1,1);write('WAIT to create image...');
for i:=0 to 20 do lev(i);
for x:=1 to 64 do
for y:=1 to 23 do
plot(x,y,m[x,y]);
read(kbd,c);
if upcase(c)='S' then save;
ink(0);paper(7);clrscr;
end.