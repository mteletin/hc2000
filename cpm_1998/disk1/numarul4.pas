var a:array[1..1024]of real;
    j,s:integer;i,n:real;
begin
write('Dati n:');readln(n);
s:=1;i:=n;
while i>0 do begin
a[s]:=i;
s:=s+1;
if (i-10*int(i/10)=4)or(i-10*int(i/10)=0)then i:=int(i/10)
   else i:=i*2;
end;
for j:=s-1 downto 1 do write(' ',a[j]:0:0);
end.