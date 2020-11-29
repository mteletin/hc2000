function keypressed:boolean;
var a:integer;begin bdos(11,a);if a=0 then keypressed=false
else f:=true;end;
function readkey:char;begin read(kbd,readkey);end;