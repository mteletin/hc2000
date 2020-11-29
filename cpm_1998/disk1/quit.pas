const a:array[1..5]of string[64]=(
'     0:2      0 0 0          :7     0     0            :7 :7',
'     690       787          :87    787   787          :87:87',
'     0 0:20 0 0 0  :7  :7 72 0 :72  0 :2  0 00:7:2  :2 0  0 ',
'     0 000000 0 0  32  32:71 0 679  0 00  0 000 00  00 0  0 ',
'     0 039349 0 37 79  79374 0 37   3739  37390 00  39 0  0 ');

var i,j     :integer;
{$i prwindow.pas}
{$i prcolors.pas}
{$i prborder.pas}
begin
border(0);iobord(0);ink(5);paper(0);clrscr;
gotoxy(1,8);
for i:=1 to 5 do begin
for j:=1 to length(a[i]) do
if a[i][j]=' 'then begin set1;write(' ');end
              else begin set2;write(chr(ord(a[i][j])-16));end;
writeln;
end;
gotoxy(26,14);write('YOUR COMPUTER...');
end.