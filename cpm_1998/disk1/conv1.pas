{$m 4092,0,0}
var f1:file;f2:file of byte;s1,s2:string[30];sp:integer;
c:char;ex:boolean;
procedure NON;begin writeln('Non available!');end;
procedure MODAUD;
var n,i,k:integer;begin
write('Source file:');readln(s1);write('Destination file:');
readln(s2);assign(f1,s1);assign(f2,s2);reset(f1);rewrite(f2);
k:=0;while not(eof(f1)) do begin
blockread(f1,mem[$b000],1);for i:=1 to 128 do begin
k:=k+1;if (k>9)or(k<0) then begin
if k=10 then write(f2,mem[$afff+k mod 128]);
if k>=14 then write(f2,mem[$afff+k mod 128]);end;
end;end;
close(f1);close(f2);end;
procedure AUDCSD;begin NON;end;
procedure CSDAUD;begin NON;end;
procedure BTXT;begin NON;end;
procedure CTXT;begin NON;end;
begin crtinit;clrscr;repeat;
gotoxy(1,4);writeln('MENU:');
writeln('1.from BASIC-MOD to CP/M-AUD');
writeln('2.from AUD       to CSD');
writeln('3.from CSD       to AUD');
writeln('4.from BASIC-TXT to CP/M-TXT');
writeln('5.from CP/M-TXT  to BASIC-TXT');
writeln('0.EXIT');
read(kbd,c);
if c='1' then MODAUD
else if c='2' then AUDCSD
else if c='3' then CSDAUD
else if c='4' then BTXT
else if c='5' then CTXT
else if c='0' then ex:=true
else ex:=false;
until ex;clrscr;crtexit;end.