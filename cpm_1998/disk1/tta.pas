{$g+}
{$m 1024,0,56000}
var f1,f2,f3:text;a:array[1..10240]of char;
 ct:array[1..128]of record nl:string[20];cp:boolean;end;
 u,s,x,y,l1,l2,nf,n:integer;c,h,j:char;rd,wr:string[40];
 wu,w:boolean;
procedure ink(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(73);c:=chr(48+x);write(a,b,c);end;
procedure paper(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(80);c:=chr(48+x);write(a,b,c);end;
{$i prwindow.pas}

begin
repeat
writeln;repeat write('Compress/Input.txt/Quit:');readln(c);
c:=upcase(c);until ((c='C')or(c='Q'))or(c='I');
if c='Q' then halt;
if c='I' then begin
assign(f3,'input.txt');{$i-}
reset(f3);{$i+}
if ioresult<>0 then begin
writeln('INPUT file not found!(INPUT.TXT)');end
else
nf:=0;
while not(eof(f3)) do begin
nf:=nf+1;readln(f3,ct[nf].nl);ct[nf].cp:=false;end;
n:=1;s:=1;c:='+';
clrscr;window(0,19,21,20+12);
repeat
repeat
for y:=1 to 20 do begin
if ct[y+n-1].cp then ink(7) else ink(4);
if y=s then lowvideo else highvideo;
gotoxy(21,y+1);
write(ct[y+n-1].nl);end;w:=false;wu:=false;
repeat read(kbd,c);
u:=s;
if c=chr(24) then begin
s:=s+1;w:=true;
if s>20 then begin wu:=true;
s:=20;if n<nf-20 then n:=n+1;end;end;

if c=chr(5) then begin s:=s-1;w:=true;if s<1 then begin s:=1;
wu:=true;if n>1 then n:=n-1;end;end;

if c=' ' then begin ct[s+n-1].cp:=not(ct[s+n-1].cp);w:=true;end;

if w then begin
if ct[s+n-1].cp then ink(7) else ink(4);
gotoxy(21,s+1);
lowvideo;write(ct[s+n-1].nl);
if u<>s then begin
if ct[u+n-1].cp then ink(7) else ink(4);
gotoxy(21,u+1);
highvideo;write(ct[u+n-1].nl);
end;end;

until wu or(c=chr(13));
until not(wu);
until c=chr(13);
end
else begin
nf:=1;write('Input filename:');readln(ct[1].nl);ct[1].cp:=true;
end;
clrscr;ink(3);lowvideo;writeln('Name     Len    Packed  Ratio');
highvideo;

for n:=1 to nf do begin
if ct[n].cp then begin
wr:='';
for y:=1 to length(ct[n].nl) do begin
if ord(ct[n].nl[y])>32 then wr:=wr+ct[n].nl[y];end;
ct[n].nl:=wr;rd:=wr;wr:='';w:=true;
for y:=1 to length(ct[n].nl) do begin
if w then wr:=wr+ct[n].nl[y];
if ct[n].nl[y]='.' then begin wr:=wr+'TTA';
ct[n].nl:=wr;y:=length(ct[n].nl);w:=false;end;end;ink(2);
write(rd:25,' --- ');
w:=true;
assign(f1,rd);assign(f2,wr);
{$i-}
reset(f1);{$i+}
if ioresult<>0 then begin
ink(5);paper(1);lowvideo;writeln('Error:File not found!');
highvideo;writeln('Check INPUT file INPUT.TXT');
end
else begin
rewrite(f2);
x:=1;l1:=0;l2:=0;
while not(eof(f1)) do begin
read(f1,h);l1:=l1+1;if h='''' then w:=not w;
if ((h=' ')and(h=j))and w then
while not(eof(f1))and
(h=' ') do begin read(f1,h);l1:=l1+1;
if h='''' then w:=not w;end;j:=h;
a[x]:=h;x:=x+1;l2:=l2+1;if x>=10240 then begin
for y:=1 to x do write(f2,a[y]);x:=1;end;
end;
if x<10240 then for y:=1 to x do write(f2,a[y]);ink(5);
write(l1:6,l2:8);ink(0);writeln((100/l1*l2):8:2,' %');
close(f1);close(f2);end;
end;end;ink(5);
until false;
end.
