type str=string[128];

procedure dir(dsk:byte);
var g,x,f,s,t,rw,dma:integer;e:string[8];
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
for s:=0 to 31 div(dsk+1) do begin rw:=1;dma:=$dc00;t:=2-dsk;
rwts(dsk,s,t,rw,dma);for x:=0 to 3 do begin f:=x*32+12;
if mem[dma+f]=229 then s:=32 else begin
if (mem[dma+f]=0)and(mem[dma+f-12]=0) then begin
e:='';write('');
for g:=1 to 8 do begin f:=g+x*32;
e:=e+chr(mem[dma+f]);end;
write(e,'.');
e:='';
for g:=9 to 11 do begin f:=g+x*32;
e:=e+chr(mem[dma+f]);end;
write(e);
write('  ');
end;end;end;end;
end;

procedure runf(s:str);
var f:file;i:integer;
begin
  bdos(13);assign(f,'$$$.sub');{$i-} reset(f);{$i+}
  if ioresult=0 then write('Error:can not run file because $$$.SUB file is present on disk!')
  else begin rewrite(f);mem[$dd00]:=length(s);s:=s+chr(0)+'$';
for i:=1 to length(s) do mem[$dd00+i]:=ord(s[i]);
blockwrite(f,mem[$dd00],1);close(f);end;end;

procedure typef(s:str);
var f:file;i,k:integer;c:char;
begin
k:=0;
assign(f,s);{$i-} reset(f);{$i+}
if ioresult<>0 then write('Error:can not view file because does''n exists!')
else begin write('File:',s);
while not(eof(f)) do begin blockread(f,mem[$dd00],1);
for i:=1 to 128 do if mem[$dcff+i]<>26 then begin
write(chr(mem[$dcff+i]));if mem[$dcff+i]=10 then k:=k+1;
if k mod 20=19 then begin read(kbd,c);k:=k+1;end;end;
end;end;end;

{begin
dir(0);
writeln;
dir(1);
writeln;
runf('a:turbo');
writeln;
typef('b:prdira.pas');
end.}