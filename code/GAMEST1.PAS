unit gamest1;
interface
procedure gamestart1;
procedure round(n:integer);
procedure victory;
implementation
uses crt,drawe,battles,keys2,pal;

type
  rol = record
    d : integer;
    xd,yd : integer;
    w : integer;
    xw,yw : integer;
    s : integer;
    xs,ys : integer;
  end;

const
  rolik : array[1..31] of rol =
  ((d:0;xd:110;yd:100;w:3;xw:66;yw:165;s:0;xs:174;ys:160),
  (d:1;xd:110;yd:100;w:4;xw:62;yw:165;s:1;xs:178;ys:160),
  (d:2;xd:110;yd:100;w:5;xw:58;yw:165;s:2;xs:182;ys:160),
  (d:0;xd:110;yd:100;w:3;xw:54;yw:165;s:0;xs:186;ys:160),
  (d:1;xd:110;yd:100;w:4;xw:50;yw:165;s:1;xs:190;ys:160),
  (d:2;xd:110;yd:100;w:5;xw:46;yw:165;s:2;xs:194;ys:160),
  (d:0;xd:110;yd:100;w:0;xw:46;yw:165;s:3;xs:194;ys:160),        (***)
  (d:1;xd:110;yd:100;w:1;xw:50;yw:167;s:4;xs:190;ys:162),
  (d:2;xd:110;yd:100;w:2;xw:54;yw:169;s:5;xs:186;ys:164),
  (d:0;xd:110;yd:100;w:0;xw:58;yw:171;s:3;xs:182;ys:166),
  (d:1;xd:110;yd:100;w:1;xw:62;yw:173;s:4;xs:178;ys:168),
  (d:2;xd:110;yd:100;w:2;xw:66;yw:175;s:5;xs:174;ys:170),
  (d:0;xd:110;yd:100;w:0;xw:70;yw:175;s:3;xs:170;ys:170),
  (d:1;xd:110;yd:100;w:1;xw:74;yw:175;s:4;xs:166;ys:170),
  (d:2;xd:110;yd:100;w:2;xw:78;yw:175;s:5;xs:162;ys:170),
  (d:0;xd:110;yd:100;w:0;xw:82;yw:175;s:3;xs:158;ys:170),
  (d:1;xd:110;yd:100;w:1;xw:86;yw:175;s:4;xs:154;ys:170),
  (d:2;xd:110;yd:100;w:2;xw:90;yw:175;s:5;xs:150;ys:170),   (***)
  (d:0;xd:110;yd:100;w:6;xw:90;yw:175;s:6;xs:150;ys:170),
  (d:1;xd:110;yd:100;w:7;xw:90;yw:175;s:7;xs:150;ys:170),
  (d:0;xd:110;yd:90;w:6;xw:90;yw:175;s:6;xs:150;ys:170),
  (d:1;xd:110;yd:80;w:7;xw:90;yw:175;s:7;xs:150;ys:170),
  (d:0;xd:110;yd:70;w:6;xw:90;yw:175;s:6;xs:150;ys:170),
  (d:1;xd:110;yd:60;w:7;xw:90;yw:175;s:7;xs:150;ys:170),
  (d:0;xd:110;yd:50;w:6;xw:90;yw:175;s:6;xs:150;ys:170),
  (d:1;xd:110;yd:40;w:7;xw:90;yw:175;s:7;xs:150;ys:170),
  (d:0;xd:110;yd:30;w:6;xw:90;yw:175;s:6;xs:150;ys:170),
  (d:1;xd:110;yd:20;w:7;xw:90;yw:175;s:7;xs:150;ys:170),
  (d:0;xd:110;yd:10;w:6;xw:90;yw:175;s:6;xs:150;ys:170),
  (d:1;xd:110;yd:0;w:7;xw:90;yw:175;s:7;xs:150;ys:170),
  (d:1;xd:110;yd:0;w:8;xw:90;yw:175;s:8;xs:150;ys:170));

  roundx : array[1..8]of integer =
  (25,50,70,110,150,200,200,200);
  roundy : array[1..8]of integer =
  (85,75,105,85,85,90,60,30);

procedure setpalknight1(n: integer);
var
  p : array[0..767]of byte;   {палитра}
  f : file;
begin
   case n of
     1:assign(f,'pal\pal4.dat');               {файл с палитрой}
     2:assign(f,'pal\pal23.dat');               {файл с палитрой}
     3:assign(f,'pal\pal8.dat');               {файл с палитрой}
     4:assign(f,'pal\pal7.dat');               {файл с палитрой}
   end; {else
     assign(f,'pal\pal2.dat');               {файл с палитрой}
{   if n = 1 then
     assign(f,'pal\pal4.dat')               {файл с палитрой}
{   else
     assign(f,'pal\pal23.dat');               {файл с палитрой}
   reset(f,1);
   blockread(f,p,768);
   close(f);                          {закрываем файл}
   setpal(p[0],0,256);                {устанавливаем нужную палитру}
end;

procedure gamestart1;
var
  long : array[1..320]of byte;
  maxs : integer;
  f    : file;
  i,j,k,i1,j1  : integer;
  s    : string[4];
begin
  maxs := 256;
  assign(f,'kni\st1.kni');
  reset(f,1);
  for j := 0 to 199 do begin
    blockread(f,long,maxs);
    for i := 1 to 320 do begin
      np3^[j,i] := long[i+1]; {}
    end;
  end;
{    readln;       {}
  close(f);
  maxs := 48;
  assign(f,'kni\st3.kni');
  reset(f,1);
    for j := 0 to 25 do begin
      blockread(f,long,maxs);
      for i := 1 to 46 do begin
        np3^[j+135,i+108] := long[i+1]; {}
      end;
    end;
  close(f);
  setpalknight1(1);
  for j := 0 to 199 do
    for i := 0 to 255 do
      scr^[j,i+32] := np3^[j,i];
  maxs := 256;
  assign(f,'kni\st1.kni');
  reset(f,1);
  for j := 0 to 199 do begin
    blockread(f,long,maxs);
    for i := 1 to 320 do begin
      np3^[j,i] := long[i+1]; {}
    end;
  end;
  close(f);      (*************************************************)
  maxs := 40;
  for k := 1 to 3 do begin
    str(k,s);
    assign(f,'kni\dragon' + s + '.kni');
    reset(f,1);
    for j := 0 to 48 do begin
      blockread(f,long,maxs);
      for i := 0 to 39 do begin
        np4^[j,i+40*(k-1)] := long[i+1]; {}
      end;
    end;
    close(f);
  end;
  maxs := 20;
  for k := 1 to 9 do begin
    str(k,s);
    assign(f,'kni\peplew' + s + '.kni');
    reset(f,1);
    for j := 0 to 23 do begin
      blockread(f,long,maxs);
      for i := 0 to 19 do begin
        np4^[j+50,i+20*(k-1)] := long[i+1]; {}
      end;
    end;
    close(f);
  end;
  maxs := 28;
  for k := 1 to 9 do begin
    str(k,s);
    assign(f,'kni\peples' + s + '.kni');
    reset(f,1);
    for j := 0 to 27 do begin
      blockread(f,long,maxs);
      for i := 0 to 27 do begin
        np4^[j+50+24,i+28*(k-1)] := long[i+1]; {}
      end;
    end;
    close(f);
  end;
{  repeat
  until key[1];}
  delay(3000);
  for j := 0 to 199 do
    for i := 0 to 255 do
      scr^[j,i+32] := np3^[j,i];
  for k := 1 to 30 do begin
    for j := 0 to 48 do
      for i := 0 to 39 do
       if np4^[j,i+rolik[k].d*40] <> 3 then
        scr^[j+rolik[k].yd,i+32+rolik[k].xd] := np4^[j,i+rolik[k].d*40];
    for j := 0 to 23 do
      for i := 0 to 19 do
       if np4^[j+50,i+rolik[k].w*20] <> 3 then
        scr^[j+rolik[k].yw,i+32+rolik[k].xw] := np4^[j+50,i+rolik[k].w*20];
    for j := 0 to 27 do
      for i := 0 to 27 do
       if np4^[j+50+24,i+rolik[k].s*28] <> 3 then
        scr^[j+rolik[k].ys,i+32+rolik[k].xs] := np4^[j+50+24,i+rolik[k].s*28];
    delay(200);     (******)
    for j := 0 to 48 do
      for i := 0 to 39 do
        scr^[j+rolik[k].yd,i+32+rolik[k].xd] := np3^[j+rolik[k].yd,i{+32}+rolik[k].xd{-40}];
    for j := 0 to 23 do
      for i := 0 to 19 do
        scr^[j+rolik[k].yw,i+32+rolik[k].xw] := np3^[j+rolik[k].yw,i{+32}+rolik[k].xw{-20}];
    for j := 0 to 27 do
      for i := 0 to 27 do
        scr^[j+rolik[k].ys,i+32+rolik[k].xs] := np3^[j+rolik[k].ys,i{+32}+rolik[k].xs{-28}];
  end;
  k := 31;
  for j := 0 to 23 do
    for i := 0 to 19 do
      if np4^[j+50,i+rolik[k].w*20] <> 3 then
        scr^[j+rolik[k].yw,i+32+rolik[k].xw] := np4^[j+50,i+rolik[k].w*20];
  for j := 0 to 27 do
    for i := 0 to 27 do
      if np4^[j+50+24,i+rolik[k].s*28] <> 3 then
        scr^[j+rolik[k].ys,i+32+rolik[k].xs] := np4^[j+50+24,i+rolik[k].s*28];
  delay(500);
  setpalknight1(2);
  maxs := 16;
  assign(f,'kni\dragon4.kni');
  reset(f,1);
    for j := 0 to 63 do begin
      blockread(f,long,maxs);
      for i := 0 to 15 do begin
        np4^[j,i] := long[i+1]; {}
      end;
    end;
  close(f);
  i1 := 155;
  j1 := 0;
  for k := 1 to 5 do begin
   for j := 0 to 15 do
     for i := 0 to 15 do
       if np4^[j,i] <> 3 then
         scr^[j+j1,i+i1] := np4^[j,i];
   delay(200);
   for j := 0 to 15 do
     for i := 0 to 15 do
       scr^[j+j1,i+i1] := np3^[j+j1,i+i1];
   inc(j1);
   for j := 0 to 15 do
     for i := 0 to 15 do
       if np4^[j+16,i] <> 3 then
         scr^[j+j1,i+i1] := np4^[j+16,i];
   delay(200);
   for j := 0 to 15 do
     for i := 0 to 15 do
       scr^[j+j1,i+i1] := np3^[j+j1,i+i1];
   inc(j1);
  end;
  for k := 1 to 5 do begin
   for j := 0 to 15 do
     for i := 0 to 15 do
       if np4^[j+32,i] <> 3 then
         scr^[j+j1,i+i1] := np4^[j+32,i];
   delay(200);
   for j := 0 to 15 do
     for i := 0 to 15 do
       scr^[j+j1,i+i1] := np3^[j+j1,i+i1-32];
   inc(j1);
   for j := 0 to 15 do
     for i := 0 to 15 do
       if np4^[j+48,i] <> 3 then
         scr^[j+j1,i+i1] := np4^[j+48,i];
   delay(200);
   for j := 0 to 15 do
     for i := 0 to 15 do
       scr^[j+j1,i+i1] := np3^[j+j1,i+i1-32];
   inc(j1);
  end;
  delay(3000);
{  repeat
  until key[28];}
{  setpalkni(3);}
  for i := 0 to 767 do
    p[i] := 0;
  setpal(p[0],0,256);                {устанавливаем нужную палитру}
end;

procedure round(n:integer);
var
  long : array[1..320]of byte;
  maxs : integer;
  f    : file;
  i,j,k,i1,j1  : integer;
  s    : string[4];
begin
  maxs := 256;
  assign(f,'kni\st2.kni');
  reset(f,1);
  for j := 0 to 159 do begin
    blockread(f,long,maxs);
    for i := 1 to 256 do begin
      np3^[j,i] := long[i+1]; {}
    end;
  end;
  close(f);
  assign(f,'kni\pepler1.kni');
  reset(f,1);
  for j := 0 to 23 do
    for i := 0 to 23 do
      blockread(f,np4^[j,i],1);
  close(f);
  for j := 160 to 199 do
    for i := 0 to 255 do
      scr^[j,i+32] :=0;
  for j := 0 to 159 do
    for i := 0 to 255 do
      scr^[j,i+32] := np3^[j,i];
  setpalknight1(3);
  repeat
    for i := 0 to 23 do
      for j := 0 to 23 do
       if np4^[j,i]<>3 then
        scr^[j+roundy[n],i+roundx[n]+32] := np4^[j,i];
    delay(200);
    for i := 0 to 23 do
      for j := 0 to 23 do
        scr^[j+roundy[n],i+roundx[n]+32] := np3^[j+roundy[n],i+roundx[n]];
    delay(200);
  until key[28];
end;

procedure victory;
var
  long : array[1..320]of byte;
  maxs : integer;
  f    : file;
  i,j,k,i1,j1  : integer;
  s    : string[4];
  w,xw,yw,b,xb,yb,d,xd,yd : integer;
begin
  maxs := 20;
  for k := 1 to 10 do begin
    str(k,s);
    assign(f,'kni\peplew' + s + '.kni');
    reset(f,1);
    for j := 0 to 23 do begin
      blockread(f,long,maxs);
      for i := 0 to 19 do begin
        np4^[j+50,i+20*(k-1)] := long[i+1]; {}
      end;
    end;
    close(f);
  end;
  for k := 1 to 11 do begin
    str(k,s);
    assign(f,'kni\pepleb' + s + '.kni');
    reset(f,1);
    for j := 0 to 23 do begin
      blockread(f,long,maxs);
      for i := 0 to 19 do begin
        np4^[j+50+24,i+20*(k-1)] := long[i+1]; {}
      end;
    end;
    close(f);
  end;
  maxs := 24;
  for k := 1 to 2 do begin
    str(k,s);
    assign(f,'kni\pepled' + s + '.kni');
    reset(f,1);
    for j := 0 to 31 do begin
      blockread(f,long,maxs);
      for i := 0 to 23 do begin
        np4^[j+50+24+24,i+24*(k-1)] := long[i+1]; {}
      end;
    end;
    close(f);
  end;
  maxs := 320;
  assign(f,'kni\st4.kni');
  reset(f,1);
  for j := 0 to 199 do begin
    blockread(f,long,maxs);
    for i := 0 to 319 do begin
      np3^[j,i] := long[i+1]; {}
    end;
  end;
  close(f);
  for i := 0 to 767 do
    p[i] := 0;
  setpal(p[0],0,256);                {устанавливаем нужную палитру}
  for j := 0 to 199 do
    for i := 0 to 293 do
      scr^[j,i+25] := np3^[j,i];
  setpalknight1(4);
  w := 0; b := 0; d := 0;
  xw := -64; yw := 111;
  xb := 0; yb := 111;
  xd := 255; yd := 105;
  for k := 1 to 70 do begin
    if (xw > 0) and (xw <= 115) then
     for j := 0 to 22 do
      for i := 0 to 19 do
       if np4^[j+50,i+w*20] <> 3 then
        scr^[j+yw,i+32+xw] := np4^[j+50,i+w*20];
    if xw >= 115 then
  for j := 0 to 22 do
    for i := 0 to 19 do
     if np4^[j+50,i+9*20] <> 3 then
       scr^[j+yw,i+32+xw] := np4^[j+50,i+9*20];
    if (xb > 0) and (xb <= 235) then
     for j := 0 to 22 do
      for i := 0 to 19 do
       if np4^[j+50+24,i+b*20] <> 3 then
        scr^[j+yb,i+32+xb] := np4^[j+50+24,i+b*20];
     delay(200);        (*************)
    if (xw > 0) and (xw <= 115) then
     for j := 0 to 23 do
      for i := 0 to 26 do
        scr^[j+yw,i+25+xw] := np3^[j+yw,i+xw];
    if (xb > 0) and (xb <= 235) then
     for j := 0 to 23 do
      for i := 0 to 24 do
        scr^[j+yb,i+25+xb] := np3^[j+yb,i+xb];
     inc(w);
     if w >=3 then
       w := 0;
     if xw <= 115 then
       inc(xw,4);
     inc(b);
     if b >=3 then
       b := 0;
     inc(xb,4);
  end;
  b := 3; d := 0;
  xb := 290;
  xd := 246;
  for k := 1 to 27 do begin
    if (xb <= 235) then
     for j := 0 to 22 do
      for i := 0 to 26 do
        scr^[j+yb,i+25+xb] := np3^[j+yb,i+xb];
     dec(xb,4);
     inc(b);
     if b >=6 then
       b := 3;
    if (xd <= 235) then
     for j := 0 to 31 do
      for i := 0 to 31 do
        scr^[j+yd,i+25+xd] := np3^[j+yd,i+xd];
     dec(xd,4);
     inc(d);
     if d >=2 then
       d := 0;
   if (xb <= 235) then
     for j := 0 to 23 do
      for i := 0 to 19 do
       if np4^[j+50+24,i+b*20] <> 3 then
        scr^[j+yb,i+32+xb] := np4^[j+50+24,i+b*20];
   if (xd <= 235) then
     for j := 0 to 31 do
      for i := 0 to 23 do
       if np4^[j+50+24+24,i+d*24] <> 3 then
        scr^[j+yd,i+32+xd] := np4^[j+50+24+24,i+d*24];
     delay(200);        (*************)
  end;
{  end;}
  repeat
     for j := -8 to 22 do
      for i := 0 to 28 do
        scr^[j+yb,i+25+xb] := np3^[j+yb,i+xb];
     for j := 0 to 23 do
      for i := 0 to 19 do
       if np4^[j+50+24,i+7*20] <> 3 then
        scr^[j+yb,i+32+xb] := np4^[j+50+24,i+7*20];
     delay(200);
     for j := 0 to 22 do
      for i := 0 to 26 do
        scr^[j+yb,i+25+xb] := np3^[j+yb,i+xb];
     for j := 0 to 23 do
      for i := 0 to 19 do
       if np4^[j+50+24,i+8*20] <> 3 then
        scr^[j+yb,i+32+xb] := np4^[j+50+24,i+8*20];
     delay(200);
     for j := 0 to 22 do
      for i := 0 to 26 do
        scr^[j+yb,i+25+xb] := np3^[j+yb,i+xb];
     for j := 0 to 23 do
      for i := 0 to 19 do
       if np4^[j+50+24,i+9*20] <> 3 then
        scr^[j+yb,i+32+xb] := np4^[j+50+24,i+9*20];
     for j := 0 to 23 do
      for i := 0 to 19 do
       if np4^[j+50+24,i+10*20] <> 3 then
        scr^[j+yb-8,i+32+xb+4] := np4^[j+50+24,i+10*20];
     delay(200);
  until key[28];
end;

end.