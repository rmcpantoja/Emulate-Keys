;UDF to translate your applications into different languages.
;This UDF was created by Mateo Cedillo
func GetLanguageName($file)
$nlgname = IniRead($file &".lang", "Language info", "Name", "")
if $nlgname = "" then
MsgBox(16, "language engine error", "The language name is not valid")
return 0
Else
return $nlgname
EndIf
EndFunc
Func GetLanguageAuthors($file)
$nlgauthors = IniRead($file &".lang", "Language info", "Author", "")
if $nlgauthors = "" then
return 0
Else
return $nlgauthors
EndIf
EndFunc
Func GetLanguageCopyright($file)
$nlgcpr = IniRead($file &".lang", "Language info", "Copyright", "")
if $nlgcpr = "" then
return 0
Else
return $nlgcpr
EndIf
endFunc
Func GetLanguageVersion($file)
$nlgversion = IniRead($file &".lang", "Language info", "Version", "")
if $nlgversion = "" then
MsgBox(16, "language engine error", "The language version is not valid")
return 0
Else
return $nlgversion
EndIf
endFunc

func translate($LanguageName, $string)
$strings = IniRead($LanguageName &".lang", "Strings", $string, "")
if $strings = "" then
if not $string = "" then
return $string
else
MsgBox(16, "language engine error", "This translation is corrupt!")
return 0
EndIf
else
return $strings
EndIf
EndFunc