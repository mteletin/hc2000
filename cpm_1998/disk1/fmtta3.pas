type tip1=string[20];
     tip3=string[66];
     tip4=string[12];
     tip2=array[1..128]of tip4;

const nmf     :integer=21;

var da              :array[0..1]of tip2;
    m               :tip2;
    ft              :text;
    f1,f2           :file;
    cd,a,nf         :integer;
    drv,x,r,cv,nfd,v:array[0..2]of integer;
    i,y,k           :integer;
    c               :char;
    o,cm            :tip3;
    sl              :array[0..1]of array[1..128]of char;

procedure set1;var a,b,c:char;begin
a:=chr(27);b:=chr(113);write(a,b);end;
procedure set2;var a,b,c:char;begin
a:=chr(27);b:=chr(112);write(a,b);end;

procedure window(x,y,xx,yy:integer);var k:integer;a:char;
s:string[66];begin if x<xx then if y<yy then begin set2;s:='';
x:=x+1;y:=y+1;xx:=xx+1;yy:=yy+1;
for k:=y+1 to yy-1 do s:=s+' ';gotoxy(y,x);a:=chr(42);
write(a);a:=chr(39);for k:=y+1 to yy-1 do begin gotoxy(k,x);
write(a);gotoxy(k,xx);write(a);end;a:=chr(34);gotoxy(yy,x);
write(a);a:=chr(32);for k:=x+1 to xx-1 do begin gotoxy(y,k);
set2;write(a);set1;write(s);set2;gotoxy(yy,k);write(a);end;
a:=chr(35);gotoxy(y,xx);write(a);a:=chr(41);gotoxy(yy,xx);
write(a);set1;end;end;
procedure ink(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(73);c:=chr(48+x);write(a,b,c);end;
procedure paper(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(80);c:=chr(48+x);write(a,b,c);end;
procedure iobord(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(82);c:=chr(32+x);write(a,b,c);end;
procedure border(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(81);c:=chr(48+x);write(a,b,c);end;
procedure hidek;var a,b,c:char;begin
a:=chr(27);b:=chr(117);write(a,b);end;
procedure showk;var a,b,c:char;begin
a:=chr(27);b:=chr(116);write(a,b);end;
procedure clikon;var a,b,c:char;begin
a:=chr(27);b:=chr(114);write(a,b);end;
procedure clikoff;var a,b,c:char;begin
a:=chr(27);b:=chr(115);write(a,b);end;

procedure init;
begin
ink(7);paper(0);clrscr;border(0);iobord(0);
ink(4);lowvideo;
gotoxy(55,1);write('TTA-MENIU');
gotoxy(55,2);write('1.Drv St.');
gotoxy(55,3);write('2.Drv Dr.');
gotoxy(55,4);write('3.==||== ');
gotoxy(55,5);write('5.Copy   ');
gotoxy(55,6);write('6.Compr. ');
gotoxy(55,7);write('8.Erase  ');
gotoxy(55,8);write('0.EXIT   ');
paper(1);ink(5);
highvideo;end;

procedure list(a,b:integer);forward;
function chi(c:char):char;
begin
if ord(c)>127 then chi:=chr(ord(c)-128) else chi:=c;
end;

procedure rwts(dsk,s,t,rw:integer;dma:integer);
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

function space(x:tip1):tip1;
var u:integer;g:tip1;
begin
g:='';
for u:=1 to length(x) do
if x[u]<>' ' then g:=g+upcase(x[u]);
space:=g;
end;

procedure readf(d:integer);
var i:integer;
    m:tip2;

procedure fat;
var yu,g,x,f,s,t,rw,dma,dsk:integer;o:tip1;
    ht:char;

begin
yu:=1;bdos(13);
dsk:=drv[d];
bdos(14,dsk);
t:=2-drv[d];
rw:=2;   { orice <> 0   0=scriere}
dma:=$dc00; {unde apare sectorul in memorie}
for x:=0 to 128 do begin
m[x]:='';da[dsk][x]:='';end;
for s:=0 to 31 div (drv[d]+1) do
begin
 rwts(dsk,s,t,rw,dma);
 for x:=0 to 3 do
 begin
    f:=x*32+12;
    if (((mem[dma+f]=1)and(drv[d]=1))or
    (mem[dma+f]=0))and(mem[dma+f-12]=v[dsk]) then
    begin ht:=' ';f:=x*32;
          if mem[dma+10+f]>128 then ht:='';
          if mem[dma+f+9]>127 then if ht<>'' then ht:='*'
          else ht:='!';o:='';
      for g:=1 to 8 do
        o:=o+chr(mem[dma+x*32+g]);
        o:=o+ht;
      for g:=9 to 11 do
        o:=o+chr(mem[dma+x*32+g]);
      m[yu]:=o;
      yu:=yu+1;i:=yu-1;
    end;
 end;
end;
end;

begin
i:=0;
fat;if i<0 then i:=0;
nfd[drv[d]]:=i;
da[drv[d]]:=m;
cv[d]:=0;
x[d]:=0;
end;

procedure select(d:integer);
var u,uu :integer;
    c    :char;
begin
paper(5);ink(2);k:=nmf div 2;
window(k,d*28+12,k+4,d*28+15);
gotoxy(d*28+14,k+2);write('CH');
gotoxy(d*28+14,k+3);write('A:');
gotoxy(d*28+14,k+4);write('B:');
u:=drv[d]+1;uu:=0;
repeat
gotoxy(d*28+14,k+2+u);lowvideo;
case u of
0:write('CH');
1:write('A:');
2:write('B:');
end;highvideo;
if u<>uu then begin
   gotoxy(d*28+14,k+2+uu);
   case uu of
        0:write('CH');
        1:write('A:');
        2:write('B:');
   end;
end;
read(kbd,c);
if c=chr(24) then if u<2 then begin uu:=u;u:=u+1;end;
if c=chr(5)  then if u>0 then begin uu:=u;u:=u-1;end;
until (c=chr(13))or(c=chr(27));
if c=chr(13) then begin
  if u<>0 then begin drv[d]:=u-1;x[d]:=0;
  if cv[d]+1>nfd[drv[d]] then cv[d]:=0;end;
  if u=0 then 
  begin
    readf(d);
    cv[d]:=0;x[d]:=0;
    if drv[d]=drv[1-d] then begin
       cv[1-d]:=0;x[1-d]:=0;list(cv[d],1);
       end;
  end;
end;
ink(5);paper(1);
end;

procedure list1(a,b:integer);
var i,u  :integer;
    x    :tip2;
    nf   :integer;
begin
paper(1);ink(5);
nf:=nfd[drv[b]];
x:=da[drv[b]];
if nf>0 then begin

u:=nmf;
if a+u>=nf then begin u:=nf-a-1;
     for i:=2 to nmf+2 do begin
     gotoxy(15+b*27,i);write('            ');end;
     end;
for i:=1 to u+1 do begin
gotoxy(2+b*27,1+i);
if sl[drv[b]][a+i]=chr(1) then ink(7) else ink(5);
if length(x[a+i])<13 then write(x[a+i]);end;
for i:=u+2 to nmf+1 do begin
gotoxy(2+b*27,1+i);write('            ');end;

if a+u<nf then
begin
u:=nf-a-nmf+1;
if u>nmf then u:=nmf;
if u>=0 then begin
  for i:=1 to u+1 do begin
  if sl[drv[b]][a+i+nmf+1]=chr(1) then ink(7) else ink(5);
  gotoxy(15+b*27,1+i);if length(x[a+i+nmf+1])<13 then write(x[a+i+nmf+1]);end;
  end;
if (u<nmf)and(u>0)then
for i:=u+2 to nmf+1 do begin
gotoxy(15+b*27,1+i);write('            ');end;
end;end;

paper(1);ink(5);end;

procedure list;
var i,u  :integer;
    x    :tip2;
    nf   :integer;
begin
paper(1);ink(5);
x:=da[drv[b]];nf:=nfd[drv[b]];
window(0,b*27,nmf+2,26+b*27);
gotoxy(b*27+7,1);
lowvideo;write(chr(65+drv[b]),':,User',v[b]);
gotoxy(b*27+2,nmf+3);write('Fis:');
write(nfd[drv[b]]:3);
highvideo;
list1(a,b);
end;

procedure desen(d:integer);
var nf,xx,yy,a:integer;
begin
xx:=x[d];
d:=d mod 2;
a:=cv[d];
m:=da[drv[d]];
nf:=nfd[drv[d]];
if nf<1 then begin
gotoxy(2+d*27,2);x[d]:=0;y:=0;write('            ');
highvideo;end;

if nf>1 then begin
if c=chr(4) then
     if (x[d]<=nmf)then
     begin xx:=x[d];x[d]:=x[d]+nmf+1;
           if not(x[d]+2+a<nf)then x[d]:=nf-a-1;
     end
     else if nf>a+nmf*2+2 then
                        begin
                        a:=a+nmf*2+2;
                        if a+x[d]+2>nf then x[d]:=nf-a-1;
                        xx:=1;
                        list1(a,d);cv[d]:=a;end;
if c=chr(19) then
     if x[d]>nmf then begin
                      xx:=x[d];
                      x[d]:=x[d]-nmf-1;
                      end
     else
     if a>2*nmf+2 then
            begin
            a:=a-2*nmf-2;
            list1(a,d);end else
                           begin
                           if a=0 then x[d]:=0;
                           a:=0;xx:=1;
                           list1(a,d);
                           cv[d]:=a;
                           end;

if c=chr(24) then
if(nmf*2+1>x[d])and(nf>x[d]+a+1)then begin
xx:=x[d];x[d]:=x[d]+1;end
else
     if nf>a+nmf*2+2 then begin
                        a:=a+1;
                        list1(a,d);end;
if c=chr(5) then
if x[d]>0 then begin
   xx:=x[d];
   x[d]:=x[d]-1;end
else begin x[d]:=0;
     if a>0 then
            begin
            a:=a-1;
            list1(a,d);end else a:=0;
     end;
cv[d]:=a;
y:=x[d] div (nmf+1);
yy:=xx div (nmf+1);
if xx<>x[d] then begin
if sl[drv[d]][a+xx+1]=chr(1) then ink(7)
else ink(5);
gotoxy(2+yy*13+d*27,2+xx mod (nmf+1));
highvideo;write(m[a+xx+1]);
cv[d]:=a;
end;

if sl[drv[d]][a+x[cd]+1]=chr(1) then ink(7)
else ink(5);
if c<>chr(9) then begin
 gotoxy(2+y*13+d*27,2+x[d] mod (nmf+1));
 lowvideo;write(m[a+x[d]+1]);highvideo;
 ink(5);end;
end;end;

procedure cop(s1,s2:tip1;var r:boolean);
var q,k,i:integer;b:boolean;o:tip1;
begin
if c<>chr(27) then begin
r:=true;b:=true;o:='';o:=o+s2[1]+':FM.TMP';
q:=ord(s2[1])-65;
assign(f1,s1);
{$i-}
reset(f1);
{$i+}
if ioresult<>0 then r:=false
else begin
assign(f2,s2);
b:=true;
while not(eof(f1)) do begin
k:=0;while not(eof(f1))and(k<45)do begin
blockread(f1,mem[$5030+k*128],1);k:=k+1;end;
if b then begin rewrite(f2);b:=false;end;
blockwrite(f2,mem[$5030],k);end;
close(f2);close(f1);
rename(f2,s2);
end;end;
end;


procedure copyf;
var s1,s2           :string[40];
    uu,l2,u,l1,st   :integer;
    c               :char;
    r               :boolean;
begin
     paper(2);ink(6);c:=chr(0);
     window(8,10,11,37);l2:=0;
     for u:=1 to 128 do if sl[drv[cd]][u]=chr(1) then l2:=1;
     if l2=0 then begin
                  st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
                  sl[drv[cd]][st]:=chr(1);end;l1:=0;
     for u:=1 to 128 do
     if sl[drv[cd]][u]=chr(1) then
     begin sl[drv[cd]][u]:=chr(0);
     gotoxy(12,10);
       lowvideo;
       write('Copy from:');
       highvideo;
s1:=chr(65+drv[cd])+':';
s1:=s1+m[u];s1[11]:='.';
s1:=space(s1);
     write(s1:14);
     gotoxy(12,11);
       lowvideo;
s2:=chr(65+drv[1-cd])+':'+m[u];s2[11]:='.';s2:=space(s2);
       write('       To:');
       write(s2:14);
       highvideo;
if c<>'~' then begin read(kbd,c);
if (c<>'~') then
if ord(c)>29 then begin gotoxy(22,11);write('               ');
     gotoxy(22,11);
     readln(s2);end;end;
if c<>chr(27) then begin
  s2:=space(s2);if s2[2]<>':' then
  s2:=s1[1]+':'+s2;
  cop(s1,s2,r);if c<>chr(27) then l1:=1;
end;end;
if c<>chr(27) then
if (upcase(s2[1])='A')and(l1=1)then readf(drv[0]) else readf(drv[1]);
list(cv[0],0);list(cv[1],1);
ink(5);paper(1);
end;


procedure erasef;
const adr=$dd00;
      maxbl=40;
var f1              :file;
    s1              :string[40];
    uu,l2,u,l1,st,ed:integer;
    c               :char;
begin
     paper(2);ink(6);c:=chr(0);
     window(8,10,10,37);l2:=0;
     for u:=1 to 128 do if sl[drv[cd]][u]=chr(1) then l2:=1;
     if l2=0 then begin
                  st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
                  sl[drv[cd]][st]:=chr(1);end;l1:=0;
     for u:=1 to 128 do
     if (sl[drv[cd]][u]=chr(1))and((m[u][9]=' ')or(m[u][9]=''))
     then begin sl[drv[cd]][u]:=chr(0);
     gotoxy(12,10);
       lowvideo;
       write('ERASE :');
       highvideo;
s1:=chr(65+drv[cd])+':';
s1:=s1+m[u];s1[11]:='.';
s1:=space(s1);
     write(s1:14);
if c<>'~' then read(kbd,c);
if (c='~')or(c=chr(13)) then
begin
  assign(f1,s1);l1:=1;
  if c<>chr(27) then begin erase(f1);end;
  if x[cd]>0 then x[cd]:=x[cd]-1 else if a>0 then a:=a-1;
end;
end;
paper(1);ink(5);
if l1=1 then begin readf(cd);end;
list(cv[cd],0);
list(cv[1-cd],1);
paper(1);ink(5);
end;

procedure transf;
var f1:file;
    f2:file of byte;
    s1,s2:string[40];
    n,i,k,uu,l2,u,l1,st:integer;
    c:char;
    r:boolean;

procedure comp(nm,wr:tip1);
var f1,f2:text;
    a:array[1..10240]of char;
    x,y,l1,l2:integer;
    h,j:char;
    w:boolean;

begin
w:=true;
assign(f1,nm);
assign(f2,wr);
reset(f1);rewrite(f2);
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
if x<10240 then for y:=1 to x do write(f2,a[y]);
gotoxy(55,14);writeln((100/l1*l2):6:2,' %');
close(f1);close(f2);end;

begin
     paper(2);ink(6);c:=chr(0);
     window(8,10,11,37);l2:=0;
     for u:=1 to 128 do if sl[drv[cd]][u]=chr(1) then l2:=1;
     if l2=0 then begin
                  st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
                  sl[drv[cd]][st]:=chr(1);end;l1:=0;
     for u:=1 to 128 do
     if sl[drv[cd]][u]=chr(1) then
     begin sl[drv[cd]][u]:=chr(0);
     gotoxy(12,10);
       write('Source:');
       highvideo;
s1:=chr(65+drv[cd])+':';
s1:=s1+m[u];s1[11]:='.';
s1:=space(s1);
     write(s1:15);
     gotoxy(12,11);
s2:=chr(65+drv[1-cd])+':'+m[u];s2[11]:='.';
s2[12]:='T';s2[13]:='T';s2[14]:='A';s2:=space(s2);
       write('    To:');lowvideo;
       write(s2:15);
       highvideo;
if c<>'~' then begin read(kbd,c);
if (c<>'~') then
if ord(c)>29 then begin gotoxy(19,11);write('               ');
     gotoxy(19,11);
     readln(s2);end;end;
if c<>chr(27) then begin
  s2:=space(s2);if s2[2]<>':' then
  s2:=s1[1]+':'+s2;
  comp(s1,s2);if c<>chr(27) then l1:=1;
end;end;
if c<>chr(27) then
if (upcase(s2[1])='A')and(l1=1)then readf(drv[0]) else readf(drv[1]);
list(cv[0],0);list(cv[1],1);
ink(5);paper(1);
end;

procedure playaud;
begin
end;


begin
cd:=0;
for i:=0 to 2 do begin drv[i]:=cd;x[i]:=0;r[i]:=0;
v[i]:=0;nfd[i]:=0;cv[i]:=0;end;y:=0;
paper(0);border(0);iobord(0);clrscr;
c:=chr(0);for i:=1 to 128 do
          for k:=0 to 1 do begin
          da[k][i]:='';
          sl[k][i]:=chr(0);
          end;
init;
assign(ft,'A:FM001.TMP');
{$i-}
reset(ft);
{$i+}
if ioresult=0 then begin
readln(ft,drv[0]);readln(ft,drv[1]);
readln(ft,nmf);close(ft);end;
readf(0);
hidek;clikoff;
if drv[0]<>drv[1] then readf(1);
list(cv[0],0);
list(cv[1],1);
a:=cv[cd];
m:=da[drv[cd]];
nf:=nfd[drv[cd]];
ink(5);
repeat
c:=chr(0);
desen(cd);
read(kbd,c);

if c=chr(9) then begin cd:=1-cd;list1(cv[0],0);list1(cv[1],1);
end;
case c of
'!':begin select(0);list(cv[0],0);end;
'@':begin select(1);list(cv[1],1);end;
'%':if nfd[drv[cd]]>0 then begin clikon;showk;copyf;end;
'&':if nfd[drv[cd]]>0 then begin clikon;showk;transf;end;
'(':if nfd[drv[cd]]>0 then begin clikon;showk;erasef;end;
end;
hidek;clikoff;
m:=da[drv[cd]];
nf:=nfd[drv[cd]];

if c=chr(6) then
if sl[drv[cd]][a+y*(nmf+1)+1+x[cd] mod (nmf+1)]=chr(1)
then sl[drv[cd]][a+y*(nmf+1)+1+x[cd] mod (nmf+1)]:=chr(0)
else sl[drv[cd]][a+y*(nmf+1)+1+x[cd] mod (nmf+1)]:=chr(1);
da[drv[cd]]:=m;
a:=cv[cd];

desen(cd);
if nf>0 then begin
y:=x[cd] div (nmf+1);
o:='';

a:=cv[cd];
if c=chr(13) then begin
 for i:=10 to 12 do
 o:=o+chi(m[a+y*(nmf+1)+1+x[cd] mod (nmf+1)][i]);
  if o='MOD' then begin {apel procedura de incarcare COM }
                  write(#07);transf;end;
  if o='AUD' then playaud;

end;
ink(5);
end;

until c='_';
clrscr;showk;clikoff;
paper(1);ink(5);bdos(13);
end.