unit keys2;
INTERFACE
var
   key : array[0..127]of boolean; {признаки клавиш - нажата/отпущена}

procedure initkeys;

IMPLEMENTATION
uses dos;
var
    ExitSave:Pointer;     { адрес старой программы выхода в DOS }
    p9old:pointer;        { адрес прерывания 9 }
    i : integer;
{$F+}
procedure NewInt; interrupt;  { новое аппаратное прерывание клавиатуры }
var
   Button : byte;
begin
   asm
      cli
      in al,60h ;
      mov Button,al
      in al,61h   { инициализация клавиатуры }
      mov ah,al
      or al,80h
      out 61h,al
      mov al,ah
      out 61h,al
      sti
   end;
   if Button < 128 then key[Button] := TRUE
                   else key[Button-128] := FALSE;
   asm
      mov al,20h  {конец обработки прерывания}
      out 20h,al
   end;
end;

procedure MyExit;  { дополнительная процедура при выходе в DOS }
begin
    ExitProc:=ExitSave;
    SetIntVec(9,p9old);
end;
{$F-}
procedure initkeys;
begin
   GetIntVec(9,p9old);
   SetIntVec(9,@NewInt);   {переопределение прерывания клавиатуры }
   ExitSave:=ExitProc;  {переопределение процедуры выхода}
   ExitProc:=@MyExit;
   for i := 0 to 127 do key[i] := FALSE;
end;

end.