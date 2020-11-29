PROGRAM personal_files;
TYPE tip=char;
VAR c:char;lo,ll,m,n,x,u,y,i,j:integer;
    t:array[0..400,1..64]of char;
    f1,f:text;s,ln,li:string[64];ex:boolean;
    xi,yi,yz,k,p:integer;
    s1,s2,s4:string[62];s3:string[53];s5:string[255];
    ch,c1,c2,c3,c4:char;
    ab,b2,b3,b4:boolean;
    cl:array [0..7] of byte;
    aux:byte;
procedure at(x,y:integer);var a,b,c,d:char;begin a:=chr(27);
b:=chr(65);c:=chr(x+32);d:=chr(y+32);write(f1,a,b,c,d);end;
procedure cls;var c:char;begin c:=chr(24);write(f1,c);end;
procedure gotoxy(x,y:integer);begin at(y-1,x-1);end;
procedure iobord(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(82);c:=chr(32+x);write(f1,a,b,c);end;
procedure border(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(81);c:=chr(48+x);write(f1,a,b,c);end;
procedure ink(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(73);c:=chr(48+x);write(f1,a,b,c);end;
procedure paper(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(80);c:=chr(48+x);write(f1,a,b,c);end;
procedure set1;var a,b,c:char;begin
a:=chr(27);b:=chr(113);write(f1,a,b);end;
procedure set2;var a,b,c:char;begin
a:=chr(27);b:=chr(112);write(f1,a,b);end;

procedure window(x,y,xx,yy:integer);var k:integer;a:char;
s:string[66];begin if x<xx then if y<yy then begin set2;s:='';
x:=x+1;y:=y+1;xx:=xx+1;yy:=yy+1;
for k:=y+1 to yy-1 do s:=s+' ';gotoxy(y,x);a:=chr(42);
write(f1,a);a:=chr(39);for k:=y+1 to yy-1 do begin gotoxy(k,x);
write(f1,a);gotoxy(k,xx);write(f1,a);end;a:=chr(34);gotoxy(yy,x);
write(f1,a);a:=chr(32);for k:=x+1 to xx-1 do begin gotoxy(y,k);
set2;write(f1,a);set1;write(f1,s);set2;gotoxy(yy,k);write(f1,a);end;
a:=chr(35);gotoxy(y,xx);write(f1,a);a:=chr(41);gotoxy(yy,xx);
write(f1,a);set1;end;end;
PROCEDURE ldf;forward;

PROCEDURE ct;VAR i:integer;s:string[255];
BEGIN fillchar(s,128,' ');for i:=8 to 17 do begin
gotoxy(1,i);write(f1,s);gotoxy(1,25-i);write(f1,s,s);end;end;
PROCEDURE initx;BEGIN x:=1;i:=1;END;
PROCEDURE inity;BEGIN y:=2;j:=1;END;
PROCEDURE initfile;BEGIN ink(cl[2]);paper(cl[6]);
window(4,6,7,23);gotoxy(9,6);ink(cl[3]);write(f1,'Filename:');
gotoxy(10,7);ink(cl[1]);write(f1,'-');read(s);END;
PROCEDURE writelin(k:byte);var i:byte;BEGIN
for i:=1 to 64 do write(f1,t[k,i]);END;
PROCEDURE scrollup;BEGIN if j<350 then BEGIN
gotoxy(1,2);delline;gotoxy(1,23);writelin(j+1);END
else j:=j-1;END;
PROCEDURE scrolldown;BEGIN if j>0 then BEGIN
gotoxy(1,2);write(f1,chr(27),chr(26));
gotoxy(1,2);writelin(j);END else j:=j+1;END;
PROCEDURE incy;BEGIN if y<22 then BEGIN y:=y+1;j:=j+1;END
else BEGIN j:=j+1;scrollup;END;END;
PROCEDURE decx;BEGIN x:=x-1;i:=i-1;END;
PROCEDURE letx;BEGIN x:=64;i:=64;END;
PROCEDURE incx;BEGIN x:=x+1;i:=i+1;END;
PROCEDURE decy;BEGIN if y>2 then BEGIN y:=y-1;j:=j-1;END
else BEGIN j:=j-1; scrolldown;END;END;
PROCEDURE clear;var u,p:integer;
BEGIN paper(cl[1]);ink(cl[4]);window(12,17,4,55);
gotoxy(21,14);paper(cl[2]);write(f1,'Clearing:');paper(cl[1]);
ink(cl[5]);for u:=1 to 400 do BEGIN
gotoxy(29+u div 17,14);write(f1,'');for p:=1 to 64 do
t[u,p]:=chr(32);END;initx;inity;ink(cl[7]);END;
PROCEDURE tex;
BEGIN paper(cl[0]);ink(cl[7]);border(cl[0]);
for u:=0 to 21 do BEGIN gotoxy(1,u+2);writelin(j+u-y+2);END;
END;
PROCEDURE save;
var f:file of tip;
    x,y:integer;
BEGIN
gotoxy(1,24);write(f1,'Saving the file ... ',s);
highvideo;gotoxy(1,10);
assign(f,s);
{$i-}
rewrite(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,39);gotoxy(19,10);ink(cl[5]);
write(f1,'FILE NOT CREATED');gotoxy(17,11);
write(f1,'Could not create file');gotoxy(17+length(s) div 2,12);
lowvideo;write(f1,s);highvideo;read(kbd,c);END
else BEGIN
for x:=0 to 256 do write(f1,chr(0));
END;END;
PROCEDURE load;
var f:file of tip;
    x,y,m:integer;
BEGIN
gotoxy(1,24);write(f1,'Loading the file ... ',s);
clear;assign(f,s);
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,36);gotoxy(18,10);ink(cl[5]);
write(f1,'FILE NOT FOUNDED');gotoxy(17,11);
write(f1,'Could not find file');gotoxy(17+length(s) div 2,12);
lowvideo;write(f1,s);highvideo;read(kbd,c);END
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
gotoxy(1,24);write(f1,'Saving the file ... ',s);
highvideo;
assign(f,s);
{$i-}
rewrite(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,39);gotoxy(19,10);ink(cl[5]);
write(f1,'FILE NOT CREATED');gotoxy(17,11);
write(f1,'Could not create file');gotoxy(17+length(s) div 2,12);
lowvideo;write(f1,s);highvideo;read(kbd,c);END
else BEGIN
for x:=0 to 256 do write(f1,chr(0));
END;END;

PROCEDURE loadtxt;
var x,y:integer;
BEGIN
gotoxy(1,24);write(f1,'Loading the file ... ',s);
clear;assign(f,s);
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN
paper(cl[2]);ink(cl[6]);
window(8,14,12,36);gotoxy(18,10);ink(cl[5]);
write(f1,'FILE NOT FOUNDED');gotoxy(17,11);
write(f1,'Could not find file');gotoxy(17+length(s) div 2,12);
lowvideo;write(f1,s);highvideo;read(kbd,c);END
else BEGIN x:=1;
while not eof(f) do BEGIN y:=1;readln(f,ln);
for lo:=1 to length(ln) do BEGIN
if y>64 then BEGIN y:=1;x:=x+1;END;
t[x,y]:=ln[y];y:=y+1;END;x:=x+1;j:=1;
END;END;END;

PROCEDURE main;BEGIN paper(cl[0]);highvideo;ink(cl[7]);at(23,0);
write(f1,'                                                               ');
paper(cl[0]);ink(cl[0]);at(0,0);iobord(cl[0]);
write(f1,'                                                                ');
paper(cl[5]);ink(cl[1]);at(0,0);write(f1,'F');highvideo;
write(f1,'ile ');lowvideo;write(f1,'O');highvideo;write(f1,'ptions ');
lowvideo;write(f1,'H');highvideo;write(f1,'elp ');lowvideo;
write(f1,'E');highvideo;write(f1,'dit ');paper(cl[1]);ink(cl[5]);
tex;
at(1,25);lowvideo;write(f1,s);highvideo;END;

PROCEDURE mfile;BEGIN
paper(cl[2]);ink(cl[6]);at(0,0);highvideo;write(f1,'File');
paper(cl[5]);ink(cl[1]);highvideo;window(1,0,9,11);
at(2,1);lowvideo;write(f1,'O');
ink(cl[2]);highvideo;write(f1,'pen');ink(cl[1]);
at(3,1);lowvideo;write(f1,'N');
ink(cl[2]);highvideo;write(f1,'ew ');ink(cl[1]);
at(4,1);lowvideo;write(f1,'S');ink(cl[2]);highvideo;write(f1,'ave');
ink(cl[1]);
at(5,1);write(f1,'Save ');lowvideo;ink(cl[2]);write(f1,'A');
ink(cl[1]);highvideo;
write(f1,'s...');
at(6,1);lowvideo;write(f1,'E');ink(cl[2]);
write(f1,'xit');ink(cl[1]);highvideo;at(7,1);
write(f1,'Save-');lowvideo;write(f1,'T');highvideo;
at(8,1);write(f1,'Loa');lowvideo;write(f1,'d');highvideo;write(f1,'-T');
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

PROCEDURE moptions;
BEGIN
paper(cl[2]);ink(cl[6]);at(0,5);write(f1,'Options');
highvideo;
paper(cl[0]);ink(cl[4]);
window(1,4,6,16);
ink(cl[5]);at(2,6);
lowvideo;write(f1,'S');
highvideo;write(f1,'et colors');
at(3,6);lowvideo;write(f1,'P');highvideo;write(f1,'assword');
at(4,6);lowvideo;write(f1,'L');highvideo;write(f1,'ock');
at(5,6);lowvideo;write(f1,'U');highvideo;write(f1,'nlock');
read(kbd,c1);c1:=upcase(c1);
if c1='S' then
BEGIN
paper(cl[0]);ink(cl[5]);
window(4,2,11,58);
repeat
for i:=0 to 7 do
BEGIN
paper(i);ink(7-i);
at(5,i*4+4);write(f1,'    ');
at(6,i*4+4);write(f1,'  ',i,' ');
at(8,i*4+4);paper(cl[i]);ink(cl[7-i]);write(f1,'    ');
at(9,i*4+4);write(f1,'  ',i,' ');
END;
at(7,8);paper(cl[1]);ink(cl[7]);
write(f1,'Original set of colours...');
at(10,8);write(f1,'Changed set of colours...');
paper(cl[0]);ink(cl[7]);
at(5,44);write(f1,'=MENU=');
at(6,40);write(f1,'1.Change colours');
at(7,40);write(f1,'2.Load config.');
at(8,40);write(f1,'3.Reset colours');
at(9,40);write(f1,'4.Monochrome');read(kbd,c2);
if c2='3' then for k:=0 to 7 do cl[k]:=k
else if c2='1' then
BEGIN
repeat
at(10,40);write(f1,'Change:');read(k);
until (k>-1) and (k<8);
at(10,40);write(f1,'           ');
repeat
at(10,40);write(f1,'With:');read(p);
until (i>-1) and (i<8);
aux:=cl[k];cl[k]:=cl[p];cl[p]:=aux;
END
else if c2='4' then BEGIN for p:=0 to 3 do cl[p]:=0;
for p:=4 to 7 do cl[p]:=7;END
else if c2='2' then ldf;
at(10,40);paper(cl[0]);ink(cl[7]);write(f1,'           ');
until ((c2<>'1') and (c2<>'3')) and ((c2<>'4')and(c2<>'2'));
for k:=0 to 7 do t[0,k+1]:=chr(cl[k]);border(cl[0]);iobord(cl[0]);
END
else if c1='P' then
BEGIN
paper(cl[7]);ink(cl[0]);
window(4,2,9,30);
ink(cl[1]);at(5,3);lowvideo;write(f1,'A');
highvideo;write(f1,'ctivate Password');
at(6,3);lowvideo;write(f1,'N');highvideo;write(f1,'one');
at(7,3);write(f1,'Password is ');
if t[0,9]='1' then write(f1,'active.')
 else
 BEGIN
  write(f1,'not present.');
 END;
at(8,3);lowvideo;write(f1,'S');
highvideo;write(f1,'et password (19chr).');
read(kbd,c4);c4:=upcase(c4);
if c4='A' then t[0,9]:='1';
if c4='N' then if t[0,9]<>'1' then
for k:=9 to 30 do t[0,k]:=' '
else BEGIN
at(0,30);write(f1,'*Error* (press RETURN)');
readln;
END;
if c4='S' then if t[0,9]='1'
then BEGIN
at(0,30);
paper(cl[0]);ink(cl[6]);write(f1,'Old password:');read(s3);
b3:=true;
for i:=1 to length(s3) do
if (s3[i]<>t[0,i+9]) then b3:=false;
if (i=ord(t[0,28]))and b3 then t[0,9]:='0';
at(0,40);write(f1,'               ');
END
else
BEGIN
at(0,30);write(f1,'New password:');read(s3);
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
at(0,30);write(f1,'Invalid!(press RETURN)');readln;END
else t[0,30]:='0';
END;
paper(cl[2]);ink(cl[4]);
END;

PROCEDURE mhelp;var f:text;BEGIN at(0,13);
paper(cl[3]);ink(cl[6]);write(f1,'HELP');assign(f,'personal.hlp');
{$i-}
reset(f);
{$i+}
if ioresult=0 then BEGIN
paper(cl[0]);ink(cl[6]);window(7,0,18,63);ink(cl[4]);
window(19,0,22,40);ink(cl[7]);at(20,2);write(f1,'=HELP=MENU= ');
at(21,2);ink(cl[5]);lowvideo;write(f1,'N');highvideo;
write(f1,'ext page  ');lowvideo;
write(f1,'Q');highvideo;write(f1,'uit this menu  ');
repeat i:=8;
repeat readln(f,s3);
if s3[1]<>'.' then BEGIN paper(cl[0]);ink(cl[5]);at(i,5);
write(f1,s3);i:=i+1;END;
until ((i=19) or (s3[1]='.')) or eof(f);
repeat read(kbd,c1);c1:=upcase(c1);
until (c1='N') or (c1='Q');
until (c1='Q') or eof(f);
close(f);
END;END;

PROCEDURE medit;
BEGIN
if t[0,9]='1' then BEGIN
gotoxy(40,1);write(f1,'Password is present...');delay(1000);
END else BEGIN ink(cl[7]);paper(cl[0]);
ll:=1;li:='';for n:=1 to 63 do li:=li+chr(127);
ex:=false;
repeat tex;
lowvideo;write(f1,'  Row:',x,' Line:',j,'  File:',s,'          ');
highvideo;
repeat gotoxy(x,y);
read(kbd,c);if c<>chr(24) then write(f1,c);gotoxy(1,23);
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
write(f1,ord(c),' Row:',x,' Line:',j,'  File:',s,'          ');
highvideo;
until c=chr(27);
until c=chr(27);
END;END;

PROCEDURE ldf;
BEGIN
assign(f,'PERSINIT.CFG');
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN gotoxy(2,3);
writeln(f1,'File not found!',chr(7));delay(1000);
END else
BEGIN for x:=0 to 7 do read(f,cl[x]);close(f);
border(cl[0]);iobord(cl[0]);paper(cl[0]);ink(cl[7]);END;
END;

BEGIN assign(f1,'personal.txt');rewrite(f1);
initx;inity;
s:='noname.txt';
for k:=0 to 7 do BEGIN cl[k]:=k;
t[0,k+1]:=chr(cl[k]);END;t[0,30]:='0';
highvideo;window(0,0,4,63);gotoxy(2,2);
writeln(f1,'Personal Editor V6.11 (c) 1996-1997 TIM Software Power .');
ldf;gotoxy(2,4);write(f1,'This program is registred to TIM''97');
clear;repeat repeat ex:=false;main;repeat
at(0,48);read(kbd,c1);c1:=upcase(c1);
until (c1<>chr(26))and((((c1='O')or(c1='H'))or(c1='F'))or(c1='E'));
if c1='F' then mfile
   else if c1='O' then moptions
   else if c1='H' then mhelp
   else if c1='E' then begin medit;ex:=false;end
until ex;
paper(cl[2]);ink(cl[6]);
window(8,20,13,43);ink(cl[4]);
at(9,29);write(f1,'Quit ?');
at(11,22);write(f1,'Yes              No');
repeat read(kbd,c1);until c1<>'';
c1:=upcase(c1);if c1<>'Y' then ex:=false;
until ex;assign(f,'PERSEXIT.CFG');
{$i-}
reset(f);
{$i+}
if ioresult<>0 then BEGIN cls;
border(0);iobord(0);paper(0);ink(7);cls;
writeln(f1,'File not found!',chr(7));
END else
BEGIN for x:=0 to 7 do read(f,cl[x]);close(f);
border(cl[0]);iobord(cl[0]);paper(cl[0]);ink(cl[7]);cls;END;
writeln(f1,'Copyright 1996-1997 TIM SOFTWARE POWER ENTERTAINMENT ');
writeln(f1,'You just used the Version 6.11');
writeln(f1,'See you next time!!!');close(f1);
END.