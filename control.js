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
  if (syntax == "fasm") commentSign = ";";
  else if (syntax == "gas") commentSign = "#";
  else throw 'Driver error: Unrecognized syntax name "' + syntax + '"!';
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
  if (!str || str[0] == ";") return;
  var isString = false;
  for (var i = 0; i < str.length; i++)
    if (str[i] == '"' || str[i] == "'") isString = !isString;
    else if (str[i] == ";") {
      //Obrisi komentar, ako se slucajno nesto kao '<=' ili ':=' nalazi u komentaru, da ne smeta parseru.
      str = str.substr(0, i - 1);
      break;
    }
  if (syntax == "gas") asm(".intel_syntax noprefix");
  asm("finit");
  if (str.indexOf("<=") + 1) {
    var constantName = str.substr(0, str.indexOf("<="));
    constantName = constantName.replace(/\s*$/, "");
    var constantValue = str.substr(str.indexOf("<=") + "<=".length);
    asm("jmp " + constantName + "$");
    if (syntax == "fasm") asm(constantName + " db " + constantValue);
    else {
      asm(constantName + ":");
      asm(".ascii " + constantValue);
    }
    asm(constantName + "$:");
  } else if (str.indexOf(":=") + 1) {
    var variableName = str.substr(0, str.indexOf(":="));
    variableName = variableName.replace(/\s*$/, "");
    var arth = str.substr(str.indexOf(":=") + ":=".length);
    parseArth(tokenizeArth(arth)).compile();
    if (syntax == "fasm") asm("fstp dword [result]");
    else asm("fstp dword ptr [result]");
    if (syntax == "fasm") asm("mov edx, dword [result]");
    else asm("mov edx, dword ptr [result]");
    if (variableName.indexOf("[") + 1 || variableName.indexOf("(") + 1) {
      var indexOfBracket =
        (variableName.indexOf("[") + 1 || variableName.indexOf("(") + 1) - 1;
      var arrayName = variableName.substr(0, indexOfBracket);
      arrayName = arrayName.replace(/\s*$/, "");
      var subscript = variableName.substr(
        indexOfBracket + 1,
        variableName.length - indexOfBracket - 2
      );
      parseArth(tokenizeArth(subscript)).compile();
      if (syntax == "fasm") asm("fistp dword [result]");
      else asm("fistp dword ptr [result]");
      if (syntax == "fasm") asm("mov ebx, dword [result]");
      else asm("mov ebx, dword ptr [result]");
      if (syntax == "fasm") asm("mov dword [" + arrayName + "+4*ebx],edx");
      else asm("mov dword ptr [" + arrayName + "+4*ebx],edx");
    } else {
      if (syntax == "fasm") asm("mov dword [" + variableName + "],edx");
      else asm("mov dword ptr [" + variableName + "],edx");
    }
  } else if (/^If\s/.test(str)) {
    var arth = str.substr("If ".length);
    parseArth(tokenizeArth(arth)).compile();
    if (syntax == "fasm") asm("fistp dword [result]");
    else asm("fistp dword ptr [result]");
    if (syntax == "fasm") asm("mov eax, dword [result]");
    else asm("mov eax, dword ptr [result]");
    asm("test eax,eax");
    var label1 = "ElseLabel" + Math.floor(Math.random() * 1000000);
    var label2 = "EndIfLabel" + Math.floor(Math.random() * 1000000);
    stack.push(label2);
    stack.push(label1);
    asm("jz " + label1);
    hasElse.push(false);
  } else if (/^EndIf/.test(str))
    if (hasElse.pop()) asm(stack.pop() + ":");
    else {
      asm(stack.pop() + ":");
      asm(stack.pop() + ":");
    }
  else if (/^ElseIf\s/.test(str)) {
    var labelOfElse = stack.pop();
    var labelOfEndIf = stack.pop();
    asm("jmp " + labelOfEndIf);
    asm(labelOfElse + ":");
    var arth = str.substr("ElseIf ".length);
    parseArth(tokenizeArth(arth)).compile();
    if (syntax == "fasm") asm("fistp dword [result]");
    else asm("fistp dword ptr [result]");
    if (syntax == "fasm") asm("mov eax, dword [result]");
    else asm("mov eax, dword ptr [result]");
    asm("test eax,eax");
    var newLabelOfElse = "ElseLabel" + Math.floor(Math.random() * 1000000);
    stack.push(labelOfEndIf);
    stack.push(newLabelOfElse);
    asm("jz " + newLabelOfElse);
  } else if (/^Else/.test(str)) {
    var labelOfElse = stack.pop();
    var labelOfEndIf = stack.pop();
    asm("jmp " + labelOfEndIf);
    asm(labelOfElse + ":");
    stack.push(labelOfEndIf);
    hasElse.pop();
    hasElse.push(true);
  } else if (/^While\s/.test(str)) {
    var arth = str.substr("While ".length);
    var label1 = "WhileLabel" + Math.floor(Math.random() * 1000000);
    stack.push(label1);
    asm(label1 + ":");
    parseArth(tokenizeArth(arth)).compile();
    var label2 = "EndWhileLabel" + Math.floor(Math.random() * 1000000);
    if (syntax == "fasm") asm("fistp dword [result]");
    else asm("fistp dword ptr [result]");
    if (syntax == "fasm") asm("mov eax, dword [result]");
    else asm("mov eax, dword ptr [result]");
    asm("test eax,eax");
    asm("je " + label2);
    stack.push(label2);
  } else if (/^EndWhile/.test(str)) {
    var endWhileLabel = stack.pop();
    var whileLabel = stack.pop();
    asm("jmp " + whileLabel);
    asm(endWhileLabel + ":");
  } else {
    parseArth(tokenizeArth(str)).compile();
    if (syntax == "fasm") asm("fstp dword [result]");
    else asm("fstp dword ptr [result]");
  }
  if (syntax == "gas") asm(".att_syntax");
}
