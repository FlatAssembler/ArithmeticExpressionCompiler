var stack=[];
var hasElse=[];
isAssembly=false;
function compileString(str)
{
    str=str.replace(/^\s*/,"");
    if (/^AsmEnd/.test(str))
    {
        asm(";Inline assembly ended.");
        isAssembly=false;
        return;
    }
    if (/^AsmStart/.test(str))
    {
        isAssembly=true;
        asm(";Inline assembly begins.");
        return;
    }
    if (isAssembly)
    {
        asm(str);
        return;
    }
    asm(';'+str);
    if (!str || str[0]==';') return;
    asm("finit");
    if (str.indexOf("<=")+1) {
        var constantName=str.substr(0,str.indexOf("<="));
        constantName=constantName.replace(/\s*$/,"");
        var constantValue=str.substr(str.indexOf("<=")+"<=".length);
        asm("jmp "+constantName+"$");
        asm(constantName+" db "+constantValue);
        asm(constantName+"$:");
    }
    else if (str.indexOf(":=")+1)
    {
        var variableName=str.substr(0,str.indexOf(":="));
        variableName=variableName.replace(/\s*$/,"");
        var arth=str.substr(str.indexOf(":=")+":=".length);
        parseArth(tokenizeArth(arth)).compile();
        asm("fstp dword [result]");
        asm("mov edx, dword [result]");
        if (variableName.indexOf("[")+1 || variableName.indexOf("(")+1)
        {
            var indexOfBracket=(variableName.indexOf("[")+1 || variableName.indexOf("(")+1)-1;
            var arrayName=variableName.substr(0,indexOfBracket);
            var subscript=variableName.substr(indexOfBracket+1,variableName.length-indexOfBracket-2);
            parseArth(tokenizeArth(subscript)).compile();
            asm("fistp dword [result]");
            asm("mov ebx,[result]");
            asm("mov dword ["+arrayName+"+4*ebx],edx");
        }
        else
            asm("mov dword ["+variableName+"],edx");
    }
    else if (/^If\s/.test(str))
    {
        var arth=str.substr("If ".length);
        parseArth(tokenizeArth(arth)).compile();
        asm("fistp dword [result]");
        asm("mov eax,[result]");
        asm("test eax,eax");
        var label1="l"+(Math.floor(Math.random()*1000000));
        var label2="l"+(Math.floor(Math.random()*1000000));
        stack.push(label2);
        stack.push(label1);
        asm("jz "+label1);
        hasElse.push(false);
    }
    else if (/^EndIf/.test(str))
        if (hasElse.pop())
            asm(stack.pop()+":");
        else
        {
            asm(stack.pop()+":");
            asm(stack.pop()+":");
        }
    else if (/^ElseIf\s/.test(str)) {
        var labelOfElse=stack.pop();
        var labelOfEndIf=stack.pop();
        asm("jmp "+labelOfEndIf);
        asm(labelOfElse+":");
        var arth=str.substr("ElseIf ".length);
        parseArth(tokenizeArth(arth)).compile();
        asm("fistp dword [result]");
        asm("mov eax,[result]");
        asm("test eax,eax");
        var newLabelOfElse="l"+(Math.floor(Math.random()*1000000));
        stack.push(labelOfEndIf);
        stack.push(newLabelOfElse);
        asm("jz "+newLabelOfElse);
    }
    else if (/^Else/.test(str))
    {
        var labelOfElse=stack.pop();
        var labelOfEndIf=stack.pop();
        asm("jmp "+labelOfEndIf);
        asm(labelOfElse+':');
        stack.push(labelOfEndIf);
        hasElse.pop();
        hasElse.push(true);
    }
    else if (/^While\s/.test(str))
    {
        var arth=str.substr("While ".length);
        var label1="l"+(Math.floor(Math.random()*1000000));
        stack.push(label1);
        asm(label1+":");
        parseArth(tokenizeArth(arth)).compile();
        var label2="l"+(Math.floor(Math.random()*1000000));
        asm("fistp dword [result]");
        asm("mov eax,[result]");
        asm("test eax,eax");
        asm("je "+label2);
        stack.push(label2);
    }
    else if (/^EndWhile/.test(str))
    {
        var endWhileLabel=stack.pop();
        var whileLabel=stack.pop();
        asm("jmp "+whileLabel);
        asm(endWhileLabel+':');
    }
    else
    {
        parseArth(tokenizeArth(str)).compile();
        asm("fstp dword [result]");
    }
}
