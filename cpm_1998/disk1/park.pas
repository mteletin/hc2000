type tip=string[200];tpi=char;
var f,f1:text;c:char;h,j,x,y,n,k:integer;s,m:tip;

procedure hal;begin writeln('Reading $$$.SUB...');
halt;end;

procedure cop(s1,s2:tip);var f1,f2:text;c:char;begin
assign(f1,s1);assign(f2,s2);reset(f1);rewrite(f2);
while not(eof(f1)) do begin read(f1,c);write(f2,c);end;
close(f1);close(f2);end;

procedure commandprompt;begin
if h=0 then begin assign(f,'$$$.sub');rename(f,'BACKUP.PRK');end;
end;
procedure restoresub;begin
if j=0 then begin assign(f,'BACKUP.PRK');rename(f,'$$$.sub');end;
end;

procedure restore;begin
assign(f,'AUTO.SUB');rename(f,'PARK.TMP');
assign(f,'AUTO.OLD');rename(f,'AUTO.SUB');
assign(f,'PARK.TMP');rename(f,'AUTO.OLD');
end;

procedure specify;
begin write('Input the name of SUB-file:');readln(s);
assign(f,s); {$i-}  reset(f);  {$i+}  x:=0;
if ioresult<>0 then x:=1;close(f);if x=1 then
writeln('File:',s,' does not exists!')
else begin if k=1 then begin assign(f,'auto.old');erase(f);end;
assign(f,'AUTO.SUB');rename(f,'AUTO.OLD');assign(f1,'AUTO.SUB');
assign(f,s);reset(f);rewrite(f1);while not(eof(f)) do begin
read(f,c);write(f1,c);end;close(f);close(f1);end;end;

begin
repeat
assign(f,'AUTO.SUB'); {$i-} reset(f); {$i+}
if ioresult<>0 then begin writeln('AUTO.SUB is missing!');
writeln('PARK cannot run without this file...');halt;end;

assign(f,'BACKUP.PRK');j:=0;
{$i-} reset(f); {$i+} if ioresult<>0 then j:=1;

assign(f,'AUTO.OLD');
{$i-} reset(f); {$i+} k:=1;if ioresult<>0 then k:=0;

assign(f,'$$$.sub');h:=0;
{$i-} reset(f); {$i+} if ioresult<>0 then h:=2;
clrscr;
writeln('CP/M 2.22 Startup menu:');writeln;
writeln('1.Command prompt only');
writeln('2.Continue with current configuration');
if j=0 then writeln('3.Reinstall PARK');
writeln('4.Install a specified SUB-file');
if k=1 then writeln('0.Restore old AUTO.SUB');
close(f);writeln;
if k=1 then
writeln('WARNING! File AUTO.OLD existence confirmed!');
write('Option:');
repeat
repeat read(kbd,c);write(c,chr(8));
until (c>='0')and(c<='9');
until (c<>'0')or(k=1);
writeln(c);
if c='1' then begin commandprompt;hal;end;
if c='2' then hal;
if c='3' then restoresub;
if c='0' then restore;
if c='4' then specify;
until false;
end.