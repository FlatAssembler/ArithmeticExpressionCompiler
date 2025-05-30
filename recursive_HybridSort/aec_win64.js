// JavaScript s web-stranice https://flatassembler.github.io/compiler.html
// Izmijenjen da ispisuje asemblerski kod kompatibilan sa 64-bitnim Windowsima,
// koji koriste RIP-relativno adresiranje.
/*i486 i noviji procesori iz x86 familije imaju FPU stog od 8 bitseta po 80
   bitova. Ovaj se program oslanja na njega. 8 bitseta je u vecini slucajeva
   dovoljno. Ako bismo zeljeli da moze jos kompliciranije stvari raditi (ili ga
   uciniti portabilnim), trebali bismo napraviti svoj stog. Da program bude
   lakse tako izmijeniti, pokusao sam
             sto vise ne pristupati stogu izravno, nego preko funkcija.*/
function finit() {
  // Inicijalizira FPU stog kad je se pozove prvi put u programu, inace brise
  // sve brojeve na njemu
  asm("finit");
}
function faddp() {
  // Dodaje pretposljednjem broju posljednji broj na FPU stogu i brise
  // posljednji broj
  asm("faddp");
}
function fsubp() {
  // Oduzima posljednji broj od pretposljednjeg te brise posljednji broj na
  // stogu
  asm("fsubp");
}
function fmulp() {
  // Mnozi zadnja dva broja na FPU stogu, uklanja ih sa stoga, te rezultat
  // dodaje na vrh stoga
  asm("fmulp");
}
function fdivp() {
  // Dijeli pretposljednji broj na FPU stogu s posljednjim, brise sa stoga ta
  // dva broja te rezultat dodaje na stog
  asm("fdivp");
}
function fsinp() {
  // Zamijenjuje zadnji broj na stogu njegovim sinusom (radijani)
  asm("fsin");
}
function fcosp() {
  // Zamijenjuje zadnji broj na stogu njegovim kosinusom (radijani)
  asm("fcos");
}
function ftanp() {
  //-||- tangensom -||-, po formuli tan(x)=sin(x)/cos(x)
  asm("fsincos");
  fdivp();
}
function fsqrt() {
  //-||- kvardatnim korijenom
  asm("fsqrt");
}
function fatanp() {
  //-||- arkus tangensom
  asm("fld1");
  fatan2();
}
function fatan2() {
  // Racuna arkus tangens kolicnika predzadnjeg i zadnjeg broja, brise te
  // brojeve, te dodaje rezultat na stog
  asm("fpatan");
}
function fasinp() {
  //-||- arkus sinus (po formuli arctan(x/sqrt(1-x*x)))
  fstp();
  fld();
  asm("fld1");
  fld();
  fld();
  fmulp();
  fsubp();
  fsqrt();
  fdivp();
  fatanp();
}
function facosp() {
  // -||- arkus kosinus (po formuli pi/2-arcsin(x))
  fstp();
  asm("fldpi");
  asm("fld1");
  asm("fld1");
  faddp();
  fdivp();
  fld();
  fasinp();
  fsubp();
}
function flnp() {
  // Zamijenjuje zadnji broj na stogu njegovim prirodnim logaritmom
  asm("fld1");
  asm("fxch");
  asm("fyl2x");
  asm("fldl2e");
  fdivp();
}
function fexpp() {
  // Zamijenjuje zadnji broj na stogu s e^x, gdje je 'e' baza prirodnog
  // logaritma.
  asm("fldl2e");
  fmulp();
  asm("fld1");
  asm("fscale");
  asm("fxch");
  asm("fld1");
  asm("fxch");
  asm("fprem");
  asm("f2xm1");
  faddp();
  fmulp();
}
function flogp() {
  // -||- dekadskim logaritmom (po formuli ln(x)/ln(10))
  flnp();
  asm("mov dword [rip + result]," +
      (highlight ? '<span style="color:#007700">' : "") + "10" +
      (highlight ? "</span>" : ""));
  fild();
  flnp();
  fdivp();
}
function fpowp() {
  // Zamijenjuje zadnja dva broja na stogu njihovom potencijom (po formuli
  // exp(ln(x)*y)).
  asm("fxch");
  flnp();
  fmulp();
  fexpp();
}
function fabsp() {
  // Zamijenjuje zadnji broj na stogu njegovom apsolutnom vrijednoscu
  asm("fabs");
}
function fpmod() {
  // Zamijenjuje zadnja dva broja na stogu ostatkom pri dijeljenju zadnjeg s
  // predzadnjim.
  asm("fxch");
  asm("fprem");
  asm("fxch");
  fstp();
}
function fcomip() {
  // Usporedi dva broja na vrhu stoga i postavi CPU-ove zastavice da oznacuju
  // rezultat usporedbe. "fcomip" postoji samo na i686 i novijim x86 procesorima,
  //a mi ciljamo na i486.
  // https://www.vogons.org/viewtopic.php?p=1130626#p1130626
  asm("fcomp");
  asm("push " + (highlight ? '<span style="color:#007777">' : "") + "ax" +
      (highlight ? "</span>" : ""));
  asm("fstsw " + (highlight ? '<span style="color:#007777">' : "") + "ax" +
      (highlight ? "</span>" : ""));
  asm("mov " + (highlight ? '<span style="color:#007777">' : "") + "al" +
      (highlight ? "</span>" : "") + "," +
      (highlight ? '<span style="color:#007777">' : "") + "ah" +
      (highlight ? "</span>" : ""));
  asm("lahf");
  asm("and " + (highlight ? '<span style="color:#007777">' : "") + "ax" +
      (highlight ? "</span>" : "") + "," +
      (highlight ? '<span style="color:#007700">' : "") + "0xba45" +
      (highlight ? "</span>" : ""));
  asm("or " + (highlight ? '<span style="color:#007777">' : "") + "ah" +
      (highlight ? "</span>" : "") + "," +
      (highlight ? '<span style="color:#007777">' : "") + "al" +
      (highlight ? "</span>" : ""));
  asm("sahf");
  asm("pop " + (highlight ? '<span style="color:#007777">' : "") + "ax" +
      (highlight ? "</span>" : ""));
}
function fstp() {
  // Obrisi broj na vrhu stoga i stavi ga u "result".
  if (syntax == "fasm")
    asm("fstp dword [rip + result]");
  else if (syntax == "gas")
    asm("fstp dword ptr [rip + result]");
  else
    throw "Invalid syntax name!";
}
function fld() {
  // Stavi broj iz varijable "result" na vrh stoga.
  if (syntax == "fasm")
    asm("fld dword [rip + result]");
  else if (syntax == "gas")
    asm("fld dword ptr [rip + result]");
  else
    throw "Invalid syntax name!";
}
function fild() {
  // Pretpostavi da je u "result"-u cijeli broj, pretvori ga u decimalni i stavi
  // na stog.
  if (syntax == "fasm")
    asm("fild dword [rip + result]");
  else if (syntax == "gas")
    asm("fild dword ptr [rip + result]");
  else
    throw "Invalid syntax name!";
}
function fistp() {
  // Pretvori broj na vrhu stoga u cijeli broj, spremi ga u "result" i obrisi sa
  // stoga.
  if (syntax == "fasm")
    asm("fistp dword [rip + result]");
  else if (syntax == "gas")
    asm("fistp dword ptr [rip + result]");
  else
    throw "Invalid syntax name!";
}
var syntax = "fasm";
var verboseMode = false;
var varijable = new Object(); // Globalni objekt pomocu kojeg ce komunicirati
                              // strukture koje konstruira "Token", u C++-u bi
                              // to bio std::map<std::string,float>.
var alerted; // Prikazuje se samo jedna greska u svakom pokusaju interpretiranja
             // ili compiliranja.
var highlight =
    typeof window !=
    "undefined"; // Hocemo li sintaksno bojati Assembler (jer pokusaj da se to
                 // radi u Nashornu ili Rhinu, koji se pokrecu iz komandne
                 // linije, samo pravi probleme)?
if (typeof window == "undefined") {
  // Nashorn, Rhino, Duktape i slicni JavaScript interpreteri...
  eval("var alert=function(x){throw String(x);};"); // Ironicno, ali izgleda da
                                                    // je ovo nacin ispisivanja
                                                    // stringa na konzolu koji
                                                    // podrzava najvise
                                                    // JavaScript iterpretera
                                                    // (iako tome to uopce nije
                                                    // namijenjeno).
  eval("var prompt=function(x){return null;};"); // Imate bolju ideju? Stvarno
                                                 // neobicno da JavaScript nema
                                                 // standardnu funkciju za ulaz
                                                 // sa standardnog ulaza, ali
                                                 // ima za ulaz sa prompt-boxa
                                                 // ako je pokrenut u GUI-u.
}
if (typeof ArrayBuffer != "undefined" && typeof Float32Array != "undefined") {
  // Moderni JavaScript interpreteri (koji podrzavaju naredbe "ArrayBuffer" i
  // "Float32Array") mogu relativno jednostavno pretvarati decimalne brojeve u
  // IEEE754 zapis.
  getIEEE754 = function(decimalNumber) {
    var floatArray = new Float32Array([ decimalNumber ]);
    var buffer = floatArray.buffer;
    var intArray = new Int32Array(buffer);
    return ((highlight ? '<span style="color:#007700">' : "") + "0x" +
            intArray[0].toString(16) + (highlight ? "<\/span>" : ""));
  };
}
if (!Array.prototype.includes)
  // Dirty-fix za starije preglednike koji ne podrzavaju JavaScript naredbu
  // Array.includes (kao sto je Internet Explorer 6).
  Array.prototype.includes = function(x) {
    for (var i = 0; i < this.length; i++)
      if (this[i] == x)
        return true;
    return false;
  };
var boolean = [
  0, 1, "<", "=", ">", "&", "|", "not("
]; // Sto sve vraca logicku vrijednost, a ne broj.
if (eval("0=='+'")) {
  // https://github.com/svaarala/duktape/issues/2019
  boolean[0] = "0"; // Imate bolju ideju?
  boolean[1] = "1";
}
function Token(tmp) {
  // Konstruktor strukture koju koristi parser
  var ret = new Object();
  ret.operands = [];
  ret.text = tmp;
  ret.depth = 0;
  ret.DFS = function() // Pokusat cu izbjeci stack overflow tako da se prvo
                       // kompajliraju "dublji" izrazi.
  {
    if (this.depth)
      return this.depth;
    if (!this.operands.length)
      this.depth = 1;
    else
      for (var i = 0; i < this.operands.length; i++)
        this.depth = Math.max(this.depth, this.operands[i].DFS() + 1);
    return this.depth;
  };
  ret.toLisp = function() {
    this.name = this.text;
    if (this.text.charAt(this.text.length - 1) == "(" ||
        this.text.charAt(this.text.length - 1) == "[")
      this.name = this.text.slice(0, this.text.length - 1);
    if (this.operands.length) {
      var ret = "(" + this.name + " ";
      for (var i = 0; i < this.operands.length; i++)
        ret += this.operands[i].toLisp() +
               (i == this.operands.length - 1 ? "" : " ");
      ret += ")";
      return ret.replace(/\)\s\)/g, "))");
    } else
      return this.text.replace(/\)\s\)/g, "))");
  };
  ret.interpret = function() {
    if (alerted)
      return 0 / 0;
    else if (this.text == "+" && !this.operands.length)
      // Ako netko unese "c++"
      return 1;
    else if (this.text.charAt(0) >= "0" && this.text.charAt(0) <= "9")
      return this.text * 1;
    else if (this.text == "?:")
      return this.operands[0].interpret() ? this.operands[1].interpret()
                                          : this.operands[2].interpret();
    else if (this.text == "+")
      return this.operands[0].interpret() + this.operands[1].interpret();
    else if (this.text == "-")
      return this.operands[0].interpret() - this.operands[1].interpret();
    else if (this.text == "/")
      return this.operands[0].interpret() / this.operands[1].interpret();
    else if (this.text == "\\")
      return this.operands[1].interpret() / this.operands[0].interpret();
    else if (this.text == "*")
      return this.operands[0].interpret() * this.operands[1].interpret();
    else if (this.text == "sin(")
      return Math.sin(this.operands[0].interpret());
    else if (this.text == "cos(")
      return Math.cos(this.operands[0].interpret());
    else if (this.text == "tan(")
      return Math.tan(this.operands[0].interpret());
    else if (this.text == "atan2(")
      return Math.atan2(this.operands[0].interpret(),
                        this.operands[1].interpret());
    else if (this.text == "arctan(")
      return Math.atan(this.operands[0].interpret());
    else if (this.text == "ctg(")
      return 1 / Math.tan(this.operands[0].interpret());
    else if (this.text == "arcctg(")
      return Math.PI / 2 - Math.atan(this.operands[0].interpret());
    else if (this.text == "sqrt(")
      return Math.sqrt(this.operands[0].interpret());
    else if (this.text == "arcsin(")
      return Math.asin(this.operands[0].interpret());
    else if (this.text == "arccos(")
      return Math.acos(this.operands[0].interpret());
    else if (this.text == "ln(")
      return Math.log(this.operands[0].interpret());
    else if (this.text == "log(")
      return Math.log(this.operands[0].interpret()) / Math.log(10);
    else if (this.text == "exp(")
      return Math.exp(this.operands[0].interpret());
    else if (this.text == "pow(")
      return Math.pow(this.operands[0].interpret(),
                      this.operands[1].interpret());
    else if (this.text == "abs(")
      return Math.abs(this.operands[0].interpret());
    else if (this.text == "mod(")
      return this.operands[0].interpret() % this.operands[1].interpret();
    // U JavaScriptu, za razliku od C-a, operator '%' podrzava decimalne
    // brojeve.
    else if (this.text == "=")
      return ((this.operands[0].interpret() == this.operands[1].interpret()) *
              1);
    else if (this.text == "<")
      return ((this.operands[0].interpret() < this.operands[1].interpret()) *
              1);
    else if (this.text == ">")
      return ((this.operands[0].interpret() > this.operands[1].interpret()) *
              1);
    else if (this.text == "not(") {
      if (!boolean.includes(this.operands[0].text))
        alert(
            "Interpreter warning: Casting a non-Boolean number into Boolean, may cause undefined behaviour.");
      return !this.operands[0].interpret() * 1;
    } else if (this.text == "&") {
      if (!boolean.includes(this.operands[0].text) ||
          !boolean.includes(this.operands[1].text))
        alert(
            "Interpreter warning: Casting a non-Boolean number into Boolean, may cause undefined behaviour.");
      return ((this.operands[0].interpret() && this.operands[1].interpret()) *
              1);
    } else if (this.text == "|") {
      if (!boolean.includes(this.operands[0].text) ||
          !boolean.includes(this.operands[1].text))
        alert(
            "Interpreter warning: Casting a non-Boolean number into Boolean, may cause undefined behaviour.");
      return ((this.operands[0].interpret() || this.operands[1].interpret()) *
              1);
    } else if (this.text.charAt(this.text.length - 1) == "(") {
      alerted = 1;
      alert("Interpreter error: Unrecognized function name '" +
            this.text.slice(0, this.text.length - 1) + "'.");
      return 0 / 0;
    }
    if (varijable[this.text] == null)
      if (typeof window != "undefined")
        /*U Duktapeu (JavaScript engineu
                                                     napisanom u cijelosti u
           C99, ima znatno manje sposobnosti optimizacije nego sto imaju Rhino
                                                     ili Nashorn, ali njegov se
           optimizator barem ne rusi ako se pokrene na "manje popularnim"
           platformama poput Androida), Nashornu i Rhinu vjerojatno je najbolje
                                                     rjesenje traziti od
           vanjskog programa da deklarira varijable i ispisati poruku o pogresci
           ako on to nije napravio. Sto da kazem o tim engineima, ja imam dojam
                                                     da su sporiji (a vjerojatno
           i bugovitiji) cak i od Internet Explorera 6. Mislim, on mora ne samo
           izvrsiti JavaScript, nego i CSS i parsirati HTML, i kao da to sve
           skupa radi brze no sto Rhino i Duktape izvrsavaju JavaScript, barem
           na Androidu.*/
        varijable[this.text] =
            prompt("Enter the value of the variable '" + this.text + "'");
      else
        alert("Interpreter error: Variable '" + this.text +
              "' is not declared.");
    return varijable[this.text] * 1;
  };
  ret.commentedLispExpression = function() {
    var commentedLispExpression = syntax == "gas" ? "#" : ";";
    if (highlight)
      commentedLispExpression =
          '<span style="color:#777777">' + commentedLispExpression + "<\/span>";
    var lispExpression = 'Pushing "' + this.toLisp() + '" to the FPU stack...';
    for (var i = 0; i < lispExpression.length; i++) {
      var currentChar = lispExpression.charAt(i);
      if (highlight) {
        if (currentChar == "&")
          currentChar = "&amp;";
        if (currentChar == "<")
          currentChar = "&lt;";
        if (currentChar == ">")
          currentChar = "&gt;";
      }
      if (highlight)
        commentedLispExpression +=
            '<span style="color:#777777">' + currentChar + "<\/span>";
      else
        commentedLispExpression += currentChar;
    }
    return commentedLispExpression;
  };
  ret.compile = function() {
    if (this.text == " ")
      return;
    if (this.text == "+" && !this.operands.length)
      // Ako netko unese, na primjer, "c++".
      this.text = "1";
    // Problem: Sto ako netko unese "c--"? Da to rijesimo, morali bismo nekako
    // izmijeniti parser, ako ne i tokenizer.
    if (this.text == "?:") {
      // Ako je rekurzija dosla na cvor u AST-u s uvijetnim operatorom.
      this.operands[2].compile(); // Prevedi prvo treci operand na
                                  // asemblerski...
      this.operands[1].compile(); //...zatim prevedi drugi operand...
      this.operands[0].compile(); //...te konacno prevedi uvijet.
      // Sada je uvijet na vrhu FPU stoga.
      if (verboseMode)
        asm(this.commentedLispExpression());
      fistp();            // Prebaci taj uvijet u varijablu "rezultat".
      asm("xor eax,eax"); // Obrisi sadrzaj CPU registra.
      if (syntax == "fasm")
        asm("cmp dword [rip + result],eax");
      // Usporedi rezultat sa sadrzajem tog registra (to jest, s nulom).
      else if (syntax == "gas")
        asm("cmp dword ptr [rip + result],eax");
      else
        throw "Invalid syntax name!";
      var prvi = (highlight ? '<span style="color:#777700">' : "") +
                 "firstOperandOfTheTernaryOperatorIsZeroLabel" +
                 Math.round(Math.random() * 1000000) +
                 (highlight ? "<\/span>" : "");
      var drugi = (highlight ? '<span style="color:#777700">' : "") +
                  "endOfTheTernaryOperatorLabel" +
                  Math.round(Math.random() * 1000000) +
                  (highlight ? "<\/span>" : "");
      asm("jz " + prvi); // Ako prvi operand nije nula...
      fstp();
      if (syntax == "fasm")
        asm("mov eax, dword [rip + result]");
      // Spremi drugi operand u CPU-ov registar i...
      else if (syntax == "gas")
        asm("mov eax, dword ptr [rip + result]");
      else
        throw "Invalid syntax name!";
      fstp(); //...obrisi treci operand sa FPU stoga, a zatim...
      if (syntax == "fasm")
        asm("mov dword [rip + result],eax");
      else if (syntax == "gas")
        asm("mov dword ptr [rip + result],eax");
      else
        throw "Invalid syntax name!";
      fld(); //...ponovno ucitaj drugi operand iz registra na stog.
      asm("jmp " + drugi);
      asm(prvi + ":"); // Inace, ako prvi operand jest nula...
      fstp(); // Obrisi drugi operand sa stoga, a na stogu, naravno, zadrzi
              // treci operand.
      asm(drugi + ":");
      return;
    }
    var zamijeni = false;
    if (this.operands.length > 1 &&
        this.operands[0].DFS() < this.operands[1].DFS()) {
      zamijeni = true;
      var tmp = this.operands[0];
      this.operands[0] = this.operands[1];
      this.operands[1] = tmp;
    }
    for (var i = 0; i < this.operands.length; i++)
      this.operands[i].compile();
    if (verboseMode)
      asm(this.commentedLispExpression());
    if (zamijeni)
      asm("fxch");
    if (this.text.charAt(0) >= "0" && this.text.charAt(0) <= "9") {
      // Broj
      if (typeof getIEEE754 != "function")
        asm("mov dword" + (syntax == "gas" ? " ptr" : "") + " [rip + result]," +
            (highlight ? '<span style="color:#007700">' : "") + this.text +
            "f" + (highlight ? "</span>" : ""));
      else
        asm("mov dword" + (syntax == "gas" ? " ptr" : "") + " [rip + result]," +
            getIEEE754(this.text * 1) +
            (highlight ? ' <span style="color:#777777">' +
                             (syntax == "gas" ? "#" : ";") + "IEEE754 hex of " +
                             this.text + "<\/span>"
                       : (syntax == "gas" ? " #" : " ;") + "IEEE754 hex of " +
                             this.text));
      fld();
    } else if (this.text == "+")
      faddp();
    else if (this.text == "-")
      fsubp();
    else if (this.text == "/")
      fdivp();
    else if (this.text == "\\") {
      asm("fxch");
      fdivp();
    } else if (this.text == "*")
      fmulp();
    else if (this.text == "sin(")
      fsinp();
    else if (this.text == "cos(")
      fcosp();
    else if (this.text == "tan(")
      ftanp();
    else if (this.text == "ctg(") {
      ftanp();
      asm("mov dword" + (syntax == "gas" ? " ptr" : "") + " [rip + result]," +
          (highlight ? '<span style="color:#007700">' : "") +
          (getIEEE754 ? getIEEE754(-1) : "-1f") + (highlight ? "</span>" : ""));
      fld();
      fpowp();
    } else if (this.text == "atan2(")
      fatan2();
    else if (this.text == "arctan(")
      fatanp();
    else if (this.text == "arcctg(") {
      fatanp();
      asm("fldpi");
      asm("mov dword [rip + result]," +
          (highlight ? '<span style="color:#007700">' : "") +
          (getIEEE754 ? getIEEE754(2) : "2f") + (highlight ? "</span>" : ""));
      fld();
      fdivp();
      asm("fxch");
      fsubp();
    } else if (this.text == "sqrt(")
      fsqrt();
    else if (this.text == "arcsin(")
      fasinp();
    else if (this.text == "arccos(")
      facosp();
    else if (this.text == "ln(")
      flnp();
    else if (this.text == "log(")
      flogp();
    else if (this.text == "exp(")
      fexpp();
    else if (this.text == "pow(")
      fpowp();
    else if (this.text == "abs(")
      fabsp();
    else if (this.text == "mod(")
      fpmod();
    else if (this.text == "=") {
      var prvi = (highlight ? '<span style="color:#777700">' : "") +
                 "operandsOfTheEqualityOperatorAreNotEqualLabel" +
                 Math.round(Math.random() * 1000000) +
                 (highlight ? "</span>" : "");
      var drugi = (highlight ? '<span style="color:#777700">' : "") +
                  "endOfTheEqualityOperatorLabel" +
                  Math.round(Math.random() * 1000000) +
                  (highlight ? "</span>" : "");
      fcomip();
      fstp();
      asm("jne " + prvi);
      asm("fld1");
      asm("jmp " + drugi);
      asm(prvi + ":");
      asm("fldz");
      asm(drugi + ":");
    } else if (this.text == "<") {
      var prvi = (highlight ? '<span style="color:#777700">' : "") +
                 "secondOperandOfTheComparisonIsSmallerOrEqualLabel" +
                 Math.round(Math.random() * 1000000) +
                 (highlight ? "</span>" : "");
      var drugi = (highlight ? '<span style="color:#777700">' : "") +
                  "endOfTheLessThanComparisonLabel" +
                  Math.round(Math.random() * 1000000) +
                  (highlight ? "</span>" : "");
      fcomip();
      fstp();
      asm("jna " + prvi);
      asm("fld1");
      asm("jmp " + drugi);
      asm(prvi + ":");
      asm("fldz");
      asm(drugi + ":");
    } else if (this.text == ">") {
      var prvi = (highlight ? '<span style="color:#777700">' : "") +
                 "secondOperandOfTheComparisonIsGreaterOrEqualLabel" +
                 Math.round(Math.random() * 1000000) +
                 (highlight ? "</span>" : "");
      var drugi = (highlight ? '<span style="color:#777700">' : "") +
                  "endOfTheGreaterThanComparisonLabel" +
                  Math.round(Math.random() * 1000000) +
                  (highlight ? "</span>" : "");
      fcomip();
      fstp();
      asm("jnb " + prvi);
      asm("fld1");
      asm("jmp " + drugi);
      asm(prvi + ":");
      asm("fldz");
      asm(drugi + ":");
    } else if (this.text == "not(") {
      if (!boolean.includes(this.operands[0].text))
        alert(
            "Compiler warning: Casting a non-Boolean number into Boolean, may cause undefined behaviour.");
      asm("fld1");
      asm("fxch");
      fsubp();
    } else if (this.text == "&") {
      if (!boolean.includes(this.operands[0].text) ||
          !boolean.includes(this.operands[1].text))
        alert(
            "Compiler warning: Casting a non-Boolean number into Boolean, may cause undefined behaviour.");
      fistp();
      if (syntax == "fasm")
        asm("mov eax,dword [rip + result]");
      else if (syntax == "gas")
        asm("mov eax,dword ptr [rip + result]");
      else
        throw "Invalid syntax name!";
      fistp();
      if (syntax == "fasm")
        asm("and dword [rip + result],eax");
      else if (syntax == "gas")
        asm("and dword ptr [rip + result],eax");
      else
        throw "Invalid syntax name!";
      fild();
    } else if (this.text == "|") {
      if (!boolean.includes(this.operands[0].text) ||
          !boolean.includes(this.operands[1].text))
        alert(
            "Compiler warning: Casting a non-Boolean number into Boolean, may cause undefined behaviour.");
      fistp();
      if (syntax == "fasm")
        asm("mov eax,dword [rip + result]");
      else if (syntax == "gas")
        asm("mov eax,dword ptr [rip + result]");
      else
        throw "Invalid syntax name!";
      fistp();
      if (syntax == "fasm")
        asm("or dword [rip + result],eax");
      else if (syntax == "gas")
        asm("or dword ptr [rip + result],eax");
      else
        throw "Invalid syntax name!";
      fild();
    } else if (this.text.charAt(this.text.length - 1) == "(" ||
               this.text.charAt(this.text.length - 1) == "[") {
      if (typeof window != "undefined") {
        alerted = 1;
        alert("Compiler error: Unrecognized function name '" +
              this.text.slice(0, this.text.length - 1) + "'.");
        asm((highlight ? '<span style="color:#777777">' : "") +
            ";Here the linker should insert the code for calling the function '" +
            this.text.slice(0, this.text.length - 1) + "'!" +
            (highlight ? "</span>" : ""));
      } else {
        // Hajdemo ovako jednostavno implementirati pokazivace u Duktapeu, kao u
        // QBASIC-u :-)!
        var commentSign = syntax == "gas" ? '#': ';';
        fistp();
	asm("xor rbx, rbx");
        if (syntax == "fasm")
          asm("mov ebx, dword [rip + result]");
        else if (syntax == "gas")
          asm("mov ebx,dword ptr [rip + result]");
        else
          throw "Invalid syntax name!";
	asm("lea r9, dword" + (syntax == "gas" ? " ptr" : "") +" [rip + "+ this.text.substr(0, this.text.length - 1) +"]");
	asm("shl rbx, 2 "+commentSign+"Multiply rbx by 4, the number of bytes in Float32");
	asm("add r9, rbx");
        asm("fld dword" + (syntax == "gas" ? " ptr" : "") + " [r9]");
      }
    } // Ako je this.text naziv neke varijable
    else {
      if (mnemonike.includes(this.text) || registri.includes(this.text)) {
        alert(
            "Compiler error: Can't use the word \"" + this.text +
            '" as a variable name because it is a reserved keyword in x86 assembly.');
        alerted = 1;
        return;
      }
      asm("fld dword " + (syntax == "gas" ? "ptr " : "") +
          (highlight ? '<span style="color:#770000">' : "") + "[rip + " + this.text +
          "]" + (highlight ? "</span>" : ""));
    }
  };
  return ret;
}
function tokenizeArth(arth) {
  if (alerted)
    return [];
  var ret = [ "" ];
  if (!String.prototype.charAtIndex)
    String.prototype.charAtIndex = function(i) { return this.charAt(i); };
  arth = arth.replace(/\)\(/g, ")*(");
  arth = arth.replace(/;.*$/, " ");
  var isString = false;
  for (var i = 0; i < arth.length; i++) {
    if ((arth.charAtIndex(i) >= "0" && arth.charAtIndex(i) <= "9") ||
        arth.charAtIndex(i) == "." ||
        (arth.charAtIndex(i) >= "A" && arth.charAtIndex(i) <= "Z") ||
        (arth.charAtIndex(i) >= "a" && arth.charAtIndex(i) <= "z") ||
        arth.charAtIndex(i) == "_" ||
        (ret[ret.length - 1] == "sin" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "cos" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "tan" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "arcsin" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "arccos" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "arctan" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "pow" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "log" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "ln" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "exp" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "sqrt" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "atan2" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "abs" && arth.charAtIndex(i) == "(") ||
        (ret[ret.length - 1] == "not" && arth.charAtIndex(i) == "(") ||
        isString) {
      ret[ret.length - 1] = ret[ret.length - 1] + arth.charAtIndex(i);
      if (arth.charAtIndex(i) == '"' || arth.charAtIndex(i) == "'")
        isString = !isString;
    } else {
      ret.push(arth.charAtIndex(i)), ret.push("");
      if (arth.charAtIndex(i) == '"' || arth.charAtIndex(i) == "'") {
        isString = !isString;
        ret.pop();
      }
    }
    if ((ret[ret.length - 1].charAtIndex(ret[ret.length - 1].length - 1) ==
             "(" ||
         ret[ret.length - 1].charAtIndex(ret[ret.length - 1].length - 1) ==
             "[") &&
        !isString) {
      ret.push("");
    }
  }
  for (var i = 0; i < ret.length; i++)
    if (!ret[i].length || ret[i] == " ") {
      ret.splice(i, 1);
      i--;
    }
  for (var i = 1; i < ret.length; i++)
    if (ret[i] == "-" &&
        (ret[i - 1] == "+" || ret[i - 1] == "-" || ret[i - 1] == "*" ||
         ret[i - 1] == "/" || ret[i - 1] == ">" || ret[i - 1] == "<" ||
         ret[i - 1] == "=" || ret[i - 1] == ":" || ret[i - 1] == "?")) {
      // Ako netko unese nesto kao "a*-b"
      ret.splice(i, 0, "(");
      if (i + 2 >= ret.length) {
        alert(
            "Tokenizer error: Unable to assign the type to the operator '-' (whether it's unary or binary).");
        alerted = 1;
        return ret;
      }
      if (ret[i + 2].charAt(ret[i + 2].length - 1) != "(")
        ret.splice(i + 3, 0, ")");
      else {
        var j = i + 3;
        var c = 1;
        do {
          if (j >= ret.length) {
            alert(
                "Tokenizer error: Unable to assign the type to the operator '-' (whether it's unary or binary).");
            alerted = 1;
            return ret;
          }
          if (ret[j].charAt(ret[j].length - 1) == "(")
            c++;
          else if (ret[j].charAt(ret[j].length - 1) == ")")
            c--;
          j++;
        } while (c);
        ret.splice(j, 0, ")");
      }
    }
  for (var i = 0; i < ret.length; i++)
    if (ret[i].charAt(0) >= "a" && ret[i].charAt(0) <= "z" &&
        ((ret[i + 1] == "(" && ret[i].charAt(ret[i].length - 1) != "(") ||
         ret[i + 1] == "[")) {
      ret[i] += ret[i + 1];
      ret.splice(i + 1, 1);
    } else if (ret[i].charAt(0) >= "0" && ret[i].charAt(0) <= "9") {
      var decimal = 0;
      for (var j = 0; j < ret[i].length; j++) {
        if ((decimal && ret[i].charAt(j) == ".") ||
            ((ret[i].charAt(j) < "0" || ret[i].charAt(j) > "9") &&
             ret[i].charAt(j) != ".")) {
          alert("Tokenizer error: Can't assign the type to the token '" +
                ret[i] + "'.");
          alerted = 1;
          return ret;
        } else if (!decimal && ret[i].charAt(j) == ".")
          decimal = 1;
      }
    } else if (ret[i].charAt(0) == '"' || ret[i].charAt(0) == "'") {
      if (ret[i].length == 3 && ret[i].charAt(0) == ret[i].charAt(2) &&
          ret[i].charAt(0) == "'") {
        ret[i] = ret[i].charCodeAt(1).toString();
      } else {
        alerted = 1;
        alert("Tokenizer error: The token " + ret[i] +
              " appears to be a string, which this program doesn't support.");
        return ret;
      }
    }
  return ret;
}
function parseArth(arth) {
  // Slozenost algoritma kojeg koristi parser je kvadratna ako nema zagrada, a
  // kubna(?) ako ima zagrada, te parser ne moze parsirati funkcije s vise od
  // dva argumenta, valjalo bi upotrijebiti neki bolji algoritam (recimo, nekako
  // implementirati Shunting-Yard).
  if (alerted)
    return Token(" ");
  if (!arth.length) {
    alert(
        "Parser error: No expression between the parentheses ('()' is not a valid syntax).");
    alerted = 1;
    return Token(" ");
  }
  for (var i = 0; i < arth.length; i++)
    if (arth[i].text == undefined)
      arth[i] = Token(arth[i]);
  for (var i = 0; i < arth.length; i++)
    if ((arth[i].text == "pow(" || arth[i].text == "atan2(" ||
         arth[i].text == "mod(") &&
        !arth[i].operands.length) {
      var c = 1;
      var j = 0;
      while (c) {
        j++;
        if (i + j >= arth.length) {
          alerted = 1;
          alert(
              "Parser error: Expected a ',' to divide the arguments of a binary function.");
          return arth[0];
        }
        if (arth[i + j].text == ",")
          c--;
        else if (arth[i + j].text == "pow(" || arth[i + j].text == "atan2(" ||
                 arth[i + j].text == "mod(")
          c++;
      }
      var tmp = [];
      for (var k = 1; k < j; k++)
        tmp.push(arth[i + k].text);
      arth[i].operands.push(parseArth(tmp));
      var k = 0;
      c = 1;
      while (c) {
        k++;
        if (i + j + k >= arth.length) {
          alerted = 1;
          alert(
              "Parser error: Expected a ')' to mark the end of the second argument of a binary function.");
          return arth[0];
        }
        if (arth[i + j + k].text == ")")
          c--;
        else if (arth[i + j + k].text.charAt(arth[i + j + k].text.length - 1) ==
                 "(")
          c++;
      }
      tmp = [];
      for (var l = 1; l < k; l++)
        tmp.push(arth[i + j + l].text);
      arth[i].operands.push(parseArth(tmp));
      arth.splice(i + 1, j + k);
      if (arth[i].text == "atan2(") {
        var tmp = Token("*");
        tmp.operands.push(Token(180 / Math.PI + ""));
        tmp.operands.push(arth[i]);
        arth[i] = tmp;
      }
    } else if ((arth[i].text.charAt(arth[i].text.length - 1) == "(" ||
                arth[i].text.charAt(arth[i].text.length - 1) == "[") &&
               !arth[i].operands.length && arth[i].text != "pow(" &&
               arth[i].text != "atan2(" && arth[i].text != "mod(" &&
               arth[i].text != "(") {
      var c = 1;
      var j = 0;
      while (c) {
        j++;
        if (i + j >= arth.length) {
          alerted = 1;
          alert(
              "Parser error: Expected a ')' to mark the end of the argument of a unary function.");
          return arth[0];
        }
        if (arth[i + j].text == ")" || arth[i + j].text == "]")
          c--;
        else if ((arth[i + j].text.charAt(arth[i + j].text.length - 1) == "(" ||
                  arth[i + j].text.charAt(arth[i + j].text.length - 1) ==
                      "[") &&
                 !arth[i + j].operands.length)
          c++;
      }
      var tmp = [];
      for (var k = 1; k < j; k++)
        tmp.push(arth[i + k].text);
      arth[i].operands.push(parseArth(tmp));
      arth.splice(i + 1, j);
      if (arth[i].text == "arctan(" || arth[i].text == "arcsin(" ||
          arth[i].text == "arccos(" || arth[i].text == "arcctg(") {
        var tmp = Token("*");
        tmp.operands.push(Token(180 / Math.PI + ""));
        tmp.operands.push(arth[i]);
        arth[i] = tmp;
      } else if (arth[i].text == "sin(" || arth[i].text == "cos(" ||
                 arth[i].text == "tan(" || arth[i].text == "ctg(") {
        var tmp = Token("/");
        tmp.operands.push(arth[i].operands[0]);
        tmp.operands.push(Token(180 / Math.PI + ""));
        arth[i].operands[0] = tmp;
      }
    } else if (arth[i].text == "(") {
      var c = 1;
      var j = 0;
      while (c) {
        j++;
        if (i + j >= arth.length) {
          alerted = 1;
          alert("Parser error: Mismatched parentheses.");
          return arth[0];
        }
        if (arth[i + j].text == ")")
          c--;
        else if (arth[i + j].text.charAt(arth[i + j].text.length - 1) == "(")
          c++;
      }
      var tmp = [];
      for (var k = 1; k < j; k++)
        tmp.push(arth[i + k].text);
      arth[i] = parseArth(tmp);
      arth.splice(i + 1, j);
    }
  if (alerted)
    return arth[0];
  if ((arth[0].text == "-" || arth[0].text == "+") &&
      !arth[0].operands.length) {
    if (arth.length == 1) {
      alerted = 1;
      alert("Parser error: The binary operator '" + arth[0].text +
            "' has less than two operands.");
      return arth[0];
    }
    arth[0].operands.push(Token("0"));
    arth[0].operands.push(arth[1]);
    arth.splice(1, 1);
  }
  for (var i = 0; i < arth.length; i++)
    if ((arth[i].text == "*" || arth[i].text == "/" || arth[i].text == "\\") &&
        !arth[i].operands.length) {
      if (arth.length - 1 == i || !i) {
        alerted = 1;
        alert("Parser error: The binary operator '" + arth[i].text +
              "' has less than two operands.");
        return arth[0];
      }
      arth[i].operands.push(arth[i - 1]);
      arth[i].operands.push(arth[i + 1]);
      arth.splice(i - 1, 1);
      arth.splice(i, 1);
      i--;
    }
  for (var i = 0; i < arth.length; i++)
    if ((arth[i].text == "+" || arth[i].text == "-") &&
        !arth[i].operands.length) {
      if (arth.length - 1 == i || !i) {
        alerted = 1;
        alert("Parser error: The binary operator '" + arth[i].text +
              "' has less than two operands.");
        return arth[0];
      }
      arth[i].operands.push(arth[i - 1]);
      arth[i].operands.push(arth[i + 1]);
      arth.splice(i - 1, 1);
      arth.splice(i, 1);
      i--;
    }
  for (var i = 0; i < arth.length; i++)
    if ((arth[i].text == "=" || arth[i].text == "<" || arth[i].text == ">") &&
        !arth[i].operands.length) {
      if (arth.length - 1 == i || !i) {
        alerted = 1;
        alert("Parser error: The binary operator '" + arth[i].text +
              "' has less than two operands.");
        return arth[0];
      }
      arth[i].operands.push(arth[i - 1]);
      arth[i].operands.push(arth[i + 1]);
      arth.splice(i - 1, 1);
      arth.splice(i, 1);
      i--;
    }
  for (var i = 0; i < arth.length; i++)
    if (arth[i].text == "&" && !arth[i].operands.length) {
      if (arth.length - 1 == i || !i) {
        alerted = 1;
        alert("Parser error: The binary operator '" + arth[i].text +
              "' has less than two operands.");
        return arth[0];
      }
      arth[i].operands.push(arth[i - 1]);
      arth[i].operands.push(arth[i + 1]);
      arth.splice(i - 1, 1);
      arth.splice(i, 1);
      i--;
    }
  for (var i = 0; i < arth.length; i++)
    if (arth[i].text == "|" && !arth[i].operands.length) {
      if (arth.length - 1 == i || !i) {
        alerted = 1;
        alert("Parser error: The binary operator '" + arth[i].text +
              "' has less than two operands.");
        return arth[0];
      }
      arth[i].operands.push(arth[i - 1]);
      arth[i].operands.push(arth[i + 1]);
      arth.splice(i - 1, 1);
      arth.splice(i, 1);
      i--;
    }
  for (var i = 0; i < arth.length; i++)
    if (arth[i].text == "?") {
      if (arth.length - 1 == i || !i) {
        alerted = 1;
        alert(
            "Parser error: The ternary operator '?:' has less than three operands!");
        return arth[0];
      }
      arth[i].operands.push(arth[i - 1]);
      arth[i].text = "?:";
      var j = 1;
      var c = 1;
      do {
        if (i + j >= arth.length) {
          alerted = 1;
          alert("Parser error: There is a '?' without its corresponding ':'.");
          return arth[0];
        }
        if (arth[i + j].text == "?")
          c++;
        if (arth[i + j].text == ":")
          c--;
        j++;
      } while (c);
      var drugiOperand = new Array();
      for (var k = i + 1; k < i + j - 1; k++)
        drugiOperand.push(arth[k]);
      arth[i].operands.push(parseArth(drugiOperand));
      var treciOperand = new Array();
      for (var k = i + j; k < arth.length; k++)
        treciOperand.push(arth[k]);
      arth[i].operands.push(parseArth(treciOperand));
      arth = [
        arth[i]
      ]; // Znam da ovo nije bas pametno, ali raditi ce dokle god je uvijetni
         // operator upravo operator najnizeg prioriteta u cijelom jeziku.
    }
  if (arth.length > 1) {
    alerted = 1;
    alert("Parser error: Unexpected token '" + arth[1].text + "'.");
  }
  checkAST(arth[0]);
  return arth[0];
}
function checkAST(node) {
  // Postoje li "gramaticke iluzije", izrazi koji se mogu parsirati, ali ne
  // znace nista (recimo "5**").
  if ((node.text == "*" || node.text == "-" || node.text == "/" ||
       node.text == "=" || node.text == "<" || node.text == ">" ||
       node.text == "&" || node.text == "|") &&
      node.operands.length < 2 && !alerted) {
    alerted = 1;
    alert("Parser error: Unexpected token '" + node.text + "'.");
  }
  for (var i = 0; i < node.operands.length; i++)
    checkAST(node.operands[i]);
}
var mnemonike = [
  "mov",    "fxch",    "fabs",   "fild",  "f2xm1", "fprem", "fld1",
  "fscale", "fldl2e",  "fyl2x",  "fldpi", "fstp",  "fld",   "fpatan",
  "fsqrt",  "fsincos", "fcos",   "fsin",  "fdivp", "fmulp", "fsubp",
  "faddp",  "finit",   "fcomip", "jne",   "jmp",   "fldz",  "jna",
  "jnb",    "fistp",   "and",    "or",    "xor",   "jz",    "cmp"
];
var registri = [ "eax", "st0", "st1" ];
var assembler = "";
function compile() {
  try {
    if (document.getElementById("FASM").checked)
      syntax = "fasm";
    else
      syntax = "gas";
    verboseMode = document.getElementById("verbose").checked;
    if (syntax == "gas" && typeof getIEEE754 != "function") {
      alert("Generating GAS-compatible code requires a modern JavaScript " +
            "interpreter which supports ArrayBuffer!");
      alerted = 1;
      return;
    }
    alerted = 0;
    document.getElementById("diagramSpan").style.display = "none";
    interpreter.innerHTML = "null";
    var tokenized = "[";
    var arr = tokenizeArth(document.getElementById("input").value);
    for (var i = 0; i < arr.length; i++)
      if (i < arr.length - 1)
        tokenized += "'" + arr[i] + "'" +
                     "," +
                     " ";
      else
        tokenized += "'" + arr[i] + "'" +
                     "]";
    if (!/\]$/.test(tokenized))
      tokenized += "]"; // Ako tko ukuca prazan string ili samo razmake.
    document.getElementById("tokenized").innerHTML = tokenized;
    document.getElementById("LISP").innerHTML =
        parseArth(tokenizeArth(document.getElementById("input").value))
            .toLisp();
    assembler = document.getElementById("assembly").innerHTML = "";
    if (syntax == "gas")
      asm(".intel_syntax noprefix");
    if (verboseMode) {
      var stringToComment = "Initializing FPU...";
      if (syntax == "gas")
        stringToComment = "#" + stringToComment;
      else
        stringToComment = ";" + stringToComment;
      var commentedString = "";
      for (var i = 0; i < stringToComment.length; i++)
        commentedString += '<span style="color:#777777">' +
                           stringToComment.charAt(i) + "<\/span>";
      asm(commentedString);
    }
    finit();
    parseArth(tokenizeArth(document.getElementById("input").value)).compile();
    if (verboseMode) {
      var stringToComment =
          'Moving "st0" (top of the FPU stack) into "result"...';
      if (syntax == "gas")
        stringToComment = "#" + stringToComment;
      else
        stringToComment = ";" + stringToComment;
      var commentedString = "";
      for (var i = 0; i < stringToComment.length; i++)
        commentedString += '<span style="color:#777777">' +
                           stringToComment.charAt(i) + "<\/span>";
      asm(commentedString);
    }
    fstp();
    if (syntax == "gas")
      asm(".att_syntax");
    if (highlight)
      syntaxHighlighting();
    document.getElementById("assembly").innerHTML = assembler;
  } catch (e) {
    alert(
        'Internal compiler error!\nThe message generated by your JavaScript interpreter is: "' +
        e.name + ": " + e.message + '".\n' +
        "Please e-mail me (Teo Samarzija, you can get to my e-mail address by opening the menu by clicking the icon in the top left corner of the popup or by minimizing the popup and right-clicking the icon you get at the bottom of the window) with the instructions on how to reproduce that error (for example, which arithmetic expression you entered). But don't do that if you are one of those people who are using Internet Explorer, Android Stock Browser or, even worse, Netscape, to browse the modern web. I've wasted enough of my time already to make this web-app work in those browsers. What works in other browsers immediately doesn't work in them even after hours of tweaking (because they are not open-source and, to improve them, you need to ask the companies who make them \"Mother, may I?\", to which they usually respond \"No, you are not good enough at programming. Government, protect us from this thief!\"). JavaScript is not the best programming language in the world, and the JavaScript interpreters that don't abide the new standards make it even worse.");
  }
}
function syntaxHighlighting() {
  for (var i = 0; i < mnemonike.length; i++)
    assembler = assembler.replace(eval("/\\s" + mnemonike[i] + "\\s/g"),
                                  '<span style="color:#000077">' +
                                      mnemonike[i] + "</span> ");
  assembler = assembler.replace(/\[result\]/g,
                                '<span style="color:#770000">[result]</span>');
  assembler =
      assembler.replace(/dword/g, '<span style="color:#770077">dword</span>');
  for (var i = 0; i < registri.length; i++)
    assembler = assembler.replace(eval("/" + registri[i] + "/g"),
                                  '<span style="color:#007777">' + registri[i] +
                                      "</span>");
  assembler = assembler.replace(/\,/g, '<span style="color:#333333">,</span>');
  assembler =
      assembler.replace(/:\s/g, '<span style="color:#333333">:</span> ');
  assembler = assembler.replace(
      ".intel_syntax", '<span style="color:#773300">.intel_syntax</span>');
  assembler = assembler.replace(
      ".att_syntax", '<span style="color:#773300">.att_syntax</span>');
  assembler = assembler.replace("noprefix",
                                '<span style="color:#337700">noprefix</span>');
  assembler =
      assembler.replace(/ptr/g, '<span style="color:#337700">ptr</span>');
}
function interpret() {
  try {
    alerted = 0;
    document.getElementById("diagramSpan").style.display = "none";
    varijable = new Object();
    var tokenized = "[";
    var arr = tokenizeArth(document.getElementById("input").value);
    for (var i = 0; i < arr.length; i++)
      if (i < arr.length - 1)
        tokenized += "'" + arr[i] + "'" +
                     "," +
                     " ";
      else
        tokenized += "'" + arr[i] + "'" +
                     "]";
    document.getElementById("tokenized").innerHTML = tokenized;
    document.getElementById("LISP").innerHTML =
        parseArth(tokenizeArth(document.getElementById("input").value))
            .toLisp();
    document.getElementById("assembly").innerHTML = "";
    document.getElementById("interpreter").innerHTML =
        parseArth(tokenizeArth(document.getElementById("input").value))
            .interpret();
  } catch (e) {
    alert(
        'Internal compiler error!\nThe message generated by your JavaScript interpreter is: "' +
        e.name + ": " + e.message + '".\n' +
        "Please e-mail me (Teo Samarzija, you can get to my e-mail address by opening the menu by clicking the icon in the top left corner of the popup or by minimizing the popup and right-clicking the icon you get at the bottom of the window) with the instructions on how to reproduce that error (for example, which arithmetic expression you entered). But don't do that if you are one of those people who are using Internet Explorer, Android Stock Browser or, even worse, Netscape, to browse the modern web. I've wasted enough of my time already to make this web-app work in those browsers. What works in other browsers immediately doesn't work in them even after hours of tweaking (because they are not open-source and, to improve them, you need to ask the companies who make them \"Mother, may I?\", to which they usually respond \"No, you are not good enough at programming. Government, protect us from this thief!\"). JavaScript is not the best programming language in the world, and the JavaScript interpreters that don't abide the new standards make it even worse.");
  }
}
function asm(x) {
  assembler += (typeof window != "undefined" ? "\n" : "") + x +
               (typeof window != "undefined"
                    ? "\n<br/>"
                    : "\n"); // Da, Nashorn i Rhino ne podrzavaju naredbu "br".
}
var maxX = 0, maxY = 0, minY = 0;
function showAST() {
  maxX = maxY = minX = 0;
  if (!document.createElementNS) {
    alert(
        "Diagram error: Can't access the SVG elements from JavaScript. You appear to be using a browser that doesn't support that. If you are using Internet Explorer 11, make sure it isn't running in the compatibility mode.");
    alerted = 1;
    return;
  }
  alerted = 0;
  document.getElementById("diagramSpan").style.display = "block";
  document.getElementById("assembly").innerHTML = "";
  interpreter.innerHTML = "null";
  var tokenized = "[";
  var arr = tokenizeArth(document.getElementById("input").value);
  for (var i = 0; i < arr.length; i++)
    if (i < arr.length - 1)
      tokenized += "'" + arr[i] + "'" +
                   "," +
                   " ";
    else
      tokenized += "'" + arr[i] + "'" +
                   "]";
  document.getElementById("tokenized").innerHTML = tokenized;
  var vrh = parseArth(tokenizeArth(document.getElementById("input").value));
  document.getElementById("LISP").innerHTML = vrh.toLisp();
  while (document.getElementById("diagram").childNodes.length)
    document.getElementById("diagram").removeChild(
        document.getElementById("diagram").firstChild);
  if (vrh.DFS() > 5) {
    alert(
        "Diagram error: The AST is too deep to be shown using a simple diagram. The maximal depth is set to be 5.");
    alerted = 1;
    return;
  }
  var trinarni = vrh.toLisp().indexOf("?:") != -1;
  draw(vrh, 0, 0, 200 * Math.pow(trinarni ? 3 : 2, vrh.DFS() - 2), 0, trinarni);
  /*Ova formula za razmak izmedu cvorova od istog roditelja je vjerojatno
           optimalno rjesenje za izraze gdje je AST potpuno binarno stablo ili
           blizu potpunog binarnog stabla, kao sto je npr. izraz:
           "((((5+5)+(5+5))+((5+5)+(5+5)))+(((5+5)+(5+5))+((5+5)+(5+5))))".
           Trebalo bi pronaci opcenitije rjesenje kada AST nije gust, ali da
     moze biti i dublji.*/
  document.getElementById("diagram").style.width = maxX - minX + 200;
  document.getElementById("diagram").style.height = maxY + 100;
  for (
      var i = 0; i < document.getElementById("diagram").childNodes.length;
      i++ // Ako je neki cvor lijevo izvan SVG-a (dakle, da se do njega ne moze
          // niti scrollati), pomakni ga na x=0, i sve ostale cvorove pomakni za
          // jednako toliko udesno.
  ) {
    if (document.getElementById("diagram").childNodes[i].getAttribute("x"))
      document.getElementById("diagram").childNodes[i].setAttribute(
          "x",
          document.getElementById("diagram").childNodes[i].getAttribute("x") *
                  1 -
              minX);
    if (document.getElementById("diagram").childNodes[i].getAttribute("x1"))
      document.getElementById("diagram").childNodes[i].setAttribute(
          "x1",
          document.getElementById("diagram").childNodes[i].getAttribute("x1") *
                  1 -
              minX);
    if (document.getElementById("diagram").childNodes[i].getAttribute("x2"))
      document.getElementById("diagram").childNodes[i].setAttribute(
          "x2",
          document.getElementById("diagram").childNodes[i].getAttribute("x2") *
                  1 -
              minX);
  }
  document.getElementById("diagramSpan").scrollLeft =
      document.getElementById("node0").getAttribute("x") -
      document.getElementById("diagramSpan").clientWidth / 2 +
      75; // Namijestanje korijena stabla na sredinu ekrana.
}
function draw(objekt, x, y, razmak, id, imaLiTrinarnog) {
  if (x > maxX)
    maxX = x;
  if (x < minX)
    minX = x;
  if (y > maxY)
    maxY = y;
  var svgNS = "http://www.w3.org/2000/svg";
  var pravokutnik = document.createElementNS(svgNS, "rect");
  pravokutnik.setAttribute("x", x);
  pravokutnik.setAttribute("y", y);
  pravokutnik.setAttribute("width", 150);
  pravokutnik.setAttribute("height", 50);
  pravokutnik.style.fill = "#FFAAAA";
  pravokutnik.setAttribute("id", "node" + id);
  if (objekt.DFS() == 1)
    pravokutnik.style.fill = "#AAFFAA";
  if (objekt.operands.length == 1)
    pravokutnik.style.fill = "#AAAAFF";
  document.getElementById("diagram").appendChild(pravokutnik);
  var tekst = document.createElementNS(svgNS, "text");
  tekst.appendChild(document.createTextNode(objekt.text));
  tekst.setAttribute("x", x + 75 - objekt.text.length * 4);
  tekst.setAttribute("y", y + 20);
  tekst.style.fill = "black";
  tekst.setAttribute("font-family", "monospace");
  tekst.setAttribute("font-size", 14);
  document.getElementById("diagram").appendChild(tekst);
  if (objekt.operands.length == 1 && !x) {
    draw(objekt.operands[0], x, y + 100, razmak / (imaLiTrinarnog ? 3 : 2),
         id + 1, imaLiTrinarnog);
    var crta = document.createElementNS(svgNS, "line");
    crta.setAttribute("x1", x + 75);
    crta.setAttribute("y1", y + 50);
    crta.setAttribute("x2", x + 75);
    crta.setAttribute("y2", y + 100);
    crta.setAttribute("stroke-width", 2);
    crta.setAttribute("stroke", "black");
    document.getElementById("diagram").appendChild(crta);
  } else if (objekt.operands.length == 1 && x < 0) {
    draw(objekt.operands[0],
         x + ((imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) * razmak,
         y + 100, razmak / (imaLiTrinarnog ? 3 : 2), id + 1, imaLiTrinarnog);
    var crta = document.createElementNS(svgNS, "line");
    crta.setAttribute("x1", x + 75);
    crta.setAttribute("y1", y + 50);
    crta.setAttribute(
        "x2",
        x + ((imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) * razmak +
            75);
    crta.setAttribute("y2", y + 100);
    crta.setAttribute("stroke-width", 2);
    crta.setAttribute("stroke", "black");
    document.getElementById("diagram").appendChild(crta);
  } else if (objekt.operands.length == 1 && x > 0) {
    draw(objekt.operands[0],
         x - ((imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) * razmak,
         y + 100, razmak / (imaLiTrinarnog ? 3 : 2), id + 1, imaLiTrinarnog);
    var crta = document.createElementNS(svgNS, "line");
    crta.setAttribute("x1", x + 75);
    crta.setAttribute("y1", y + 50);
    crta.setAttribute(
        "x2",
        x - ((imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) * razmak +
            75);
    crta.setAttribute("y2", y + 100);
    crta.setAttribute("stroke-width", 2);
    crta.setAttribute("stroke", "black");
    document.getElementById("diagram").appendChild(crta);
  } else if (objekt.operands.length == 2 && imaLiTrinarnog && x < 0)
    for (var i = 1; i < objekt.operands.length + 1; i++) {
      draw(objekt.operands[i - 1],
           x + (i - (imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) *
                   razmak,
           y + 100, razmak / (imaLiTrinarnog ? 3 : 2), id + 1, imaLiTrinarnog);
      var crta = document.createElementNS(svgNS, "line");
      crta.setAttribute("x1", x + 75);
      crta.setAttribute("y1", y + 50);
      crta.setAttribute(
          "x2", x +
                    (i - (imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) *
                        razmak +
                    75);
      crta.setAttribute("y2", y + 100);
      crta.setAttribute("stroke-width", 2);
      crta.setAttribute("stroke", "black");
      document.getElementById("diagram").appendChild(crta);
    }
  else if (objekt.operands.length == 2 && imaLiTrinarnog && !x)
    for (var i = 0; i < objekt.operands.length + 1; i++) {
      if (i == 1)
        continue;
      draw(objekt.operands[i == 0 ? i : 1],
           x + (i - (imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) *
                   razmak,
           y + 100, razmak / (imaLiTrinarnog ? 3 : 2), id + 1, imaLiTrinarnog);
      var crta = document.createElementNS(svgNS, "line");
      crta.setAttribute("x1", x + 75);
      crta.setAttribute("y1", y + 50);
      crta.setAttribute(
          "x2", x +
                    (i - (imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) *
                        razmak +
                    75);
      crta.setAttribute("y2", y + 100);
      crta.setAttribute("stroke-width", 2);
      crta.setAttribute("stroke", "black");
      document.getElementById("diagram").appendChild(crta);
    }
  else
    for (var i = 0; i < objekt.operands.length; i++) {
      draw(objekt.operands[i],
           x + (i - (imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) *
                   razmak,
           y + 100, razmak / (imaLiTrinarnog ? 3 : 2), id + 1, imaLiTrinarnog);
      var crta = document.createElementNS(svgNS, "line");
      crta.setAttribute("x1", x + 75);
      crta.setAttribute("y1", y + 50);
      crta.setAttribute(
          "x2", x +
                    (i - (imaLiTrinarnog ? 3 : 1) / (imaLiTrinarnog ? 3 : 2)) *
                        razmak +
                    75);
      crta.setAttribute("y2", y + 100);
      crta.setAttribute("stroke-width", 2);
      crta.setAttribute("stroke", "black");
      document.getElementById("diagram").appendChild(crta);
    }
}
var sessionID;
function downloadAJAX() {
  try {
    sessionID = Math.floor(Math.random() * 100);
    compile();
    if (alerted)
      return;
    document.getElementById("AJAXmessage").style.display = "inline";
    var vars = [];
    var arr = tokenizeArth(document.getElementById("input").value);
    for (var i = 0; i < arr.length; i++)
      if (((arr[i].charAt(0) >= "a" && arr[i].charAt(0) <= "z") ||
           (arr[i].charAt(0) >= "A" && arr[i].charAt(0) <= "Z")) &&
          arr[i].charAt(arr[i].length - 1) != "(" && !vars.includes(arr[i]))
        vars.push(arr[i]);
    vars.sort();
    var json = "[";
    for (var i = 0; i < vars.length; i++)
      json += '"' + vars[i] + '",';
    json = json.substring(0, json.length - 1) + "]";
    var kod = document.getElementById("assembly").innerText;
    if (!kod) {
      alerted = 1;
      alert(
          "Emitter error: Your browser doesn't appear to support the JavaScript 'innerText' directive. Can't send the assembly code to the server. Please use either Internet Explorer or some modern browser.");
      document.getElementById("AJAXmessage").style.display = "none";
      return;
    }
    if (/\n\n/.test(kod))
      // Dirty-fix za Operu <=14 (gdje 'innerText' '<br/>' pretvara u '\n\n'
      // umjesto u '\n').
      kod = kod.replace(/\n\n*/g, "\n");
    if (!/\n$/.test(kod))
      // Internet Explorer 11... Mislim, ima smisla to sto ti radis ovdje (ne
      // ubacivati zadnji '<br/>' u 'innerText' ako ga se ne moze misem
      // kopirati), ali to nije po standardu.
      kod += "\n";
    var xmlHTTP;
    if (window.XMLHttpRequest)
      xmlHTTP = new XMLHttpRequest();
    else
      xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
    xmlHTTP.open("POST", "setDownload.php", true);
    xmlHTTP.onreadystatechange = function() {
      if (this.readyState == 4) {
        document.getElementById("AJAXmessage").style.display = "none";
        if (this.status == 200)
          if (window.download && window.download instanceof Function)
            // Safari 6
            window.download("http://flatassembler.000webhostapp.com/download" +
                            sessionID + ".asm");
          else
            window.location.assign(
                "http://flatassembler.000webhostapp.com/download" + sessionID +
                ".asm");
        else if (this.status - 200) {
          alerted = 1;
          alert("Emitter error: Can't connect to the server.");
        }
      }
    };
    xmlHTTP.setRequestHeader("Content-type",
                             "application/x-www-form-urlencoded");
    xmlHTTP.send("varijable=" + json + "&kod=" + kod +
                 "&sessionID=" + sessionID);
    if (!window.XMLHttpRequest && navigator.onLine !== false)
      // Opet, prokleti Internet Explorer 6...
      setTimeout(function() {
        var xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
        xmlHTTP.open("HEAD", "download" + sessionID + ".asm", false);
        xmlHTTP.send(null);
        document.getElementById("AJAXmessage").style.display = "none";
        if (!alerted)
          if (xmlHTTP.status == 200)
            window.location.assign(
                "http://flatassembler.000webhostapp.com/download" + sessionID +
                ".asm");
          else
            alert("Emitter error: Can't connect to the server.");
      }, 3000); // Ako 'onreadystatechange' iz nekog razloga ne bude radio.
  } catch (
      e // Ponovno, Internet Explorer 6 (koji baca exceptione umjesto da postavi
        // "XMLHttpRequest.status").
  ) {
    alerted = 1;
    alert("Emitter error: " + e.message +
          " (this is the message generated by the browser).");
    document.getElementById("AJAXmessage").style.display = "none";
  }
}
if (typeof window != "undefined")
  window.onresize = function() // Ako se JavaScript pokrene u pregledniku, a ne,
                               // recimo, u Nashornu ili Rhinu.
  {
    var ie6 = false; // Internet Explorer 6 i drugi slicni preglednici (s CSS
                     // Box-Model-Bugom).
    if ((document.getElementById("zatvori").offsetWidth < 18 ||
         document.getElementById("zatvori").style.width == "21px") &&
        document.getElementById("zatvori").style.display != "none")
      ie6 = true;
    try {
      document.getElementById("content").style.width =
          document.body.clientWidth - 30 +
          "px"; // Ovo je zapravo tocno po standardu jer nije specificiran
                // "doctype", pa je "document.body" ovdje isto sto i "viewport"
                // (kako je bilo i u Internet Exploreru 6).
      document.getElementById("content").style.height =
          document.body.clientHeight - 49 + "px";
      document.getElementById("titleBar").style.width =
          document.body.clientWidth - 30 - 3 * 20 + "px";
      document.getElementById("smanji").style.left =
          document.body.clientWidth - 30 - 3 * 20 + 1 * 21 - ie6 * 15 + "px";
      document.getElementById("povecaj").style.left =
          document.body.clientWidth - 30 - 3 * 20 + 2 * 21 - ie6 * 15 + "px";
      document.getElementById("zatvori").style.left =
          document.body.clientWidth - 30 - 3 * 20 + 3 * 21 - ie6 * 15 + "px";
    } catch (
        e // Internet Explorer 7 i 8... imate bolju ideju sto da se radi u
          // njima?
    ) {
      window.onresize = function() {};
      alert(
          "Driver warning: You appear to be using a browser in which the JavaScript directive 'document.body.clientWidth' isn't correctly implemented." +
          "The layout will probably break if you resize the window.\n" +
          "If possible, please use a browser that correctly implements that directive, such as Internet Explorer 6, Internet Explorer 9 or Internet Explorer 11 (but not Internet Explorer 7, Internet Explorer 8 or Internet Explorer 10).\n" +
          "Or, better yet, don't use Internet Explorer. " +
          "Microsoft doesn't include Internet Explorer in Windows because it wants you to use it as a regular browser. It's there because:\n" +
          "1. When you have just installed a new operating system, you need to use it to download a proper browser from the Internet.\n" +
          "2. If some incompetent programmer tries to enable his C or C++ program to display web-pages by linking it against the DLL of Trident (the legacy web-engine used in Internet Explorer), that his program doesn't crash immediately.\n" +
          "3. If you are forced to use a computer with 512MB of RAM and 1Ghz Celeron processor running Windows 7 to do something on-line.\n" +
          "4. If some program uses the Active-X controls (a legacy technology used in Internet Explorer to simulate some features of modern JavaScript) to install itself.\n" +
          "5. Some ethernet programs that haven't been updated for decades, used in some government agencies, might work slightly better in Internet Explorer than in proper browsers if run on modern computers.\n" +
          "So, Internet Explorer has its uses, but exploring the Internet isn't one of them.");
      document.getElementById("content").style.width = "100%";
      document.getElementById("content").style.height = "100%";
      document.getElementById("titleBar").style.width = "100%";
      document.getElementById("smanji").style.right = 8 + 2 * 21 + "px";
      document.getElementById("povecaj").style.right = 8 + 1 * 21 + "px";
      document.getElementById("zatvori").style.right = 8 + 0 * 21 + "px";
    }
    if (ie6) {
      // CSS Box-Model-Bug u Internet Exploreru 6 (da suzava elemente s
      // prikazanim rubovima).
      document.getElementById("smanji").style.width = "21px";
      document.getElementById("povecaj").style.width = "21px";
      document.getElementById("zatvori").style.width = "21px";
    }
    var niz = document.getElementsByTagName("mark");
    document.getElementsByTagName("nav")[0].style.height =
        niz.length * 30 + "px";
    document.getElementsByTagName("nav")[0].style.top = "27px";
    document.getElementsByTagName("nav")[0].style.left = "13px";
    for (var i = 0; i < niz.length; i++) {
      niz[i].style.display = "block";
      niz[i].style.position = "absolute";
      niz[i].style.top = 30 * i + "px";
      niz[i].style.left = "0px";
      niz[i].style.zIndex = 101;
      niz[i].style.width = "250px";
      niz[i].style.background = "#EEEEEE";
      niz[i].style.borderStyle = "none none solid none";
      niz[i].style.borderWidth = "1px";
      niz[i].style.padding = "5px";
      niz[i].style.fontFamily = "Arial";
      niz[i].onmouseout = function() {
        this.style.background = "#EEEEEE";
        this.style.color = "black";
      };
      niz[i].onmouseenter = function() {
        this.style.background = "#0000AA";
        this.style.color = "white";
      };
      if (!window.XMLHttpRequest)
        niz[i].style.height = "30px";
    }
    document.getElementById("about").onclick = function() {
      alert(
          "This web-app was made by Teo Samarzija. It is not connected to Tomasz Grysztar, the creator of FlatAssembler, in any way.\nIt is open-source. You can see most of its source just by clicking 'View Source' in your browser. Its back-end is so simple that probably anyone who knows basic PHP could make it, so you don't need source for that (of course, the same is not true for the PHP interpreter, the Apache web server and the 000webhost hosting service that power this website).\nIts purpose is to popularize Assembly language programming, and also to impress his computer science professor, and perhaps his future employer.");
    };
    document.getElementById("download").onclick = function() {
      window.open("https://www.flatassembler.net/download.php");
    };
    document.getElementById("exit").onclick = function() { history.back(); };
    document.getElementById("mailMe").onclick = function() { sendMail("Teo"); };
    document.getElementById("mailTomasz").onclick =
        function() { sendMail("Tomasz"); };
    document.getElementById("backEndReset").onclick =
        function() { resetBackEnd(); };
    if (document.getElementById("zatvori").style.left.substring(
            0, document.getElementById("zatvori").style.left.length - 2) -
            document.getElementById("content").style.width.substring(
                0, document.getElementById("content").style.width.length - 2) >
        10)
      // Firefox, stvarno brzo izvodis JavaScript, ali to ovdje pravi probleme.
      document.getElementById("content").style.width =
          document.getElementById("zatvori").style.left.substring(
              0, document.getElementById("zatvori").style.left.length - 2) -
          3 + "px";
    var shareIt = document.getElementById("shareIt");
    shareIt.style.position = "absolute";
    shareIt.style.fontFamily = "Arial";
    shareIt.style.color = "white";
    shareIt.style.paddingLeft = shareIt.style.paddingRight = "8px";
    shareIt.style.left =
        document.body.clientWidth / 2 -
        shareIt.offsetWidth / 2; // Mislio sam da ni ovo nece raditi u Internet
                                 // Exploreru 8, no izgleda da ipak radi.
    shareIt.style.top =
        document.body.clientHeight / 2 - shareIt.offsetHeight / 2;
    shareIt.style.textAlign = "center";
    document.getElementById("smanji").onclick = function() {
      document.getElementById("content").style.display = "none";
      document.getElementById("titleBar").style.display = "none";
      document.getElementById("smanji").style.display = "none";
      document.getElementById("povecaj").style.display = "none";
      document.getElementById("zatvori").style.display = "none";
      document.getElementById("favicon").style.display = "none";
      document.getElementById("ikona").style.display = "block";
      document.getElementById("opis").style.backgroundColor = "transparent";
      document.getElementsByTagName("nav")[0].style.display = "none";
      document.getElementById("ikona").style.left =
          document.body.clientWidth / 2 -
          document.getElementById("ikona").offsetWidth / 2;
      document.getElementById("ikona").style.top = "auto";
      document.getElementById("ikona").style.bottom = "8px";
    };
    if (/(M|m)obile/.test(navigator.userAgent)) {
      /*Android Stock Browser, ne znam sto da kazem o tebi.
                                                       Dobro podrzavas SVG, onaj
         PacMan za smartphone sto sam ga napravio kao jedan od svojih prvih
         programa u JavaScriptu u tebi je odmah radio, i dugo si bio moj
         najdrazi mobilni preglednik. Ali sada vidim sto ljudi misle kada kazu
         da si ti novi Inernet Explorer 6. Zapravo, jos si gori od Internet
         Explorera 6 utoliko sto se Internet Explorer 6 barem serverima
         predstavlja kao zastarjeli preglednik, pa serveri (i napredniji
         korisnici) znaju sto da ocekuju. Ti se uz to serverima predstavljas kao
         preglednik kompatibilan sa Safarijem. E, ja imam MacAir samo godinu
         dana mladi od tebe, i ja slobodno mogu reci da se Safari na MacAiru
         tako ne ponasa. Internet Explorer 6 se relativno lako detektira
         browser-sniffingom, a vecina njegovih bugova mogu se na dobro poznati
         nacin otkriti feature-detectionom. Za tebe nijedno od tog nije slucaj.
         Ja zbog tebe moram blokirati napredne znacajke svojih web-aplikacija u
         svim mobilnim preglednicima, ti ne podrzavas ispravno neke znacajke
         JavaScripta koje cak i Internet Explorer 6 ispravno podrzava (iako je
         on iz 2001, a ti iz 2012.), a ne das da to na neki jednostavan nacin
         detektiram. Svaka ti cast sto se ne zaglavljujes svako malo kao Chrome
         i sto ne trosis bateriju kao Firefox, ali time sto se svaka druga
         stranica u tebi slama i bude necitka (i time sto te mnogi serveri danas
         naprosto odbijaju posluziti jer ne podrzavas dobro HTTPS) zadajes
         ljudima jos vise glavobolja.*/
      document.getElementById("ikona").onclick =
          function() // Mislim, imate bolju ideju sto da se radi u Android Stock
                     // Browseru?
      {
        document.getElementById("content").style.display = "block";
        document.getElementById("titleBar").style.display = "block";
        document.getElementById("smanji").style.display = "block";
        document.getElementById("povecaj").style.display = "block";
        document.getElementById("zatvori").style.display = "block";
        document.getElementById("favicon").style.display = "block";
        document.getElementById("ikona").style.display = "none";
      };
    } else {
      document.getElementById("ikona").ondblclick = function() {
        document.getElementById("content").style.display = "block";
        document.getElementById("titleBar").style.display = "block";
        document.getElementById("smanji").style.display = "block";
        document.getElementById("povecaj").style.display = "block";
        document.getElementById("zatvori").style.display = "block";
        document.getElementById("favicon").style.display = "block";
        document.getElementById("ikona").style.display = "none";
        document.getElementsByTagName("nav")[0].style.display = "none";
        document.getElementsByTagName("nav")[0].style.top = "27px";
        document.getElementsByTagName("nav")[0].style.left = "13px";
      };
      document.getElementById("ikona").onclick = function() {
        document.getElementById("opis").style.backgroundColor = "blue";
      };
      document.getElementById("ikona").onmousedown = function(event) {
        if ((event && event.button == 2) ||
            (window.event && window.event.button == 2))
          /*Internet Explorer 6 evente tretira kao globalne varijable, a ne kao
             lokalne. "2" znaci desna tipka misa.*/
          return;
        dragInit(this);
      };
      document.getElementById("ikona").oncontextmenu = function(event) {
        document.getElementsByTagName("nav")[0].style.display = "block";
        if (this.offsetTop +
                document.getElementsByTagName("nav")[0].clientHeight * 1 <
            document.body.clientHeight) {
          document.getElementsByTagName("nav")[0].style.top =
              this.offsetTop + 5 + "px";
          document.getElementsByTagName("nav")[0].style.left =
              this.offsetLeft + 5 + "px";
        } else {
          document.getElementsByTagName("nav")[0].style.top =
              this.offsetTop + 50 -
              document.getElementsByTagName("nav")[0].clientHeight * 1 + "px";
          document.getElementsByTagName("nav")[0].style.left =
              this.offsetLeft + 5 + "px";
        }
        if (event && event.stopPropagation)
          // Ponovno, prokleti Internet Explorer 6.
          event.stopPropagation();
        return false;
      };
    }
    document.getElementById("povecaj").onclick = function() {
      window.onresize = function() {};
      document.getElementById("titleBar").style.display = "none";
      document.getElementById("smanji").style.display = "none";
      document.getElementById("povecaj").style.display = "none";
      document.getElementById("zatvori").style.display = "none";
      document.getElementById("favicon").style.display = "none";
      document.getElementById("content").style.background = "#FFFFFF";
      document.getElementById("content").style.left = "0px";
      document.getElementById("content").style.top = "0px";
      document.getElementById("content").style.width = "100%";
      document.getElementById("content").style.height = "100%";
      document.getElementById("content").style.borderStyle = "none";
      document.getElementById("content").style.padding = "0px";
      document.getElementById("content").style.position = "static";
      document.getElementById("showMenu").style.display = "block";
      document.getElementById("showMenu").onclick = function() {
        if (document.getElementsByTagName("nav")[0].style.display == "none")
          // Da se menu moze zatvoriti u Android Stock Browseru.
          document.getElementsByTagName("nav")[0].style.display = "block";
        else
          document.getElementsByTagName("nav")[0].style.display = "none";
      };
      document.getElementById("shareIt").style.display =
          "none"; // Ne znam sto se zapravo dogada u Android Stock Browseru s
                  // tim natpisom (kao da na elemente koji su apsulotno
                  // pozicionirani u JavaScriptu ne utjece CSS-ov "z-index"),
                  // ali izgleda da ovo rjesava problem.
      document.body.style.background = "transparent";
      document.getElementById("content").onclick = function() {
      }; // Jer Android Stock Browser inace ne reagira na "Show Menu".
    };
  };
if (typeof window != "undefined")
  onresize();
if (typeof navigator != "undefined" && /(M|m)obile/.test(navigator.userAgent))
  // Izbornik se nece automatski zatvoriti u Android Stock Browseru.
  document.getElementById("content").onclick = function() {
    document.getElementsByTagName("nav")[0].style.display = "none";
  };
function sendMail(whom) {
  var sifrirano;
  if (whom == "Tomasz")
    sifrirano = [
      6,  2,  36, 28, 1, 42, 17, 21, 23, 50, 54, 9,  21, 17,
      19, 35, 17, 22, 8, 16, 60, 0,  6,  75, 28, 53, 17
    ];
  else if (whom == "Teo")
    sifrirano = [
      27, 0,  36, 75, 1,  49, 8, 21, 23, 8,  57, 15,
      21, 37, 21, 61, 29, 4,  9, 92, 51, 10, 25
    ];
  var tmp = sifrirano[0];
  sifrirano[0] = sifrirano[2];
  sifrirano[2] = tmp;
  tmp = sifrirano[17];
  sifrirano[17] = sifrirano[16];
  sifrirano[16] = tmp;
  var hash2;
  if (whom == "Teo")
    hash2 = 554;
  else if (whom == "Tomasz")
    hash2 = 603;
  var kljuc = prompt(
      "Spambot protection problem: What is the name of the fictional character who had a spell casted on him so that he couldn't grow up, and he had to fight against the pirates? His nickname is 'Pan'.",
      "His name without 'Pan'.");
  var desifrirano = [];
  for (var i = 0; i < sifrirano.length; i++)
    desifrirano.push(sifrirano[i] ^ kljuc.charCodeAt(i % kljuc.length));
  var hash1 = 0;
  for (var i = 0; i < desifrirano.length; i++)
    hash1 = (hash1 * 128 + desifrirano[i]) % 907;
  if (hash1 == hash2) {
    var email = "";
    for (var i = 0; i < desifrirano.length; i++)
      email += String.fromCharCode(desifrirano[i]);
    window.location.assign("mailto:" + email);
  } else
    alert("Unfortunately, you didn't give the expected answer.");
}
function resetBackEnd() {
  sessionID = Math.floor(Math.random() * 100);
  if (!window.XMLHttpRequest) {
    alerted = 1;
    alert(
        "Emitter error: Your browser doesn't appear to support the JavaScript 'XMLHttpRequest' object. Connecting to the server using the ActiveX controls is not secure.");
    return;
  }
  var password = prompt("Enter password (known by Teo Samarzija):");
  document.getElementById("AJAXmessage").style.display = "inline";
  var xmlHTTP = new XMLHttpRequest();
  xmlHTTP.password = password;
  xmlHTTP.open("POST", "oneTimeKey.php", true);
  /*Ovo bi trebalo zastiti od man-in-the-middle attacka.
       To je bolja zastita nego jednostavno POST-ati nesifriranu lozinku preko
     interneta na server, ali je manje sigurno nego HTTPS jer se ovdje (zbog
     xor-sifriranja) koristi isti kljuc i na klijentu i na serveru. Ako netko
     uspije interceptirati vezu i kada se kontaktira "oneTimeKey.php" i kada se
     salje sifrirana lozinka do "deleteDownloads.php", relativno ce lako
       desifrirati lozinku.*/
  xmlHTTP.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xmlHTTP.send("sessionId=" + sessionID);
  xmlHTTP.onreadystatechange = function() {
    if (this.readyState == 4) {
      var oneTimeKey = this.responseText * 1 - sessionID - sessionID * 256;
      var json = "[";
      var password = this.password;
      for (var i = 0; i < password.length; i++)
        json += (password.charCodeAt(i) ^
                 (i % 2 ? oneTimeKey % 256 : oneTimeKey / 256)) +
                (i < password.length - 1 ? "," : "]");
      var xmlHttp = new XMLHttpRequest();
      xmlHTTP.open("POST", "deleteDownloads.php", true);
      xmlHTTP.setRequestHeader("Content-type",
                               "application/x-www-form-urlencoded");
      xmlHTTP.send("password=" + json + "&sessionId=" + sessionID);
      xmlHTTP.onreadystatechange = function() {
        if (this.readyState == 4)
          alert('Emitter message: The server apparently responded with "' +
                this.responseText +
                (this.status - 200 ? " (Error " + this.status + ")" : "") +
                '".');
        document.getElementById("AJAXmessage").style.display = "none";
      };
    }
  };
}
var isFirefox = false; // Firefox se ovdje zapravo jedini ponasa ispravno, svi
                       // drugi preglednici koje sam isprobao zapravo pokusavaju
                       // kopirati stare verzije Internet Explorera.
var selected;
var x_pos = 0;
var y_pos = 0;
var x_elem = 0;
var y_elem = 0;
function dragInit(elem) {
  // Da se ikona koja se dobije minimiziranjem moze vuci misem (kao u
  // Windowsima 3.11).
  selected = elem;
  x_elem = x_pos - selected.offsetLeft;
  y_elem = y_pos - selected.offsetTop;
}
function moveElement(e) {
  if (!window.event) {
    isFirefox = true;
    window.event = new Object();
  }
  if (isFirefox) {
    window.event.clientX = e.clientX;
    window.event.clientY = e.clientY;
  }
  x_pos = window.event.clientX;
  y_pos = window.event.clientY;
  if (document.getElementsByTagName("nav")[0].style.display ==
          "block" && // Ako je prozor minimiziran, prikazan je menu, a mis nije
                     // na njemu, sakrij ga.
      (x_pos - document.getElementsByTagName("nav")[0].offsetLeft < 0 ||
       x_pos - document.getElementsByTagName("nav")[0].offsetLeft >
           document.getElementsByTagName("nav")[0].clientWidth ||
       y_pos - document.getElementsByTagName("nav")[0].offsetTop < -20 ||
       y_pos - document.getElementsByTagName("nav")[0].offsetTop >
           document.getElementsByTagName("nav")[0].clientHeight))
    document.getElementsByTagName("nav")[0].style.display = "none";
  if (selected) {
    // Ako je tipka misa pritisnuta, a kursor pokazuje na ikonu (koja se
    // pojavljuje kada minimiziramo "prozor").
    selected.style.left = x_pos - x_elem + "px";
    selected.style.top = y_pos - y_elem + "px";
  }
}
function destroy(e) {
  if (!window.event) {
    isFirefox = true;
    window.event = new Object();
  }
  if (isFirefox) {
    window.event.clientX = e.clientX;
    window.event.clientY = e.clientY;
  }
  if (window.event.clientX <
          document.getElementById("ikona").style.left.substring(
              0, document.getElementById("ikona").style.left.length - 2) *
              1 ||
      window.event.clientX >
          document.getElementById("ikona").style.left.substring(
              0, document.getElementById("ikona").style.left.length - 2) *
                  1 +
              document.getElementById("ikona").offsetWidth ||
      window.event.clientY <
          document.getElementById("ikona").style.top.substring(
              0, document.getElementById("ikona").style.top.length - 2) *
              1 ||
      window.event.clientY >
          document.getElementById("ikona").style.top.substring(
              0, document.getElementById("ikona").style.top.length - 2) *
                  1 +
              document.getElementById("ikona").offsetHeight)
    document.getElementById("opis").style.backgroundColor =
        "transparent"; //"Odznaci" ikonu ako korisnik klikne nesto sto njoj ne
                       // pripada.
  selected = null;
}
if (typeof window != "undefined") {
  // Ako je JavaScript pokrenut u pravom pregledniku, a ne iz komandne linije.
  document.onmousemove = moveElement;
  document.onmouseup = destroy;
}
if (typeof document != "undefined" && !document.getElementsByClassName)
  // Nadao sam se da ce ovo omoguciti da onaj JavaScript koji nudi 000webhost
  // radi u Internet Exploreru 6, ali ne omogucuje. Sada ta skripta u Internet
  // Exploreru 6 jos uvijek neispravno pozicionira logo (u gornji desni rub iza
  // prozorcica), a ne javlja niti poruku o pogresci.
  document.getElementsByClassName = function(str) {
    var niz = document.getElementsByTagName("*");
    var ret = [];
    for (var i = 0; i < niz.length; i++)
      if (eval("/(\\s|^)" + str + "(\\s|$)/").test(niz[i].className))
        ret.push(niz[i]);
    return ret;
  };
// Datoteka "control.js":
var stack = [];
var hasElse = [];
isAssembly = false;
function compileString(str) {
  str = str.replace(/^\s*/, "");
  var commentSign;
  if (/^syntax\s*gas/i.test(str)) {
    syntax = "gas";
    return;
  } else if (/^syntax\s*fasm/i.test(str)) {
    syntax = "fasm";
    return;
  } else if (/^syntax\s/i.test(str))
    throw "Driver error: Unrecognized syntax name!";
  if (syntax == "fasm")
    commentSign = ";";
  else if (syntax == "gas")
    commentSign = "#";
  else
    throw 'Driver error: Unrecognized syntax name "' + syntax + '"!';
  if (/^verboseMode\s*on/i.test(str)) {
    verboseMode = true;
    return;
  } else if (/^verboseMode\s*off/i.test(str)) {
    verboseMode = false;
    return;
  } else if (/^verboseMode\s*/i.test(str))
    throw 'Driver error: Please specify "VerboseMode" (for debugging the compiler) to be either "on" or "off"!';
  if (/^AsmEnd/.test(str)) {
    asm(commentSign + str);
    asm(commentSign + "Inline assembly ended.");
    isAssembly = false;
    return;
  }
  if (/^AsmStart/.test(str)) {
    isAssembly = true;
    asm(commentSign + str);
    asm(commentSign + "Inline assembly begins.");
    return;
  }
  if (isAssembly) {
    asm(str);
    return;
  }
  asm(commentSign + str);
  if (!str || str[0] == ";") {
    if (verboseMode)
      asm(commentSign + "The entire line is a comment, moving on...");
    return;
  }
  var isString = false;
  for (var i = 0; i < str.length; i++)
    if (str[i] == '"' || str[i] == "'")
      isString = !isString;
    else if (str[i] == ";" && !isString) {
      // Obrisi komentar, ako se slucajno nesto kao '<=' ili ':=' nalazi u
      // komentaru, da ne smeta parseru.
      str = str.substr(0, i);
      break;
    }
  if (syntax == "gas") {
    if (verboseMode)
      asm(commentSign +
          "We don't know which mode the assembler is in right now, so let's switch it to the intel_syntax mode.");
    asm(".intel_syntax noprefix");
  }
  if (verboseMode)
    asm(commentSign + "Initializing the FPU stack...");
  asm("finit");
  if (str.indexOf("<=") + 1) {
    if (verboseMode)
      asm(commentSign + "Type of the directive is: constant.");
    var constantName = str.substr(0, str.indexOf("<="));
    constantName = constantName.replace(/\s*$/, "");
    var constantValue = str.substr(str.indexOf("<=") + "<=".length);
    asm("jmp " + constantName + "$");
    if (syntax == "fasm")
      asm(constantName + " db " + constantValue);
    else {
      asm(constantName + ":");
      asm(".ascii " + constantValue);
    }
    asm(constantName + "$:");
  } else if (str.indexOf(":=") + 1) {
    if (verboseMode)
      asm(commentSign + "Type of the directive is: assignment.");
    var variableName = str.substr(0, str.indexOf(":="));
    variableName = variableName.replace(/\s*$/, "");
    var arth = str.substr(str.indexOf(":=") + ":=".length);
    if (verboseMode)
      asm(commentSign + "Calculating the rvalue...");
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode)
      asm(commentSign + 'Storing the top of the FPU stack into "edx".');
    if (syntax == "fasm")
      asm("fstp dword [rip + result]");
    else
      asm("fstp dword ptr [rip + result]");
    if (syntax == "fasm")
      asm("mov edx, dword [rip + result]");
    else
      asm("mov edx, dword ptr [rip + result]");
    if (variableName.indexOf("[") + 1 || variableName.indexOf("(") + 1) {
      var indexOfBracket =
          (variableName.indexOf("[") + 1 || variableName.indexOf("(") + 1) - 1;
      var arrayName = variableName.substr(0, indexOfBracket);
      arrayName = arrayName.replace(/\s*$/, "");
      var subscript = variableName.substr(
          indexOfBracket + 1, variableName.length - indexOfBracket - 2);
      if (verboseMode)
        asm(commentSign + "Calculating the l-value...");
      parseArth(tokenizeArth(subscript)).compile();
      if (verboseMode)
        asm(commentSign + 'Moving the pointer from "st0" to "ebx".');
      if (syntax == "fasm")
        asm("fistp dword [rip + result]");
      else
        asm("fistp dword ptr [rip + result]");
      asm("xor rbx, rbx");
      if (syntax == "fasm")
        asm("mov ebx, dword [rip + result]");
      else
        asm("mov ebx, dword ptr [rip + result]");
      if (verboseMode)
        asm(commentSign +
            'Storing the r-value (now in "edx") where "ebx" points to.');
      // console.log("DEBUG: Storing into an array, point #1");    
      asm("lea r9, dword" + (syntax == "gas" ? " ptr" : "") +" [rip + "+ arrayName +"]");
      // console.log("DEBUG: Storing into an array, point #2");
      asm("shl rbx, 2 "+commentSign+"Multiply rbx by 4, the number of bytes in Float32");
      asm("add r9, rbx");
      if (syntax == "fasm")
        asm("mov dword [r9],edx");
      else
        asm("mov dword ptr [r9],edx");
    } else {
      if (verboseMode)
        asm(commentSign +
            'Storing the r-value (now in "edx") into the variable.');
      if (syntax == "fasm")
        asm("mov dword [rip + " + variableName + "],edx");
      else
        asm("mov dword ptr [rip + " + variableName + "],edx");
    }
  } else if (/^If\s/.test(str)) {
    if (verboseMode)
      asm(commentSign + "Type of the directive is: if-statement.");
    var arth = str.substr("If ".length);
    if (verboseMode)
      asm(commentSign + "Calculating the expression...");
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode)
      asm(commentSign + "Comparing the just-calculated expression with 0...");
    if (syntax == "fasm")
      asm("fistp dword [rip + result]");
    else
      asm("fistp dword ptr [rip + result]");
    if (syntax == "fasm")
      asm("mov eax, dword [rip + result]");
    else
      asm("mov eax, dword ptr [rip + result]");
    asm("test eax,eax");
    if (verboseMode)
      asm(commentSign + "Branching based on whether the expression is 0...");
    var label1 = "ElseLabel" + Math.floor(Math.random() * 1000000);
    var label2 = "EndIfLabel" + Math.floor(Math.random() * 1000000);
    stack.push(label2);
    stack.push(label1);
    asm("jz " + label1);
    hasElse.push(false);
  } else if (/^EndIf/.test(str)) {
    if (verboseMode)
      asm(commentSign + "Type of the directive is: EndIf-statement.");
    if (hasElse.pop())
      asm(stack.pop() + ":");
    else {
      asm(stack.pop() + ":");
      asm(stack.pop() + ":");
    }
  } else if (/^ElseIf\s/.test(str)) {
    if (verboseMode)
      asm(commentSign + "Type of the directive is: ElseIf-statement.");
    var labelOfElse = stack.pop();
    var labelOfEndIf = stack.pop();
    if (verboseMode)
      asm(commentSign +
          "If the expression in the If-statement evaluates to 1...");
    asm("jmp " + labelOfEndIf);
    if (verboseMode)
      asm(commentSign + "If it evaluates to 0...");
    asm(labelOfElse + ":");
    var arth = str.substr("ElseIf ".length);
    if (verboseMode)
      asm(commentSign +
          "Evaluating the expression after the ElseIf keyword...");
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode)
      asm(commentSign + "Comparing that expression to 0...");
    if (syntax == "fasm")
      asm("fistp dword [rip + result]");
    else
      asm("fistp dword ptr [rip + result]");
    if (syntax == "fasm")
      asm("mov eax, dword [rip + result]");
    else
      asm("mov eax, dword ptr [rip + result]");
    asm("test eax,eax");
    if (verboseMode)
      asm(commentSign + "Branching based on whether it was 0...");
    var newLabelOfElse = "ElseLabel" + Math.floor(Math.random() * 1000000);
    stack.push(labelOfEndIf);
    stack.push(newLabelOfElse);
    asm("jz " + newLabelOfElse);
  } else if (/^Else/.test(str)) {
    if (verboseMode)
      asm(commentSign + "Type of the directive: Else-statement.");
    var labelOfElse = stack.pop();
    var labelOfEndIf = stack.pop();
    asm("jmp " + labelOfEndIf);
    asm(labelOfElse + ":");
    stack.push(labelOfEndIf);
    hasElse.pop();
    hasElse.push(true);
  } else if (/^While\s/.test(str)) {
    if (verboseMode)
      asm(commentSign + "Type of the directive: beginning of the while-loop");
    var arth = str.substr("While ".length);
    var label1 = "WhileLabel" + Math.floor(Math.random() * 1000000);
    stack.push(label1);
    if (verboseMode)
      asm(commentSign +
          "Marking where the evaluation of the expression begins (because it needs to be repeated once we come to the end of the loop).");
    asm(label1 + ":");
    if (verboseMode)
      asm(commentSign + 'Evaluating the expression after the "While" keyword');
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode)
      asm(commentSign + "Comparing the expression to 0...");
    var label2 = "EndWhileLabel" + Math.floor(Math.random() * 1000000);
    if (syntax == "fasm")
      asm("fistp dword [rip + result]");
    else
      asm("fistp dword ptr [rip + result]");
    if (syntax == "fasm")
      asm("mov eax, dword [rip + result]");
    else
      asm("mov eax, dword ptr [rip + result]");
    asm("test eax,eax");
    if (verboseMode)
      asm(commentSign + "Branching based on whether it is 0...");
    asm("je " + label2);
    stack.push(label2);
  } else if (/^EndWhile/.test(str)) {
    if (verboseMode)
      asm(commentSign + "Type of the directive: end of the while-loop.");
    var endWhileLabel = stack.pop();
    var whileLabel = stack.pop();
    asm("jmp " + whileLabel);
    asm(endWhileLabel + ":");
  } else {
    if (verboseMode)
      asm(commentSign +
          'Type of the statement: unrecognized, passing it unchanged to "compiler.js".');
    parseArth(tokenizeArth(str)).compile();
    if (verboseMode)
      asm(commentSign +
          'Storing the just-computed expression into "result"...');
    if (syntax == "fasm")
      asm("fstp dword [rip + result]");
    else
      asm("fstp dword ptr [rip + result]");
  }
  if (syntax == "gas") {
    if (verboseMode)
      asm(commentSign +
          "We don't know what comes next, whichever program will control the assembler next will likely expect it to be in the att_syntax mode.");
    asm(".att_syntax");
  }
}
// Sada slijedi kod specifican za NodeJS. Sada mogu koristiti najnoviji
// JavaScript bez brige o tome da ga neki internetski preglednik nece
// podrzavati.
if (typeof require == "function") {
  const fs = require("fs");
  const argv = process.argv;
  if (argv.length < 3 || !(/\.aec$/i.test(argv[2]))) {
    console.error(`Please run this program like this:
node aec.js name_of_aec_program.aec`);
    process.exitCode = 1;
  } else {
    fs.readFile(argv[2], 'utf8', (error, data) => {
      if (error) {
        console.error(`Cannot open file "${argv[2]}" for reading.
NodeJS file system module reported:
`,
                      error);
        process.exitCode = 1;
      } else {
        console.log("Successfully opened file for reading!");
        const lines = data.replace(/\r\n/g, '\n')
                          . // Neki tekstni editori (Windows Notepad) spremaju
                            // znak za novi red kao "\r\n" umjesto kao '\n'.
                      split('\n');
        let isThereAnError = false;
        for (let i = 0; i < lines.length; i++) {
          try {
            compileString(lines[i]);
          } catch (error) {
            console.error(`Line #${i + 1}: ${error}
${lines[i]}
`);
            isThereAnError = true;
          }
        }
        if (stack.length) {
          console.error(
              `The control structures, such as "While", "EndWhile", "If", "Else" and
"EndIf", appear not to be properly nested, aborting compilation!`);
          isThereAnError = true;
        }
        if (!isThereAnError) {
          let commentSign;
          if (syntax == "fasm")
            commentSign = ';';
          else
            commentSign = '#';
          assembler =
              commentSign +
              "Generated by ArithmeticExpressionCompiler ( https://flatassembler.github.io/compiler.html ) run in NodeJS.\n" +
              assembler;
          const nameOfTheProgram =
              process.argv[2].substr(0, process.argv[2].length - ".AEC".length);
          let nameOfTheAssembly = nameOfTheProgram;
          if (syntax == "fasm")
            nameOfTheAssembly += "_win64.asm";
          else
            nameOfTheAssembly += "_win64.s";
          fs.writeFile(nameOfTheAssembly, assembler, (error) => {
            if (error) {
              console.error(
                  "Cannot open output file. NodeJS FileSystem module reports:");
              console.error(error);
              process.exitCode = 1;
            } else {
              console.log(
                  `Compilation finished without errors, assembly is saved in "${
                      nameOfTheAssembly}"!
Now run the assembler! That's where you are on your own.`);
            }
          });
        }
      }
    });
  }
}
if ((typeof require != "function") && (typeof document != "object")) {
  (print || console.log)(
      "JavaScript interpreter appears to be neither a browser nor NodeJS, quitting now!");
}
