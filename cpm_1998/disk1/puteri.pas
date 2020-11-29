program puteri;
type nod=^art;
     art=record
         ld,ls:nod;
         c:integer;
         end;
var p,q,r:nod;
    n,u,i,m:integer;
procedure uuu(t:nod);
begin
while t<>nil do begin
t^.c:=t^.c*n;t:=t^.ld;end;end;
procedure ttt(t:nod);
begin while t<>nil do begin
m:=t^.c div 10;t^.c:=t^.c mod 10;
if t^.ld<>nil then begin
t^.ld^.c:=t^.ld^.c+m;end
else if m<>0 then begin new(q);t^.ld:=q;
q^.ls:=t;q^.c:=m;q^.ld:=nil;end;p:=t;t:=t^.ld;end;end;
begin
clrscr;write('Numarul:');readln(n);
write('Puterea:');readln(u);
new(q);q^.c:=1;r:=q;q^.ls:=nil;q^.ld:=nil;
for i:=1 to u do begin
uuu(r);ttt(r);end;
writeln;writeln('Numarul ',n,' la puterea ',u,' este:');
while p<>nil do begin write(p^.c);p:=p^.ls;
end;readln;end.