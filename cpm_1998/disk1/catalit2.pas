type tip1=string[12];
var fl:array[1..128]of tip1;f1,f2:file;
    k,i,j:integer;n:tip1;c:char;
procedure dir;
var g,x,f,s,t,rw,dma,dsk:integer;e:string[11];
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
i:=1;
for s:=0 to 31 do begin dsk:=0;t:=2;rw:=1;dma:=$dc00;
rwts(dsk,s,t,rw,dma);for x:=0 to 3 do begin f:=x*32+12;
if mem[dma+f]=229 then s:=32 else begin
if (mem[dma+f]=0)and(mem[dma+f-12]=mem[4]div 16) then begin
e:='';
for g:=1 to 11 do begin f:=g+x*32;
e:=e+chr(mem[dma+f]);end;
if ((e[9]='C')and(e[10]='O'))and(e[11]='M')then begin
fl[i]:='';for g:=1 to 8 do if e[g]<>' ' then fl[i]:=fl[i]+e[g];
fl[i]:=fl[i]+'.COM';i:=i+1;end else fl[i]:='';
end;end;end;end;
end;

begin
dir;i:=i-1;
randomize;n:=fl[mem[$105]mod i+1];
mem[$105]:=mem[$105];
write('>',i,'< ',n,' ',k);
assign(f1,n);rewrite(f1);
blockwrite(f1,mem[$100],75);write(n,' too large!');
close(f1);write('BDOS error loading file');read(kbd,c);
end.