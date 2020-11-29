type tip1=string[66];
var s,s1:tip1;
    f:text;
    i,j:integer;
    ok:boolean;
begin
   mem[4]:=mem[4]mod 16;j:=0;
   assign(f,'userlist.sys');
repeat
      {$i-}
      reset(f);
      {$i+}

      if ioresult<>0 then
               begin
                    writeln('File USERLIST.SYS not found!');
                    halt;
               end;

      ok:=false;
      write('Login:');readln(s);
 while (not(eof(f)))and(not ok) do
          begin
               readln(f,s1);
               if s1=s then
                       begin
                            ok:=true;
                            readln(f,j);
                            mem[4]:=mem[4]mod 16+j*16;
                            writeln('User ',s,' loged in...');
                            halt;
                       end;
          end;
       writeln('Incorrect login (type "sys" to exit)');
until ok;
end.