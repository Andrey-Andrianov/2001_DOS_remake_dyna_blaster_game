unit battles;
interface
procedure forbomb;
procedure step2(l,n,n2:integer);
implementation
uses drawe,crt,keys2;

procedure forbomb;
var
  l,i,j,i1,i2,l1 : integer;
begin
   for l := 1 to bombsx do begin
     if bombs[l].chot < 30 then
       if map[bombs[l].x,bombs[l].y] < 26 then
        if map[bombs[l].x,bombs[l].y] < 23 then
          map[bombs[l].x,bombs[l].y] := 23
         else
          map[bombs[l].x,bombs[l].y] := 26
       else
          map[bombs[l].x,bombs[l].y] := 20
     else begin
       map[bombs[l].x,bombs[l].y] := 7;
       puttail1(bombs[l].x*16-16+40,bombs[l].y*16-16+24,map[bombs[l].x,bombs[l].y]);
       puttail1byff(bombs[l].x*16-16+40,bombs[l].y*16-16+24,map[bombs[l].x,bombs[l].y]);
       j := 0;
       for i := 1 to (playses[bombs[l].play].kolfir - 1) do begin
         if map[bombs[l].x,bombs[l].y - i] <> 0 then
           if map[bombs[l].x,bombs[l].y - i] = 22 then
             map[bombs[l].x,bombs[l].y - i] := 39
           else begin
             map[bombs[l].x,bombs[l].y - i] := 4;
             break;
           end
         else break;
         j := i;
       end;
       if j = (playses[bombs[l].play].kolfir - 1) then begin
         if map[bombs[l].x,bombs[l].y - j - 1] = 22 then
           map[bombs[l].x,bombs[l].y - j - 1] := 51;
         if map[bombs[l].x,bombs[l].y - j - 1] = 3 then
           map[bombs[l].x,bombs[l].y - j - 1] := 4;
       end;
       j := 0;
       for i := 1 to (playses[bombs[l].play].kolfir - 1) do begin
         if map[bombs[l].x,bombs[l].y + i] <> 0 then
           if map[bombs[l].x,bombs[l].y + i] = 22 then
             map[bombs[l].x,bombs[l].y + i] := 39
           else begin
             map[bombs[l].x,bombs[l].y + i] := 4;
             break;
           end
         else break;
         j := i;
       end;
       if j = (playses[bombs[l].play].kolfir - 1) then begin
         if map[bombs[l].x,bombs[l].y + j + 1] = 22 then
           map[bombs[l].x,bombs[l].y + j + 1] := 18;
         if map[bombs[l].x,bombs[l].y + j + 1] = 3 then
           map[bombs[l].x,bombs[l].y + j + 1] := 4;
       end;
       j := 0;
{}     for i := 1 to (playses[bombs[l].play].kolfir - 1) do begin
         if map[bombs[l].x + i,bombs[l].y] <> 0 then
           if map[bombs[l].x + i,bombs[l].y] = 22 then
             map[bombs[l].x + i,bombs[l].y] := 52
           else begin
             map[bombs[l].x + i,bombs[l].y] := 4;
             break;
           end
         else break;
         j := i;
       end;
       if j = (playses[bombs[l].play].kolfir - 1) then begin
         if map[bombs[l].x + j + 1,bombs[l].y] = 22 then
           map[bombs[l].x + j + 1,bombs[l].y] := 6;
         if map[bombs[l].x + j + 1,bombs[l].y] = 3 then
           map[bombs[l].x + j + 1,bombs[l].y] := 4;
       end;
       j := 0;
{}     for i := 1 to (playses[bombs[l].play].kolfir - 1) do begin
         if map[bombs[l].x - i,bombs[l].y] <> 0 then
           if map[bombs[l].x - i,bombs[l].y] = 22 then
             map[bombs[l].x - i,bombs[l].y] := 52
           else begin
             map[bombs[l].x - i,bombs[l].y] := 4;
             break;
           end
         else break;
         j := i;
       end;
       if j = (playses[bombs[l].play].kolfir - 1) then begin
         if map[bombs[l].x - j - 1,bombs[l].y] = 22 then
           map[bombs[l].x - j - 1,bombs[l].y] := 30;
         if map[bombs[l].x - j - 1,bombs[l].y] = 3 then
           map[bombs[l].x - j - 1,bombs[l].y] := 4;
       end;
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1byff(i*16-16+40,j*16-16+24,map[i,j]);
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1(i*16-16+40,j*16-16+24,map[i,j]);
  for i := 1 to playsx do if playses[i].liv then begin   (**************************)
    i1 := (playses[i].x + 4 - 32) div 16;
    i2 := (playses[i].y -4 - 24-8) div 16+1;
    if not ((map[i1,i2] = 22) or (map[i1,i2] = 20) or (map[i1,i2] = 23) or (map[i1,i2] = 26)) then begin
      playses[i].liv := false;
      for j := (playses[i].y - 23) to (playses[i].y) do
        for l1 := (playses[i].x - 8) to (playses[i].x + 8) do
          scr^[j,l1] := np3^[j,l1];
      putspr2(playses[i].x-8,playses[i].y-23,i*13-1);
      dec(playslx);
      delay(100);
    end else if playses[i].liv then
      putspr2(playses[i].x-8,playses[i].y-23,(i-1)*13+playses[i].nap+playses[i].nom);
  end;
  delay(100);
  for j := 1 to 11 do
    for i := 1 to 15 do begin
      if (map[i,j] = 7) or (map[i,j] = 6) or (map[i,j] =18)
            or (map[i,j] =30) or (map[i,j] =39) or (map[i,j] =51)
            or (map[i,j] = 52) then begin
        map[i,j] := 22;
        map2[i,j] := 22;
      end;
      if map[i,j] = 4 then begin
        if map2[i,j] = 22 then begin
          map[i,j] := 22;
          map2[i,j] := 22;
        end;
        if map2[i,j] = 29 then begin
          map[i,j] := 29;
          map2[i,j] := 22;
        end;
        if map2[i,j] = 32 then begin
          map[i,j] := 32;
          map2[i,j] := 22;
        end;
        if map2[i,j] = 35 then begin
          map[i,j] := 35;
          map2[i,j] := 22;
        end;
        if map2[i,j] = 3 then begin
          map[i,j] := 22;
          map2[i,j] := 22;
        end;
      end;
    end;
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1byff(i*16-16+40,j*16-16+24,map[i,j]);
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1(i*16-16+40,j*16-16+24,map[i,j]);
       dec(bombsx);
       dec(playses[bombs[l].play].kolpbom);
       for i := 1 to bombsx  do
         bombs[i] := bombs[i+1];
     end;
     puttail1(bombs[l].x*16-16+40,bombs[l].y*16-16+24,map[bombs[l].x,bombs[l].y]);
     puttail1byff(bombs[l].x*16-16+40,bombs[l].y*16-16+24,map[bombs[l].x,bombs[l].y]);
     inc(bombs[l].chot);
   end;
end;

procedure colormap(l : integer);
var
  i,j : integer;
begin
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1byff(i*16-16+40,j*16-16+24,map[i,j]);
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1(i*16-16+40,j*16-16+24,map[i,j]);
   for i := 1 to playsx do if playses[l].liv then
    putspr2(playses[l].x-8,playses[l].y-23,(l-1)*13+playses[l].nap+playses[l].nom);
end;


procedure step2(l,n,n2:integer);
var
  i,j,i1,i2 : integer;
begin
    i1 := (map[(playses[l].x - 8-32+4) div 16 +1,((playses[l].y - 4 - 24) div 16)]);
    i2 := map[(playses[l].x -8-32+12-4) div 16 ,((playses[l].y - 4 - 24) div 16)];
    if key[playses[l].up] and maps[i1] and maps[i2] then begin
      for j := (playses[l].y - 23) to (playses[l].y) do
        for i := (playses[l].x - 8) to (playses[l].x + 8) do
          scr^[j,i] := np3^[j,i];
      playses[l].y := playses[l].y - 4;
      if (playses[l].nap = 9) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 9;
        playses[l].nom := 0;
      end;
    end;
    if key[playses[l].up] and (((i1 = 32) and (i2 = 32)) or ((i1 = 29) and (i2 = 29)) or ((i1 = 35) and (i2 = 35))) then begin
      case i1 of
        32 :inc(playses[l].kolfir);
        29 :inc(playses[l].kolbom);
        35 :;
      end;
      playses[l].y := playses[l].y - 4;
{      map[(playses[l].x + 4 - 32) div 16,(playses[l].y -4 - 24-8) div 16+1]:=22;}
      map[(playses[l].x -8-32+12) div 16 ,((playses[l].y - 4 - 24) div 16)] := 22;
      colormap(l);
      if (playses[l].nap = 9) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 9;
        playses[l].nom := 0;
      end;
    end;
    i1 :=map[(playses[l].x - 8-32+4) div 16 +1,((playses[l].y  - 24-4) div 16 +1)];
    i2 :=map[(playses[l].x -8-32+12-4) div 16 ,((playses[l].y - 24) div 16 +1)];
    if key[playses[l].down] and maps[i1] and maps[i2] then begin
      for j := (playses[l].y - 23) to (playses[l].y) do
        for i := (playses[l].x - 8) to (playses[l].x + 8) do
          scr^[j,i] := np3^[j,i];
      playses[l].y := playses[l].y + 4;
      if (playses[l].nap = 0) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 0;
        playses[l].nom := 0;
      end;
    end;
    if key[playses[l].down] and (((i1 = 32) and (i2 = 32)) or ((i1 = 29) and (i2 = 29)) or ((i1 = 35) and (i2 = 35)))then begin
      case i1 of
        32 :inc(playses[l].kolfir);
        29 :inc(playses[l].kolbom);
        35 :;
      end;
      playses[l].y := playses[l].y + 4;
{      map[(playses[l].x + 4 - 32) div 16,(playses[l].y -4 - 24-8) div 16+1]:=22;}
      map[(playses[l].x -8-32+12) div 16 ,((playses[l].y - 24) div 16 +1)] :=22;
      colormap(l);
      if (playses[l].nap = 0) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 0;
        playses[l].nom := 0;
      end;
    end;
    i1 :=map[(playses[l].x + 4 - 32-4) div 16 +1,(playses[l].y - 4 - 24-8-4) div 16 +1];
    i2 :=map[(playses[l].x  - 32-4+4) div 16 +1,(playses[l].y - 4 - 24) div 16 +1];
    if key[playses[l].righ] and maps[i1] and maps[i2] then begin
      for j := (playses[l].y - 23) to (playses[l].y) do
        for i := (playses[l].x - 8) to (playses[l].x + 8) do
          scr^[j,i] := np3^[j,i];
      playses[l].x := playses[l].x + 4;
      if (playses[l].nap = 3) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 3;
        playses[l].nom := 0;
      end;
    end;
    if key[playses[l].righ] and (((i1 = 32) and (i2 = 32)) or ((i1 = 29) and (i2 = 29)) or ((i1 = 35) and (i2 = 35)))then begin
      case i1 of
        32 :inc(playses[l].kolfir);
        29 :inc(playses[l].kolbom);
        35 :;
      end;
      playses[l].x := playses[l].x + 4;
{      map[(playses[l].x + 4 - 32) div 16,(playses[l].y -4 - 24-8) div 16+1]:=22;}
      map[(playses[l].x  - 32-4+4) div 16 +1,(playses[l].y - 4 - 24) div 16 +1] :=22;
      colormap(l);
      if (playses[l].nap = 3) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 3;
        playses[l].nom := 0;
      end;
    end;
    i1 :=map[((playses[l].x - 4 - 32{16}) div 16 ),(playses[l].y -4 - 24-8) div 16+1];
    i2 :=map[(playses[l].x + 4 - 32-4) div 16 ,(playses[l].y -4 - 24) div 16 +1];
    if key[playses[l].left] and maps[i1] and maps[i2] then begin
      for j := (playses[l].y - 23) to (playses[l].y) do
        for i := (playses[l].x - 8) to (playses[l].x + 8) do
          scr^[j,i] := np3^[j,i];
      playses[l].x := playses[l].x - 4;
      if (playses[l].nap = 6) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 6;
        playses[l].nom := 0;
      end;
    end;
    if key[playses[l].left] and (((i1 = 32) and (i2 = 32)) or ((i1 = 29) and (i2 = 29)) or ((i1 = 35) and (i2 = 35)))then begin
      case i1 of
        32 :inc(playses[l].kolfir);
        29 :inc(playses[l].kolbom);
        35 :;
      end;
      playses[l].x := playses[l].x - 4;
{      map[(playses[l].x + 4 - 32) div 16,(playses[l].y -4 - 24-8) div 16+1]:=22;}
      map[(playses[l].x + 4 - 32-4) div 16 ,(playses[l].y -4 - 24) div 16 +1] := 22;
      colormap(l);
      if (playses[l].nap = 6) and (playses[l].nom <= 1) then
        inc(playses[l].nom)
      else begin
        playses[l].nap := 6;
        playses[l].nom := 0;
      end;
    end;
    if key[playses[l].ent] and (playses[l].kolpbom < playses[l].kolbom)  then begin
      i1 := (playses[l].x + 4 - 32) div 16;
      i2 := (playses[l].y -4 - 24-8) div 16+1;
      if map[i1,i2] = 22 then begin
      inc(playses[l].kolpbom);
      inc(bombsx);
      bombs[bombsx].x :={(playses[l].x + 4 - 32) div 16}i1;
      bombs[bombsx].y :={(playses[l].y -4 - 24-8) div 16+1}i2;
      bombs[bombsx].chot := 0;
      bombs[bombsx].play := l;
      map[bombs[bombsx].x,bombs[bombsx].y] := 20;
      puttail1(bombs[bombsx].x*16-16+40,bombs[bombsx].y*16-16+24,map[bombs[bombsx].x,bombs[bombsx].y]);
      puttail1byff(bombs[bombsx].x*16-16+40,bombs[bombsx].y*16-16+24,map[bombs[bombsx].x,bombs[bombsx].y]);
      if playses[l].liv then
        putspr2(playses[l].x-8,playses[l].y-23,(l-1)*13+playses[l].nap+playses[l].nom);
      end;
    end;
    if (not (key[playses[l].left] or key[playses[l].righ] or key[playses[l].up] or key[playses[l].down]))
                                         and (playses[l].nom > 0) then begin
      for j := (playses[l].y - 23) to (playses[l].y) do
        for i := (playses[l].x - 8) to (playses[l].x + 8) do
          scr^[j,i] := np3^[j,i];
      playses[l].nom := 0;
    end;
end;

end.