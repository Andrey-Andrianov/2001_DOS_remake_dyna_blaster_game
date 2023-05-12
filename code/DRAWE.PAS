unit drawe;
interface
type
   tiletype = array[0..15,0..15]of byte; {тип массива для одного кадра}
   tileptr = ^tiletype;                    {указатель на массив кадра}
   tiletype2 = array[0..23,0..15]of byte; {тип массива для одного кадра}
   tileptr2 = ^tiletype2;                    {указатель на массив кадра}
   scrtype = array[0..199,0..319]of byte; {тип массива для экрана}
   scrptr = ^scrtype;                    {указатель на массив экрана}
   plays = record
     x : integer;
     y : integer;
     up   : integer;
     down : integer;
     righ : integer;
     left : integer;
     nap : integer;
     nom : integer;
     ent : integer;
     liv : boolean;
     kolvic : integer;
     kolbom : integer;
     kolpbom : integer;
     kolfir : integer;
   end;
   bomb = record
     chot : integer;
     x    : integer;
     y    : integer;
     play : integer;
   end;
const
  playses : array [1..4] of plays =
 ((x:64;y:64;up:72;down:80;righ:77;left:75;nap:0;nom:0;ent:28;liv:true;kolvic:0;kolbom:1;kolpbom:0;kolfir:2),
 (x:256;y:184;up:19;down:33;righ:34;left:32;nap:0;nom:0;ent:15;liv:true;kolvic:0;kolbom:1;kolpbom:0;kolfir:2),
 (x:256;y:64;up:72;down:80;righ:77;left:75;nap:0;nom:0;ent:28;liv:true;kolvic:0;kolbom:1;kolpbom:0;kolfir:2),
 (x:64;y:184;up:19;down:33;righ:34;left:32;nap:0;nom:0;ent:15;liv:true;kolvic:0;kolbom:1;kolpbom:0;kolfir:2));

 maps : array [0..55] of boolean =
 (false,true,true,false,false,false,true,true,false,true,true,false,true,true,false,true,true,false,true,true,
 true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,
 true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true);
var
   np  : array[0..70]of tileptr;     {указатель на массив кадров}
   np2 : array[0..90]of tileptr2;    {указатель на массив кадров}
   np3 : scrptr;                 {указазатель на экран}
   np4 : scrptr;                 {указазатель на экран}
   p : array[0..767]of byte;   {палитра}
   scr : scrptr;
   num_key,num_char : byte;
   map : array [1..15,1..11] of byte;
   map2: array [1..15,1..11] of byte;
   playsx : integer;
   playslx : integer;
   bombsx : integer;
   kolv : integer;
   bombs : array [0..12] of bomb;
   EXIT  : BOOLEAN;
{   prizes : array []}
procedure setpalkni(n:byte);
procedure viem;
procedure getmemtail;
procedure freememtail;
procedure start(var nomber:byte);
procedure readtailall;
procedure puttail1(x,y,n:integer);
procedure puttail1byff(x,y,n:integer);
procedure puttail2(x,y,n:integer);
procedure putspr2(x,y,n:integer);
procedure beginbattle;
Procedure WaitKey;

implementation
uses pal,grtext,crt,keys2,battles;

procedure colorbar(x01,y01,x02,y02,color:integer);
var
  i,j : integer;
  t1,t2 : longint;
begin
  for j :=y01 to y02 do
    for i := x01 to x02 do
      scr^[j,i] := color;
end;

Procedure WaitKey;
begin
  asm
    mov ax,0
    int 16h
    mov Num_Key,ah
    mov Num_Char,al
  end;
end;

procedure setpalkni(n : byte);
var
  p : array[0..767]of byte;   {палитра}
  f : file;
  i : integer;
  b : boolean;
begin
   if n = 3 then begin
    repeat
     b := true;
     for i := 0 to 767 do begin
       if p[i] > 2 then begin
         dec(p[i],2);
         b := false;
       end;
     end;
     setpal(p[0],0,256);                {устанавливаем нужную палитру}
    until b;
   end else begin
     if n = 1 then
       assign(f,'pal\pal2.dat');               {файл с палитрой}
     if n = 2 then
       assign(f,'pal\pal3.dat');               {файл с палитрой}
     reset(f,1);
     blockread(f,p,768);
     close(f);                          {закрываем файл}
     setpal(p[0],0,256);                {устанавливаем нужную палитру}
{     if n = 4 then begin
       for i := 0 to 767 do
         p[i] := 0;
       setpal(p[0],0,256);                {устанавливаем нужную палитру}
{     end;    }
   end;
end;

procedure getmemtail;
var
  i : integer;
begin
   for i:=0 to 70 do
     getmem(np[i],sizeof(tiletype));    {выделяем память для кадров}
   for i:=0 to 90 do
     getmem(np2[i],sizeof(tiletype2));    {выделяем память для кадров}
   getmem(np3,sizeof(scrtype));    {выделяем память для больших картинок}
   getmem(np4,sizeof(scrtype));    {выделяем память для больших картинок}
end;

procedure freememtail;
var
  i : integer;
begin
   for i:=0 to 70 do
     freemem(np[i],sizeof(tiletype));    {выделяем память для кадров}
   for i:=0 to 90 do
     freemem(np2[i],sizeof(tiletype2));    {выделяем память для кадров}
   freemem(np3,sizeof(scrtype));    {выделяем память для больших картинок}
   freemem(np4,sizeof(scrtype));    {выделяем память для больших картинок}
end;

procedure readtailall;
var
  f   : file;
  i,j,poz : integer;
  s   : string;
  long : array[0..255] of byte;
begin
  poz := 0;
  assign(f,'kni\duna001.kni');
  reset(f,1);
  for i := 1 to 3 do begin
    blockread(f,np[poz]^,sizeof(np[poz]^));
    inc(poz);
  end;
  close(f);
  for j := 2 to 3 do begin
    str(j,s);
    assign(f,'kni\duna00' + s + '.kni');
    reset(f,1);
    blockread(f,np[poz]^,sizeof(np[poz]^));
    inc(poz);
    close(f);
  end;
  for j := 4 to 9 do begin
    str(j,s);
    assign(f,'kni\duna00' + s + '.kni');
    reset(f,1);
    for i := 1 to 3 do begin
      blockread(f,np[poz]^,sizeof(np[poz]^));
      inc(poz);
    end;
    close(f);
  end;
  for j := 10 to 20 do begin
    str(j,s);
    assign(f,'kni\duna0' + s + '.kni');
    reset(f,1);
    for i := 1 to 3 do begin
      blockread(f,np[poz]^,sizeof(np[poz]^));
      inc(poz);
    end;
    close(f);
  end;
  poz := 0;
  assign(f,'kni\gwdyna.kni');
  reset(f,1);
  for i := 1 to 13 do begin
    blockread(f,np2[poz]^,368);
    inc(poz);
  end;
  close(f);
  assign(f,'kni\gbdyna.kni');
  reset(f,1);
  for i := 1 to 13 do begin
    blockread(f,np2[poz]^,368);
    inc(poz);
  end;
  close(f);
  assign(f,'kni\gedyna.kni');
  reset(f,1);
  for i := 1 to 13 do begin
    blockread(f,np2[poz]^,368);
    inc(poz);
  end;
  close(f);
  assign(f,'kni\gbldyna.kni');
  reset(f,1);
  for i := 1 to 13 do begin
    blockread(f,np2[poz]^,368);
    inc(poz);
  end;
  close(f);
  assign(f,'kni\tablo.kni');
  reset(f,1);
  for i := 1 to 24 do begin
    blockread(f,long,256);
    for j := 1 to 256 do
      np3^[i,j] := long[j-1]
  end;
  close(f);
end;

procedure viem;
var
  l,i,j : integer;
begin
  setpalkni(2);
  for l := 0 to 58 do
    for j := 0 to 15 do
      if l <= 19 then
        for i := 0 to 15 do
          scr^[j,i+l*16] := np[l]^[j,i]
      else
      if l <= 39 then
        for i := 0 to 15 do
          scr^[j+16,i+l*16] := np[l]^[j,i]
      else
        for i := 0 to 15 do
          scr^[j+32,i+l*16] := np[l]^[j,i];
  for l := 0 to 50 do
    for j := 0 to 22 do
      if l <= 19 then
        for i := 0 to 15 do
          scr^[j+64,i+l*16] := np2[l]^[j,i]
      else
      if l <= 39 then
        for i := 0 to 15 do
          scr^[j+88,i+l*16] := np2[l]^[j,i]
      else
        for i := 0 to 15 do
          scr^[j+112,i+l*16] := np2[l]^[j,i];
{     readkey;}
    repeat
    until key[1];
end;

procedure puttail1(x,y,n:integer);
var
  i,j : integer;
begin
  for j := 0 to 15 do
    for i := 0 to 15 do
      scr^[j+y,i+x] := np[n]^[j,i];
end;

procedure puttail1byff(x,y,n:integer);
var
  i,j : integer;
begin
  for j := 0 to 15 do
    for i := 0 to 15 do
      np3^[j+y,i+x] := np[n]^[j,i];
end;

procedure puttail2(x,y,n:integer);
var
  i,j : integer;
begin
  for j := 0 to 22 do
    for i := 0 to 15 do
      scr^[j+y,i+x] := np2[n]^[j,i];
end;

procedure putspr2(x,y,n:integer);
var
  i,j : integer;
begin
  for j := 0 to 22 do
    for i := 0 to 15 do
     if np2[n]^[j,i] <> 3 then
      scr^[j+y,i+x] := np2[n]^[j,i];
end;

procedure initmap;
var
  l,i,j : integer;
begin
  playses[1].x:=64;  playses[1].y:=58;
  playses[2].x:=256; playses[2].y:=184;
  playses[3].x:=256; playses[3].y:=58;
  playses[4].x:=64;  playses[4].y:=184;
  for l := 1 to 4 do begin
    playses[l].nap:=0;
    playses[l].nom:=0;
    playses[l].liv:=true;
    playses[l].kolbom:=1;
    playses[l].kolpbom:=0;
    playses[l].kolfir:=2;
  end;       {}
  for j := 1 to 11 do
    for i := 1 to 15 do
      map[i,j] := 3{22};
  for j := 1 to 4 do
    for i := 1 to 6 do
      map[i*2+1,j*2+1] := 0;
  for j := 1 to 15 do begin
    map[j,1] := 0;
    map[j,11] := 0;
  end;
  for j := 1 to 11 do begin
    map[1,j] := 0;
    map[15,j] := 0;
  end;
  map[2,2] := 22;
  map[2,3] := 22;
  map[3,2] := 22;
  map[14,2] := 22;
  map[13,2] := 22;
  map[14,3] := 22;
  map[14,10] := 22;
  map[14,9] := 22;
  map[13,10] := 22;
  map[2,10] := 22;
  map[2,9] := 22;
  map[3,10] := 22;
  randomize;
  for l := 1 to 15 do begin
    i := random(15) + 1;
    j := random(11) + 1;
    if map[i,j] = 3{22} then
      map[i,j] := 22{3};
  end;
  fillchar(scr^,sizeof(scr^),0);
  for j := 0 to 23 do
    for i := 0 to 255 do
      scr^[j,i+32] := np3^[j+1,i+1];
                                        (**********************)
  for i := 1 to 15 do
    for j := 1 to 11 do
      map2[i,j] := map[i,j];
  l := 1;
  repeat
    i := random(15) + 1;
    j := random(11) + 1;
    if map2[i,j] = 3 then begin
      map2[i,j] := 29;
      inc(l);
    end;
  until l = 8;
  l := 1;
  repeat
    i := random(15) + 1;
    j := random(11) + 1;
    if map2[i,j] = 3 then begin
      map2[i,j] := 32;
      inc(l);
    end;
  until l = 8;
  l := 1;
  repeat
    i := random(15) + 1;
    j := random(11) + 1;
    if map2[i,j] = 3 then begin
      map2[i,j] := 35;
      inc(l);
    end;
  until l = 8;
  for j := 24 to 199 do
    for i := 0 to 255 do
      scr^[j,i+32] := 27;
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1byff(i*16-16+40,j*16-16+24,map[i,j]);
  for j := 1 to 11 do
    for i := 1 to 15 do
      puttail1(i*16-16+40,j*16-16+24,map[i,j]);
  putspr2(playses[1].x-8,playses[1].y-23,0);
end;

procedure tyr;
var
  i,j,l2,l1 : integer;
  f   : file;
  b   : boolean;
begin
      for j := 0 to 199 do
        for i := 0 to 255 do
          scr^[j,i+32] := 72;
      setgttyp(0);
      setgtcol(8);
      for i := 1 to 30 do begin
        putchar(40 +i*8 - 8,0,char(205));
        putchar(40 +i*8 - 8,192,char(205));
      end;
      for i := 1 to 23 do begin
        putchar(32,i*8,char(186));
        putchar(280,i*8,char(186));
      end;
      putchar(32 ,0,char(201));
      putchar(32 ,192,char(200));
      putchar(280,0,char(187));
      putchar(280,192,char(188));
      for j := 0 to playsx-1 do begin
        for i := 1 to 25 do begin
          putchar(32 + 7*4 +i*8 - 8,(3*8)+j*4*11 - 8,char(205));
          putchar(32 + 7*4 +i*8 - 8,(7*8)+j*4*11 - 8,char(205));
        end;
        for i := 0 to 2 do begin
          putchar(32 + 7*4-8,(3*8)+j*4*11 +i*8,char(186));
          putchar(32 + 7*4 +200 ,(7*8)+j*4*11 +i*8-32,char(186));
        end;
        putchar(32 + 7*4 - 8,(3*8)+j*4*11 - 8,char(201));
        putchar(32 + 7*4 - 8,(7*8)+j*4*11 - 8,char(200));
        putchar(32 + 7*4 - 8 + 208,(3*8)+j*4*11 - 8,char(187));
        putchar(32 + 7*4 - 8 + 208,(7*8)+j*4*11 - 8,char(188));
      end;
      assign(f,'kni\finalw1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i],1);
      close(f);
      assign(f,'kni\finalb1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i+22],1);
      close(f);
      assign(f,'kni\finalr1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i+46],1);
      close(f);
      assign(f,'kni\finalbl1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i+70],1);
      close(f);
      assign(f,'kni\cup1.kni');
      reset(f,1);
      for j := 0 to 23 do
        for i := 0 to 15 do
          blockread(f,np3^[j+50,i],1);
      close(f);
      for l2 := 0 to playsx-1 do begin
        for j := 164 to 187 do
          for i := 0 to 23 do
            scr^[(j-163)+24+44*l2,i+64] := np3^[j,i+23*l2];
        for l1 := 1 to playses[l2+1].kolvic do
          for j := 50 to 73 do
            for i := 0 to 15 do
              scr^[(j-50)+24+44*l2,i+64+32+24*l1] := np3^[j,i];
      end;
      i := 0;
      repeat
        delay(100);
        inc(i);
      until key[28] or (i > 100);
      delay(200);
end;

procedure tyr2;
var
  i,j,l1,l2  : integer;
  b : boolean;
begin
      for j := 0 to 199 do
        for i := 0 to 255 do
          scr^[j,i+32] := 72;
      setgttyp(0);
      setgtcol(8);
      for i := 1 to 30 do begin
        putchar(40 +i*8 - 8,0,char(205));
        putchar(40 +i*8 - 8,192,char(205));
      end;
      for i := 1 to 23 do begin
        putchar(32,i*8,char(186));
        putchar(280,i*8,char(186));
      end;
      putchar(32 ,0,char(201));
      putchar(32 ,192,char(200));
      putchar(280,0,char(187));
      putchar(280,192,char(188));
      for j := 164 to 187 do
        for i := 0 to 23 do
          scr^[(j-163)+24,i+64] := np3^[j,i];
      for j := 164 to 187 do
        for i := 0 to 23 do
          scr^[(j-163)+24+100,i+64+150] := np3^[j,i+23*1];
      if playsx >= 3 then
        for j := 164 to 187 do
          for i := 0 to 23 do
            scr^[(j-163)+24+100,i+64] := np3^[j,i+23*2];
      if playsx = 4 then
        for j := 164 to 187 do
          for i := 0 to 23 do
            scr^[(j-163)+24,i+64+150] := np3^[j,i+23*3];
        puttext(110,170,'НОВАЯ ИГРА');
      i := 0;
      repeat
        if (i mod 10) = 0 then
          puttext(110,170,'НОВАЯ ИГРА');
        if (i mod 15) = 0 then
          colorbar(110,170,190,178,72);
        delay(100);
        inc(i);
      until key[28] or (i > 100);
end;

procedure final;
var
  i,j,l1,l2  : integer;
  b : boolean;
  f : file;
begin
      assign(f,'kni\finalw1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i],1);
      close(f);
      assign(f,'kni\finalb1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i+22],1);
      close(f);
      assign(f,'kni\finalr1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i+46],1);
      close(f);
      assign(f,'kni\finalbl1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i+70],1);
      close(f);
      for j := 0 to 199 do
        for i := 0 to 255 do
          scr^[j,i+32] := 72;
      setgttyp(0);
      setgtcol(8);
      for i := 1 to 30 do begin
        putchar(40 +i*8 - 8,0,char(205));
        putchar(40 +i*8 - 8,192,char(205));
      end;
      for i := 1 to 23 do begin
        putchar(32,i*8,char(186));
        putchar(280,i*8,char(186));
      end;
      putchar(32 ,0,char(201));
      putchar(32 ,192,char(200));
      putchar(280,0,char(187));
      putchar(280,192,char(188));
      delay(1000);
      assign(f,'kni\finalw2.kni');
      reset(f,1);
      for j := 0 to 31 do
        for i := 0 to 19 do
          blockread(f,np3^[j+100,i+94],1);
      close(f);
      assign(f,'kni\finalb2.kni');
      reset(f,1);
      for j := 0 to 31 do
        for i := 0 to 19 do
          blockread(f,np3^[j+100,i+20+94],1);
      close(f);
      assign(f,'kni\finalr2.kni');
      reset(f,1);
      for j := 0 to 31 do
        for i := 0 to 19 do
          blockread(f,np3^[j+100,i+40+94],1);
      close(f);
      assign(f,'kni\finalbl2.kni');
      reset(f,1);
      for j := 0 to 31 do
        for i := 0 to 19 do
          blockread(f,np3^[j+100,i+60+94],1);
      close(f);
      assign(f,'kni\statye1.kni');
      reset(f,1);
      for j := 0 to 87 do
        for i := 0 to 23 do
          blockread(f,np3^[j+100,i+80+94],1);
      close(f);
        for l1 := 1 to playsx do begin
         if playses[l1].kolvic < kolv then
          for j := 100 to 131 do
            for i := (l1-1)*20+93 to l1*20+93 do
              scr^[(j-163)+24+170,i+94] := np3^[j,i];
        end;
      l2 := 0;
      repeat
        for l1 := 1 to playsx do
         if playses[l1].kolvic >= kolv then begin
          for j := 100 to 132 do
            for i := (l1-1)*23 to l1*23 do
              scr^[(j-163)+24+170,i+90-(l1-1)*23] := np3^[j,i];
{        end;}
        for j := 102 to 187 do
          for i := 174 to 197 do
            if np3^[j,i] <> 3 then
              scr^[(j-102)+61+l2*5,(i-174)+72] := np3^[j,i];{}
        end;
        if l2 = 0 then
          l2 := 1
        else
          l2 := 0;
        delay(200);
        colorbar(72,60,95,160,72);
      until key[28];
      for l1 := 1 to 4 do
        playses[l1].kolvic := 0;
end;

procedure beginbattle;
var
  l,i,j : integer;
  b     : boolean;
begin
  setpalkni(2);
  tyr;
{  initkeys;}
  repeat
    b := false;
    tyr2;
    setpalkni(3);
    initmap;
    setpalkni(2);
    repeat
      forbomb;
      for l := 1 to playsx do if playses[l].liv then begin
        step2(l,22,23);
        putspr2(playses[l].x-8,playses[l].y-23,(l-1)*13+playses[l].nap+playses[l].nom);
      end;
      delay(100);
    until key[1] or (playslx <= 1);
    if playslx <= 1  then begin
      for i := 1 to playsx do
        if playses[i].liv then
           inc(playses[i].kolvic);
      playslx := playsx;
      tyr;
      delay(200);
      for i := 1 to playsx do
        if playses[i].kolvic = kolv then begin
          b := true;
          final;
        end;
    end else begin
      b := true;
    end;
  until b;
end;

procedure start(var nomber : byte);
var
  i,j,k,poz,xpoz  : integer;
  f    : file;
  long : array [0..255] of byte;
begin
  assign(f,'kni\titr.kni');
  reset(f,1);
  for j := 0 to 145 do begin
    blockread(f,long,sizeof(long));
    for i := 0 to 255 do
      np3^[j,i] := long[i];
  end;
  close(f);
  setpalkni(1);
  for j := 0 to 199 do
    for i := 0 to 255 do
      scr^[j,i+32] := 13;
  for k := 0 to 145 do begin
    while (port[$3da] and 8) = 0 do;
    for j := (199-k) to 199 do
      move(np3^[j-(199-k)],scr^[j,32],256);
  end;
  assign(f,'kni\blaster.kni');
  reset(f,1);
  for j := 0 to 34 do begin
    blockread(f,long,168);
    for i := 0 to 167 do
      if long[i] <> 3 then
         np3^[j,i] := long[i]
     else
       np3^[j,i] := 13;
  end;
  close(f);
  for j := 0 to 34 do
    for i := 0 to 167 do
     if np3^[j,i] <> 13 then
      scr^[j+22,i+32+85] := np3^[j,i];
  assign(f,'kni\dyna_d.kni');
  reset(f,1);
  for j := 0 to 42 do begin
    blockread(f,long,40);
    for i := 0 to 39 do
      if long[i] <> 3 then
         np3^[j,i] := long[i]
     else
       np3^[j,i] := 13;
  end;
  close(f);
  for j := 0 to 42 do
    for i := 0 to 39 do
      scr^[j+10,i+32+2] := np3^[j,i];
  assign(f,'kni\dyna_yna.kni');
  reset(f,1);
  for j := 0 to 42 do begin
    blockread(f,long,56);
    for i := 0 to 55 do
      if long[i] <> 3 then
         np3^[j,i] := long[i]
     else
       np3^[j,i] := 13;
  end;
  close(f);
  for j := 0 to 42 do
    for i := 0 to 55 do
     if np3^[j,i] <> 13 then
      scr^[j+1,i+32+42] := np3^[j,i];
  setgttyp(0);
  setgtcol(20);
  puttext(132,115,'Новая игра');
  puttext(132,125,'Сражение');
  puttext(132,135,'Настройка');
  puttext(132,145,'Пароль');
  poz := 115;
  xpoz := 115;
  setgtcol(19);
  for j := xpoz to xpoz+8 do
    for i := 130 downto 122 do
      scr^[j,i] := np3^[j-54,i-32];
  putchar(122,poz,'>');
  xpoz := poz;
  nomber := 10;
  repeat
    if key[80] and (poz < 145) then begin
      inc(poz,10);
      setgtcol(19);
      for j := xpoz to xpoz+8 do
        for i := 130 downto 122 do
          scr^[j,i] := np3^[j-54,i-32];
      putchar(122,poz,'>');
      xpoz := poz;
      delay(200);
    end;
    if key[72] and (poz > 115) then begin
      dec(poz,10);
      setgtcol(19);
      for j := xpoz to xpoz+8 do
        for i := 130 downto 122 do
          scr^[j,i] := np3^[j-54,i-32];
      putchar(122,poz,'>');
      xpoz := poz;
      delay(200);
    end;
  until  key[28] or key[1];
  if key[28] then
    nomber := (poz - 115) div 10
  else begin
    setpalkni(3);
    EXIT := TRUE;
  end;
end;

end.

