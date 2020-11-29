procedure iobord(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(82);c:=chr(32+x);write(a,b,c);end;
procedure border(x:integer);var a,b,c:char;begin
a:=chr(27);b:=chr(81);c:=chr(48+x);write(a,b,c);end;