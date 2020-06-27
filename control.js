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
    if (str[i] == '"' || str[i] == "'") isString = !isString;
    else if (str[i] == ";" && !isString) {
      //Obrisi komentar, ako se slucajno nesto kao '<=' ili ':=' nalazi u komentaru, da ne smeta parseru.
      str = str.substr(0, i);
      break;
    }
  if (syntax == "gas") {
    if (verboseMode)
      asm(
        commentSign +
          "We don't know which mode the assembler is in right now, so let's switch it to the intel_syntax mode."
      );
    asm(".intel_syntax noprefix");
  }
  if (verboseMode) asm(commentSign + "Initializing the FPU stack...");
  asm("finit");
  if (str.indexOf("<=") + 1) {
    if (verboseMode) asm(commentSign + "Type of the directive is: constant.");
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
    if (verboseMode) asm(commentSign + "Type of the directive is: assignment.");
    var variableName = str.substr(0, str.indexOf(":="));
    variableName = variableName.replace(/\s*$/, "");
    var arth = str.substr(str.indexOf(":=") + ":=".length);
    if (verboseMode) asm(commentSign + "Calculating the rvalue...");
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode)
      asm(commentSign + 'Storing the top of the FPU stack into "edx".');
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
      if (verboseMode) asm(commentSign + "Calculating the l-value...");
      parseArth(tokenizeArth(subscript)).compile();
      if (verboseMode)
        asm(commentSign + 'Moving the pointer from "st0" to "ebx".');
      if (syntax == "fasm") asm("fistp dword [result]");
      else asm("fistp dword ptr [result]");
      if (syntax == "fasm") asm("mov ebx, dword [result]");
      else asm("mov ebx, dword ptr [result]");
      if (verboseMode)
        asm(
          commentSign +
            'Storing the r-value (now in "edx") where "ebx" points to.'
        );
      if (syntax == "fasm") asm("mov dword [" + arrayName + "+4*ebx],edx");
      else asm("mov dword ptr [" + arrayName + "+4*ebx],edx");
    } else {
      if (verboseMode)
        asm(
          commentSign + 'Storing the r-value (now in "edx") into the variable.'
        );
      if (syntax == "fasm") asm("mov dword [" + variableName + "],edx");
      else asm("mov dword ptr [" + variableName + "],edx");
    }
  } else if (/^If\s/.test(str)) {
    if (verboseMode)
      asm(commentSign + "Type of the directive is: if-statement.");
    var arth = str.substr("If ".length);
    if (verboseMode) asm(commentSign + "Calculating the expression...");
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode)
      asm(commentSign + "Comparing the just-calculated expression with 0...");
    if (syntax == "fasm") asm("fistp dword [result]");
    else asm("fistp dword ptr [result]");
    if (syntax == "fasm") asm("mov eax, dword [result]");
    else asm("mov eax, dword ptr [result]");
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
    if (hasElse.pop()) asm(stack.pop() + ":");
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
      asm(
        commentSign + "If the expression in the If-statement evaluates to 1..."
      );
    asm("jmp " + labelOfEndIf);
    if (verboseMode) asm(commentSign + "If it evaluates to 0...");
    asm(labelOfElse + ":");
    var arth = str.substr("ElseIf ".length);
    if (verboseMode)
      asm(
        commentSign + "Evaluating the expression after the ElseIf keyword..."
      );
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode) asm(commentSign + "Comparing that expression to 0...");
    if (syntax == "fasm") asm("fistp dword [result]");
    else asm("fistp dword ptr [result]");
    if (syntax == "fasm") asm("mov eax, dword [result]");
    else asm("mov eax, dword ptr [result]");
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
      asm(
        commentSign +
          "Marking where the evaluation of the expression begins (because it needs to be repeated once we come to the end of the loop)."
      );
    asm(label1 + ":");
    if (verboseMode)
      asm(commentSign + 'Evaluating the expression after the "While" keyword');
    parseArth(tokenizeArth(arth)).compile();
    if (verboseMode) asm(commentSign + "Comparing the expression to 0...");
    var label2 = "EndWhileLabel" + Math.floor(Math.random() * 1000000);
    if (syntax == "fasm") asm("fistp dword [result]");
    else asm("fistp dword ptr [result]");
    if (syntax == "fasm") asm("mov eax, dword [result]");
    else asm("mov eax, dword ptr [result]");
    asm("test eax,eax");
    if (verboseMode) asm(commentSign + "Branching based on whether it is 0...");
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
      asm(
        commentSign +
          'Type of the statement: unrecognized, passing it unchanged to "compiler.js".'
      );
    parseArth(tokenizeArth(str)).compile();
    if (verboseMode)
      asm(
        commentSign + 'Storing the just-computed expression into "result"...'
      );
    if (syntax == "fasm") asm("fstp dword [result]");
    else asm("fstp dword ptr [result]");
  }
  if (syntax == "gas") {
    if (verboseMode)
      asm(
        commentSign +
          "We don't know what comes next, whichever program will control the assembler next will likely expect it to be in the att_syntax mode."
      );
    asm(".att_syntax");
  }
}
