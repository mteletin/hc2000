type tip1=string[20];
     tip3=string[66];
     tip4=string[12];
     tip2=array[1..128]of tip4;

const nmf     :integer=21;
      CONY    :integer=$3Ac0;

var m               :tip2;
    lgs             :tip1;
    ft              :text;
    f1,f2           :file;
    cd,a,nf         :integer;
    drv,x,r,cv,nfd,v:array[0..2]of integer;
    i,y,k           :integer;
    c               :char;
    o,cm            :tip3;
    sl              :array[1..128]of char;
procedure ink(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(73);c:=chr(48+x);write(a,b,c);end;

procedure init;
begin
clrscr;
lowvideo;
gotoxy(55,1);write('PLAY-MENU');
gotoxy(55,2);write('1.Drv St.');
gotoxy(55,3);write('6.Playaud');
gotoxy(55,4);write('8.Erase  ');
gotoxy(55,5);write('0.EXIT   ');
highvideo;end;

procedure list(a:integer);forward;
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
m[x]:='';end;
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
m:=m;
cv[d]:=0;
x[d]:=0;
end;

procedure select;
var u,uu :integer;
    c    :char;
begin
k:=nmf div 2;
gotoxy(14,k+2);write('CH');
gotoxy(14,k+3);write('A:');
gotoxy(14,k+4);write('B:');
u:=drv[0]+1;uu:=0;
repeat
gotoxy(14,k+2+u);lowvideo;
case u of
0:write('CH');
1:write('A:');
2:write('B:');
end;highvideo;
if u<>uu then begin
   gotoxy(14,k+2+uu);
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
  if u<>0 then begin drv[0]:=u-1;x[0]:=0;
  if cv[0]+1>nfd[drv[0]] then cv[0]:=0;end;
  if u=0 then
  begin
    readf(0);
    cv[0]:=0;x[0]:=0;
    begin
       list(cv[0]);
       end;
  end;
end;
end;

procedure list1(a:integer);
var i,u  :integer;
    nf   :integer;
begin
ink(5);nf:=nfd[0];
if nf>0 then begin

u:=nmf;
if a+u>=nf then begin u:=nf-a-1;
     for i:=2 to nmf+2 do begin
     gotoxy(15,i);write('             ');end;
     end;
for i:=1 to u+1 do begin
gotoxy(2,1+i);
if sl[a+i]=chr(1) then ink(7) else ink(5);
if length(m[a+i])<13 then write(m[a+i]);end;
for i:=u+2 to nmf+1 do begin
gotoxy(2,1+i);write('            ');end;

if a+u<nf then
begin
u:=nf-a-nmf+1;
if u>nmf then u:=nmf;
if u>=0 then begin
  for i:=1 to u+1 do begin
  if sl[a+i+nmf+1]=chr(1) then ink(7) else ink(5);
  gotoxy(15,1+i);if length(m[a+i+nmf+1])<13 then write(m[a+i+nmf+1]);end;
  end;
if (u<nmf)and(u>0)then
for i:=u+2 to nmf+1 do begin
gotoxy(15,1+i);write('            ');end;
end;end;

end;

procedure list;
var i,u  :integer;
    nf   :integer;
begin
nf:=nfd[drv[0]];
gotoxy(7,1);
lowvideo;write(chr(65+drv[0]),':,User',v[0]);
gotoxy(2,nmf+3);write('Fis:');
write(nfd[drv[0]]:3);
highvideo;
list1(a);
end;

procedure desen(d:integer);
var nf,xx,yy,a:integer;
begin
xx:=x[d];
d:=d mod 2;
a:=cv[d];
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
                        list1(a);cv[d]:=a;end;
if c=chr(19) then
     if x[d]>nmf then begin
                      xx:=x[d];
                      x[d]:=x[d]-nmf-1;
                      end
     else
     if a>2*nmf+2 then
            begin
            a:=a-2*nmf-2;
            list1(a);end else
                           begin
                           if a=0 then x[d]:=0;
                           a:=0;xx:=1;
                           list1(a);
                           cv[d]:=a;
                           end;

if c=chr(24) then
if(nmf*2+1>x[d])and(nf>x[d]+a+1)then begin
xx:=x[d];x[d]:=x[d]+1;end
else
     if nf>a+nmf*2+2 then begin
                        a:=a+1;
                        list1(a);end;
if c=chr(5) then
if x[d]>0 then begin
   xx:=x[d];
   x[d]:=x[d]-1;end
else begin x[d]:=0;
     if a>0 then
            begin
            a:=a-1;
            list1(a);end else a:=0;
     end;
cv[d]:=a;
y:=x[d] div (nmf+1);
yy:=xx div (nmf+1);
if xx<>x[d] then begin
if sl[a+xx+1]=chr(1) then ink(7)
else ink(5);
gotoxy(2+yy*13+d*27,2+xx mod (nmf+1));
highvideo;write(m[a+xx+1]);
cv[d]:=a;
end;

if sl[a+x[cd]+1]=chr(1) then ink(7)
else ink(5);
if c<>chr(9) then begin
 gotoxy(2+y*13+d*27,2+x[d] mod (nmf+1));
 lowvideo;write(m[a+x[d]+1]);highvideo;
 ink(5);end;
end;end;


procedure setpar(l,s:integer);begin mem[$c4fe]:=s;
mem[$c4fc]:=l mod 256;mem[$c4fd]:=l div 256;mem[$c4fa]:=lo(CONY);
mem[$c4fb]:=hi(CONY);end;

procedure play;begin
inline($f3);
inline($e5/$c5/$d5/$f5);{ PUSH ALL }
inline($06/$08/$2a/$fa/$c4/$ed/$5b/$fc/$c4);
inline($cb/$46/$3e/$38/$cb/$a7/$28/$02/$cb/$e7/$cb/$06/$d3/$fe);
          {         ^ colour 38-black 07-white   }
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e3/$10/$da);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;

procedure played(s:tip1);
var f:file of byte;l:integer;h:byte;
begin
if lgs<>s then begin
assign(f,s);reset(f);lgs:=s;
if not(eof(f)) then read(f,h);l:=0;
while not(eof(f)) do begin read(f,mem[CONY+l]);l:=l+1;end;
if l>31800 then l:=31800;setpar(l,h);end;
play;end;


procedure erasef(k:byte);
const adr=$dd00;
      maxbl=40;
var f1              :file;
    s1              :string[40];
    uu,l2,u,l1,st,ed:integer;
    c               :char;
begin
     c:=chr(0);l2:=0;
     for u:=1 to 128 do if sl[u]=chr(1) then l2:=1;
     if l2=0 then begin
                  st:=a+y*(nmf+1)+1+x[cd] mod (nmf+1);
                  sl[st]:=chr(1);end;l1:=0;
     for u:=1 to 128 do
     if (sl[u]=chr(1))and((m[u][9]=' ')or(m[u][9]=''))
     then begin sl[u]:=chr(0);
     gotoxy(2,10);
       lowvideo;if k=0 then
       write('ERASE :') else
       write('PLAY  :');
       highvideo;
s1:=chr(65+drv[cd])+':';
s1:=s1+m[u];s1[11]:='.';
s1:=space(s1);
     write(s1:14);
if c<>'~' then read(kbd,c);
if (c='~')or(c=chr(13)) then
begin
  assign(f1,s1);l1:=1;
  if c<>chr(27) then if k=1 then played(s1) else begin
  erase(f1);
  if x[cd]>0 then x[cd]:=x[cd]-1 else if a>0 then a:=a-1;
  end;
end;
end;
if (l1=1)and(k=0) then readf(cd);
list(cv[cd]);
end;

begin
cd:=0;
for i:=0 to 2 do begin drv[i]:=cd;x[i]:=0;r[i]:=0;
v[i]:=0;nfd[i]:=0;cv[i]:=0;end;y:=0;
clrscr;
c:=chr(0);for i:=1 to 128 do
          begin
          m[i]:='';
          sl[i]:=chr(0);
          end;
init;
readf(0);
if drv[0]<>drv[1] then readf(1);
list(cv[0]);
a:=cv[cd];
nf:=nfd[drv[cd]];
repeat
c:=chr(0);
desen(cd);
read(kbd,c);

if c=chr(9) then begin cd:=1-cd;list1(cv[0]);
end;
case c of
'!':begin select;list(cv[0]);end;
'#':play;
'&':if nfd[drv[cd]]>0 then begin erasef(1);end;
'(':if nfd[drv[cd]]>0 then begin erasef(0);end;
end;
nf:=nfd[drv[cd]];

if c=chr(6) then
if sl[a+y*(nmf+1)+1+x[cd] mod (nmf+1)]=chr(1)
then sl[a+y*(nmf+1)+1+x[cd] mod (nmf+1)]:=chr(0)
else sl[a+y*(nmf+1)+1+x[cd] mod (nmf+1)]:=chr(1);
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
                  write(#07);end;
  if o='AUD' then erasef(1);

end;
end;

until c='_';
clrscr;
end.