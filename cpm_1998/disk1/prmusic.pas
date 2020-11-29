procedure setpar(s,l:integer);begin mem[$c4fe]:=s;
mem[$c4fc]:=l mod 256;mem[$c4fd]:=l div 256;mem[$c4fa]:=0;
mem[$c4fb]:=$22;end;

procedure rec;begin
inline($f3);
inline($e5/$c5/$d5/$f5);{ PUSH ALL }
inline($06/$08/$2a/$fa/$c4/$ed/$5b/$fc/$c4);
inline($db/$fe/$cb/$77/$cb/$86/$28/$02/$cb/$c6/$cb/$06);
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e5/$10/$dc);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;

procedure play;begin
inline($f3);
inline($e5/$c5/$d5/$f5);{ PUSH ALL }
inline($06/$08/$2a/$fa/$c4/$ed/$5b/$fc/$c4);
inline($cb/$46/$3e/$38/$cb/$a7/$28/$02/$cb/$e7/$cb/$06/$d3/$fe);
             {      ^colour     }
inline($3a/$fe/$c4/$4f/$00/$00/$0d/$20/$fb/$23/$1b/$7a/$b3/$20);
inline($e3/$10/$da);
inline($f1/$d1/$c1/$e1);{ POP  ALL }
inline($fb);
end;