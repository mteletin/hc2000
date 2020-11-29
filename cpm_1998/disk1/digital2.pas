var st:array[1..10]of byte;ln,x:integer;c:char;
s:string[25];f:file of byte;sp:byte;

procedure dir;
var g,x,f,s,t,rw,dma,dsk:integer;e:string[12];y:string[8];

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
if (mem[dma+f]=0)and(mem[dma+f-12]=0) then begin
e:='';for g:=1 to 11 do begin f:=g+x*32;
e:=e+chr(mem[dma+f]);end;
if (e[9]='A')and(e[10]='U')and(e[11]='D')then begin
y:=e;write(y,'        ');end;
end;end;end;
end;

procedure setpar(s,l:integer);begin mem[$c4fe]:=s;
mem[$c4fc]:=l mod 256;mem[$c4fd]:=l div 256;mem[$c4fa]:=$b0;
mem[$c4fb]:=$24;end;

procedure rec;begin
inline($f3);
inline($e5/$c5/$d5/$f5);{ PUSH ALL }
inline($06/$08/$2a/$fa/$c4/$ed/$5b/$fc/$c4);
inline($db/$fe/$cb/$77/$cb/$86/$28/$02/$cb/$c6/$cb/$06);
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e5/$10/$dc);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;

procedure play;begin
inline($f3);
inline($e5/$c5/$d5/$f5);{ PUSH ALL }
inline($06/$08/$2a/$fa/$c4/$ed/$5b/$fc/$c4);
inline($cb/$46/$3e/$38/$cb/$a7/$28/$02/$cb/$e7/$cb/$06/$d3/$fe);
                 {   ^  }
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e3/$10/$da);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;

begin
setpar(1,10000);s:='noname.aud';
repeat clrscr;bdos(13);
dir;repeat
gotoxy(1,23);
writeln('                                               ');
gotoxy(1,21);
writeln('1.Record 2.Play 3.Speed & len(max 32760) 4.Exit');
writeln('5.Save 6.Load Sp:',sp:4,' Len:',ln:6,' ',s:13);
c:=' ';read(kbd,c);if c='3' then begin
write('Ln:');read(ln);write(' Sp:');readln(sp);
setpar(sp,ln);end;if c='1' then rec;if c='2' then play;
if c='5' then begin bdos(13);write('SaveName:');read(s);s:=s+'.aud';
assign(f,s);rewrite(f);write(f,sp);for x:=1 to ln do
write(f,mem[$24af+x]);close(f);end;if c='6' then begin
write('LoadName:');read(s);s:=s+'.aud';assign(f,s);
{$i-} reset(f);{$i+}
if ioresult<>0 then s:='NotFound!'
else begin ln:=0;read(f,sp);while not (eof(f)) do begin
read(f,mem[$24af+ln]);ln:=ln+1;end;end;close(f);setpar(sp,ln);
end;
if c='7' then repeat play;
until (port[254]<>191)and(port[254]<>255);
until (c='4')or(c=chr(13));
until c='4';
end.