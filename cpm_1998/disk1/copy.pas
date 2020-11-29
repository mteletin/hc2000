const adr=$7700;
      maxbl=40;
var f1,f2:file;
    s1,s2:string[40];
    uu,l2,u,l1:integer;c:char;
begin repeat
writeln('(c) 1997 TIM''S Copy program (interdrive).');
write('            Copy from:');readln(s1);
write('                   To:');readln(s2);
assign(f1,s1);reset(f1);assign(f2,s2);rewrite(f2);
l1:=filesize(f1);
while not(eof(f1)) do begin uu:=0;
while (uu<maxbl)and((l1>0)and(not(eof(f1))))do begin
u:=1;blockread(f1,mem[adr+128*(uu-1)],u);l1:=l1-1;uu:=uu+1;end;
for l2:=1 to uu do begin
u:=1;blockwrite(f2,mem[adr+128*(l2-1)],u);end;end;
close(f1);close(f2);
write('More?(y/n)');read(kbd,c);c:=upcase(c);until (c='N');end.