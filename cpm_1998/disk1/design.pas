var m:array[1..64,1..24]of byte;x,y,cl:integer;ch:char;
{$i b:prcolors.pas}
procedure plot(x,y:integer);
begin
if x mod 2=1 then begin gotoxy(x,y);lowvideo;
ink(m[x,y]);paper(m[x+1,y]);write(' ');highvideo;end
else begin gotoxy(x-1,y);ink(m[x-1,y]);paper(m[x,y]);lowvideo;
write(' ');highvideo;end;
end;
procedure save;var x,y:integer;f:file of byte;s:string[40];
begin gotoxy(1,24);write('Input filename:');read(s);
assign(f,s);rewrite(f);for x:=1 to 64 do for y:=1 to 23 do
write(f,m[x,y]);close(f);end;
procedure cursor(var x,y:integer;var c:char);
const crm:set of char=['M','N',' ']; {<-taste de foc}
begin repeat gotoxy(x,y);read(kbd,c);c:=upcase(c);
if(c='Q')and(y>1)then y:=y-1;if(c='A')and(y<24)then y:=y+1;
if(c='P')and(x<64)then x:=x+1;if(c='O')and(x>1)then x:=x-1;
if(y=24)and(x=64)then x:=x-1;gotoxy(x,y);until c in crm;end;
begin
clrscr;gotoxy(1,24);for x:=0 to 7 do begin paper(x);
write('      ');end;paper(7);ink(0);
lowvideo;write('|SAVE |EXIT |');highvideo;
for x:=1 to 64 do for y:=1 to 24 do m[x,y]:=7;
cl:=0;x:=32;y:=12;repeat cursor(x,y,ch);
if(y=24)then begin
if(x<49)then cl:=x div 6;
if(x>49)and(x<56)then save;
if x>56 then begin
gotoxy(1,24);write('Save CURRENT image? (y/n)');
read(kbd,ch);ch:=upcase(ch);if ch='Y' then save;
paper(7);ink(0);halt;end;end else begin m[x,y]:=cl;
plot(x,y);end;gotoxy(x,y);until false;end.