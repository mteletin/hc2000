type tip1=string[255];
     tip2=string[20];
     tip3=array[1..1024]of byte;
     tip4=record
          n:tip2;
          nrgr:integer;
          gr:array[1..30]of byte;
          end;
var c1,c:tip1;
    cx,d,v:char;
    nrf,i,j:integer;
    l:array[1..32]of tip4;
    dr:array[1..30]of tip3;

function up(s:tip1):tip1;
var t:tip1;k,j,i:integer;
begin
i:=1;t:='';
if s[1]=' ' then begin
 while s[i]=' ' do i:=i+1;
 end;
k:=i;
if s[k]<>' ' then begin
 while (s[k]<>' ')and(k<=length(s))do k:=k+1;
 k:=k-1;
 end;
for j:=i to k do t:=t+upcase(s[j]);
up:=t;end;

procedure setdrva;
begin
end;

procedure setdrvb;
begin
end;

procedure dird;
begin
end;

procedure era;
var k,u:integer;
begin
if d='A' then begin
              setdrva;
              dird;
         end else
if d='B' then begin
              setdrvb;
              dird;
         end else
if d='C' then begin
              clrscr;
              gotoxy(1,3);
if nrf=0 then writeln('No file(s) on virtual disk.');
u:=0;for k:=1 to nrf do begin
{if th}
u:=u+l[k].nrgr;if k=23 then read(kbd,cx);end;
end;
end;

procedure dir;
var k,u:integer;
begin
if d='A' then begin
              setdrva;
              dird;
         end else
if d='B' then begin
              setdrvb;
              dird;
         end else
if d='C' then begin
              clrscr;
              gotoxy(1,3);
if nrf=0 then writeln('No file(s) on virtual disk.');
u:=0;for k:=1 to nrf do begin
writeln(l[k].n,' --- ',l[k].nrgr*1024,' Kb');
u:=u+l[k].nrgr;if k=23 then read(kbd,cx);end;
writeln('Total free space 30 Kb.');
writeln('Used space:',u,' Kb.');
writeln('Free space:',30-u,' Kb.');
end;
end;

begin
clrscr;d:='A';nrf:=0;
repeat gotoxy(1,1);
write('                                                               ');
gotoxy(1,1);write(d,'>');readln(c1);c:=up(c1);
if c='CLS'     then clrscr                           else
if c='A:'      then d:='A'                           else
if c='B:'      then d:='B'                           else
if c='C:'      then d:='C'                           else
if c='EXIT'    then halt                             else
if c='DIR'     then dir                              else
if c='VER'     then begin
                      gotoxy(1,24);lowvideo;
                      write('Version 1.0 (c) TIM Software Inc.');
                      highvideo;
                    end
   else begin
        for i:=1 to 5 do
        write('                                                               ');
        gotoxy(1,3);writeln(c,' ?');
        writeln('Unknown command or filename.');
end;
until false;
end.