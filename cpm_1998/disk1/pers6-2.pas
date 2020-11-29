PROGRAM personal_files;
TYPE tip=char;
VAR c:char;lo,ll,m,n,x,u,y,i,j:integer;
    t:array[0..400,1..64]of char;
    f:text;s,ln,li:string[64];ex:boolean;
    xi,yi,yz,k,p:integer;
    s1,s2,s4:string[62];s3:string[53];s5:string[255];
    ch,c1,c2,c3,c4:char;
    ab,b2,b3,b4:boolean;
    cl:array [0..7] of byte;
    aux:byte;

{$i b:prborder.pas}
{$i b:prcolors.pas}
{$i b:prwindow.pas}

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
read(kbd,c1);c1:=upcase(c1);
if c1='E' then ex:=true
else if c1='S' then savetxt
else if c1='O' then
BEGIN initfile;loadtxt;initx;inity;END
else if c1='A' then
BEGIN initfile;savetxt;END
else if c1='N' then
BEGIN s:='noname.txt';clear;initx;inity;END
else if c1='T' then BEGIN s1:=s;initfile;save;s:=s1;END
else if c1='D' then BEGIN initfile;load;s:=s1;initx;inity;END
else BEGIN ex:=false; END;
END;

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
read(kbd,c);if c<>chr(24) then write(c);gotoxy(1,23);
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
mfile;
until ex;
END;END;

BEGIN
initx;inity;
s:='noname.txt';port[7]:=12;
for k:=0 to 7 do BEGIN cl[k]:=k;
t[0,k+1]:=chr(cl[k]);END;t[0,30]:='0';
writeln;writeln('Personal Editor V6.2 (c) 1996-1997 TIM Software Power .');
assign(f,'PERSINIT.CFG');
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN
border(0);iobord(0);paper(0);ink(7);
writeln('No configuration file found!');
END else
BEGIN for x:=0 to 7 do read(f,cl[x]);close(f);
border(cl[0]);iobord(cl[0]);paper(cl[0]);ink(cl[7]);END;
highvideo;clear;clrscr;
repeat repeat medit;
read(kbd,c1);c1:=upcase(c1);
until ex;
paper(cl[2]);ink(cl[6]);
window(8,20,13,43);ink(cl[4]);
at(9,29);write('Quit ?');
at(11,22);write('Yes              No');
read(kbd,c1);
c1:=upcase(c1);if c1<>'Y' then ex:=false;
until ex;assign(f,'PERSEXIT.CFG');
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
writeln('You just used the Version 6.2');
writeln('See you next time!!!');
END.