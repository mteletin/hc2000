var i,j,k:integer;
procedure sfx001;
var k:integer;begin for k:=1 to 50 do begin
port[254]:=56;
for i:=1 to k do begin end;
port[254]:=0;
end;end;

procedure sfx002;
var k:integer;begin for k:=1 to 50 do begin
port[254]:=56;
for i:=1 to 51-k do begin end;
port[254]:=0;
end;end;

procedure sfx003(u:integer);
var k:integer;begin for k:=1 to u do begin
port[254]:=56;
for i:=1 to k do begin
port[254]:=56;port[254]:=0;end;
end;end;

procedure sfx004(u:integer);
var j,i,k:integer;
begin
j:=$e000;
for k:=0 to u do begin
port[254]:=mem[j]div 16*16;j:=j+1;
for i:=1 to k do begin end;
end;
end;

procedure sfx005(u:integer);
var j,i,k:integer;
begin
j:=$e000;
for k:=0 to u do begin
port[254]:=mem[j]div 16*16;j:=j+1;
for i:=1 to u-k do begin end;
end;
end;

procedure p1;
begin
{push all} inline($dd/$e5/$fd/$e5/$e5/$d5/$c5/$f5);
           inline(243/6/150/80/62/56/211/254/21/32/253);
           inline(62/0/144/87/62/0/211/254/21/32/253/16);
           inline(235/251);
{pop all}  inline($f1/$c1/$d1/$e1/$fd/$e1/$dd/$e1);
end;

procedure p2;
begin
{push all} inline($dd/$e5/$fd/$e5/$e5/$d5/$c5/$f5);
           inline(243/6/145/80/0/62/56/211/254/21/32/253);
           inline(0/62/0/144/87/62/0/211/254/21/32/253/16);
           inline(235/251);
{pop all}  inline($f1/$c1/$d1/$e1/$fd/$e1/$dd/$e1);
end;

begin

for k:=1 to 8 do begin
sfx004(50);delay(600);sfx005(50);delay(600);end;

for k:=1 to 4 do begin
sfx004(50);delay(100);sfx003(50);delay(500);sfx003(50);
sfx005(50);delay(500);end;

for k:=1 to 4 do begin
sfx004(50);delay(100);sfx001;delay(100);
for i:=1 to 4 do begin sfx003(50);delay(40);end;
sfx005(50);delay(100);sfx003(50);
for i:=1 to 4 do begin sfx002;delay(40);end;
end;

for k:=1 to 4 do begin
sfx004(50);delay(100);sfx001;delay(100);
for i:=1 to 2 do begin sfx003(50);p1;end;
sfx005(50);delay(100);sfx003(50);
for i:=1 to 2 do begin sfx002;p1;end;
end;

end.