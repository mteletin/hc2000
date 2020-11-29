var a:array[0..65,0..24]of char;
    xp,xo,x,y,nt,k,j:integer;
    v:array[1..100]of char;

procedure afisare;
var o,p:integer;
begin
for o:=1 to 64 do
for p:=1 to 23 do
if a[o,p]<>' 'then begin gotoxy(o,p);write(a[o,p]);end;end;

procedure cucereste(o,p:integer);
begin
xp:=random(3)-1;xo:=random(3)-1;
if a[o,p]<>' ' then a[xp+o,xo+p]:=a[o,p];
end;

procedure init;
begin
for k:=1 to 64 do for j:=1 to 23 do a[k,j]:=' ';
write('Introdu numarul de teritorii:');readln(nt);
writeln('Introdu simbolul fiecarui teritoriu...');
for k:=1 to nt do begin
write('tara ',k,'-->');readln(v[k]);end;
for k:=1 to nt do
begin
repeat
xp:=random(64)+1;
xo:=random(23)+1
until a[xp,xo]=' ';
a[xp,xo]:=v[k];
end;
end;

begin
init;
repeat
afisare;
for x:=1 to 64 do
for y:=1 to 23 do
begin
cucereste(x,y);
end;
until (port[254]<>191)and(port[254]<>255);
end.