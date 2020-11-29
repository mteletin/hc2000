type tim=array[1..10000]of byte;
var f:file;ad,sg,ax,bx,cx,dx,sp:integer;
    stack:array[1..2000]of integer;
    mem:^tim;
procedure inc(var x:integer);begin x:=x+1;end;
procedure dec(var x:integer);begin x:=x-1;end;
procedure push(var x:integer);begin sp:=sp+1;stack[sp]:=x;end;
procedure pop(var x:integer);begin sp:=sp-1;x:=stack[sp];end;
procedure clrstk;begin sp:=1000;end;
procedure clrmem;begin for ax:=1 to 10000 do mem[ax]:=0;end;