var m:integer;l,h,r:byte;
    f:file of byte;
    s:string[30];
begin
write('File of name:');readln(s);
assign(f,s+'.img');rewrite(f);
for m:=1 to 6144 do begin
h:=m div 256;l:=m mod 256;
mem[$bfff]:=h;mem[$bffe]:=l;
inline($F3/$3E/$EE/$D3/$C5/$21/$00/$c0/$ED);
inline($5B/$FE/$BF/$19/$7E/$32/$FD/$BF/$3E/$EE/$D3/$C7/$FB);
r:=mem[$bffd];write(f,r);
end;close(f);
end.