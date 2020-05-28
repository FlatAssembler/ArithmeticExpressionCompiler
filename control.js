var stack = [];
var hasElse = [];
isAssembly = false;
function compileString(str) {
  str = str.replace(/^\s*/, "");
  if (/^AsmEnd/.test(str)) {
    asm(";" + str);
    asm(";Inline assembly ended.");
    isAssembly = false;
    return;
  }
  if (/^AsmStart/.test(str)) {
    isAssembly = true;
    asm(";" + str);
    asm(";Inline assembly begins.");
    return;
  }
  if (isAssembly) {
    asm(str);
    return;
  }
  asm(";" + str);
  if (!str || str[0] == ";") return;
  var isString = false;
  for (var i = 0; i < str.length; i++)
    if (str[i] == '"' || str[i] == "'") isString = !isString;
    else if (str[i] == ";") {
      //Obrisi komentar, ako se slucajno nesto kao '<=' ili ':=' nalazi u komentaru, da ne smeta parseru.
      str = str.substr(0, i - 1);
      break;
    }
  asm("finit");
  if (str.indexOf("<=") + 1) {
    var constantName = str.substr(0, str.indexOf("<="));
    constantName = constantName.replace(/\s*$/g, "");
    var constantValue = str.substr(str.indexOf("<=") + "<=".length);
    asm("jmp " + constantName + "$");
    asm(constantName + " db " + constantValue);
    asm(constantName + "$:");
  } else if (str.indexOf(":=") + 1) {
    var variableName = str.substr(0, str.indexOf(":="));
    variableName = variableName.replace(/\s*$/g, "");
    var arth = str.substr(str.indexOf(":=") + ":=".length);
    parseArth(tokenizeArth(arth)).compile();
    asm("fstp dword [result]");
    asm("mov edx, dword [result]");
    if (variableName.indexOf("[") + 1 || variableName.indexOf("(") + 1) {
      var indexOfBracket =
        (variableName.indexOf("[") + 1 || variableName.indexOf("(") + 1) - 1;
      var arrayName = variableName.substr(0, indexOfBracket);
      arrayName.replace(/\s*$/g, "");
      var subscript = variableName.substr(
        indexOfBracket + 1,
        variableName.length - indexOfBracket - 2
      );
      parseArth(tokenizeArth(subscript)).compile();
      asm("fistp dword [result]");
      asm("mov ebx, dword [result]");
      asm("mov dword [" + arrayName + "+4*ebx],edx");
    } else asm("mov dword [" + variableName + "],edx");
  } else if (/^If\s/.test(str)) {
    var arth = str.substr("If ".length);
    parseArth(tokenizeArth(arth)).compile();
    asm("fistp dword [result]");
    asm("mov eax, dword [result]");
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
    asm("fistp dword [result]");
    asm("mov eax, dword [result]");
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
    asm("fistp dword [result]");
    asm("mov eax, dword [result]");
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
    asm("fstp dword [result]");
  }
}
