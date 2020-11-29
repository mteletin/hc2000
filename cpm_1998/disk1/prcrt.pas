procedure at(x,y:integer);var a,b,c,d:char;begin a:=chr(27);
b:=chr(65);c:=chr(x+32);d:=chr(y+32);write(a,b,c,d);end;
procedure cls;var c:char;begin c:=chr(24);write(c);end;