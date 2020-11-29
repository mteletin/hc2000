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
procedure user(v:byte);
var i:byte;
begin
i:=mem[4] mod 16;
i:=i+v*16;mem[4]:=i;end;

procedure init;
begin
ink(7);paper(0);clrscr;border(0);iobord(0);
ink(4);lowvideo;
gotoxy(55,1);write('FM3-MENIU');
gotoxy(55,2);write('1.Drv St.');
gotoxy(55,3);write('2.Drv Dr.');
gotoxy(55,4);write('3.View   ');
{gotoxy(55,5);write('4.Edit   ');}
gotoxy(55,5);write('5.Copy   ');
gotoxy(55,6);write('6.RenMove');
gotoxy(55,7);write('7.Usr.St.');
gotoxy(55,8);write('8.Erase  ');
gotoxy(55,9);write('9.Usr.Dr.');
gotoxy(55,10);write('0.EXIT   ');
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

procedure selusr(d:integer);
var u,uu :integer;
    c    :char;
begin
paper(5);ink(2);
window(2,d*28+12,20,d*28+15);
gotoxy(d*28+14,4);write('CH');
for u:=0 to 15 do begin
gotoxy(d*28+14,5+u);write(u:2);end;
u:=v[d]+1;uu:=0;
repeat
gotoxy(d*28+14,4+u);lowvideo;
case u of
0:write('CH')
else write(u-1:2);
end;highvideo;
if u<>uu then begin
   gotoxy(d*28+14,4+uu);
   case uu of
        0:write('CH')
        else write(uu-1:2);
   end;
end;
read(kbd,c);
if c=chr(24) then if u<16 then begin uu:=u;u:=u+1;end;
if c=chr(5)  then if u>0 then begin uu:=u;u:=u-1;end;
until (c=chr(13))or(c=chr(27));
if c=chr(13) then begin
  if u<>0 then begin v[d]:=u-1;x[d]:=0;
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
    m         :tip2;
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
user(v[cd]);
q:=ord(s2[1])-65;
assign(f1,s1);
{$i-}
reset(f1);
{$i+}
if ioresult<>0 then r:=false
else begin
user(v[q]);
assign(f2,s2);
b:=true;
while not(eof(f1)) do begin
k:=0;while not(eof(f1))and(k<64)do begin
user(v[cd]);
blockread(f1,mem[$6200+k*128],1);k:=k+1;end;
if b then begin user(v[q]);rewrite(f2);b:=false;end;
user(v[q]);blockwrite(f2,mem[$6200],k);end;
user(v[cd]);close(f2);user(v[q]);close(f1);
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

procedure movef;
var s1,s2            :string[40];
    uu,l2,u,l1,st    :integer;
    c                :char;
    r                :boolean;
begin
     paper(2);ink(6);c:=chr(0);
     window(8,10,11,37);l2:=0;
     for u:=1 to 128 do if sl[drv[cd]][u]=chr(1) then l2:=1;
     if l2=0 then begin
                  st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
                  sl[drv[cd]][st]:=chr(1);end;l1:=0;
     for u:=1 to 128 do
     if (sl[drv[cd]][u]=chr(1))and((m[u][9]=' ')or(m[u][9]=''))
     then begin
     gotoxy(12,10);sl[drv[cd]][u]:=chr(0);
       lowvideo;
       write('Move from:');
       highvideo;
s1:=chr(65+drv[cd])+':'+m[u];s1[11]:='.';
s1:=space(s1);
     write(s1:14);
     gotoxy(12,11);
       lowvideo;
s2:=chr(65+drv[1-cd])+':'+m[u];s2[11]:='.';
s2:=space(s2);
       write('       To:');
       write(s2:14);
       highvideo;
if c<>'~' then begin read(kbd,c);
if (c<>'~')and(c<>chr(27)) then
if ord(c)>29 then begin gotoxy(22,11);write('               ');
     gotoxy(22,11);
     readln(s2);
     end;end;
if c<>chr(27) then begin
s2:=space(s2);
if s2[2]<>':' then
  s2:=s1[1]+':'+s2;
if (upcase(s1[1])=upcase(s2[1]))and((s1[2]=s2[2])and(c<>chr(27)))then begin
  user(v[cd]);assign(f1,s1);rename(f1,s2);l1:=1;end else begin
  cop(s1,s2,r);
  if (r)and(c<>chr(27))then begin user(v[cd]);
  l1:=2;assign(f1,s1);erase(f1);end;
end;end;end;
if c<>chr(27) then
if (s2[1]='A')and(l1<>0) then
                         begin
                         readf(drv[0]);
                         if l1=2 then readf(drv[1]);
                         end
                          else
                          begin
                          readf(drv[1]);
                          if l1=2 then readf(drv[0]);
                          end;
list(cv[0],0);list(cv[1],1);
paper(1);ink(5);
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
  user(v[cd]);
  assign(f1,s1);l1:=1;
  if c<>chr(27) then begin user(v[cd]);erase(f1);end;
  if x[cd]>0 then x[cd]:=x[cd]-1 else if a>0 then a:=a-1;
end;
end;
paper(1);ink(5);
if l1=1 then begin readf(cd);end;
list(cv[cd],0);
list(cv[1-cd],1);
paper(1);ink(5);
end;

procedure view;
const ct:integer=13;
var st:integer;
    c :char;
    ln:string[128];
begin
user(v[cd]);
ink(6);paper(0);c:=' ';
gotoxy(1,12);write(#$1b,#$59);k:=nmf;
nmf:=8;list(cv[0],0);list(cv[1],1);nmf:=k;
st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
o:=m[st];o[9]:='.';o:=space(chr(65+drv[cd])+':'+o);
paper(6);ink(2);gotoxy(1,12);write('File:',o);
paper(0);ink(6);assign(ft,o);{$i-} reset(ft);{$i+}
if ioresult=0 then begin
st:=0;while (not(eof(ft)))and(c<>chr(27)) do begin
readln(ft,ln);
if st<10 then begin st:=st+1;
st:=st+(length(ln))div 64;end
else begin
     read(kbd,c);if length(ln)div 64=1 then ct:=12 else ct:=13;
     for i:=1 to 1+length(ln)div 64 do begin
     gotoxy(1,13);
     write(#$1b,#$13);
     end;end;
gotoxy(1,ct+st);for i:=1 to length(ln) do
if (ord(ln[i])<31)or((ord(ln[i])>127)and(ord(ln[i])<159))
then write('.') else
if ord(ln[i])<128 then begin highvideo;write(ln[i]);end
else begin lowvideo;write(ln[i]);end;
end;gotoxy(1,24);lowvideo;
write('Press any key to return...');
read(kbd,c);highvideo;end
else begin gotoxy(1,12);write(#$1b,#$59);gotoxy(1,24);WRITE('ERROR ON VIEWING');
end;
gotoxy(1,12);write(#$1b,#$59);
init;list(cv[0],0);list(cv[1],1);close(ft);
end;

procedure playdem;
var st:integer;
begin
user(v[cd]);
st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
o:=m[st];o[9]:='.';o:=space(chr(65+drv[cd])+':'+o);
assign(ft,o);reset(ft);
clrscr;while not(eof(ft)) do begin
read(ft,c);write(c);end;delay(1000);gotoxy(1,24);
paper(0);ink(5);border(0);iobord(0);
write('Press a key...');read(kbd,c);init;
init;list(cv[0],0);list(cv[1],1);end;

procedure runf;
var st:integer;
    f :text;
begin
showk;
user(v[cd]);
assign(f1,'a:$$$.sub');
rewrite(f1);for i:=0 to 128*4 do mem[$6400+i]:=26;

o:='FM2'+chr(0)+'$';
for i:=1 to 5 do mem[$6400+i]:=ord(o[i]);
mem[$6400]:=3;
o:='USER 0'+chr(0)+'$';
for i:=1 to length(o) do mem[$6400+128+i]:=ord(o[i]);
mem[$6400+128]:=length(o)-2;

o:='A:'+chr(0)+'$';
for i:=1 to 4 do mem[$6400+256+i]:=ord(o[i]);
mem[$6400+256]:=2;

st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
o:=m[st];o[9]:=' ';o[10]:=' ';o[11]:=' ';o[12]:=' ';
o:=space(chr(65+drv[cd])+':'+o);
paper(2);ink(6);
window(10,4,12,60);gotoxy(6,11);lowvideo;
write('Command parameters or press ENTER');
gotoxy(6,12);write(chr(65+drv[cd]),'>',o,' ');
readln(cm);o:=o+' '+cm;highvideo;paper(1);

o:=o+chr(0)+'$';
mem[$6400+384]:=length(o)-2;
for i:=1 to length(o) do mem[$6400+384+i]:=ord(o[i]);
clrscr;writeln('Run:',o);

o:=chr(65+drv[cd])+':'+chr(0)+'$';
for i:=1 to 4 do mem[$6400+512+i]:=ord(o[i]);
mem[$6400+512]:=2;
blockwrite(f1,mem[$6400],5);close(f1);

user(0);
assign(ft,'A:FM001.TMP');rewrite(ft);writeln(ft,drv[0]);
writeln(ft,drv[1]);writeln(ft,nmf);close(ft);ink(6);paper(1);
user(v[cd]);halt;end;

begin
cd:=0;

assign(f1,'A:FM002.TMP');
{$i-}
reset(f1);
{$i+}
if ioresult=0 then begin
              assign(f2,'A:$$$.SUB');
              {$i-}
              reset(f2);
              {$i+}
              if ioresult=0 then begin close(f2);erase(f2);end;
              end
else begin
assign(f2,'A:$$$.SUB');
{$i-}
reset(f2);
{$i+}
if ioresult=0 then begin close(f2);rename(f2,'A:FM002.TMP');end;
end;


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
'#':if nfd[drv[cd]]>0 then begin clikon;showk;view;end;
'$':begin end;
'%':if nfd[drv[cd]]>0 then begin clikon;showk;copyf;end;
'&':if nfd[drv[cd]]>0 then begin clikon;showk;movef;end;
'''':begin selusr(0);list(cv[0],0);end;
'(':if nfd[drv[cd]]>0 then begin clikon;showk;erasef;end;
')':begin selusr(1);list(cv[1],1);end;
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
  if o='COM' then begin {apel procedura de incarcare COM }
                  write(#07);runf;end;
  if o='DEM' then playdem;
  if o='CHN' then begin
  clrscr;
  m[a+y*(nmf+1)+1+x[cd] mod (nmf+1)][9]:='.';
  writeln(chr(65+drv[cd])+'>'+m[a+y*(nmf+1)+1+x[cd] mod (nmf+1)][9]);
  assign(f1,space(m[a+y*(nmf+1)+1+x[cd] mod (nmf+1)]));
  reset(f1);execute(f1);end;

end;
ink(5);
end;

until c='_';
clrscr;showk;clikoff;
paper(1);ink(5);bdos(13);

assign(f1,'A:$$$.SUB');
{$i-}
reset(f1);
{$i+}
if ioresult=0 then begin close(f1);erase(f1);end;

assign(f2,'A:FM002.TMP');
{$i-}
reset(f2);
{$i+}
if ioresult=0 then begin close(f2);rename(f2,'A:$$$.SUB');end;

assign(ft,'A:FM001.TMP');rewrite(ft);writeln(ft,drv[0]);
writeln(ft,drv[1]);writeln(ft,nmf);close(ft);user(v[cd]);
end.