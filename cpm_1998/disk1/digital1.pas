var st:array[1..10]of byte;ln,x:integer;c:char;
s:string[25];f:file of byte;sp:byte;

procedure setpar(s,l:integer);begin mem[$c4fe]:=s;
mem[$c4fc]:=lo(l);mem[$c4fd]:=hi(l);mem[$c4fa]:=$00;
mem[$c4fb]:=$22;end;

procedure rec;begin
inline($f3);
inline($e5/$c5/$d5/$f5);{ PUSH ALL }
inline($06/$08/$2a/$fa/$c4/$ed/$5b/$fc/$c4);
inline($db/$fe/$cb/$77/$cb/$86/$28/$02/$cb/$c6/$cb/$06);
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e5/$10/$dc);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;

procedure play;begin
inline($f3);
inline($e5/$c5/$d5/$f5);{ PUSH ALL }
inline($06/$08/$2a/$fa/$c4/$ed/$5b/$fc/$c4);
inline($cb/$46/$3e/$38/$cb/$a7/$28/$02/$cb/$e7/$cb/$06/$d3/$fe);
               {     ^      }
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e3/$10/$da);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;

begin
setpar(1,10000);s:='noname.aud';
repeat clrscr;lowvideo;writeln('Menu');highvideo;
writeln('1.Record 2.Play 3.Speed & len(max 32767) 4.Exit');
writeln('5.Save 6.Load Sp:',sp:4,' Len:',ln,' ',s);
c:=' ';read(kbd,c);if c='3' then begin
write('Ln:');read(ln);write(' Sp:');readln(sp);
setpar(sp,ln);end;if c='1' then rec;if c='2' then play;
if c='5' then begin writeln('FileName:');read(s);s:=s+'.aud';
assign(f,s);rewrite(f);write(f,sp);for x:=1 to ln do
write(f,mem[$21FF+x]);close(f);end;if c='6' then begin
write('FileName:');read(s);s:=s+'.aud';assign(f,s);
{$i-} reset(f);{$i+}
if ioresult<>0 then s:='NotFound!'
else begin ln:=0;read(f,sp);while not (eof(f)) do begin
read(f,mem[$21FF+ln]);ln:=ln+1;end;end;close(f);setpar(sp,ln);
end;until c='4';
end.