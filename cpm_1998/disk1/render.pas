const nmax=7;
      dimmax=20;
      nrvf=5;
      iki=2;
var a:array[1..dimmax,1..dimmax]of byte;
    r:array[1..100]of byte;
    uk,o,n,i:byte;

procedure ink(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(73);c:=chr(48+x);write(a,b,c);end;
procedure paper(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(80);c:=chr(48+x);write(a,b,c);end;

procedure list(o:byte);
var m:integer;h,l,i,j:byte;
begin
for i:=1 to dimmax do
for j:=1 to dimmax do begin
m:=(i-1)+(j-1)*32;h:=m div 256;l:=m mod 256;
mem[$bfff]:=h;mem[$bffe]:=l;mem[$bffd]:=(((a[i,j]+o)mod 8)*8);
inline($F3/$3E/$EE/$D3/$C5/$21/$00/$D8/$ED);
inline($5B/$FE/$BF/$19/$3A/$FD/$BF/$77/$3E/$EE/$D3/$C7/$FB);
end;
end;

procedure mark(v:byte);
var i,j:byte;k,l:integer;
begin
for i:=2 to dimmax-1 do
for j:=2 to dimmax-1 do
if (a[i,j]=0) then
for k:=-1 to 1 do
for l:=-1 to 1 do
begin
if (a[i+k,j+l]>v)and(r[uk]=0) then
     a[i,j]:=v;
begin uk:=uk+1;if uk>100 then uk:=1;end;
end;
end;


procedure init;
var i,j:byte;
begin
uk:=1;
for i:=1 to dimmax do
for j:=1 to dimmax do
a[i,j]:=0;
for i:=1 to nrvf do
a[random(dimmax-2)+2,random(dimmax-2)+2]:=nmax;
for i:=nmax downto 1 do
mark(i);
for i:=1 to 100 do r[i]:=random(iki);
end;


begin
ink(6);paper(1);clrscr;
init;
list(0);
end.