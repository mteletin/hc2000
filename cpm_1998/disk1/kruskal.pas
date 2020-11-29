var x,y,c,v:array[1..50]of integer;
    e,ct,d,a,b,n,m,i,j:integer;

function min(a,b:integer):integer;
begin
if a>b then min:=b else min:=a;
end;

function max(a,b:integer):integer;
begin
if a>b then max:=a else max:=b;
end;

begin
write('Dati numarul de noduri:');readln(n);
write('Dati numarul de muchii:');readln(m);
for i:=1 to n do v[i]:=i;
for i:=1 to m do begin
write('Dati muchia ',i,'<x y cost>:');readln(x[i],y[i],c[i]);
end;
repeat
a:=1;
for i:=1 to m-1 do
    if c[i]>c[i+1] then begin
                        b:=c[i];
                        c[i]:=c[i+1];
                        c[i+1]:=b;
                        b:=x[i];
                        x[i]:=x[i+1];
                        x[i+1]:=b;
                        b:=y[i];
                        y[i]:=y[i+1];
                        y[i+1]:=b;
                        a:=0;
                        end;
until a=1;
a:=0;d:=1;ct:=0;
repeat
a:=a+1;
if (v[x[a]]<>v[y[a]])then
begin
b:=min(v[x[a]],v[y[a]]);
e:=max(v[x[a]],v[y[a]]);
for j:=1 to n do if v[j]=e then v[j]:=b;
v[x[a]]:=b;v[y[a]]:=b;
writeln(x[a],':',y[a],' c:',c[a]);
ct:=ct+c[a];
d:=d+1;
end;
until (d>=n);
writeln('Cost total:',ct);
end.