unit keys2;
INTERFACE
var
   key : array[0..127]of boolean; {�ਧ���� ������ - �����/���饭�}

procedure initkeys;

IMPLEMENTATION
uses dos;
var
    ExitSave:Pointer;     { ���� ��ன �ணࠬ�� ��室� � DOS }
    p9old:pointer;        { ���� ���뢠��� 9 }
    i : integer;
{$F+}
procedure NewInt; interrupt;  { ����� �����⭮� ���뢠��� ���������� }
var
   Button : byte;
begin
   asm
      cli
      in al,60h ;
      mov Button,al
      in al,61h   { ���樠������ ���������� }
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
      mov al,20h  {����� ��ࠡ�⪨ ���뢠���}
      out 20h,al
   end;
end;

procedure MyExit;  { �������⥫쭠� ��楤�� �� ��室� � DOS }
begin
    ExitProc:=ExitSave;
    SetIntVec(9,p9old);
end;
{$F-}
procedure initkeys;
begin
   GetIntVec(9,p9old);
   SetIntVec(9,@NewInt);   {��८�।������ ���뢠��� ���������� }
   ExitSave:=ExitProc;  {��८�।������ ��楤��� ��室�}
   ExitProc:=@MyExit;
   for i := 0 to 127 do key[i] := FALSE;
end;

end.