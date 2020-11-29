program parcurgere_df;
var viz:array[1..20]of 0..1;
    a:array[1..20,1..20]of integer;
    n,m,k,ps,i,j,x,y:integer;
    s,urm:array[1..20]of integer;
begin
writeln('Program pentru parcurgerea');
writeln('unui graf neorientat in');
writeln('latime (DF)');
write('n,m=');readln(n,m);
for i:=1 to n do
    for j:=1 to n do a[i,j]:=0;
for i:=1 to m do
    begin
    write('muchia ',i,' =');readln(x,y);
    a[x,y]:=1;a[y,x]:=1;
    end;
write('Varful de plecare:');readln(i);
for j:=1 to n do begin
                 viz[j]:=0;urm[j]:=0;
                 end;
s[1]:=i;ps:=1;
viz[i]:=1;writeln('Ordinea varfurilor in DF ',i,' ');
while ps>=1 do
begin
j:=s[ps];
k:=urm[j]+1;
while (k<=n)and((a[j,k]=0)or(a[j,k]=1)and(viz[k]=1))do k:=k+1;
urm[j]:=k;
if k=n+1 then ps:=ps-1
else begin
     write(k,' ');
     viz[k]:=1;
     ps:=ps+1;
     s[ps]:=k;
     end;
end;
writeln('Apasa ENTER pentru a iesi...');
readln;
end.