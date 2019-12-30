-- Implementacija MergeSorta u Adi.

with Ada.Text_IO;
procedure Msort is
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
      if a = 0 then
         Ada.Text_IO.Put ("0");
         return;
      end if;
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
   n, i, brojac, vrhStoga, donjaGranica, gornjaGranica, sredinaNiza,
   gdjeSmoUPrvomNizu, gdjeSmoUDrugomNizu : Integer;
   type niz is array (Integer range 0 .. 20_000) of Integer;
   type vrstaGrananja is (razdvajati, spajati);
   type stogOGrananju is array (Integer range 0 .. 20_000) of vrstaGrananja;
   trebaLiSpajatiIliRazdvajati : vrstaGrananja;
   original, pomocni, stogSDonjimGranicama, stogSGornjimGranicama : niz;
   stogSPodacimaTrebaLiPetljaRazdvajatiIliSpajatiNizove : stogOGrananju;
begin
   Ada.Text_IO.Put_Line ("Unesite koliko cete brojeva unijeti:");
   n := ReadInt;
   Ada.Text_IO.Put_Line ("Unesite te brojeve:");
   i := 0;
   while i < n loop
      original (i) := ReadInt;
      i            := i + 1;
   end loop;
   brojac                                                          := 0;
   vrhStoga                                                        := 1;
   stogSDonjimGranicama (vrhStoga)                                 := 0;
   stogSGornjimGranicama (vrhStoga)                                := n;
   stogSPodacimaTrebaLiPetljaRazdvajatiIliSpajatiNizove (vrhStoga) :=
     razdvajati;
   while vrhStoga > 0 loop
      gornjaGranica               := stogSGornjimGranicama (vrhStoga);
      donjaGranica                := stogSDonjimGranicama (vrhStoga);
      trebaLiSpajatiIliRazdvajati :=
        stogSPodacimaTrebaLiPetljaRazdvajatiIliSpajatiNizove (vrhStoga);
      vrhStoga    := vrhStoga - 1;
      sredinaNiza := (donjaGranica + gornjaGranica) / 2;
      if trebaLiSpajatiIliRazdvajati = razdvajati
      then --Razdvajanje niza u dva priblizno jednaka,
         --njihova granica ce biti "sredinaNiza"
           --(ona ce pripadati drugom nizu, a sve do nje prvom nizu).
         if gornjaGranica - donjaGranica > 1
         then --Niz velicine 1 ili 0 uvijek je poredan, i ne trebamo nista dalje raditi.
            vrhStoga := vrhStoga + 1;
            stogSDonjimGranicama (vrhStoga) := donjaGranica;
            stogSGornjimGranicama (vrhStoga) := gornjaGranica;
            stogSPodacimaTrebaLiPetljaRazdvajatiIliSpajatiNizove (vrhStoga) :=
              spajati; --Nakon sto smo poredali ta dva niza, trebamo ih spojiti.
            --Podatak o sadasnjim granicama stavljamo prvi na stog kako bi bio zadnji izvaden sa stoga.
            vrhStoga := vrhStoga + 1;
            stogSDonjimGranicama (vrhStoga) := donjaGranica;
            stogSGornjimGranicama (vrhStoga) := sredinaNiza;
            stogSPodacimaTrebaLiPetljaRazdvajatiIliSpajatiNizove (vrhStoga) :=
              razdvajati;
            vrhStoga := vrhStoga + 1;
            stogSDonjimGranicama (vrhStoga) := sredinaNiza;
            stogSGornjimGranicama (vrhStoga) := gornjaGranica;
            stogSPodacimaTrebaLiPetljaRazdvajatiIliSpajatiNizove (vrhStoga) :=
              razdvajati;
         end if;
      else --Spajanje dva poredana niza u treci poredani niz,
         --gdje prvi niz ima granice "donjaGranica" i "sredinaNiza",
         --a drugi "sredinaNiza" i "gornjaGranica".
         i                  := donjaGranica;
         gdjeSmoUPrvomNizu  := donjaGranica;
         gdjeSmoUDrugomNizu := sredinaNiza;
         while i < gornjaGranica loop
            if
              (gdjeSmoUPrvomNizu = sredinaNiza or
               original (gdjeSmoUDrugomNizu) <
                 original (gdjeSmoUPrvomNizu)) and
              gdjeSmoUDrugomNizu < gornjaGranica
            then
               pomocni (i)        := original (gdjeSmoUDrugomNizu);
               gdjeSmoUDrugomNizu := gdjeSmoUDrugomNizu + 1;
            else
               pomocni (i)       := original (gdjeSmoUPrvomNizu);
               gdjeSmoUPrvomNizu := gdjeSmoUPrvomNizu + 1;
            end if;
            i      := i + 1;
            brojac := brojac + 1;
         end loop;
         i := donjaGranica;
         while i < gornjaGranica loop
            original (i) := pomocni (i);
            brojac       := brojac + 1;
            i            := i + 1;
         end loop;
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
end Msort;
