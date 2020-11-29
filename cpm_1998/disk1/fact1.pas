program puteri;
type nod=^art;
     art=record
         ld,ls:nod;
         c:integer;
         end;
var v,p,q,r:nod;
    n,u,i,m:integer;
    f:file;
procedure uuu(t:nod);
begin
while t<>nil do begin
t^.c:=t^.c*i;t:=t^.ld;end;end;

procedure ttt(t:nod);
begin
m:=1;
while (t<>nil)or(m>0) do begin
m:=t^.c div 10;t^.c:=t^.c mod 10;
if t^.ld<>nil then begin
t^.ld^.c:=t^.ld^.c+m;end
else if m<>0 then begin new(q);t^.ld:=q;
q^.ls:=t;q^.c:=m;q^.ld:=nil;end;p:=t;t:=t^.ld;end;end;

begin
new(v);
clrscr;write('Numarul:');readln(n);
new(q);q^.c:=1;r:=q;q^.ls:=nil;q^.ld:=nil;
for i:=1 to n do begin
uuu(r);ttt(r);end;
writeln;writeln('Factorial de ',n,' este:');
while p<>nil do begin write(p^.c);p:=p^.ls;
end;readln;
release(v);
end.