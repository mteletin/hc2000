var f:text;i,k:integer;c:char;

procedure delay(x:integer);var a:char;u:integer;begin
a:=chr(0);for u:=1 to x do write(f,a);end;

procedure at(x,y:integer);var a,b,c,d:char;begin a:=chr(27);
b:=chr(65);c:=chr(x+32);d:=chr(y+32);write(f,a,b,c,d);end;
procedure cls;var c:char;begin c:=chr(24);write(f,c);end;

procedure iobord(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(82);c:=chr(32+x);write(f,a,b,c);end;
procedure border(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(81);c:=chr(48+x);write(f,a,b,c);end;

procedure ivideo;var a,b,c:char;begin
a:=chr(27);b:=chr(106);write(f,a,b);end;
procedure tvideo;var a,b,c:char;begin
a:=chr(27);b:=chr(107);write(f,a,b);end;

procedure ink(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(73);c:=chr(48+x);write(f,a,b,c);end;
procedure paper(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(80);c:=chr(48+x);write(f,a,b,c);end;

procedure set1;var a,b,c:char;begin
a:=chr(27);b:=chr(113);write(f,a,b);end;
procedure set2;var a,b,c:char;begin
a:=chr(27);b:=chr(112);write(f,a,b);end;

procedure window(x,y,xx,yy:integer);var k:integer;a:char;
s:string[66];begin if x<xx then if y<yy then begin set2;s:='';
for k:=y to yy-1 do s:=s+' ';at(x,y);a:=chr(42);
write(f,a);a:=chr(39);for k:=y+1 to yy-1 do begin at(x,k);
write(f,a);at(xx,k);write(f,a);end;a:=chr(34);at(x,yy);
write(f,a);a:=chr(32);for k:=x+1 to xx-1 do begin at(k,y);
set2;write(f,a);set1;write(f,s);set2;at(k,yy);write(f,a);end;
a:=chr(35);at(xx,y);write(f,a);a:=chr(41);at(xx,yy);
write(f,a);set1;end;end;

begin
assign(f,'DEMO1.DEM');rewrite(f);
paper(0);ink(7);cls;window(0,0,6,63);
at(1,2);write(f,'(C) 1997 TIM SOFTWARE POWER   Entertainment Ltd.');
at(2,2);write(f,'This is a demonstration file .  To a larger  set');
at(3,2);write(f,'of programs that you can have from TIM. See you!');
for k:=10 downto 0 do
    begin
    at(5,1);write(f,k:3);
    delay(400);
    end;
for k:=7 downto 0 do begin
ink(k);
at(1,2);write(f,'(C) 1997 TIM SOFTWARE POWER   Entertainment Ltd.');
at(2,2);write(f,'This is a demonstration file .  To a larger  set');
at(3,2);write(f,'of programs that you can have from TIM. See you!');
end;
ink(7);cls;
paper(2);ink(6);
window(11,32,22,63);
at(12,33);write(f,'So, this is a ');
at(13,33);write(f,'demonstration file!');
delay(1000);
at(14,33);write(f,'Let''s see what you');
at(15,33);write(f,'can get from here...');
delay(500);
at(16,33);write(f,'Let''s have another');
at(17,33);write(f,'window...');
paper(1);ink(5);window(2,2,17,31);
delay(300);
at(3,3);write(f,'Hello!');
delay(1000);
ink(6);paper(2);
at(18,33);write(f,'Let''s clear this window!');
delay(600);
window(11,32,22,63);
ink(7);paper(3);window(4,18,19,47);
at(5,19);write(f,'That''s better...');delay(1300);
paper(1);ink(5);window(17,0,23,21);
at(18,1);write(f,'Message!');
ink(7);paper(3);
at(6,19);write(f,'This will be the');
at(7,19);write(f,'message window.');
delay(2000);
paper(2);ink(6);window(0,0,16,63);


ink(5);paper(1);
close(f);
reset(f);
while not(eof(f)) do begin
read(f,c);write(c);end;
close(f);
end.