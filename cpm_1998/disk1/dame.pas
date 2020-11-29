program dame;
const a:integer=1;v='*';
var x:array[1..100]of integer;
 b,i,j,s,n,z,k:integer;
procedure print;
var l,i,j:integer;begin
gotoxy(b+1,a+1);writeln('Sol:',s);s:=s+1;
for i:=1 to n do begin for j:=1 to n do begin
if (j mod 2)xor(i mod 2)=1 then lowvideo else highvideo;
gotoxy(b+j,a+i+1);if x[i]=j then write(v) else write(' ');
end;end;b:=b+n+2;if b>56 then begin b:=0;
if (a+n+n)<21 then a:=a+n+2 else begin readln;
for l:=1 to n+1 do begin gotoxy(1,24);writeln;end;end;
end;end;

function verif(k:integer):boolean;var i:integer;
begin verif:=true;for i:=1 to k-1 do
if (x[i]=x[k])or(abs(i-k)=abs(x[i]-x[k])) then verif:=false;
end;begin write(chr(24));s:=1;b:=0;
write('Introduceti numarul de dame (care e si latura tablei):');
readln(n);a:=1;k:=1;x[k]:=0;
while k>0 do
 begin
 z:=0;
 while (x[k]<n)and(z=0) do
 begin
 x[k]:=x[k]+1;
 if verif(k) then z:=1;
 end;
 if z=0 then k:=k-1
 else
 if k=n then
 begin print;
 end
 else
 begin
 k:=k+1;
 x[k]:=0;
 end;
 end;
writeln;
write('Apasa RETURN (CR) ...');readln;
end.r