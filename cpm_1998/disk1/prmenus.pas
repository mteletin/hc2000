type mnu=array[1..20]of string[60];
     str=string[60];
{var a:mnu;b:integer;}
{trebuie si prwindow.pas}
procedure nwindow(x,y,xx,yy:integer;c:char);var k:integer;s:string[62];
begin x:=x+1;y:=y+1;xx:=xx+1;yy:=yy+1;s:='';for k:=y to yy do s:=s+c;
for k:=x to xx do begin gotoxy(y,k);write(s);end;end;

procedure option(x,y,l:byte;s:str);
begin if l=1 then lowvideo else highvideo;
window(y-1,x-1,y+1,x+length(s));gotoxy(x+1,y+1);
write(s);highvideo;end;

function menu(x,y,n,o:byte;a:mnu):integer;
var m,i,j,k:byte;
    c:char;
begin
m:=0;highvideo;
for i:=1 to n do if length(a[i])>m then m:=length(a[i]);
nwindow(y-1,x-1,y+n,x+m,' ');
for i:=1 to n do begin gotoxy(x+1,y+i);write(a[i]);end;
i:=o;j:=o;
repeat
gotoxy(x+1,y+j);highvideo;write(a[j]);
gotoxy(x+1,y+i);lowvideo;write(a[i]);
read(kbd,c);menu:=i;
if c=chr(5) then if i>1 then begin j:=i;i:=i-1;end;
if c=chr(24) then if i<n then begin j:=i;i:=i+1;end;
until (c=chr(13))or(c=chr(27));
if c=chr(27) then menu:=0;
end;

{begin
a[1]:='directory';
a[2]:='file operation';
a[3]:='run';
a[4]:='exit';
b:=menu(5,5,4,2,a);
option(2,2,1,a[b]);
end.}