var f    :text;
    i,j:integer;
    s    :string[66];
    a    :array[1..128]of string[66];
    c    :char;
begin
     assign(f,'USERLIST.SYS');
        {$i-}
        reset(f);
        {$i+}
     if ioresult<>0 then
        begin
           writeln('Error:File USERLIST.SYS not founded!');
           halt;
        end;
     i:=0;
     writeln('User-list:');
     while not(eof(f)) do
           begin
                write('<',i:3,'>');readln(f,s);
                write(s:16);read(f,j);
                write(' -=- ',j:2);readln(f,s);
                writeln('; ',s);i:=i+1;
                if (i>20)and(i mod 20=0) then read(kbd,c);
           end;
     close(f);
end.