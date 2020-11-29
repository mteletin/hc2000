var c:char;ok:boolean;
    f:text;s:string[60];
begin
 clrscr;write('Nume fisier:');readln(s);
 assign(f,s);
 rewrite(f);ok:=true;
 while ok do
  begin
   if c=chr(13) then begin writeln;writeln(f);end;
   read(kbd,c);
   if (c<>chr(26))and(c<>chr(13)) then write(f,c);
   write(c);
   if c=chr(26) then ok:=false;
  end;
 close(f);
end.