PROGRAM personal_files;
TYPE tip=char;
VAR fm:file of byte;
    f,ft:text;
    c:char;
    aux,spe:byte;
    cl:array [0..7] of byte;
    lni,lo,ll,m,n,x,u,y,i,j,xi,yi,yz,k,p:integer;
    s,ln,li:string[64];
    mz,s1,s2,s4:string[62];
    s3:string[53];
    s5:string[255];
    ch,c1,c2,c3,c4:char;
    ex,ab,b2,b3,b4:boolean;
    t:array[0..400,1..64]of char;

{$i prmusic1.pas}
{$i priocrt.pas}
{$i prbeep.pas}
{$i prborder.pas}
{$i prcursor.pas}
{$i prcolors.pas}
{$i prwindow.pas}

PROCEDURE at(x,y:integer);
BEGIN
gotoxy(y+1,x+1);
END;

PROCEDURE ct;VAR i:integer;s:string[255];
BEGIN fillchar(s,128,' ');for i:=8 to 17 do begin
gotoxy(1,i);write(s);gotoxy(1,25-i);write(s,s);end;end;
PROCEDURE initx;BEGIN x:=1;i:=1;END;
PROCEDURE inity;BEGIN y:=2;j:=1;END;
PROCEDURE initfile;BEGIN ink(cl[2]);paper(cl[6]);
window(4,6,7,23);gotoxy(9,6);ink(cl[3]);write('Filename:');
gotoxy(10,7);ink(cl[1]);write('-');read(s);END;
PROCEDURE writelin(k:byte);var i:byte;BEGIN
for i:=1 to 64 do write(t[k,i]);END;
PROCEDURE scrollup;BEGIN if j<350 then BEGIN
gotoxy(1,2);delline;gotoxy(1,23);writelin(j+1);END
else j:=j-1;END;
PROCEDURE scrolldown;BEGIN if j>0 then BEGIN
gotoxy(1,2);write(chr(27),chr(26));
gotoxy(1,2);writelin(j);END else j:=j+1;END;
PROCEDURE incy;BEGIN if y<22 then BEGIN y:=y+1;j:=j+1;END
else BEGIN j:=j+1;scrollup;END;END;
PROCEDURE decx;BEGIN x:=x-1;i:=i-1;END;
PROCEDURE letx;BEGIN x:=64;i:=64;END;
PROCEDURE incx;BEGIN x:=x+1;i:=i+1;END;
PROCEDURE decy;BEGIN if y>2 then BEGIN y:=y-1;j:=j-1;END
else BEGIN j:=j-1; scrolldown;END;END;
PROCEDURE clear;var u,p:integer;
BEGIN paper(cl[1]);ink(cl[4]);window(19,2,21,27);
gotoxy(3,21);paper(cl[2]);write('Clearing:');paper(cl[1]);
ink(cl[5]);for u:=1 to 400 do BEGIN
gotoxy(12+u div 27,21);write('');for p:=1 to 64 do
t[u,p]:=chr(32);END;initx;inity;ink(cl[7]);END;
PROCEDURE tex;
BEGIN paper(cl[0]);ink(cl[7]);border(cl[0]);
for u:=0 to 21 do BEGIN gotoxy(1,u+2);writelin(j+u-y+2);END;
END;
PROCEDURE save;
var f:file of tip;
    x,y:integer;
BEGIN
gotoxy(1,24);write('Saving the file ... ',s);
highvideo;gotoxy(1,10);
assign(f,s);
{$i-}
rewrite(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,39);gotoxy(19,10);ink(cl[5]);
write('FILE NOT CREATED');gotoxy(17,11);
write('Could not create file');gotoxy(17+length(s) div 2,12);
lowvideo;write(s);highvideo;read(kbd,c);END
else BEGIN
for x:=0 to j do
for y:=1 to 64 do
write(f,t[x,y]);close(f);
END;END;
PROCEDURE load;
var f:file of tip;
    x,y,m:integer;
BEGIN
gotoxy(1,24);write('Loading the file ... ',s);
clear;assign(f,s);
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,36);gotoxy(18,10);ink(cl[5]);
write('FILE NOT FOUNDED');gotoxy(17,11);
write('Could not find file');gotoxy(17+length(s) div 2,12);
lowvideo;write(s);highvideo;read(kbd,c);END
else BEGIN
x:=0;y:=1;
while not eof(f) do BEGIN
read(f,t[x,y]);if (ord(t[x,y])>31)or(x=0) then BEGIN
y:=y+1;if y>64 then BEGIN y:=1;x:=x+1;END;END;
END;ll:=x;for m:=1 to 64 do BEGIN cl[m-1]:=ord(t[0,m]);END;
j:=1;END;END;

PROCEDURE savetxt;
var tu,x,y,mu,ni:integer;
BEGIN
gotoxy(1,24);write('Saving the file ... ',s);
highvideo;
assign(f,s);
{$i-}
rewrite(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,39);gotoxy(19,10);ink(cl[5]);
write('FILE NOT CREATED');gotoxy(17,11);
write('Could not create file');gotoxy(17+length(s) div 2,12);
lowvideo;write(s);highvideo;read(kbd,c);END
else BEGIN
for x:=1 to j do BEGIN ni:=64;tu:=1;
for mu:=64 downto 1 do if t[x,mu]<>' 'then
if tu=0 then begin ni:=mu;tu:=1;END;
for y:=1 to ni do
write(f,t[x,y]);writeln(f);END;
close(f);END;END;

PROCEDURE loadtxt;
var x,y:integer;
BEGIN
gotoxy(1,24);write('Loading the file ... ',s);
clear;assign(f,s);
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,36);gotoxy(18,10);ink(cl[5]);
write('FILE NOT FOUNDED');gotoxy(17,11);
write('Could not find file');gotoxy(17+length(s) div 2,12);
lowvideo;write(s);highvideo;read(kbd,c);END
else BEGIN x:=1;
while not eof(f) do BEGIN y:=1;readln(f,ln);
for lo:=1 to length(ln) do BEGIN
if y>64 then BEGIN y:=1;x:=x+1;END;
t[x,y]:=ln[y];y:=y+1;END;x:=x+1;j:=1;
END;END;END;

PROCEDURE main;BEGIN paper(cl[0]);highvideo;ink(cl[7]);at(23,0);
lowvideo;write('(C) 1996 TIM Software Entertainment. TurboPascal compiler 4.4 ');
paper(cl[0]);ink(cl[0]);at(0,0);iobord(cl[0]);
write('                                                              ');
paper(cl[5]);ink(cl[1]);at(0,0);write('F');highvideo;
write('ile ');lowvideo;write('O');highvideo;write('ptions ');
lowvideo;write('H');highvideo;write('elp ');lowvideo;
write('E');highvideo;write('dit ');paper(cl[1]);ink(cl[5]);
tex;
at(1,25);lowvideo;write(s);highvideo;
at(0,30);paper(cl[0]);write('                                 ');
at(0,40);paper(cl[2]);ink(cl[6]);write('Command:');END;

PROCEDURE mfile;BEGIN
paper(cl[2]);ink(cl[6]);at(0,0);highvideo;write('File');
paper(cl[5]);ink(cl[1]);highvideo;window(1,0,9,11);
at(2,1);lowvideo;write('O');
ink(cl[2]);highvideo;write('pen');ink(cl[1]);
at(3,1);lowvideo;write('N');
ink(cl[2]);highvideo;write('ew ');ink(cl[1]);
at(4,1);lowvideo;write('S');ink(cl[2]);highvideo;write('ave');
ink(cl[1]);
at(5,1);write('Save ');lowvideo;ink(cl[2]);write('A');
ink(cl[1]);highvideo;
write('s...');
at(6,1);lowvideo;write('E');ink(cl[2]);
write('xit');ink(cl[1]);highvideo;at(7,1);
write('Save-');lowvideo;write('T');highvideo;
at(8,1);write('Loa');lowvideo;write('d');highvideo;write('-T');
at(0,30);paper(cl[0]);highvideo;write('                                 ');
at(0,40);paper(cl[3]);ink(cl[7]);write('Command:');c1:=readkey;
c1:=upcase(c1);
if c1='E' then ex:=true
else if c1='S' then
BEGIN
savetxt;
END
else if c1='O' then
BEGIN
at(0,30);paper(cl[0]);write('                                 ');
at(0,40);
paper(cl[1]);ink(cl[6]);
{write('Filename:');read(s);} initfile;
loadtxt;initx;inity;
END
else if c1='A' then
BEGIN
at(0,30);paper(cl[0]);write('                                 ');
at(0,40);
paper(cl[1]);ink(cl[6]);
{write('Filename:');read(s);} initfile;
savetxt;
END
else if c1='N' then
BEGIN
s:='noname.txt';clear;initx;inity;
END
else if c1='T' then BEGIN
at(0,40);
paper(cl[1]);ink(cl[6]);s1:=s;
{write('Filename:');read(s);} initfile;
save;s:=s1;END
else if c1='D' then BEGIN
at(0,40);
paper(cl[1]);ink(cl[6]);
{write('Filename:');read(s);} initfile;
load;s:=s1;initx;inity;END
else BEGIN ex:=false; END;
END;

PROCEDURE moptions;
BEGIN
paper(cl[2]);ink(cl[6]);at(0,5);write('Options');
highvideo;
paper(cl[0]);ink(cl[4]);
window(1,4,6,16);
ink(cl[5]);at(2,6);
lowvideo;write('S');
highvideo;write('et colors');
at(3,6);lowvideo;write('P');highvideo;write('assword');
at(4,6);lowvideo;write('L');highvideo;write('ock');
at(5,6);lowvideo;write('U');highvideo;write('nlock');
paper(cl[1]);ink(cl[4]);at(0,40);
write('Command:');paper(cl[0]);write('       ');
at(0,48);c1:=readkey;
at(0,40);paper(cl[0]);write('                     ');
c1:=upcase(c1);
if c1='S' then
BEGIN
paper(cl[0]);ink(cl[5]);
window(4,2,11,58);
repeat
for i:=0 to 7 do
BEGIN
paper(i);ink(7-i);
at(5,i*4+4);write('    ');
at(6,i*4+4);write('  ',i,' ');
at(8,i*4+4);paper(cl[i]);ink(cl[7-i]);write('    ');
at(9,i*4+4);write('  ',i,' ');
END;
at(7,8);paper(cl[1]);ink(cl[7]);
write('Original set of colours...');
at(10,8);write('Changed set of colours...');
paper(cl[0]);ink(cl[7]);
at(5,44);write('=MENU=');
at(6,40);write('1.Change colours');
at(7,40);write('2.Leave unchanged');
at(8,40);write('3.Reset colours');
at(9,40);write('4.Monochrome');
at(10,44);write('>');c2:=readkey;
if c2='3' then for k:=0 to 7 do cl[k]:=k
else if c2='1' then
BEGIN
repeat
at(10,40);write('Change:');read(k);
until (k>-1) and (k<8);
at(10,40);write('           ');
repeat
at(10,40);write('With:');read(p);
until (i>-1) and (i<8);
aux:=cl[k];cl[k]:=cl[p];cl[p]:=aux;
END
else if c2='4' then BEGIN for p:=0 to 3 do cl[p]:=0;
for p:=4 to 7 do cl[p]:=7;END;
at(10,40);paper(cl[0]);ink(cl[7]);write('           ');
until ((c2<>'1') and (c2<>'3')) and (c2<>'4');
for k:=0 to 7 do t[0,k+1]:=chr(cl[k]);border(cl[0]);iobord(cl[0]);
END
else if c1='P' then
BEGIN
paper(cl[7]);ink(cl[0]);
window(4,2,9,30);
ink(cl[1]);at(5,3);lowvideo;write('A');
highvideo;write('ctivate Password');
at(6,3);lowvideo;write('N');highvideo;write('one');
at(7,3);write('Password is ');
if t[0,9]='1' then write('active.')
 else
 BEGIN
  write('not present.');
 END;
at(8,3);lowvideo;write('S');
highvideo;write('et password (19chr).');
at(0,40);paper(cl[1]);ink(cl[7]);write('              ');
at(0,40);write('Command:');c4:=readkey;
c4:=upcase(c4);
if c4='A' then t[0,9]:='1';
if c4='N' then if t[0,9]<>'1' then
for k:=9 to 30 do t[0,k]:=' '
else BEGIN
at(0,30);write('*Error* (press RETURN)');beep;
readln;
END;
if c4='S' then if t[0,9]='1'
then BEGIN
at(0,40);write('               ');
at(0,30);
paper(cl[0]);ink(cl[6]);write('Old password:');read(s3);
b3:=true;
for i:=1 to length(s3) do
if (s3[i]<>t[0,i+9]) then b3:=false;
if (i=ord(t[0,28]))and b3 then t[0,9]:='0';
at(0,40);write('               ');
END
else
BEGIN
at(0,40);write('                 ');
at(0,30);write('New password:');read(s3);
t[0,9]:='0';for k:=1 to length(s3) do t[0,k+9]:=s3[k];
t[0,28]:=chr(length(s3));
END;
END
else if c1='L' then
BEGIN
t[0,30]:='1';
END
else if c1='U' then
BEGIN
if t[0,9]='1' then BEGIN
at(0,30);write('Invalid!(press RETURN)');
beep;readln;END
else t[0,30]:='0';
END;
paper(cl[2]);ink(cl[4]);
END;

PROCEDURE mhelp;var f:text;BEGIN at(0,13);
paper(cl[3]);ink(cl[6]);write('HELP');assign(f,'personal.hlp');
{$i-}
reset(f);
{$i+}
if ioresult=0 then BEGIN
paper(cl[0]);ink(cl[6]);window(7,0,18,63);ink(cl[4]);
window(19,0,22,40);ink(cl[7]);at(20,2);write('=HELP=MENU= ');
at(21,2);ink(cl[5]);lowvideo;write('N');highvideo;
write('ext page  ');lowvideo;
write('Q');highvideo;write('uit this menu  ');
repeat i:=8;
repeat readln(f,s3);
if s3[1]<>'.' then BEGIN paper(cl[0]);ink(cl[5]);at(i,5);
write(s3);i:=i+1;END;
until ((i=19) or (s3[1]='.')) or eof(f);
repeat at(21,30);write('          ');
lowvideo;at(21,30);write('>');c1:=readkey;highvideo;
c1:=upcase(c1);
until (c1='N') or (c1='Q');
until (c1='Q') or eof(f);
close(f);
END;END;

PROCEDURE medit;
BEGIN
if t[0,9]='1' then BEGIN
gotoxy(40,1);write('Password is present...');delay(1000);
END else BEGIN ink(cl[7]);paper(cl[0]);
ll:=1;li:='';for n:=1 to 63 do li:=li+chr(127);
ex:=false;
repeat tex;
lowvideo;write('  Row:',x,' Line:',j,'  File:',s,'          ');
highvideo;
repeat gotoxy(x,y);
c:=readkey;gotoxy(1,23);
if (ord(c)>31) then BEGIN
t[j,x]:=c;incx;END;
if c=chr(19) then decx;
if c=chr(24) then incy;
if c=chr(5) then decy;
if c=chr(4) then incx;
if c=chr(13) then BEGIN initx;
if y<23 then incy
else scrollup;END;
if x>64 then BEGIN initx;incy;END;
if x<1 then if y>1 then BEGIN letx;decy;END;
gotoxy(1,23);if ll<j then ll:=j;
gotoxy(1,24);lowvideo;
write(ord(c),' Row:',x,' Line:',j,'  File:',s,'          ');
highvideo;
until c=chr(27);
repeat
lowvideo;
gotoxy(1,24);
write('1.Name 2.Sav 3.Load 4.Ed 5.Clr 6.Quit 7.S-Txt 8.L-Txt');
c:=readkey;
case c of
'5':clear;
'6':ex:=true;
'3':BEGIN gotoxy(1,24);write(li);gotoxy(1,24);
write(' Name:');read(s);load;END;
'1':BEGIN gotoxy(1,24);write(li);gotoxy(1,24);
write(' Name:');read(s);END;
'2':save;
'7':savetxt;
'8':BEGIN gotoxy(1,24);write(li);gotoxy(1,24);
write(' Name:');read(s);loadtxt;END;
END;
until (c=chr(27))or(c='4')or ex;
highvideo;
until ex;
END;END;

BEGIN
initx;inity;
s:='noname.txt';port[7]:=12;
for k:=0 to 7 do BEGIN cl[k]:=k;
t[0,k+1]:=chr(cl[k]);END;t[0,30]:='0';
writeln;writeln('Personal Editor V6.0 (c) 1996-1997 TIM Software Power .');

assign(f,'PERSINIT.CFG');
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN
border(0);iobord(0);paper(0);ink(7);
writeln('No configuration file found!');
END else
BEGIN for x:=0 to 7 do read(f,cl[x]);close(f);
border(cl[0]);iobord(cl[0]);paper(cl[0]);ink(cl[7]);clrscr;END;

assign(f,'persaudi.cfg');
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN
border(0);iobord(0);paper(0);ink(7);
writeln('No music configuration file found!');
END else BEGIN
readln(f,mz);assign(fm,mz);
{$i-} reset(fm);
{$i+}
if ioresult<>0 then BEGIN writeln('Error in PERSAUDI.CFG file.');
writeln('File ',mz,' does not exist! Music is off the menu');
END
else begin lni:=0;read(fm,spe);while not (eof(fm)) do begin
read(fm,mem[$5700+lni]);lni:=lni+1;end;setpar(lni,spe);
play;end;close(fm);
END;
highvideo;clear;clrscr;
repeat repeat ex:=false;main;repeat
at(0,48);c1:=readkey;c1:=upcase(c1);
until (c1<>chr(26))and((((c1='O')or(c1='H'))or(c1='F'))or(c1='E'));
if c1='F' then mfile
   else if c1='O' then moptions
   else if c1='H' then mhelp
   else if c1='E' then begin medit;ex:=false;end
until ex;beep;
paper(cl[2]);ink(cl[6]);
window(8,20,13,43);ink(cl[4]);
at(9,29);write('Quit ?');
at(11,22);write('Yes              No');
at(12,31);write('>');repeat c1:=readkey;until c1<>'';
c1:=upcase(c1);if c1<>'Y' then ex:=false;
until ex;beep;
assign(f,'PERSEXIT.CFG');
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN clrscr;
border(0);iobord(0);paper(0);ink(7);clrscr;
writeln('No configuration file found!');
END else
BEGIN for x:=0 to 7 do read(f,cl[x]);close(f);
border(cl[0]);iobord(cl[0]);paper(cl[0]);ink(cl[7]);clrscr;END;
writeln('Copyright 1996-1997 TIM SOFTWARE POWER ENTERTAINMENT ');
writeln('See you next time!!!');
END.