program textprocesor;
const
a:array[1..12]of string[60]=('Menu settings:',
'Let spaces between commers (Turbo Pascal)->',
'Eliminate comments (Turbo Pascal)        ->',
'Eliminate all spaces (less one)          ->',
'Limited lines in visual range (by words) ->',
'Eliminate blank lines                    ->',
'Eliminate control chars                  ->',
'Input source filename (text to compact)  ->',
'Input destination filename (compacted)   ->',
'Now, working...',
'Operation completed.',
'(C) 1996 TIM Software Power Entertainment Ltd.');
var f1,f2:text;i,j,f,x,y,l1,l2,xx:integer;e:array[1..6]of boolean;
s1,s2:string[50];s,sv:string[255];c1,c2,c3:char;ok1,ok2,b1,b2,b3:boolean;
{$i prwindow.pas}
{$i priocrt.pas}
{$i prcolors.pas}
{$i prborder.pas}
{$i prclick.pas}

begin
border(7);iobord(7);paper(7);ink(0);clrscr;window(0,0,12,63);
gotoxy(3,2);write(a[1]);for f:=1 to 6 do e[f]:=true;xx:=x;
for f:=2 to 11 do begin gotoxy(3,f+1);write(a[f]);
if (f-1)<7 then if e[f-1] then write('Enabled ') else
write('Disabled');end;
x:=1;s1:='';s2:='';ok1:=false;ok1:=false;xx:=1;
repeat
if xx<>x then begin gotoxy(3,xx+2);write(a[xx+1]);
if xx<7 then if e[xx]then write('Enabled ')else write('Disabled');
if xx=7 then write(s1);if xx=8 then write(s2);end;

gotoxy(3,x+2);lowvideo;write(a[x+1]);if x<7 then
if e[x]then write('Enabled ') else write('Disabled');
if x=7 then write(s1);if x=8 then write(s2);highvideo;

repeat c1:=readkey;until (((c1=chr(5))or(c1=chr(24)))or
((c1=chr(4))or(c1=chr(19))))or(c1=chr(13));
if (c1=chr(5))and(x>1)then begin xx:=x;x:=x-1;end;
if (c1=chr(24))and(x<10)then begin xx:=x;x:=x+1;end;
if ((c1=chr(19))or(c1=chr(4)))and(x<7)then begin e[x]:=not e[x];end;
if (c1=chr(13))then if x=7 then begin ok1:=true;
gotoxy(3,9);write(a[8]);read(s1);write('  ');end
else if x=8 then begin gotoxy(3,10);write(a[9]);read(s2);
write('  ');ok2:=true;end
else if x=9 then if ok1 and ok2 then begin

{main program}




end;
until (c1=chr(13))and(x=10);
writeln;writeln;end.