program stars;
var x,y:array[1..100] of integer;zz,z:array[1..100]of real;
    hh,ii,j,l,f,g,h,i:integer;c:char;
{$i b:prwindow.pas}
{$i b:prborder.pas}
{$i b:prcolors.pas}
{$i b:prcursor.pas}
{$i b:prcrt.pas}

begin
paper(2);
hidek;
randomize;
cls;border(2);
for f:=1 to 100 do
begin
x[f]:=random(30)-15;
y[f]:=random(20)-10;
z[f]:=random(4);
end;zz:=z;
paper(0);
window(4,8,19,55);
for g:=1 to 50 do
begin
for l:=1 to 2 do
begin
for f:=1 to 20 do
begin
h:=round(x[f]*z[f]);hh:=round(x[f]*zz[f]);
i:=round(y[f]*z[f]);ii:=round(y[f]*zz[f]);
h:=h+32;i:=i+12;hh:>��DD�@�@FD�pp����Ã��G� �Ã��A�B �Â@�BBnd(i<18) then begin
   at(i,h);write('.');
   end;
if (((hh>10)and(hh<54))and(ii>5))and(ii<18) then begin
   at(ii,hh);write(' ');
   end;
end;
end;
zz:=z;
for f:=1 to 20 do
begin
z[f]:=z[f]+0.2;
if z[f]>4 then z[f]:=0;
end;
end;
showk;ink(5);
border(0);
paper(1);
at(12,0);
for f:=0 to 14 do
write(chr(27),chr(26));
at(23,0);
for f:=0 to 24 do writeln;
end.