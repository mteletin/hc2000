function readkey:char;begin bdos(1);readkey:=chr(mem[$c845]);end;
procedure printc(c:char);begin bdos(2,ord(c));end;