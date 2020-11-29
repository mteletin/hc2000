program parcurgere_BF;
var viz:array[1..20]of 0..1;
    a:array[1..20,1..20]of integer;
    n,m,p,i,j,x,y,u,v:integer;
    c:array[1..20]of integer;
begin
clrscr;
writeln('Program penru realizarea parcurgerii in inaltime.');
writeln('(Breadth First)');
writeln('Dati Numarul de varfuri si de Muchii ale grafului neorientat');
write('N=');readln(n);write('M=');readln(m);
for i:=1 to n do
    for j:=1 to n do a[i,j]:=0;
for i:=1 to m do
    begin
    write('muchia(',i,') x y >');
    readln(x,y);a[x,y]:=1;a[y,x]:=1;
    end;
write('Varful de plecare:');readln(i);
for j:=1 to n do viz[j]:=0;
c[1]:=i;p:=1;u:=1;viz[i]:=1;
while p<=u do begin
              v:=c[p];
              for j:=1 to n do
              if (a[v,j]=1)and(viz[j]=0)then begin
                                             u:=u+1;
                                             c[u]:=j;viz[j]:=1;
                                             end;
              p:=p+1;
              end;
write('Lista varfurilor in parcurgere BF plecand din ',i,' este:');
for j:=1 to u do write(c[j],' ');
writeln;
end.