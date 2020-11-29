procedure plot(x,y,c:integer);
begin
if x mod 2=1 then begin gotoxy(x,y);lowvideo;
ink(m[x,y]);paper(m[x+1,y]);write(' ');highvideo;end
else begin gotoxy(x,y);ink(m[x-1,y]);paper(m[x,y]);write(' ');end;
end;