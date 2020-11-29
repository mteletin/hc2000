Type
TipStr=string[30];
TipHarta=Packed array[1..100,1..100]of 1..15;
TipUnitate=record
        Nume:Char;
        Mobila,Vie:Boolean;
        TipTeren,Tip,Atac,Aparare,Prod:Byte;
        Tipprod,Cost,Tipcost,X,Y,Mut:Byte;
        end;
TipJucator=record
        Unitati:array[1..255]of TipUnitate;
        Construct,Hrana,Aluminiu,Armament:Integer;
        end;
TipTeren=record
         Tip:char;
         Mut:byte;
         end;
Var  NrJuc:integer;
     Jucator:array[1..4]of TipJucator;
     Unitate:array[1..10]of TipUnitate;
     FU:file of TipUnitate;
     FT:file of TipTeren;
     FM:file of TipHarta;
     Teren:array[1..15]of TipTeren;
     Map:TipHarta;
     S:TipStr;

Procedure ViewMap(x,y:integer);
Var i,j,a,b:integer;
Begin
x:=x-16;y:=y-8;
if x<1 then x:=1;
if y<1 then y:=1;
if x>69 then x:=69;
if y>85 then y:=85;

for i:=0 to 15 do
for j:=0 to 31 do
begin a:=x+i;b:=y+b;
gotoxy(i+1,j+1);
If Map[a,b]<5 then
   write(Teren[Map[a,b]].Tip)
Else write(Unitate[Teren[Map[a,b]].Mut].Nume);
end;

End;

Procedure LoadMap;
begin
clrscr;write('Input the name of the map:');readln(s);
assign(FM,s);reset(FM);read(FM,Map);close(FM);
End;

begin
end.