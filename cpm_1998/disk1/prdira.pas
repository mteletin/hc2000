procedure dir;
var g,x,f,s,t,rw,dma,dsk:integer;e:string[8];
procedure rwts(dsk,s,t,rw:byte;dma:integer);
begin
mem[$dd00]:=dsk;mem[$dd01]:=s;mem[$dd02]:=t;
mem[$dd03]:=lo(dma);mem[$dd04]:=hi(dma);
mem[$dd05]:=rw;
{push all}      inline($dd/$e5/$fd/$e5/$e5/$d5/$c5/$f5);
inline($3a/$00/$dd/$4f/$cd/$1b/$d3/$3a/$01/$dd/$4f);
inline($cd/$21/$d3/$3a/$02/$dd/$4f/$cd/$1e/$d3/$3a);
inline($04/$dd/$47/$3a/$03/$dd/$4f/$cd/$24/$d3/$3a);
inline($05/$dd/$fe/$00/$28/$05/$cd/$27/$d3/$28/$03);
inline($cd/$2a/$d3/$00);
{pop all}       inline($f1/$c1/$d1/$e1/$fd/$e1/$dd/$e1);
end;

begin
for s:=0 to 31 do begin dsk:=0;t:=2;rw:=1;dma:=$dc00;
rwts(dsk,s,t,rw,dma);for x:=0 to 3 do begin f:=x*32+12;
if mem[dma+f]=229 then s:=32 else begin
if (mem[dma+f]=0)and(mem[dma+f-12]=0) then begin
e:='';
for g:=1 to 8 do begin f:=g+x*32;
e:=e+chr(mem[dma+f]);end;
write(e,'        ');
end;end;end;end;
end;