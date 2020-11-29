CONST ADDR:integer=$2050;
      b:array[1..11]of integer=(2,1,3,4,5,4,3,2,1,5,4);
      c:array[1..11]of integer=(8,8,8,4,4,4,4,4,2,2,1);
TYPE tip1=string[30];
VAR f:file of byte;
    j,l,i:integer;s:byte;
    a:array[1..5]of integer;
    h:char;
procedure setpar(s:byte;l:integer);begin mem[$c4fe]:=s;
mem[$c4fc]:=l mod 256;mem[$c4fd]:=l div 256;mem[$c4fa]:=0;
mem[$c4fb]:=$22;end;

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
             {      ^colour     }
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e3/$10/$da);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;

procedure load(st:tip1;k:integer);
begin
assign(f,st);
reset(f);
read(f,s);
l:=0;
while not(eof(f)) do begin
read(f,mem[addr+l]);l:=l+1;end;
a[k]:=addr;
addr:=addr+l;
end;

begin
load('Part1.aud',1);
load('Part2.aud',2);
load('Part3.aud',3);
load('Part4.aud',4);
load('Part5.aud',5);
setpar(4,7615);
repeat
for j:=1 to 11 do begin
addr:=a[b[j]];
mem[$c4fa]:=lo(addr);
mem[$c4fb]:=hi(addr);
for i:=1 to c[j] do play;
end;
clrscr;write('Repeat(Y/N):');
read(kbd,h);write(h);
until upcase(h)<>'Y';
end.