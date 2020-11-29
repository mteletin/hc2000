var c:char;f:file of byte;s:string[50];
    sys:array[1..10240]of byte;

CONST conY:integer=$6000;

procedure rwts(dsk,s,t,rw:byte;dma:integer);
begin
mem[$dd00]:=dsk;
mem[$dd01]:=s;
mem[$dd02]:=t;
mem[$dd03]:=lo(dma);
mem[$dd04]:=hi(dma);
mem[$dd05]:=rw;
{push all}      inline($dd/$e5/$fd/$e5/$e5/$d5/$c5/$f5);
inline($3a/$00/$dd/$4f/$cd/$1b/$d3/$3a/$01/$dd/$4f);
inline($cd/$21/$d3/$3a/$02/$dd/$4f/$cd/$1e/$d3/$3a);
inline($04/$dd/$47/$3a/$03/$dd/$4f/$cd/$24/$d3/$3a);
inline($05/$dd/$fe/$00/$28/$05/$cd/$27/$d3/$28/$03);
inline($cd/$2a/$d3/$00);
{pop all}       inline($f1/$c1/$d1/$e1/$fd/$e1/$dd/$e1);
end;

procedure creatsys;
var i,j:integer;
begin
clrscr;
writeln('Copiere sistem pe discheta din fisier.');
write('Nume fisier(nu-esire):');readln(s);
if s<>'nu' then begin
s:=s+'.SYS';
bdos(13);
assign(f,s);reset(f);
for i:=0 to 69 do begin
for j:=0 to 127 do begin
read(f,mem[cony+j]);end;
rwts(0,i,0,0,conY);
end;
close(f);
end;
writeln('Sistemul a fost creat cu succes(smile!...)');
end;

procedure creatfis;
var i,j:integer;
begin
clrscr;
writeln('Copiere in fisier a sistemului.');
write('Nume fisier(nu-esire):');readln(s);
if s<>'nu' then begin
s:=s+'.SYS';
bdos(13);
assign(f,s);rewrite(f);
for i:=0 to 69 do begin
rwts(0,i,0,2,conY);
for j:=0 to 127 do begin
write(f,mem[cony+j]);end;
end;
close(f);
end;
writeln('Fisierul a fost creat cu succes(smile!...)');
end;

procedure copysist;
var i,j:integer;
begin
bdos(13);
clrscr;
writeln('Copiere in fisier a sistemului.');
write('Apasa enter (nu-esire)');readln(s);
if s<>'nu' then begin
for i:=0 to 69 do begin
rwts(0,i,0,2,conY);
for j:=0 to 127 do begin
sys[j+i*128]:=mem[cony+j];end;
end;

writeln('Introdu discul destinatie si apasa enter>');readln;
bdos(13);
for i:=0 to 69 do begin
for j:=0 to 127 do begin
mem[cony+j]:=sys[j+i*128];end;
rwts(0,i,0,0,conY);
end;

end;
writeln('Sistemul a fost creat cu succes(smile!...)');
end;

begin
repeat
clrscr;
writeln('Acest program a fost creat de TIM SOFTWARE 14.04.1998');
writeln('Optiuni');
writeln;
writeln('1.Creare FISIER cu sistemul de operare CP/m');
writeln('2.Creare disc SYSTEM dintr-un fisier dat');
writeln('3.Copiere system de pe un disk pe altul');
writeln('0.SYSTEM(quit)');
write('>');
read(kbd,c);
if c='2' then creatsys;
if c='1' then creatfis;
if c='3' then copysist;
until c='0';
end.