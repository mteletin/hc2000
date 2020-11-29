var m:array[0..65,0..24]of byte;
    f:file of byte;c:byte;
    x,y:integer;
    s:string[40];
    ex:boolean;
    ch:char;
{$i prcolors.pas}
procedure plot(x,y:integer);
begin
if x mod 2=1 then begin gotoxy(x,y);lowvideo;
ink(m[x,y]);paper(m[x+1,y]);write(' ');highvideo;end
else begin gotoxy(x,y);ink(m[x-1,y]);paper(m[x,y]);write(' ');end;
end;
begin
repeat clrscr;repeat
write('Introdu numele imaginii (eventual DRIVE):');
readln(s);s:=s+'.ams';assign(f,s);
{$i-} reset(f);{$i+}
if ioresult<>0 then begin
writeln('Nu am gasit fisierul sau a fost o eroare de disc!');
writeln('Mai incearca odata...');
ex:=false;end else ex:=true;
until ex;
for x:=1 to 64 do
for y:=1 to 23 do
read(f,m[x,y]);
for y:=1 to 23 do
for x:=1 to 64 do
plot(x,y);
ink(0);paper(7);gotoxy(1,24);write('X-iesire.');read(kbd,ch);
if upcase(ch)='X' then ex:=true else ex:=false;clrscr;
clrscr;until ex;end.