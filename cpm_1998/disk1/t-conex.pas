program tare_conexitate;
var a:array[1..20,1..20]of byte;
    n,m,x,y,i,j,k:integer;
begin
clrscr;
writeln('Avem un graf orientat si se cere sa se determine');
writeln('daca este tare conex sau nu...');
write('Dati numarul de varfuri:');readln(n);
for i:=1 to n do
    for j:=1 to n do a[i,j]:=0;
write('Dati numarul de muchii:');readln(m);
writeln('Dati muchiile...');
for i:=1 to m do
begin
write('Muchia ',i,' x y:');readln(x,y);
a[x,y]:=1;
end;
for k:=1 to n do
for i:=1 to n do
for j:=1 to n do
if a[i,j]=0 then a[i,j]:=a[i,k]*a[k,j];
writeln('Matricea drumuilor este...');
x:=0;
for i:=1 to n do
begin
for j:=1 to n do
begin
write(a[i,j]);
x:=x+a[i,j];end;
writeln;
end;
if x=n*n then writeln('Graful dat este tare conex...')
else writeln('Se observa ca graful nu este tare conex.');
end.