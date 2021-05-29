;EMulate keys
; #pragma compile(Icon, C:\Program Files\AutoIt3\Icons\au3.ico)
#pragma compile(UPX, False)
#pragma compile(FileDescription, Emulate keys)
#pragma compile(ProductName, Emulate keys)
#pragma compile(ProductVersion, 0.4.0.0)
#pragma compile(FileVersion, 0.4.0.0, 0.4.0.0)
#pragma compile(LegalCopyright, © 2018-2021 MT Programs, All rights reserved)
#pragma compile(CompanyName, 'MT Programs')
;include
#include <AutoItConstants.au3>
#include "include\Desencriptador.au3"
#include <EditConstants.au3>
#Include<fileConstants.au3>
#include <FTPEx.au3>
#include <guiConstantsEx.au3>
#include <ProgressConstants.au3>
#include "include\reader.au3"
#include "include\sapi.au3"
#include "include\NVDAControllerClient.au3"
#include "include\kbc.au3"
#include "include\menu_nvda.au3"
#include "updater.au3"
#include <WindowsConstants.au3>
$l1 = GUICreate("Loading...")
GUISetState(@SW_SHOW)
sleep(10)
If not FileExists("EMK.au3") Then
sleep(10)
Extractor()
else
sleep(25)
comprovar()
endif
Func Extractor()
GUICtrlCreateLabel("Extracting sounds...", 40, 20)
sleep(100)
Local $zip_carpeta = @scriptDir & '\soundsdata.dat'
If FileExists("sounds\soundsdata.dat\*.mp3") then
if @compiled then
msgbox (4096, "error", "Damn thief, stop stealing the sounds!")
exit
EndIf
comprovar()
endif
If FileExists(@TempDir &"\sounds\soundsdata.dat\*.mp3") then
if @compiled then
;remover esa carpeta
DirRemove(@TempDir & "/sounds", 1)
EndIf
endIf
sleep(1000)
desencriptar()
comprovar()
If FileExists($zip_carpeta) Then
sleep(50)
GUIDelete($l1)
comprovar()
endIf
GUIDelete($l1)
EndFunc
func comprovar()
if not fileExists ("config") then
DirCreate("config")
EndIf
GUIDelete($l1)
checkselector()
EndFunc
func checkselector()
global $sLanguage = iniRead ("config\config.st", "General settings", "language", "")
select
case $sLanguage ="es"
checkupd()
case $sLanguage ="eng"
checkupd()
case else
selector()
endselect
endfunc
Func Selector()
if not fileExists ("config") then
DirCreate("config")
if @error then
MSGBox(0, "Error", "Config folder could not be created.")
exitpersonaliced()
EndIf
EndIf
local $widthCell,$msg,$iOldOpt
$langGUI= GUICreate("Language Selection")
$widthCell=70
$iOldOpt=Opt("GUICoordMode",$iOldOpt)
GUICtrlCreateLabel("Select language:", 30, 50,$widthCell)
GUISetBkColor(0x00E0FFFF)
GUISetState(@SW_SHOW)
$windowslanguage= @OSLang
;Spanish languages: Idiomas en español:
select
case $windowslanguage = "0c0a" or $windowslanguage = "040a" or $windowslanguage = "080a" or $windowslanguage = "100a" or $windowslanguage = "140a" or $windowslanguage = "180a" or $windowslanguage = "1c0a" or $windowslanguage = "200a" or $windowslanguage = "240a" or $windowslanguage = "280a" or $windowslanguage = "2c0a" or $windowslanguage = "300a" or $windowslanguage = "340a" or $windowslanguage = "380a" or $windowslanguage = "3c0a" or $windowslanguage = "400a" or $windowslanguage = "440a" or $windowslanguage = "480a" or $windowslanguage = "4c0a" or $windowslanguage = "500a"
$menu=Reader_create_menu("Por favor, selecciona tu idioma", "español,inglés,salir")
;English languages: Idiomas para inglés:
case $windowslanguage = "0809" or $windowslanguage = "0c09" or $windowslanguage = "1009" or $windowslanguage = "1409" or $windowslanguage = "1809" or $windowslanguage = "1c09" or $windowslanguage = "2009" or $windowslanguage = "2409" or $windowslanguage = "2809" or $windowslanguage = "2c09" or $windowslanguage = "3009" or $windowslanguage = "3409" or $windowslanguage = "0425"
$menu=Reader_create_menu("Please select language", "spanish,english,exit")
case else
$menu=Reader_create_menu("Please select language", "spanish,english,exit")
endselect
select
case $menu = 1
IniWrite("config\config.st", "General settings", "language", "es")
sleep(100)
GUIDelete($langGUI)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
checkupd()
case $menu = 2
IniWrite ("config\config.st", "General settings", "language", "eng")
sleep(100)
GUIDelete($langGUI)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
checkupd()
case $menu = 3
sleep(100)
exitpersonaliced()
EndSelect
endFunc
func checkupd()
$main_u = GUICreate("Emulate keys Checking version...")
GUISetState(@SW_SHOW)
sleep(100)
checkmkversion()
slep(500)
GUIDelete($main_u)
endfunc
func checKmkversion()
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
Local $yourexeversion = FileGetVersion("EMK.exe")
select
case $sLanguage ="es"
$newversion=" Tienes la "
$newversion2=", y está disponible la "
case $sLanguage ="eng"
$newversion=" You have the version "
$newversion2=", And is available the "
endselect
$fileinfo = InetGet("https://www.dropbox.com/s/9iyflhit0t8ddbd/MKWeb.dat?dl=1", "MKWeb.dat")
;$file_down = FileOpen("MKWeb.dat")
FileCopy("MKWeb.dat", @TempDir & "\MKWeb.dat")
$latestver = iniRead (@TempDir & "\MKWeb.dat", "updater", "LatestVersion", "")
if $sLanguage ="Es" then
select
Case $latestVer > $yourexeversion
speak("hay una nueva versión.")
TTSDialog("actualización disponible! " &$newversion &$yourexeversion &$newversion2 &$latestver& ". Presiona enter para descargar.")
sleep(100)
DownloadEMK()
;GUIDelete($main_u)
Case else
;GUIDelete($main_u)
principal()
endselect
endif
if $sLanguage ="Eng" then
select
Case $latestVer > $yourexeversion
speak("there is a new version.", 3)
TTSDialog("update available! " &$newversion &$yourexeversion &$newversion2 &$latestver& ". Press enter to download.")
DownloadEMK()
case else
principal()
endselect
endif
InetClose($fileinfo)
If @Compiled Then
FileDelete("MKWeb.dat")
FileDelete(@tempDir & "\MKWeb.dat")
EndIf
endfunc
GUIDelete($main_u)
func principal()
$slanguage = iniRead ("config\config.st", "General settings", "language", "")
global $program_ver = 0.4
SoundPlay(@TempDir &"\sounds\soundsdata.dat\open.mp3",1)
$Gui_main = guicreate("Emulate keys " &$program_ver)
HotKeySet("{F1}", "playhelp")
$mensaje1="Emulate Keys"
$replacements = iniRead ("config\config.st", "Key Settings", "Replace", "")
if $replacements ="Yes" then
replaceKeys()
EndIf
select
case $slanguage ="es"
$mensaje2="Enviar teclas a una aplicación..."
$mensaje3="Reemplazar el pulso de una tecla por otra"
$mensaje4="&salir"
$mensaje5="ayuda"
$mensaje5a="Herramientas"
$mensaje6="Acerca de emulate keys"
$mensaje7="Manual del usuario"
$mensaje8="visitar sitio web"
$mensaje9="Bloqueo y desbloqueo de teclado o mouse"
$mensaje9a="Creador de paquetes de teclas"
$mensaje10="Errores y sugerencias"
$mensaje10a="Enviar paquete de sonidos"
$mensaje11="Pulsa alt para abrir el menú."
$mensaje12="&Salir"
case $sLanguage ="eng"
$mensaje2="Send keys to an application..."
$mensaje3="Replace the pulse of one key with another"
$mensaje4="&exit"
$mensaje5="help"
$mensaje5a="Tools"
$mensaje6="About emulate keys"
$mensaje7="User manual"
$mensaje8="visit website"
$mensaje9="Lock and unlock keyboard or mouse"
$mensaje9a="Keys package creator"
$mensaje10="Errors and suggestions"
$mensaje10a="Send soundpack"
$mensaje11="Press alt to open the menu."
$mensaje12="E&xit"
endselect
$okmessaje="OK"
Local $idEMK = GUICtrlCreateMenu($mensaje1)
Local $idSenditem = GUICtrlCreateMenuItem($mensaje2, $idEMK)
Local $idEMKitem = GUICtrlCreateMenuItem($mensaje3, $idEMK)
Local $idBlockitem = GUICtrlCreateMenuItem($mensaje9, $idEMK)
Local $idExititem = GUICtrlCreateMenuItem($mensaje4, $idEMK)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
Local $idTSmenu = GUICtrlCreateMenu($mensaje5a)
Local $idPackcritem = GUICtrlCreateMenuItem($mensaje9a, $idTSmenu)
Local $idHelpmenu = GUICtrlCreateMenu($mensaje5)
Local $idErrorreporting = GUICtrlCreateMenuItem($mensaje10, $idHelpmenu)
Local $idSendpack = GUICtrlCreateMenuItem($mensaje10a, $idHelpmenu)
Local $idHelpitema = GUICtrlCreateMenuItem($mensaje6, $idHelpmenu)
Local $idHelpitemb = GUICtrlCreateMenuItem($mensaje7, $idHelpmenu)
Local $idHelpitemc = GUICtrlCreateMenuItem($mensaje8, $idHelpmenu)
GUICtrlCreateMenuItem("", $idEMK, 2)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel($mensaje11, 0,100,20,20,$WS_TABSTOP)
GUICtrlSetState(-1, $GUI_FOCUS)
Local $idExitbutton = GUICtrlCreateButton($mensaje12, 120, 100, 20, 20)
GUISetState(@SW_SHOW)
; Loop until the user exits.
While 1
Switch GUIGetMsg()
Case $idSenditem
;GUIDelete($gui_main)
_send()
Case $idEMKitem
replace()
Case $idBlockitem
sleep(250)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
block()
Case $GUI_EVENT_CLOSE, $idExitbutton, $idExititem
exitpersonaliced()
Case $idErrorreporting
select
case $sLanguage ="es"
$mensaje=InputBox("Reportar un error...", "Cuéntanos en este cuadro qué es lo que deseas reportar o sugerirnos:", "", " M2000")
if $mensaje="" then
$mensaje="Este mensaje está en blanco..."
endif
$yourname=InputBox("tu nombre", "escribe tu nombre en este campo a continuación:", "")
if $yourname="" then
$yourname="Alguien sin identificarse"
endif
$combo=InputBox("Correo Electrónico, opcional", "Escribe tu correo electrónico en caso de que necesitemos ponernos en contacto contigo.", "")
if $combo="" then
$combo="No se ha especificado."
endif
$correo="Correo electrónico: " (&$combo)
case $sLanguage ="eng"
$mensaje=InputBox("Report a bug...", "Tell us in this box what you want to report or suggest:", "")
if $mensaje="" then
$mensaje="This message is blank ..."
endif
$yourname=InputBox("Your name", "write your name in this field below:", "", " M2000")
if $yourname="" then
$yourname="Someone unidentified"
endif
$combo=InputBox("Email, optional", "Write your email in case we need to contact you.", "")
if $combo="" then
$combo="Not specified."
endif
$correo="Email: " (&$combo)
endselect
$program="Emulate Keys, "
$SmtpServer = "smtp.gmail.com"              ; address for the smtp-server to use - REQUIRED
select
case $sLanguage ="es"
$FromName = "Reportero de errores"                      ; name from who the email was sent
case $sLanguage ="eng"
$FromName = "Bug reporter"                      ; name from who the email was sent
endselect
$FromAddress = "reporterodeerrores@gmail.com" ; address from where the mail should come
$ToAddress = "angelitomateocedillo@gmail.com"   ; destination address of the email - REQUIRED
select
case $sLanguage ="es"
$Su1=" nos ha enbiado un reporte de error"
$Subject = ($program &$yourname &$su1)                   ; subject from the email - can be anything you want it to be
case $sLanguage ="eng"
$Su1=" You have sent us an error report"
$Subject = ($program &$yourname &$su1)                   ; subject from the email - can be anything you want it to be
endselect
select
case $sLanguage ="es"
$gr="Gracias, el reportero de errores."
$Body = ($mensaje &@crlf &$correo &@crlf &$gr)                             ; the messagebody from the mail - can be left blank but then you get a blank mail
case $sLanguage ="eng"
$gr="Thanks, the bug reporter."
$Body = ($mensaje &@crlf &$correo &@crlf &$gr)                              ; the messagebody from the mail - can be left blank but then you get a blank mail
endselect
$AttachFiles = ""                       ; the file(s) you want to attach seperated with a ; (Semicolon) - leave blank if not needed
$CcAddress = ""       ; address for cc - leave blank if not needed
$BccAddress = ""     ; address for bcc - leave blank if not needed
$Importance = "High"                  ; Send message priority: "High", "Normal", "Low"
$Username = "Reporterodeerrores"                    ; username for the account used from where the mail gets sent - REQUIRED
$Password = "superpollo1234567890"                  ; password for the account used from where the mail gets sent - REQUIRED
$IPPort = 465                            ; port used for sending the mail
$ssl = 1                                ; enables/disables secure socket layer sending - put to 1 if using httpS
;~ $IPPort=465                          ; GMAIL port used for sending the mail
;~ $ssl=1                               ; GMAILenables/disables secure socket layer sending - put to 1 if using httpS
_SednMail ($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
case $idSendpack 
Sendpack()
Case $idHelpitema
select
case $slanguage ="es"
MsgBox(0, "Acerca de...", "Emulate keys versión " &$program_ver &"beta te permite hacer actividades con tus teclas. Programa desarrollado por Mateo Cedillo. 2018-2021 MT programs.")
case $slanguage ="eng"
MsgBox(0, "About", "Emulate Keys version " &$program_ver &"beta allows you to do activities with your keys. Program developed by Mateo Cedillo. 2018-2021 MT programs.")
endselect
continueLoop
case $idHelpitemb
playhelp()
case $idHelpitemc
ShellExecute("http://mateocedillo.260mb.net/")
EndSwitch
WEnd
EndFunc
Func _SednMail ($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
Global $oMyRet[2]
Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
$rc = _INetSmtpMailCom($SmtpServer, $FromName, $FromAddress, $ToAddress, $Subject, $Body, $AttachFiles, $CcAddress, $BccAddress, $Importance, $Username, $Password, $IPPort, $ssl)
If @error Then
MsgBox(0, "Error sending message", "Error code:" & @error & "  Description:" & $rc)
EndIf
endfunc
Func _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject = "", $as_Body = "", $s_AttachFiles = "", $s_CcAddress = "", $s_BccAddress = "", $s_Importance="Normal", $s_Username = "", $s_Password = "", $IPPort = 465, $ssl = 1)
Local $objEmail = ObjCreate("CDO.Message")
$objEmail.From = '"' & $s_FromName & '" <' & $s_FromAddress & '>'
$objEmail.To = $s_ToAddress
Local $i_Error = 0
Local $i_Error_desciption = ""
If $s_CcAddress <> "" Then $objEmail.Cc = $s_CcAddress
If $s_BccAddress <> "" Then $objEmail.Bcc = $s_BccAddress
$objEmail.Subject = $s_Subject
If StringInStr($as_Body, "<") And StringInStr($as_Body, ">") Then
$objEmail.HTMLBody = $as_Body
Else
$objEmail.Textbody = $as_Body & @CRLF
EndIf
If $s_AttachFiles <> "" Then
Local $S_Files2Attach = StringSplit($s_AttachFiles, ";")
For $x = 1 To $S_Files2Attach[0]
$S_Files2Attach[$x] = _PathFull($S_Files2Attach[$x])
;~          ConsoleWrite('@@ Debug : $S_Files2Attach[$x] = ' & $S_Files2Attach[$x] & @LF & '>Error code: ' & @error & @LF) ;### Debug Console
If FileExists($S_Files2Attach[$x]) Then
ConsoleWrite('+> File attachment added: ' & $S_Files2Attach[$x] & @LF)
$objEmail.AddAttachment($S_Files2Attach[$x])
Else
ConsoleWrite('!> File not found to attach: ' & $S_Files2Attach[$x] & @LF)
SetError(1)
Return 0
EndIf
Next
EndIf
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $s_SmtpServer
If Number($IPPort) = 0 then $IPPort = 25
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $IPPort
;Authenticated SMTP
If $s_Username <> "" Then
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = $s_Username
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = $s_Password
EndIf
If $ssl Then
$objEmail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
EndIf
;Update settings
$objEmail.Configuration.Fields.Update
; Set Email Importance
Switch $s_Importance
Case "High"
$objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "High"
Case "Normal"
$objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "Normal"
Case "Low"
$objEmail.Fields.Item ("urn:schemas:mailheader:Importance") = "Low"
EndSwitch
$objEmail.Fields.Update
; Sent the Message
$objEmail.Send
If @error Then
SetError(2)
Return $oMyRet[1]
EndIf
$objEmail=""
EndFunc   ;==>_INetSmtpMailCom
Func MyErrFunc()
    $HexNumber = Hex($oMyError.number, 8)
    $oMyRet[0] = $HexNumber
    $oMyRet[1] = StringStripWS($oMyError.description, 3)
    ConsoleWrite("### COM Error !  Number: " & $HexNumber & "   ScriptLine: " & $oMyError.scriptline & "   Description:" & $oMyRet[1] & @LF)
    SetError(1); something to check for when this function returns
    Return
EndFunc   ;==>MyErrFunc
func playhelp()
select
case $sLanguage  ="es"
Local $manualdoc = "documentation\manual1.txt"
$editmessage1="Manual del usuario."
$editmessage2="No se encuentra el archivo."
$editmessage3="abriendo..."
case $sLanguage ="eng"
Local $manualdoc = "documentation\manual2.txt"
$editmessage1="User manual."
$editmessage2="The file cannot be found."
$editmessage3="opening..."
endSelect
Local $DocOpen = FileOpen($manualdoc, $FO_READ)
ToolTip($editmessage3)
speaking($editmessage3)
sleep(100)
If $DocOpen = -1 Then
MsgBox($MB_SYSTEMMODAL, "error", "An error occurred when reading the file.")
Return False
EndIf
Local $openned = FileRead($DocOpen)
$manualwindow = GUICreate($manualdoc)
Local $idMyedit = GUICtrlCreateEdit($openned, 8, 92, 121, 97, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY, $WS_VSCROLL, $WS_VSCROLL, $WS_CLIPSIBLINGS))
GUISetState(@SW_SHOW)
; Loop until the user exits.
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
FileClose($DocOpen)
ExitLoop
EndSwitch
WEnd
GUIDelete()
EndFunc
func _send()
$lang = iniRead ("config\config.st", "General settings", "language", "")
$read_speed = iniRead ("config\config.st", "Key settings", "Speed", "")
select
case $lang ="es"
$message1="introduzca el nombre de la aplicación:"
$message2="Introduzca el nombre de la (s) tecla (s) a enviar"
$message3="¿Cuántas veces se repetirá esta acción?"
$message4="Nombre de aplicación"
$message5="teclas"
$message6="Repetición"
$message7="tienes 3 segundos para ir a la aplicación..."
$message8="acción immediata!"
$message9="Finalizado."
$message10="Velocidad"
$message11="Este campo está en blanco..."
$message12="Por favor selecciona velocidad de retraso:"
$message13="pausa"
case $lang ="eng"
$message1="enter the name of the application:"
$message2="Enter the name of the key (s) to send"
$message3="How many times will this action be repeated?"
$message4="Application name"
$message5="keys"
$message6="Repeat"
$message7="you have 3 seconds to go to the application..."
$message8="immediate action!"
$message9="Finished."
$message10="Speed"
$message11="This field is blank ..."
$message12="Please select delay speed:"
$message13="pause"
endSelect
$enterApp=InputBox($message4, $message1, "", " M100")
if $enterApp="" then
speaking($message11)
sleep(300)
exitpersonaliced()
endif
$SendKey=InputBox($message5, $message2, "", " M100")
if $sendKey="" then
speaking($message11)
sleep(300)
exitpersonaliced()
EndIf
$RepeatKey=InputBox($message6, $message3, "", " M100")
if $repeatKey="" then
speaking($message11)
sleep(300)
exitpersonaliced()
endIf
if $read_speed ="25" or $read_speed ="50" or $read_speed ="75" or $read_speed ="100" or $read_speed ="200" or $read_speed ="250" or $read_speed ="300" or $read_speed ="500" or $read_speed ="700" or $read_speed ="1000" then
$key_speed = $read_speed
else
$p_options=reader_Create_Menu($message12, "25 ms,50 ms,75 ms,100 ms,200 ms,250 ms,300 ms,500 ms,700 ms,1000 ms")
select
case $p_options = 1
$key_speed="25"
case $p_options = 2
$key_speed="50"
case $p_options = 3
$key_speed="75"
case $p_options = 4
$key_speed="100"
case $p_options = 5
$key_speed="200"
case $p_options = 6
$key_speed="250"
case $p_options = 7
$key_speed="300"
case $p_options = 8
$key_speed="500"
case $p_options = 9
$key_speed="700"
case $p_options = 10
$key_speed="1000"
endSelect
IniWrite("config\config.st", "Key settings", "Speed", $key_speed)
endIf
sleep(200)
speaking($message7)
beep(1000,200)
sleep(800)
beep(1000,200)
sleep(800)
beep(1000,200)
sleep(800)
beep(2000,200)
sleep(800)
speaking($message8)
WINWAITACTIVE($enterApp)
;estableciendo teclas
FOR $I=0 TO $RepeatKey STEP 1
$keysound = Random(1, 10, 1)
SEND($SendKey)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\key" &$keysound& ".mp3",0)
sleep($key_speed)
next
speaking($message9)
endFunc
func exitpersonaliced()
SoundPlay(@TempDir &"\sounds\soundsdata.dat\close.mp3",0)
sleep(1000)
$devmode="0"
select
case $devmode= "0"
FileDelete("MKWeb.dat")
FileDelete(@tempDir & "\MKWeb.dat")
DirRemove(@TempDir & "/sounds", 1)
sleep(50)
exit
case $devmode= "1"
sleep(100)
exit
endselect
endfunc
func block()
$lang = iniRead ("config\config.st", "General settings", "language", "")
select
case $lang="es"
$block1="¡Atención! Estás consciente de que esta opción bloqueará la entrada de teclado y mouse. Úsala solamente por si la necesitas. para desbloquear tu dispositivo, usa las teclas control + shift + b."
global $block2="Bloqueado."
global $block3="Desbloqueado."
case $lang="eng"
$block1="Attention! You are aware that this option will block keyboard and mouse input. Use it only in case you need it. To unlock your device, use the control + shift + b command."
global $block2="Blocked."
global $block3="Unlocked."
endSelect
ttsDialog($block1)
BlockInput($BI_DISABLE)
speaking($block2)
HotKeySet("^+b", "unlock")
$bloked="1"
endFunc
func unlock()
BlockInput($BI_ENABLE)
speaking($block3)
HotKeySet("^+b", "block")
endFunc
func replace()
$lang = iniRead ("config\config.st", "General settings", "language", "")
select
case $lang="es"
$message1="Nombre de tecla"
$message2="Introduzca el nombre de la tecla que vas a reemplazar:"
$message3="tecla de reemplazo"
$message4="Introduce la tecla que reemplazará a la escrita en el campo anterior:"
$message5="Nota: Para mantener en funcionamiento el reemplazo de las teclas, el programa debe estar en ejecución, dado a que esto no modifica ningún valor al registro."
$message6="Este mapeo de teclas ya existe en las configuraciones del programa."
case $lang="eng"
$message1="Key name"
$message2="Enter the name of the key you are going to replace:"
$message3="replacement key"
$message4="Enter the key that will replace the one written in the previous field:"
$message5="Note: To keep the key replacement running, the program must be running, as this does not change any registry values."
$message6="This keymap already exists in the program settings."
endSelect
$Orig=InputBox($message1, $message2, "", " M10")
if $ORIG="" then
speaking("blank")
sleep(300)
replace()
endIf
$KeyToReplace=InputBox($message3, $message4, "", " M10")
if $KeyToReplace="" then
speaking("blank")
sleep(300)
replace()
endIf
$ifExists = iniRead ("config\config.st", "Key replace", $orig, "")
if $ifExists = $KeyToReplace then
MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "Error", $message6)
replace()
else
IniWrite("config\config.st", "Key settings", "Replace", "Yes")
IniWrite("config\config.st", "Key Replace", $orig, $KeyToReplace)
replaceKeys()
endIf
endFunc
func replaceKeys()
speaking("loading...")
global $arr = IniReadSection("config\config.st", "Key Replace")
If @error Then
msgbox(0, "error", "error reading keymaps.")
else
For $original1 = 1 To $arr[0][0]
hotkeyset($arr[$original1][1], "Enviartecla")
speaking("Original key: " &$arr[$original1][0])
speaking("replacement key: " &$arr[$original1][1])
sleep(200)
Next
speaking("Ready")
endIf
endFunc
Func Enviartecla()
For $cambia = 1 To $arr[0][0]
send($arr[$cambia][0])
;speaking($arr[$cambia][0])
Next
endFunc
Func Sendpack()
$program="Emulate Keys, "
select
case $sLanguage ="es"
$mensaje= @username &"Envió un paquete de sonidos. Compruébalo y descárgalo aquí: Nombre de archivo: "
$sendaPack="Selecciona el archivo de paquete"
$Packtype="Archivos dat, (*.dat)"
$err="ERROR"
$err2="No se ha encontrado el archivo: "
case $sLanguage ="eng"
$mensaje=@username &"Sent a sound pack. Check it out and download it here: File name: "
$sendaPack="Select the package file"
$Packtype="dat files, (*.dat)"
$err="ERROR"
$err2="File not found: "
endselect
$packfile = FileOpenDialog($sendapack, @ScriptDir &"\packs", $packtype)
If @error OR NOT $packfile OR NOT FileExists($packfile) Then
MsgBox(0, $err, $err2 &$PACKfile)
Exitpersonaliced()
Else
speaking($packfile)
endIf
Local $sServer = 'ftpupload.net'
Local $sUsername = 'n260m_27330965'
Local $sPass = 'mrcp123'
Local $Err, $sFTP_Message
Local $hOpen = _FTP_Open('mateocedillo.260mb.net')
Local $hConn = _FTP_Connect($hOpen, $sServer, $sUsername, $sPass)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error to connect to server", 'Error code: ' & @error)
EndIf
GUICreate("Uploading...", 220, 100, 100, 200)
GUICtrlCreateLabel("htdocs/EMKPacks/" &$packfile, 10, 10)
Global $ProgressBar = GUICtrlCreateProgress(10, 40, 200, 20, $PBS_SMOOTH)
GUICtrlSetColor(-1, 32250); not working with Windows XP Style
Global $g_idBtn_Cancel = GUICtrlCreateButton("Cancel", 75, 70, 70, 20)
GUISetState(@SW_SHOW)
Local $fuFunctionToCall = _UpdateGUIProgressBar
$MOSTRARNOMBRE = FileOpen($packfile, $FO_READ)
If $MOSTRARNOMBRE = -1 Then
MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading the file.")
EndIf
$quearchivoes = FileReadLine($MOSTRARNOMBRE, 1)
$Enviararchivo = _FTP_ProgressUpload($hConn, $packfile, "htdocs/EMKPacks/" &$quearchivoes, $fuFunctionToCall)
;$Enviararchivo = _FTP_FilePut ($hConn, $packfile, "htdocs/EMKPacks/" &$packfile)
if @error then
MsgBox(0, "Error", "The file could not be sent")
Else
Msgbox(0, "Perfect", "The file has been sent")
EndIf
Local $iFtpc = _FTP_Close($hConn)
Local $iFtpo = _FTP_Close($hOpen)
EndFunc
Func _UpdateGUIProgressBar($iPercent)
GUICtrlSetData($ProgressBar, $iPercent)
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
Return -1 ; _FTP_UploadProgress Aborts with -1, so you can exit your app afterwards
Case $g_idBtn_Cancel
Return -2 ; Just Cancel, without special Return value
EndSwitch
Return 1 ; Otherwise continue Upload
EndFunc   ;==>_UpdateGUIProgressBar