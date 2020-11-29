type  tip1=string[66];
      menu=record
          n,c,p:byte;
          m:array[1..20]of tip1;
          end;
const name:tip1='main.grp';
var   a,b,c,d:menu;man,aux:integer;ok:boolean;

procedure ink(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(73);c:=chr(48+x);write(a,b,c);end;
procedure paper(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(80);c:=chr(48+x);write(a,b,c);end;

procedure readmen(s:tip1);
var f:text;p:tip1;k:byte;b:boolean;
begin
assign(f,name);reset(f);b:=true;ok:=false;
while (not(eof(f)))and b do begin
readln(f,p);if p=s then begin
read(f,a.n);readln(f,a.p);b:=false;ok:=true;
for k:=1 to a.n do readln(f,a.m[k]);
end;
end;close(f);end;

function extract1(m:tip1):tip1;
var x:byte;l:tip1;
begin
l:='';x:=1;while (m[x]<>'\')and(x<=length(m))do begin
l:=l+m[x];x:=x+1;end;extract1:=l;end;

function extract2(m:tip1):tip1;
var x:byte;l:tip1;
begin
l:='';x:=1;while (m[x]<>'\')and(x<=length(m))do x:=x+1;x:=x+1;
if x>=length(m) then begin end
else while (m[x]<>';')and(x<=length(m))do begin
l:=l+m[x];x:=x+1;end;extract2:=l;end;

function extract3(m:tip1):tip1;
var x:byte;l:tip1;
begin
l:='';x:=1;while (m[x]<>'\')and(x<=length(m))do x:=x+1;x:=x+1;
if x>=length(m) then begin end
   else begin
        while (m[x]<>';')and(x<=length(m))do x:=x+1;x:=x+1;
        if x>=length(m) then begin end
           else begin
                while (x<=length(m)) do
                      begin
                      l:=l+m[x];x:=x+1;
                      end;
           end;
        end;
extract3:=l;
end;

function popup(v:menu;x,y,pa,inc:byte):byte;
var i,j,k:byte;
    c:char;
begin
paper(pa);ink(inc);j:=0;
for i:=1 to v.n do if j<length(extract1(v.m[i])) then
j:=length(extract1(v.m[i]));
for i:=1 to v.n do begin
    gotoxy(x,y-1+i);write(extract1(v.m[i]));
    if length(extract1(v.m[i]))<j then
       for k:=1 to j-length(extract1(v.m[i])) do write(' ');
    end;
i:=1;
repeat
paper(inc);ink(pa);
gotoxy(x,y-1+i);write(extract1(v.m[i]));
    if length(extract1(v.m[i]))<j then
       for k:=1 to j-length(extract1(v.m[i])) do write(' ');
paper(1);ink(6);
gotoxy(1,24);delline;
gotoxy(1,24);write(extract2(v.m[i]));
read(kbd,c);k:=i;
if (i<v.n)and(c=chr(24)) then i:=i+1;
if (i>1)and(c=chr(5)) then i:=i-1;
paper(pa);ink(inc);
gotoxy(x,y-1+k);write(extract1(v.m[k]));
    if length(extract1(v.m[k]))<j then
       for k:=1 to j-length(extract1(v.m[k])) do write(' ');
until (c=chr(13))or(c='E');
if c=chr(13) then popup:=i
else popup:=0;paper(1);ink(6);end;

begin
clrscr;man:=1;
readmen('main');
repeat
aux:=popup(a,1+a.p*2,1+a.p,7-a.p,a.p);
if aux<>0 then begin readmen(extract3(a.m[aux]));man:=man+1;
if man>=8 then man:=1;end;
until (aux=0)or(not ok);
clrscr;
end.