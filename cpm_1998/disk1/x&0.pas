const b:array[1..3,1..3]of byte=((2,1,2),(1,3,1),(2,1,2));
var a:array[1..3,1..3]of byte;
    x,y,o,i,j:byte;
    c:char;

procedure pass1;
var i,j:byte;
begin
o:=0;
for j:=1 to 3 do
    if o=0 then
for i:=1 to 3 do
if(a[(j mod 3)+1,i]=1)and(a[((j+1) mod 3)+1,i]=1)then
     begin x:=((j+2) mod 3)+1;y:=i;if a[x,y]=0 then o:=1;end;
if(a[x,y]=1)and(o=1)then o:=2;
for j:=1 to 3 do
    if o=0 then
for i:=1 to 3 do
if(a[i,(j mod 3)+1]=1)and(a[i,((j+1) mod 3)+1]=1)then
     begin x:=i;y:=((j+2) mod 3)+1;if a[x,y]=0 then o:=1;end;
if(a[x,y]=1)and(o=1)then o:=2;
for j:=1 to 3 do
if (o=0)and((a[(j mod 3)+1,(j mod 3)+1]=1)and(a[((j+1)mod 3)+1,((j+1)mod 3)+1]=1))then
     begin x:=((j+2)mod 3)+1;y:=x;if a[x,y]=0 then o:=1;end;
if(a[x,y]=1)and(o=1)then o:=2;
for j:=1 to 3 do
if (o=0)and((a[(j mod 3)+1,4-(j mod 3)+1]=1)and(a[((j+1)mod 3)+1,4-((j+1)mod 3)+1]=1))then
 begin x:=((j+2)mod 3)+1;y:=4-x;if a[x,y]=0 then o:=1;end;
if (a[x,y]=1)and(o=1) then o:=2;
end;

procedure pass2;
var i,j:byte;
begin
o:=0;
for j:=1 to 3 do
    if o=0 then
for i:=1 to 3 do
if(a[(j mod 3)+1,i]=2)and(a[((j+1) mod 3)+1,i]=2)then
     begin x:=((j+2) mod 3)+1;y:=i;if a[x,y]=0 then o:=1;end;
if(a[x,y]=2)and(o=1)then o:=2;
for j:=1 to 3 do
    if o=0 then
for i:=1 to 3 do
if(a[i,(j mod 3)+1]=2)and(a[i,((j+1) mod 3)+1]=2)then
     begin x:=i;y:=((j+2) mod 3)+1;if a[x,y]=0 then o:=1;end;
if(a[x,y]=2)and(o=1)then o:=2;
for j:=1 to 3 do
if (o=0)and((a[(j mod 3)+1,(j mod 3)+1]=2)and(a[((j+1)mod 3)+1,((j+1)mod 3)+1]=2))then
     begin x:=((j+2)mod 3)+1;y:=x;if a[x,y]=0 then o:=1;end;
if(a[x,y]=2)and(o=1)then o:=2;
for j:=1 to 3 do
if (o=0)and((a[(j mod 3)+1,4-(j mod 3)+1]=2)and(a[((j+1)mod 3)+1,4-((j+1)mod 3)+1]=2))then
     begin x:=((j+2)mod 3)+1;y:=4-x;if a[x,y]=0 then o:=1;end;
if (a[x,y]=2)and(o=1) then o:=2;
end;

procedure init;
var i,j:byte;
begin
for i:=1 to 3 do
for j:=1 to 3 do
a[i,j]:=0;
end;

procedure list;
var i,j:byte;
begin
gotoxy(7,5);write('1 2 3');
gotoxy(9,4);write('X');
gotoxy(5,7);write('1');
gotoxy(5,9);write('2');
gotoxy(5,11);write('3');
gotoxy(4,9);write('Y');
for i:=1 to 3 do
for j:=1 to 3 do
begin gotoxy(5+i*2,5+j*2);write(a[i,j]);
end;end;

procedure find;
var i,j,s:byte;
begin
s:=0;
for i:=1 to 3 do
for j:=1 to 3 do
begin
if s=0 then begin if a[i,j]=0 then begin s:=1;x:=i;y:=j;end;end
   else if (a[i,j]=0)and(b[i,j]>b[x,y]) then begin x:=i;y:=j;end;
end;
if s=0 then begin gotoxy(1,1);writeln('REMIZA!');halt;end;
end;


procedure computer;
begin
pass2;
if o=2 then begin
list;gotoxy(1,1);write('I won!');
halt;end
else if o=1 then begin
a[x,y]:=2;list;gotoxy(1,1);write('I won!');halt;
end
else begin
pass1;
if o=2 then begin
list;gotoxy(1,1);write('You win!');
halt;end
else if o=1 then begin
a[x,y]:=2;list;end
else begin
find;a[x,y]:=2;
list;end;
end;
end;

function search:byte;
var i,j,s:byte;
begin
s:=0;
for i:=1 to 3 do
for j:=1 to 3 do
if a[i,j]=0 then s:=1;
search:=s;
end;

procedure jucator;
var i,j:byte;
begin
repeat
clrscr;
list;
gotoxy(32,4);
write('x:');readln(x);
gotoxy(32,5);
write('y:');readln(y);
until a[x,y]=0;
a[x,y]:=1;
end;

begin
init;clrscr;list;
gotoxy(1,24);write('Cine e primul (c/j/e=exit):');
repeat read(kbd,c);
c:=upcase(c);until (c='C')or(c='J')or(c='E');
if c='E' then halt;
if c='J' then jucator;
repeat
computer;
if search=0 then begin
gotoxy(1,1);write('REMIZA!');halt;end;
jucator;
list;
until false;
end.