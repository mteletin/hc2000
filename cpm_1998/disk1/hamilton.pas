program hamiltonian;
var x:array[1..30]of integer;
    a:array[1..30,1..30]of integer;
    m,n,i,j,k,v,sol,p,q:integer;
begin
write('n,m=');readln(n,m);
for p:=1 to n do
    for q:=1 to n do a[p,q]:=0;
for k:=1 to m do begin
                 write('muchia x y =');readln(p,q);
                 a[p,q]:=1;a[q,p]:=q;
                 end;
sol:=0;
x[1]:=1;
k:=2;x[2]:=1;
while k>1 do begin
             v:=0;
             while (x[k]+1<=n)and(v=0)do
                   begin
                   x[k]:=x[k]+1;
                   v:=1;
                   for i:=1 to k-1 do
                       if x[k]=x[i] then begin
                                         v:=0;
                                         i:=k-1;
                                         end;
                   if a[x[k-1],x[k]]=0 then v:=0;
                   end;
             if v=0 then k:=k-1
             else if (k=n)and(a[x[n],x[1]]=1)then
                                begin
                                sol:=sol+1;
                                if sol=1 then writeln('Cicluri hamiltoniene:');
                                for j:=1 to n do write(x[j],' ');
                                writeln;
                                end
                  else if k<n then begin
                                   k:=k+1;
                                   x[k]:=1;
                                   end;
             end;
if sol=0 then writeln('Graful dat nu este hamiltonian.');
end.