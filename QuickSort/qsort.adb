-- Odlucio sam implementirati QuickSort i u Adi, da vidimo koliko dobar
-- asemblerski kod generiraju compileri za danas manje koristene jezike.
-- Takoder ga je relativno lagano preurediti u VHDL kod, tako da je onda
-- lagano isprobati koliko se brzo vrti ako se prevede nekim compilerom
-- za VHDL simulacije.

with Ada.Text_IO;
procedure Qsort is
   function ReadInt return Integer is
      tmp            : String (1 .. 12);
      ret, i, length : Integer;
      type sign is (pozitivno, negativno);
      predznak : sign;
   begin
      Ada.Text_IO.Get_Line (tmp, length);
      predznak := pozitivno;
      i        := 0;
      ret      := 0;
      while i < length loop
         if tmp (i + 1) = '-' then
            predznak := negativno;
            i        := i + 1;
         else
            ret :=
              ret * 10 + Character'Pos (tmp (i + 1)) - Character'Pos ('0');
            i := i + 1;
         end if;
      end loop;
      if predznak = negativno then
         ret := -ret;
      end if;
      return ret;
   end ReadInt;
   procedure PrintInt (a : Integer) is
      i, lastDigit, length, ispis, brojac : Integer;
      tmp, tmp2                           : String (1 .. 12);
      type sign is (pozitivno, negativno);
      predznak : sign;
   begin
      ispis := a;
      if ispis < 0 then
         predznak := negativno;
         ispis    := -ispis;
      else
         predznak := pozitivno;
      end if;
      i := 0;
      while ispis > 0 loop
         brojac := 0;
         while ispis >= 1000 loop
            ispis  := ispis - 1000;
            brojac := brojac + 1;
         end loop;
         brojac := brojac * 10;
         while ispis >= 100 loop
            ispis  := ispis - 100;
            brojac := brojac + 1;
         end loop;
         brojac := brojac * 10;
         while ispis >= 10 loop
            ispis  := ispis - 10;
            brojac := brojac + 1;
         end loop;
         lastDigit   := ispis;
         ispis       := brojac;
         tmp (i + 1) := Character'Val (lastDigit + Character'Pos ('0'));
         i           := i + 1;
      end loop;
      length := i;
      i      := 0;
      while i < length loop
         tmp2 (i + 1) := tmp (length - i);
         i            := i + 1;
      end loop;
      if predznak = negativno then
         Ada.Text_IO.Put ("-");
      end if;
      Ada.Text_IO.Put (tmp2 (1 .. length));
   end PrintInt;
   n, i, brojac, vrhStoga, donjaGranica, gornjaGranica, gdjeJePivot, staviVece,
   staviManje : Integer;
   type niz is array (Integer range 0 .. 20_000) of Integer;
   original, pomocni, stogSDonjimGranicama, stogSGornjimGranicama : niz;
begin
   Ada.Text_IO.Put_Line ("Unesite koliko cete brojeva unijeti:");
   n := ReadInt;
   Ada.Text_IO.Put_Line ("Unesite te brojeve:");
   i := 0;
   while i < n loop
      original (i) := ReadInt;
      i            := i + 1;
   end loop;
   brojac                           := 0;
   vrhStoga                         := 1;
   stogSDonjimGranicama (vrhStoga)  := 0;
   stogSGornjimGranicama (vrhStoga) := n;
   while vrhStoga > 0 loop
      gornjaGranica := stogSGornjimGranicama (vrhStoga);
      donjaGranica  := stogSDonjimGranicama (vrhStoga);
      vrhStoga      := vrhStoga - 1;
      gdjeJePivot   := donjaGranica;
      i             := donjaGranica + 1;
      while i < gornjaGranica loop
         if original (i) < original (donjaGranica) then
            gdjeJePivot := gdjeJePivot + 1;
         end if;
         i := i + 1;
      end loop;
      staviManje            := donjaGranica;
      staviVece             := gdjeJePivot + 1;
      pomocni (gdjeJePivot) := original (donjaGranica);
      i                     := donjaGranica + 1;
      while i < gornjaGranica loop
         if original (i) < original (donjaGranica) then
            pomocni (staviManje) := original (i);
            staviManje           := staviManje + 1;
         else
            pomocni (staviVece) := original (i);
            staviVece           := staviVece + 1;
         end if;
         brojac := brojac + 1;
         i      := i + 1;
      end loop;
      i := donjaGranica;
      while i < gornjaGranica loop
         original (i) := pomocni (i);
         i            := i + 1;
      end loop;
      if gdjeJePivot < gornjaGranica - 1 then
         vrhStoga                         := vrhStoga + 1;
         stogSDonjimGranicama (vrhStoga)  := gdjeJePivot + 1;
         stogSGornjimGranicama (vrhStoga) := gornjaGranica;
      end if;
      if gdjeJePivot > donjaGranica + 1 then
         vrhStoga                         := vrhStoga + 1;
         stogSDonjimGranicama (vrhStoga)  := donjaGranica;
         stogSGornjimGranicama (vrhStoga) := gdjeJePivot;
      end if;
   end loop;
   Ada.Text_IO.Put_Line ("Sortirani niz je:");
   i := 0;
   while i < n loop
      PrintInt (original (i));
      Ada.Text_IO.Put_Line ("");
      i := i + 1;
   end loop;
   Ada.Text_IO.Put ("Unutrasnja petlja izvrsila se ");
   PrintInt (brojac);
   Ada.Text_IO.Put_Line (" puta.");
   null;
end Qsort;
