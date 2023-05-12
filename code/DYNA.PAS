program dyna;
uses drawe,crt,keys2,gamest1;
var
  i,j : integer;
  nomber : byte;
begin
   asm
     mov ax,$0013
     int $10
   end;
   EXIT := FALSE;
   scr:=ptr(SegA000,0);
   getmemtail;
   initkeys;
   repeat
   start(nomber);
   case nomber of
     0 :begin
           gamestart1;
           round(1);
           victory;
        end;
     1 : begin
           readtailall;
           playsx := 2;
           playslx :=playsx;
           bombsx := 0;
           kolv := 3;
{           viem;}
           beginbattle;
         end;
     2 :;
     3 :;
   end;
   until EXIT;
   asm
     mov ax,$0003
     int $10
   end;
   writeln(nomber);
   writeln(np2[1]^[1,1]);
   freememtail;
end.

