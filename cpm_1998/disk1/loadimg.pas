var m:integer;l,h,r:byte;
    f:file;
    s:string[30];
begin
write('File of name:');readln(s);
assign(f,s+'.scr');reset(f);blockread(f,mem[$7500-9],54);
for m:=0 to 6911 do begin
h:=m div 256;l:=m mod 256;
mem[$bfff]:=h;mem[$bffe]:=l;mem[$bffd]:=mem[$7500+m];
inline($F3/$3E/$EE/$D3/$C5/$21/$00/$c0/$ED);
inline($5B/$FE/$BF/$19/$3A/$FD/$BF/$77/$3E/$EE/$D3/$C7/$FB);
end;close(f);readln;
end.