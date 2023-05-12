uses pal;
type
  scrptr = array[0..199,0..319]of byte;
  tscr   = ^scrptr;
var
  long : array[1..320]of byte;
  maxs : integer;
  f    : file;
  fin  : file;
  l    : longint;
  i,j  : integer;
  scr  : tscr;
  b    : boolean;
  w    : char;

procedure setpalknight;
var
  p : array[0..767]of byte;   {палитра}
begin
   assign(fin,'pal4.dat');               {файл с палитрой}
{   assign(fin,'pal.dat');               {файл с палитрой}
   reset(fin,1);
   blockread(fin,p,768);
   close(fin);                          {закрываем файл}
   setpal(p[0],0,256);                {устанавливаем нужную палитру}
end;

begin
  scr := ptr(SegA000,0);
  asm
    mov ax , $0013
    int $10
  end;
  maxs := 256;
  setpalknight;
  assign(f,'st1.kni');
  reset(f,1);
  seek(f,l);
  b := false;
    for j := 0 to 199 do begin
      blockread(f,long,maxs);
      for i := 1 to 320 do begin
        scr^[j,i] := long[i+1]; {}
      end;
    end;
{    readln;       {}
  close(f);
  maxs := 48;
  assign(f,'st3.kni');
  reset(f,1);
  seek(f,l);
  b := false;
    for j := 0 to 25 do begin
      blockread(f,long,maxs);
      for i := 1 to 46 do begin
        scr^[j+135,i+108] := long[i+1]; {}
      end;
    end;
    readln;
  close(f);
  asm
    mov ax , $0003
    int $10
  end;
end.
