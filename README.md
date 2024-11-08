This is an app that tries to reverse engineer macOS' [menu localization](https://developer.apple.com/documentation/swiftui/view/keyboardshortcut(_:modifiers:localization:)#Localization), so that [Zed](https://zed.dev) can copy its behaviour.

To use this app run it in XCode.

On boot it will list out a set of keyboard layouts that appear to need mapping (i.e. they can't type the full ASCII range when command is held down).

If you change your keyboard layout to something that is not QWERTY, you can open the menu to see how characters are mapped between the two layouts.

If you hit any key, then the app will cycle through each layout it printed, and output some JSON that describes how to remap keys from QWERTY to the layout. WARNING. This will actually change the keyboard layout of the system, be careful!

There's also a button you can clik, it doesn't do anything.

### Limitations

* If you want `cmd-shift-q` and `cmd-?` to show up, you need to go to System Preferences -> Keyboard -> Shortcuts -> App Shortcuts and disable the help shortcut. Youalso need to replace the default log-out shortcut with something else. For example. I add one with the title "Log Out Conrad Irwin..." mapped to cmd-f6, and one with "Log Out Conrad irwin" mapped to cmd-shift-f6.
* Some layouts (like Tamil99) claim to not be enable-able.
* Some layouts (like UmeSami) don't seem to have a way to type some shortcuts (like `cmd-w`).
* Some layouts (like Tongan) don't seem to be localized by the macOS menu.
* I don't know how to automate the whole process; so you need to hit a key over and over again to make it work. Without user interaction the menu doesn't seem to update its localization.

Output as of 2024-11-08:
```json
{"com.apple.keylayout.ABC-AZERTY":{">":"\/","[":"^","$":"4","6":"§","1":"&","%":"5","@":"2","7":"è","|":"£",")":"0","&":"7","8":"!","\"":"%",":":"°","}":"*","5":"(","9":"ç","3":"\"","(":"9",".":";","4":"'","^":"6","<":".","!":"1","{":"¨","`":"<","2":"é","]":"$","\\":"`","#":"3",";":")","~":">","*":"8","\/":":","'":"ù","0":"à"}}
{"com.apple.keylayout.ABC-QWERTZ":{"\"":"`","}":"Ä","~":">","<":";","`":"<",">":":","'":"´","&":"\/","#":"§",":":"Ü","{":"Ö","@":"\"","*":"(","^":"&","|":"'","\\":"#",")":"=","=":"*","(":")","]":"ä","\/":"ß",";":"ü","[":"ö"}}
{"com.apple.keylayout.Albanian":{"\\":"ë","'":"@","~":">",";":"ç",":":"Ç","|":"Ë","<":";",">":":","`":"<","\"":"'","@":"\""}}
{"com.apple.keylayout.Austrian":{"\/":"ß","^":"&","*":"(","`":"<","'":"´","{":"Ö","|":"'",")":"=",">":":","&":"\/","<":";","[":"ö","\\":"#",";":"ü","(":")","~":">","\"":"`","}":"Ä","@":"\"","]":"ä",":":"Ü","=":"*","#":"§"}}
{"com.apple.keylayout.Azeri":{":":"I","{":"Ö","W":"Ü","?":",",".":"ş","\/":".","\"":"Ə","[":"ö","}":"Ğ","<":"Ç","]":"ğ","|":"\/",",":"ç",">":"Ş","'":"ə",";":"ı","w":"ü"}}
{"com.apple.keylayout.Belgian":{"`":"<","3":"\"","\/":":","*":"8","<":".","\\":"`","8":"!",">":"\/","7":"è","#":"3","&":"7","9":"ç","6":"§","@":"2",")":"0",";":")","0":"à","2":"é","4":"'","(":"9","|":"£","'":"ù","1":"&","\"":"%",":":"°","$":"4","[":"^","~":">","5":"(",".":";","%":"5","^":"6","}":"*","]":"$","{":"¨","!":"1"}}
{"com.apple.keylayout.Brazilian-ABNT2":{"\"":"`","|":"^","~":"\"","?":"Ç","`":"'","'":"´","\/":"ç","^":"¨","\\":"~"}}
{"com.apple.keylayout.Brazilian-Pro":{"^":"ˆ","~":"˜"}}
{"com.apple.keylayout.British":{"#":"£"}}
{"com.apple.keylayout.Canadian-CSA":{"\\":"à","?":"É","'":"è","]":"ç","\/":"é",">":"\"","<":"'","[":"^","{":"¨","}":"Ç","|":"À","~":"Ù","`":"ù","\"":"È"}}
{"com.apple.keylayout.Croatian":{"{":"Š","@":"\"",";":"č","<":";","~":">","=":"*",">":":","(":")","&":"'","*":"(","[":"š","'":"ć","|":"Ž","]":"đ","\"":"Ć",":":"Č","}":"Đ","^":"&",")":"=","\\":"ž","`":"<"}}
{"com.apple.keylayout.Croatian-PC":{"{":"Š","@":"\"","~":">",";":"č","<":";","=":"*",">":":","(":")","&":"\/","*":"(","[":"š","'":"ć","|":"Ž","]":"đ","\"":"Ć",":":"Č","\/":"'","}":"Đ","^":"&","`":"<",")":"=","\\":"ž"}}
{"com.apple.keylayout.Czech":{"(":"9","7":"ý","*":"8","#":"3","1":"+","9":"í","3":"š","6":"ž","2":"ě","0":"é","?":"ˇ","\/":"'","{":"Ú",")":"0","@":"2","~":"`","!":"1","$":"4","8":"á","+":"%",";":"ů",":":"\"","%":"5","4":"č","\"":"!",">":":","`":"¨","^":"6","]":")","&":"7","5":"ř","}":"(","[":"ú","<":"?","'":"§"}}
{"com.apple.keylayout.Czech-QWERTY":{"9":"í",">":":","0":"é","[":"ú","2":"ě","(":"9",")":"0","\"":"!","}":"(","@":"2","]":")","4":"č","6":"ž","%":"5","5":"ř",";":"ů","#":"3","8":"á","{":"Ú","*":"8","7":"ý","^":"6","~":"`","+":"%","!":"1","3":"š","?":"ˇ","&":"7","'":"§","<":"?","$":"4","\/":"'","1":"+","`":"¨",":":"\""}}
{"com.apple.keylayout.Danish":{"=":"`","[":"æ",";":"å","'":"¨","`":"<","{":"Æ","}":"Ø","|":"*",">":":","]":"ø","*":"(","^":"&","(":")","&":"\/","@":"\"","~":">",")":"=","<":";","\\":"'","\/":"´","$":"€","\"":"^",":":"Å"}}
{"com.apple.keylayout.Faroese":{"}":"Ð","\"":"Ø",";":"æ","\/":"´","$":"€",">":":","^":"&","@":"\"","~":">","`":"<",":":"Æ","&":"\/","[":"å","*":"(",")":"=","{":"Å","|":"*","]":"ð","=":"`","(":")","\\":"'","<":";","'":"ø"}}
{"com.apple.keylayout.Finnish":{"\/":"´","^":"&","*":"(","`":"<",")":"=","'":"¨","{":"Ö","|":"*","$":"€",">":":","&":"\/","<":";","[":"ö","\\":"'","~":">",";":"å","(":")","\"":"^","}":"Ä","@":"\"","]":"ä",":":"Å","=":"`"}}
{"com.apple.keylayout.FinnishExtended":{"]":"ä",";":"å","{":"Ö","`":"<",":":"Å","'":"¨","*":"(","<":";","~":">","=":"`","\/":"´","}":"Ä","\\":"'","|":"*","&":"\/","[":"ö","\"":"ˆ","(":")","$":"€","^":"&",")":"=",">":":","@":"\""}}
{"com.apple.keylayout.FinnishSami-PC":{")":"=","=":"`","*":"(","\"":"ˆ","\\":"@","[":"ö","@":"\"","{":"Ö",":":"Å",">":":","'":"¨",";":"å","\/":"´","<":";","|":"*","~":">","(":")","]":"ä","}":"Ä","^":"&","`":"<","&":"\/"}}
{"com.apple.keylayout.French":{"*":"8","}":"*","7":"è",";":")","8":"!",":":"°","!":"1","5":"(","%":"5","(":"9","1":"&","&":"7","4":"'","]":"$","\\":"`","^":"6","6":"§",")":"0","3":"\"","2":"é",">":"\/",".":";","<":".","\/":":","0":"à","|":"£","$":"4","{":"¨","'":"ù","[":"^","`":"<","\"":"%","~":">","9":"ç","#":"3","@":"2"}}
{"com.apple.keylayout.French-PC":{"!":"1","&":"7","\"":"%","_":"°","$":"4","}":"£","\/":":","7":"è","2":"é",">":"\/","8":"_","]":"$","#":"3",":":"§","3":"\"","1":"&",")":"0","*":"8","<":".","%":"5","4":"'",";":"!","6":"-","\\":"*","-":")","{":"¨","[":"^","'":"ù","@":"2","(":"9","0":"à","|":"μ","5":"(",".":";","`":"<","9":"ç","~":">","^":"6"}}
{"com.apple.keylayout.French-numerical":{"|":"£","!":"1","5":"(","2":"é",";":")","]":"$","[":"^",">":"\/","&":"7","@":"2","\"":"%","%":"5","'":"ù","{":"¨",")":"0","<":".","~":">","7":"è",".":";","1":"&","\/":":","^":"6","(":"9","}":"*","*":"8","8":"!","#":"3","0":"à","$":"4","9":"ç","`":"<","6":"§","\\":"`","3":"\"",":":"°","4":"'"}}
{"com.apple.keylayout.German":{"=":"*","`":"<","#":"§","'":"´","}":"Ä",":":"Ü",")":"=","\/":"ß","\"":"`","^":"&","&":"\/","]":"ä","*":"(","{":"Ö",";":"ü","|":"'","[":"ö","<":";","(":")",">":":","~":">","@":"\"","\\":"#"}}
{"com.apple.keylayout.German-DIN-2137":{"}":"Ä","~":">","\/":"ß","<":";","^":"&",">":":","{":"Ö","`":"<",":":"Ü","\\":"#",")":"=","&":"\/","=":"*","[":"ö","]":"ä","@":"\"","|":"'",";":"ü","#":"§","'":"´","\"":"`","(":")","*":"("}}
{"com.apple.keylayout.Hawaiian":{"'":"ʻ"}}
{"com.apple.keylayout.Hungarian":{"}":"Ú","(":")","*":"(","@":"\"","\"":"Á","{":"Ő","=":"ó","\/":"ü","|":"Ű",";":"é",">":":","'":"á","[":"ő","`":"í","<":"Ü","~":"Í","\\":"ű","!":"'","$":"!","&":"=","0":"ö","#":"+",":":"É","]":"ú","^":"\/",")":"Ö","+":"Ó"}}
{"com.apple.keylayout.Hungarian-QWERTY":{"=":"ó","]":"ú","#":"+",">":":","@":"\"","\/":"ü","&":"=","<":"Ü","`":"í","0":"ö","'":"á",")":"Ö","~":"Í","(":")","\\":"ű","!":"'",":":"É","*":"(",";":"é","$":"!","\"":"Á","+":"Ó","^":"\/","{":"Ő","|":"Ű","}":"Ú","[":"ő"}}
{"com.apple.keylayout.Icelandic":{"[":"æ","}":"´","=":"*",":":"Ð","\/":"'","'":"ö",")":"=","{":"Æ","(":")","*":"(","&":"\/",";":"ð","^":"&","|":"Þ","`":"<","\"":"Ö","\\":"þ",">":":","]":"´","<":";","~":">","@":"\""}}
{"com.apple.keylayout.Irish":{"#":"£"}}
{"com.apple.keylayout.IrishExtended":{"#":"£"}}
{"com.apple.keylayout.Italian":{"*":"8","7":")","}":"*",";":"ò","8":"£",":":"!","!":"1","5":"ç","%":"5","(":"9","1":"&","&":"7","4":"(","]":"$","^":"6","\\":"§","6":"è",")":"0","3":"'","2":"\"",">":"\/",".":":","<":".","\/":",","0":"é","|":"°","$":"4",",":";","'":"ù","{":"^","[":"ì","`":"<","\"":"%","~":">","9":"à","#":"3","@":"2"}}
{"com.apple.keylayout.Italian-Pro":{"\/":"'",":":"é","@":"\"","[":"ò","]":"à","'":"ì","\\":"ù","=":"*",")":"=","{":"ç",";":"è","|":"§","#":"£","<":";","\"":"^","(":")","*":"(","^":"&","&":"\/","`":"<","}":"°",">":":","~":">"}}
{"com.apple.keylayout.LatinAmerican":{"[":"{","^":"&","~":">",">":":","`":"<","(":")","<":";","\\":"¿","@":"\"","{":"[",";":"ñ","*":"(","&":"\/","\/":"'",")":"=",":":"Ñ","]":"}","|":"¡","=":"*","'":"´","}":"]","\"":"¨"}}
{"com.apple.keylayout.Lithuanian":{"+":"Ž","#":"Ę","&":"Ų","=":"ž","!":"Ą","%":"Į","1":"ą","*":"Ū","@":"Č","7":"ų","3":"ę","^":"Š","5":"į","8":"ū","4":"ė","$":"Ė","2":"č","6":"š"}}
{"com.apple.keylayout.Maltese":{"[":"ġ","`":"ż","}":"Ħ","{":"Ġ","#":"£","]":"ħ","~":"Ż"}}
{"com.apple.keylayout.NorthernSami":{":":"Å","\/":"´","[":"ø","<":";","{":"Ø","X":"Č","\"":"Ŋ","w":"š","Q":"Á","x":"č","\\":"đ","(":")",";":"å","~":"Ž",">":":","W":"Š","}":"Æ","`":"ž","*":"(","@":"\"","]":"æ",")":"=","'":"ŋ","^":"&","|":"Đ","=":"`","q":"á","&":"\/"}}
{"com.apple.keylayout.Norwegian":{"`":"<","'":"¨","~":">","\"":"^","\\":"@","*":"(","|":"*","=":"`","\/":"´","@":"\"",")":"=","[":"ø",":":"Å","}":"Æ","&":"\/",">":":","<":";","]":"æ","{":"Ø","(":")","^":"&",";":"å"}}
{"com.apple.keylayout.NorwegianExtended":{"^":"ˆ","~":"˜"}}
{"com.apple.keylayout.NorwegianSami-PC":{"\"":"ˆ","}":"Æ","~":">","<":";","`":"<","&":"\/",">":":","'":"¨",":":"Å","{":"Ø","@":"\"","*":"(","^":"&","|":"*","\\":"@",")":"=","=":"`","(":")","[":"ø","]":"æ","\/":"´",";":"å"}}
{"com.apple.keylayout.Polish":{"&":":",")":"\"","|":"$","?":"Ż",",":".","%":"+",":":"Ł",";":"ł","^":"=","}":")","]":"(","_":"ć","{":"ź","!":"§","+":"]","#":"!","(":"\/","*":"_","`":"<","\/":"ż","[":"ó","~":">","<":"ś","\"":"ę","$":"?",".":",",">":"ń","'":"ą","@":"%","=":"[","\\":";"}}
{"com.apple.keylayout.Portuguese":{")":"=","`":"<","\/":"'","'":"´","^":"&","\"":"`","<":";","]":"~",";":"º",">":":","[":"ç",":":"ª","{":"Ç","@":"\"","}":"^","(":")","&":"\/","*":"(","=":"*","~":">"}}
{"com.apple.keylayout.Sami-PC":{"}":"Æ","*":"(","x":"č","\"":"Ŋ","w":"š","[":"ø","~":"Ž","^":"&","\/":"´","@":"\"","`":"ž","]":"æ","{":"Ø","|":"Đ","<":";",")":"=",">":":","W":"Š","(":")","\\":"đ","X":"Č","=":"`","Q":"Á","q":"á","&":"\/","'":"ŋ",":":"Å",";":"å"}}
{"com.apple.keylayout.Serbian-Latin":{";":"č","\\":"ž","@":"\"",">":":","&":"'","'":"ć","<":";","]":"đ","\"":"Ć","|":"Ž","(":")","=":"*","}":"Đ","^":"&",")":"=","`":"<","[":"š","~":">",":":"Č","*":"(","{":"Š"}}
{"com.apple.keylayout.Slovak":{"!":"1","$":"4","`":"ň","1":"+","0":"é","&":"7",":":"\"","#":"3","4":"č","^":"6","*":"8","~":"Ň","{":"Ú","%":"5","5":"ť","'":"§",")":"0","}":"Ä","6":"ž","\/":"'","\"":"!","[":"ú","8":"á","]":"ä","9":"í","7":"ý","?":"ˇ",";":"ô","<":"?","@":"2","2":"ľ","3":"š",">":":","(":"9","+":"%"}}
{"com.apple.keylayout.Slovak-QWERTY":{")":"0",":":"\"","9":"í",";":"ô","6":"ž","3":"š","'":"§","\"":"!","]":"ä","^":"6","\/":"'","+":"%","@":"2","~":"Ň",">":":","`":"ň","?":"ˇ","<":"?","!":"1","#":"3","5":"ť","&":"7","$":"4","{":"Ú","2":"ľ","}":"Ä","%":"5","*":"8","1":"+","8":"á","(":"9","7":"ý","0":"é","4":"č","[":"ú"}}
{"com.apple.keylayout.Slovenian":{"]":"đ","`":"<","^":"&","@":"\"",")":"=","&":"'","\"":"Ć",":":"Č","'":"ć","*":"(","=":"*","<":";","{":"Š",";":"č","}":"Đ","(":")","~":">",">":":","\\":"ž","|":"Ž","[":"š"}}
{"com.apple.keylayout.Spanish":{"|":"\"","!":"¡","\\":"'","<":"¿","{":"Ñ","[":"ñ",":":"º",";":"´","@":"!","`":"<","\/":".","~":">","]":";",".":"ç","'":"`",">":"Ç","}":":","\"":"¨","^":"\/"}}
{"com.apple.keylayout.Spanish-ISO":{"|":"\"","~":">","`":"<","]":";","\/":".",":":"º",")":"=","(":")","<":"¿","&":"\/","^":"&",">":"Ç","*":"(",";":"´","#":"·","}":"not found","\"":"¨","{":"Ñ",".":"ç","\\":"'","[":"ñ","'":"`","@":"\""}}
{"com.apple.keylayout.Swedish":{"(":")","]":"ä","\\":"'","\"":"^","~":">","$":"€","`":"<","^":"&","{":"Ö","|":"*","\/":"´",">":":","*":"(",":":"Å",";":"å","<":";",")":"=","&":"\/","=":"`","[":"ö","}":"Ä","'":"¨","@":"\""}}
{"com.apple.keylayout.Swedish-Pro":{"\/":"´","^":"&","*":"(","`":"<","'":"¨","{":"Ö","|":"*",")":"=","$":"€",">":":","&":"\/","<":";","[":"ö","\\":"'",";":"å","(":")","~":">","\"":"^","}":"Ä","@":"\"","]":"ä",":":"Å","=":"`"}}
{"com.apple.keylayout.SwedishSami-PC":{"@":"\"","=":"`","<":";","^":"&","|":"*","`":"<",">":":",")":"=","{":"Ö","'":"¨","&":"\/","\"":"ˆ","}":"Ä","]":"ä","~":">","[":"ö","\/":"´",":":"Å","*":"(","\\":"@","(":")",";":"å"}}
{"com.apple.keylayout.SwissFrench":{":":"ü","@":"\"","&":"\/","'":"^","~":">","^":"&",")":"=","$":"ç",";":"è","\"":"`","]":"à","[":"é","\\":"$","\/":"'","#":"*","=":"¨","{":"ö","!":"+","|":"£","*":"(","+":"!","`":"<","<":";","(":")",">":":","}":"ä"}}
{"com.apple.keylayout.SwissGerman":{"=":"¨","{":"é","#":"*",":":"è","\\":"$","}":"à","!":"+","(":")","+":"!","]":"ä","\/":"'","<":";","\"":"`",";":"ü","$":"ç","'":"^","`":"<","*":"(","[":"ö",">":":","&":"\/","^":"&","~":">","@":"\"",")":"=","|":"£"}}
{"com.apple.keylayout.Turkish":{"|":"Ü","}":"I","(":"%","#":"\"",">":"Ç","&":")","^":"\/","-":"ş","\/":".","`":"<","$":"'","%":"(","@":"*","]":"ı","~":">","*":"_",",":"ö","[":"ğ","\"":"-","<":"Ö","_":"Ş",".":"ç","{":"Ğ",":":"$","'":",","\\":"ü",")":":"}}
{"com.apple.keylayout.Turkish-QWERTY-PC":{"$":"+","\\":",","|":";","`":"<","'":"ı","[":"ğ","}":"Ü","^":"&","=":".",".":"ç","#":"^","{":"Ğ","*":"(","+":":",":":"Ş","\/":"*","~":">",";":"ş",")":"=","(":")","@":"'","<":"Ö",",":"ö","&":"\/","]":"ü",">":"Ç","\"":"I"}}
{"com.apple.keylayout.Turkish-Standard":{"|":"Ü","}":"I","(":")","#":"^",">":";","=":"*","&":"'","^":"&","`":"ö","@":"\"","]":"ı","~":"Ö","*":"(",",":".",";":"ç","[":"ğ","\"":"Ş","<":":",".":",","{":"Ğ",":":"Ç","'":"ş","\\":"ü",")":"="}}
{"com.apple.keylayout.Turkmen":{"q":"ä","c":"ç","]":"ö","Q":"Ä","`":"ž","|":"Ş","[":"ň","X":"Ü","V":"Ý","\\":"ş","^":"№","v":"ý","~":"Ž","C":"Ç","x":"ü","}":"Ö","{":"Ň"}}
{"com.apple.keylayout.USInternational-PC":{"^":"ˆ","~":"˜"}}
{"com.apple.keylayout.Welsh":{"#":"£"}}

```
