var f:file;f1:file of real;b:array[1..128]of byte;g:integer;
begin
assign(f,'turbo.com');
reset(f);
while not eof(f) do begin
blockread(f,b,1);
for g:=1 to 128 do
if (b[g]>31)and(b[g]<128) then write(chr(b[g]));end;
close(f);
end.