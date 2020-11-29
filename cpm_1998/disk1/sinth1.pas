var a:array[1..17000]of byte;
    b:array[1..100]of byte;
    x,y,i,j,u,k:integer;
begin
clrscr;
writeln('Introduceti 1 sau 0 dupa cum vreti sa auziti armonica');
writeln('respectiva...');
write('Cate armonici vrei sa auzi:');readln(i);
for x:=1 to i do begin write('Armonica ',x,'--');readln(b[x]);
b[x]:=b[x]*x;end;
write('Frecventa sunetului:');readln(y);
writeln('Stai sa creez sunetul...');
j:=17000 div y;
for x:=1 to 5000 do begin
a[x]:=0;
for u:=1 to i do
if x mod (j*b[i-u+1])=0 then a[x]:=1;
end;
repeat
write('Apasa ENTER cand vrei sa auzi sunetul >');readln;
inline($f3);
for x:=1 to 5000 do
port[254]:=56*a[x];
inline($fb);
until false;
end.