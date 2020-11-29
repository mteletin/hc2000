var f:file of byte;l:integer;st:string[20];s:byte;
{$i prmusic.pas}
begin write('Name of file (8 chr):');readln(st);
assign(f,st+'.aud');reset(f);read(f,s);l:=0;
write('Press any to stop...');
while not(eof(f)) do begin read(f,mem[$2200+l]);l:=l+1;end;
setpar(s,l);repeat play;delay(1) until (port[254]=190)or(port[254]=254);
end.