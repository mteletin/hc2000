program main;

{$i prwindow.pas}
{$i prmenus.pas}
{$i prcolors.pas}
{$i prborder.pas}
{$i prcursor.pas}
{$i prclick.pas}

procedure exit;
begin
paper(1);ink(6);clrscr;border(0);iobord(0);
bdos(13);halt; {deocamdata}
end;

var a:mnu;
    i,j,k,b:integer;
    c:char;
    s:str;

procedure blanc;
begin
{push all} inline($dd/$e5/$fd/$e5/$e5/$d5/$c5/$f5);
           inline($f3/$3e/$ee/$d3/$c5/$21/$00/$d8);
           inline($11/$00/$03/$36/$38/$23/$1b/$7a);
           inline($b3/$20/$f8/$3e/$ee/$d3/$c7/$fb);
{pop  all} inline($f1/$c1/$d1/$e1/$fd/$e1/$dd/$e1);
end;

procedure dir(dsk:byte);
var g,x,f,s,t,rw,dma:integer;e:string[8];
procedure rwts(dsk,s,t,rw:byte;dma:integer);
begin

mem[$dd00]:=dsk;mem[$dd01]:=s;mem[$dd02]:=t;
mem[$dd03]:=lo(dma);mem[$dd04]:=hi(dma);
mem[$dd05]:=rw;
{push all}      inline($dd/$e5/$fd/$e5/$e5/$d5/$c5/$f5);

inline($f3/$3e/$ee/$d3/$c5/$21/225/$da/$36/$00);
inline($3e/$ee/$d3/$c7/$fb);

inline($3a/$00/$dd/$4f/$cd/$1b/$d3/$3a/$01/$dd/$4f);
inline($cd/$21/$d3/$3a/$02/$dd/$4f/$cd/$1e/$d3/$3a);
inline($04/$dd/$47/$3a/$03/$dd/$4f/$cd/$24/$d3/$3a);
inline($05/$dd/$fe/$00/$28/$05/$cd/$27/$d3/$28/$03);
inline($cd/$2a/$d3/$00);

inline($f3/$3e/$ee/$d3/$c5/$21/225/$da/$36/$38);
inline($3e/$ee/$d3/$c7/$fb);

{pop all}       inline($f1/$c1/$d1/$e1/$fd/$e1/$dd/$e1);
end;

begin
bdos(13);
for s:=0 to 31 div(dsk+1) do begin rw:=1;dma:=$dc00;t:=2-dsk;
rwts(dsk,s,t,rw,dma);for x:=0 to 3 do begin f:=x*32+12;
if mem[dma+f]=229 then s:=32 else begin
if ((mem[dma+f]=0)or((mem[dma+f]=1)and(dsk=1)))
and(mem[dma+f-12]=mem[4]div 16) then begin
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
  assign(f,'$$$.sub');
  begin rewrite(f);mem[$dd00]:=length(s);s:=s+chr(0)+'$';
for i:=1 to length(s) do mem[$dd00+i]:=ord(s[i]);
blockwrite(f,mem[$dd00],1);close(f);exit;end;end;

procedure typef(s:str);
var f:file;i,k:integer;c:char;
begin
k:=0;
assign(f,s);{$i-} reset(f);{$i+}
if ioresult<>0 then begin
option(1,20,1,'Error:can not view file because doesn''t exists!');
delay(300);
option(1,20,0,'Error:can not view file because doesn''t exists!');
end else begin write('File:',s);
while not(eof(f)) do begin blockread(f,mem[$dd00],1);
for i:=1 to 128 do if mem[$dcff+i]<>26 then begin
write(chr(mem[$dcff+i]));if mem[$dcff+i]=10 then k:=k+1;
if k mod 20=19 then begin read(kbd,c);k:=k+1;end;end;
end;end;end;

procedure dirop;
var m:string[2];
begin
b:=5;
repeat
m:=chr(65+mem[4] mod 16)+'>';
a[1]:=m+'dir a:';
a[2]:=m+'dir b:';
a[3]:=m+'cls';
a[4]:=m+'user ...';
a[5]:=m+'a:';
a[6]:=m+'b:';
a[7]:='<exit>';
paper(6);ink(1);
b:=menu(33,1,7,b,a);paper(7);ink(0);highvideo;
if (b<>0)and(b<>7) then bdos(13);
case b of
1:begin for i:=10 to 24 do begin
  gotoxy(1,i);write('                                                               ');
  end;gotoxy(1,10);dir(0);end;
2:begin for i:=10 to 24 do begin
  gotoxy(1,i);write('                                                               ');
  end;gotoxy(1,10);dir(1);end;
3:for i:=10 to 24 do begin
  gotoxy(1,i);write('                                                               ');
  end;
4:begin paper(5);ink(2);
  window(2,3,4,12);gotoxy(5,4);write('User:');read(i);
  mem[4]:=mem[4]mod 16+16*i;paper(7);ink(0);end;
5:begin bdos(13);mem[4]:=(mem[4]div 16)*16;end;
6:begin bdos(13);bdos(14,1);mem[4]:=(mem[4]div 16)*16+1;end;
end;
until (b=7)or(b=0);
end;

procedure progs;
begin
b:=1;
repeat
a[1]:='Turbo Pascal 4.4';
a[2]:='Word Star';
a[3]:='Power (FILE OPERATIONS)';
a[4]:='File Manager ''97';
a[5]:='ZSID assembler debugger';
a[6]:='Personal 7.0';
a[7]:='Digital recordings 2.1';
a[8]:='CP/M Help manual';
a[9]:='<exit>';paper(5);ink(1);
b:=menu(27,4,9,b,a);paper(7);ink(1);highvideo;
case b of
1:runf('a:turbo');
2:runf('a:ws');
3:runf('a:power');
4:runf('a:fm2');
5:runf('a:zsid');
6:runf('a:pers7-0');
7:begin mem[4]:=mem[4]mod 16+16;bdos(13);runf('a:digital2');end;
8:begin mem[4]:=mem[4]mod 16+16*3;bdos(13);runf('a:help');end;
end;
until (b=0)or(b=9);
end;

procedure diskop;
begin
b:=1;
repeat
a[1]:='Disk Interchange Program';
a[2]:='Disk utilitar';
a[3]:='Format';
a[4]:='System generator';
a[5]:='Stat';
a[6]:='<exit>';paper(4);ink(2);
b:=menu(21,7,6,b,a);paper(7);ink(0);highvideo;
case b of
1:runf('a:dip');
2:runf('a:du');
3:begin mem[4]:=mem[4]mod 16+16*5;bdos(13);runf('a:format '+chr(65+mem[4]mod 16));end;
4:begin mem[4]:=mem[4]mod 16+16*5;bdos(13);runf('a:sysgen');end;
5:runf('a:stat');
end;
until (b=0)or(b=6);
end;

begin
repeat
border(7);iobord(7);blanc;paper(7);ink(0);
option(4,1,0,'DIRECTORY OPERATIONS');
option(5,4,0,'FILE OPERATIONS POWER');
option(6,7,0,'PROGRAMS');
option(7,10,0,'DISK');
option(8,13,0,'EXIT TO SYSTEM');
i:=1;j:=1;
repeat
case j of
1:option(4,1,0,'DIRECTORY OPERATIONS');
2:option(5,4,0,'FILE OPERATIONS POWER');
3:option(6,7,0,'PROGRAMS');
4:option(7,10,0,'DISK');
5:option(8,13,0,'EXIT TO SYSTEM');
end;
case i of
1:option(4,1,1,'DIRECTORY OPERATIONS');
2:option(5,4,1,'FILE OPERATIONS POWER');
3:option(6,7,1,'PROGRAMS');
4:option(7,10,1,'DISK');
5:option(8,13,1,'EXIT TO SYSTEM');
end;highvideo;
read(kbd,c);
if c=chr(5) then if i>1 then begin j:=i;i:=i-1;end;
if c=chr(24) then if i<5 then begin j:=i;i:=i+1;end;
until (c=chr(13))or(c=chr(27));
case i of
1:dirop;
2:begin runf('power');exit;end;
3:progs;
4:diskop;
5:exit;
end;
until false;

end.