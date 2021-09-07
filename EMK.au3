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
#include <guiConstantsEx.au3>
#include <ProgressConstants.au3>
#include "include\reader.au3"
#include "include\sapi.au3"
#include "include\NVDAControllerClient.au3"
#include "include\kbc.au3"
#include "include\menu_nvda.au3"
#include "updater.au3"
;#include <WindowsConstants.au3>
$l1 = GUICreate("Loading...")
GUISetState(@SW_SHOW)
global $program_ver = 0.4
;Register_Run("EMK")
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
sleep(50)
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
;Spanish languages: Idiomas en español:
select
case @OSLang = "0c0a" or @OSLang = "040a" or @OSLang = "080a" or @OSLang = "100a" or @OSLang = "140a" or @OSLang = "180a" or @OSLang = "1c0a" or @OSLang = "200a" or @OSLang = "240a" or @OSLang = "280a" or @OSLang = "2c0a" or @OSLang = "300a" or @OSLang = "340a" or @OSLang = "380a" or @OSLang = "3c0a" or @OSLang = "400a" or @OSLang = "440a" or @OSLang = "480a" or @OSLang = "4c0a" or @OSLang = "500a"
$menu=Reader_create_menu("Por favor, selecciona tu idioma", "español,inglés,salir")
;English languages: Idiomas para inglés:
case @OSLang = "0809" or @OSLang = "0c09" or @OSLang = "1009" or @OSLang = "1409" or @OSLang = "1809" or @OSLang = "1c09" or @OSLang = "2009" or @OSLang = "2409" or @OSLang = "2809" or @OSLang = "2c09" or @OSLang = "3009" or @OSLang = "3409" or @OSLang = "0425"
$menu=Reader_create_menu("Please select language", "spanish,english,exit")
case else
$menu=Reader_create_menu("Please select language", "spanish,english,exit")
endselect
select
case $menu = 1
IniWrite("config\config.st", "General settings", "language", "es")
sleep(50)
GUIDelete($langGUI)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
checkupd()
case $menu = 2
IniWrite ("config\config.st", "General settings", "language", "eng")
sleep(50)
GUIDelete($langGUI)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
checkupd()
case $menu = 3
sleep(50)
exitpersonaliced()
EndSelect
endFunc
func checkupd()
$main_u = GUICreate("Emulate keys Checking version...")
GUISetState(@SW_SHOW)
sleep(50)
checkmkversion()
slep(500)
GUIDelete($main_u)
endfunc
func checKmkversion()
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
Local $yourexeversion = $program_ver
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
sleep(50)
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
Local $idHelpitema = GUICtrlCreateMenuItem($mensaje6, $idHelpmenu)
Local $idHelpitemb = GUICtrlCreateMenuItem($mensaje7, $idHelpmenu)
Local $idHelpitemc = GUICtrlCreateMenuItem($mensaje8, $idHelpmenu)
GUICtrlCreateMenuItem("", $idEMK, 2)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel($mensaje11, 0,100,20,20)
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
sleep(100)
SoundPlay(@TempDir &"\sounds\soundsdata.dat\selected.mp3",0)
block()
Case $GUI_EVENT_CLOSE, $idExitbutton, $idExititem
exitpersonaliced()
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
sleep(50)
If $DocOpen = -1 Then
MsgBox($MB_SYSTEMMODAL, "error", "An error occurred when reading the file.")
Return False
EndIf
Local $openned = FileRead($DocOpen)
$manualwindow = GUICreate($manualdoc)
Local $idMyedit = GUICtrlCreateEdit($openned, 8, 92, 121, 97, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY))
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
sleep(200)
exitpersonaliced()
endif
$SendKey=InputBox($message5, $message2, "", " M100")
if $sendKey="" then
speaking($message11)
sleep(200)
exitpersonaliced()
EndIf
$RepeatKey=InputBox($message6, $message3, "", " M100")
if $repeatKey="" then
speaking($message11)
sleep(200)
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
sleep(100)
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
_nvdaControllerClient_free()
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
sleep(200)
replace()
endIf
$KeyToReplace=InputBox($message3, $message4, "", " M10")
if $KeyToReplace="" then
speaking("blank")
sleep(200)
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
sleep(100)
Next
speaking("Ready")
endIf
endFunc
Func Enviartecla()
For $cambia = 1 To $arr[0][0]
send($arr[$cambia][0])
Next
endFunc