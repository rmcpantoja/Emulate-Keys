;Auto Actualizador (Auto updater)
;Created by Mateo Cedillo.
;Script:
;#pragma compile(Compression, 0)
; #pragma compile(Icon, C:\Program Files\AutoIt3\Icons\au3.ico)
#pragma compile(ExecLevel, Highestavailable)
#pragma compile(UPX, False)
#pragma compile(FileDescription, Updater tool for mt programs)
#pragma compile(ProductName, AutoUpdater)
#pragma compile(ProductVersion, 1.1.0.0)
#pragma compile(FileVersion, 1.1.0.4, 1.1.0.4)
#pragma compile(LegalCopyright, © 2018-2020 MT Programs, All rights reserved)
#pragma compile(CompanyName, 'MT Programs')
;Including scripts
#include <new\audio.au3>
#include <AutoItConstants.au3>
#include <GUIConstantsEx.au3>
#include <new\kbc.au3>
#include <MsgBoxConstants.au3>
#include <new\NVDAControllerClient.au3>
#include <new\reader.au3>
#Include <new/sapi.au3>
# Include <StringConstants.au3>
select
case _StringInArray($CmdLine, 'check')
checkupd()
case _StringInArray($CmdLine, '/download_sounds')
sUpdate()
case _StringInArray($CmdLine, '/Download_update')
downloadups()
case _StringInArray($CmdLine, '/Download_mk_update')
downloadEMK()
case _StringInArray($CmdLine, 'Dwn_portable')
Dportable()
	case Else
		MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "Oops", "Failed to initialize. This application can only be used through the command line.")
exit
endselect
#RequireAdmin
Func _StringInArray($a_Array, $s_String)
	Local $i_ArrayLen = UBound($a_Array) - 1
	For $i = 0 To $i_ArrayLen
		If $a_Array[$i] = $s_String Then
			Return $i
		EndIf
	Next
	SetError(1)
	Return 0
EndFunc
;OnAutoItExitRegister("delfiles")
;Sleep(1000)
func checkupd()
$main = GUICreate("MCY Downloader. Checking...")
GUISetState(@SW_SHOW)
sleep(100)
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
$ReadAccs = iniRead ("config\config.st", "Accessibility", "Enable enanced accessibility", "")
	Local $yourexeversion = FileGetVersion("MCY.exe")
select
case $sLanguage ="es"
$newversion=" Tienes la "
$newversion2=", y está disponible la "
case $sLanguage ="eng"
$newversion=" You have the version "
$newversion2=", And is available the "
endselect
$fileinfo = InetGet("http://mateocedillo.droppages.com/MCYWeb.dat", "MCYWeb.dat")
;	$file_down = FileOpen("MCYWeb.dat")
			FileCopy("MCYWeb.dat", @TempDir & "\MCYWeb.dat")
$latestver = iniRead (@TempDir & "\MCYWeb.dat", "updater", "LatestVersion", "")
if $sLanguage ="Es" then
if $ReadAccs ="Yes" then
select
		Case $latestVer = 0
speak("no se ha podido comprovar versión.")
checksounds()
		Case $latestVer < $yourexeversion
speak("la versión que hemos buscado es menor a la que tienes.")
checksounds()
		Case $latestVer > $yourexeversion
speak("actualización disponible!" & $newversion & $yourexeversion & $newversion2 & $latestver & ". Puedes ir a MCY, menú ayuda, buscar actualizaciones para descargarla. Aceptar botón.")
checksounds()
;exitpersonaliced()
		Case $latestVer >= $yourexeversion
speak("estás actualizado.")
checksounds()
endselect
endif
endif
if $sLanguage ="Eng" then
select
		Case $latestVer = 0
speak("version could not be checked.")
checksounds()
		Case $latestVer < $yourexeversion
speak("the version we have looked for is lower than the one you have.")
checksounds()
		Case $latestVer > $yourexeversion
speak("update available!" & $newversion & $yourexeversion & $newversion2 & $latestver & ". You can go to MCY, help menu, Check for updates to download it. OK button.")
checksounds()
;exitpersonaliced()
		Case $latestVer >= $yourexeversion
speak("you are up to date.")
checksounds()
endselect
endif
if $ReadAccs ="No" then
if $sLanguage ="Es" then
select
		Case $latestVer = 0
msgbox(0, "Error", "no se ha podido comprovar versión.")
checsounds()
		Case $latestVer < $yourexeversion
msgbox(0, "Error", "la versión que hemos buscado es menor a la que tienes.")
checksounds()
		Case $latestVer > $yourexeversion
$result= ($newversion &$yourexeversion &$newversion2 &$latestver)
msgbox(0, "actualización disponible!", $result)
checksounds()
		Case $latestVer >= $yourexeversion
msgbox(0, "estás actualizado", "no hay actualización por el momento.")
checksounds()
endselect
endif
endif
if $sLanguage ="Eng" then
select
		Case $latestVer = 0
msgbox(0, "Error", "version could not be checked.")
checksounds()
		Case $latestVer < $yourexeversion
msgbox(0, "Error", "the version we have looked for is lower than the one you have.")
checksounds()
		Case $latestVer > $yourexeversion
$result= ($newversion &$yourexeversion &$newversion2 &$latestver)
msgbox(0, "update available!", $result)
checksounds()
		Case $latestVer >= $yourexeversion
msgbox(0, "you are up to date", "no update at the moment.")
endselect
endif
	InetClose($fileinfo)
endfunc
func checksounds()
speak("buscando actu de sonidos")
$yoursoundsversion = iniRead ("sounds\soundsdata.dat\version.ini", "version", "actual", "")
$ReadAccs = iniRead ("config\config.st", "Accessibility", "Enable enanced accessibility", "")
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
select
case $sLanguage ="es"
$newversion=" Tienes la "
$newversion2=", y está disponible la "
case $sLanguage ="eng"
$newversion=" You have the version "
$newversion2=", And is available the "
endselect
$latestsounds = iniRead (@TempDir & "\MCYWeb.dat", "updater", "soundsversion", "")
if $sLanguage ="Es" then
if $ReadAccs ="Yes" then
select
		Case $latestsounds = 0
speak("imposible buscar actualización")
exitpersonaliced()
		Case $latestsounds < $yoursoundsversion
;speak("la versión que hemos buscado es menor a la que tienes.")
exitpersonaliced()
		Case $latestsounds > $yoursoundsversion
speak("actualización de sonidos disponible." & $newversion & $yoursoundsversion & $newversion2 & $latestsounds & ". Puedes ir a MCY, menú ayuda, buscar actualizaciones para descargarla. Aceptar botón.")
exitpersonaliced()
		Case $latestsounds >= $yoursoundsversion
speak("estás actualizado.")
exitpersonaliced()
endselect
endif
endif
if $sLanguage ="Eng" then
select
		Case $latestsounds = 0
;speak("version could not be checked.")
exitpersonaliced()
		Case $latestsounds < $yoursoundsversion
;speak("the version we have looked for is lower than the one you have.")
exitpersonaliced()
		Case $latestsounds > $yoursoundsversion
speak("Sounds update available." & $newversion & $yoursoundsversion & $newversion2 & $latestsounds & ". You can go to MCY, help menu, Check for updates to download it. OK button.")
exitpersonaliced()
		Case $latestVer >= $yoursoundsversion
speak("you are up to date.")
exitpersonaliced()
endselect
endif
if $ReadAccs ="No" then
if $sLanguage ="Es" then
select
		Case $latestsounds = 0
;msgbox(0, "Error", "no se ha podido comprovar versión.")
exitpersonaliced()
		Case $latestsounds < $yoursoundsversion
;msgbox(0, "Error", "la versión que hemos buscado es menor a la que tienes.")
exitpersonaliced()
		Case $latestsounds > $yoursoundsversion
;$result= ($newversion &$yoursoundsversion &$newversion2 &$latestsounds)
;msgbox(0, "actualización disponible!", $result)
exitpersonaliced()
		Case $latestsounds >= $yoursoundsversion
;msgbox(0, "estás actualizado", "no hay actualización por el momento.")
exitpersonaliced()
endselect
endif
endif
if $sLanguage ="Eng" then
select
		Case $latestsounds = 0
;msgbox(0, "Error", "version could not be checked.")
exitpersonaliced()
		Case $latestsounds < $yoursoundsversion
;msgbox(0, "Error", "the version we have looked for is lower than the one you have.")
exitpersonaliced()
		Case $latestsounds > $yoursoundsversion
;$result= ($newversion &$yoursoundsversion &$newversion2 &$latestsounds)
;msgbox(0, "update available!", $result)
exitpersonaliced()
		Case $latestsounds >= $yoursoundsversion
;msgbox(0, "you are up to date", "no update at the moment.")
exitpersonaliced()
endselect
endif
;FileDelete(@tempDir & "\MCYWeb.dat")
endfunc
func exitpersonaliced()
$devmode="0"
select
case $devmode= "0"
;FileDelete("MCYWeb.dat")
FileDelete(@tempDir & "\MCYWeb.dat")
sleep(100)
exit
case $devmode= "1"
exit
endselect
endfunc
func 	sUpdate()
$bagground = $device.opensound ("sounds\soundsdata.dat\update.ogg", 0)
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
$ReadAccs = iniRead ("config\config.st", "Accessibility", "Enable enanced accessibility", "")
$bagground.play
$bagground.repeating=1
	; Display a progress bar window.
select
case $sLanguage ="Es"
	ProgressOn("Descargando actualización de paquete de sonidos.", "Por favor espera...", "0%", 100, 100, 16)
case $sLanguage ="Eng"
	ProgressOn("Downloading  sounds update pack.", "Please wait...", "0%", 100, 100, 16)
endselect
$iPlaces = 2
$url = 'https://www.dropbox.com/s/ag51kgss48gmxcn/SOUNDSDATA.DAT?dl=1'
$fldr = 'soundsdata.dat'
$hInet = InetGet($url, $fldr, 1, 1)
$URLSize = InetGetSize($url)
While Not InetGetInfo($hInet, 2)
Sleep(100)
$Size = InetGetInfo($hInet, 0)
$Percentage = Int($Size / $URLSize * 100)
$iSize = $URLSize - $Size
select
case $sLanguage ="Es"
$m1="Estado:"
ProgressSet($Percentage, $m1, _GetDisplaySize($iSize, $iPlaces = 2) & " restante(s) " & $Percentage & " porciento completado")
case $sLanguage ="Eng"
ProgressSet($Percentage, _GetDisplaySize($iSize, $iPlaces = 2) & " remaining " & $Percentage & " percent completed.")
endselect
If _ispressed($I) Then
select
case $ReadAccs ="yes"
speaking("FileSize in bites:" & $URLSize & ". Downloaded: " & $Size& ". Progress: " & $Percentage & "%. Remaining: " & $iSize)
endselect
endif
WEnd
select
case $sLanguage ="Es"
	ProgressSet(90, "Un momento", "Actualizando sonidos.")
case $sLanguage ="Eng"
	ProgressSet(90, "Just a moment", "Updating sounds.")
endselect
sleep(4000)
	; Close the progress window.
ProgressOff()
$bagground.stop
endfunc
Func _GetDisplaySize($iTotalDownloaded, Const $iPlaces)
Local Static $aSize[4] = ["Bytes", "KB", "MB", "GB"]
For $i = 0 to 3
$iTotalDownloaded /= 1024
If (Int($iTotalDownloaded) = 0) Then Return Round($iTotalDownloaded * 1024, $iPlaces) & " " & $aSize[$i]
Next
EndFunc
func Downloadups()
$bagground2 = $device.opensound ("sounds\soundsdata.dat\update.ogg", 0)
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
$ReadAccs = iniRead ("config\config.st", "Accessibility", "Enable enanced accessibility", "")
$bagground2.play
$bagground2.repeating=1
select
case $sLanguage ="Es"
	ProgressOn("Descargando actualización.", "espera...", "0%", 100, 100, 16)
case $sLanguage ="Eng"
	ProgressOn("Downloading update.", "Please wait...", "0%", 100, 100, 16)
endselect
$type = iniRead ("config\config.st", "General settings", "Program Type", "")
$iPlaces = 2
select
case $type ="installable"
$AppUrl = 'https://www.dropbox.com/s/l19ywvrocy7vsoc/MCY_setup.exe?dl=1'
$fldr = 'MCY_Setup_Package.exe'
case $type ="portable"
$AppUrl = 'https://www.dropbox.com/s/d49pf4blsv61aoz/extract.exe?dl=1'
$fldr = 'Extract.exe'
endselect
$hInet = InetGet($AppUrl, $fldr, 1, 1)
$URLSize = InetGetSize($AppUrl)
While Not InetGetInfo($hInet, 2)
;		MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "Error", "Failed to download. Please try again.")
Sleep(100)
$Size = InetGetInfo($hInet, 0)
$Percentage = Int($Size / $URLSize * 100)
$iSize = $URLSize - $Size
select
case $sLanguage ="Es"
$m2="Descargando..."
ProgressSet($Percentage, $m2, _GetDisplaySize($iSize, $iPlaces = 2) & " restante(s) " & $Percentage & " porciento completado")
case $sLanguage ="Eng"
ProgressSet($Percentage, _GetDisplaySize($iSize, $iPlaces = 2) & " remaining " & $Percentage & " percent completed.")
endselect
If _ispressed($I) Then
select
case $ReadAccs ="yes"
speaking("FileSize in bites:" & $URLSize & ". Downloaded: " & $Size& ". Progress: " & $Percentage & "%. Remaining: " & $iSize)
endselect
endif
WEnd
select
case $sLanguage ="Es"
	ProgressSet(90, "Acabando", "Acabando...")
case $sLanguage ="Eng"
	ProgressSet(90, "ending up", "ending up... Please wait.")
endselect
select
case $sLanguage ="Es"
	ProgressSet(99, "Instalando la actualización.", "MCY Downloader se está instalando.")
case $sLanguage ="Eng"
	ProgressSet(99, "Installing update.", "MCY Downloader is installing.")
endselect
sleep(4000)
$process = ProcessExists("MCY.exe")
If NOT $process = 0 Then
	ProcessClose("MCY.exe")
EndIf
select
case $type ="installable"
runWait("MCY_Setup_package.exe /silent")
case $type ="portable"
runWait("extract.exe")
endselect
sleep(5000)
select
case $type ="installable"
FileDelete("MCY_Setup_Package.exe")
case $type ="portable"
FileDelete("extract.exe")
endselect
$bagground2.stop
run("MCY.exe")
ProgressOff()
exitpersonaliced()
endfunc
func DownloadEMK()
$sLanguage = iniRead ("config\config.st", "General settings", "language", "")
select
case $sLanguage ="Es"
	ProgressOn("Descargando actualización.", "espera...", "0%", 100, 100, 16)
case $sLanguage ="Eng"
	ProgressOn("Downloading update.", "Please wait...", "0%", 100, 100, 16)
endSelect
$iPlaces = 2
$AppUrl = 'https://www.dropbox.com/s/4wsca8huwjcltsg/EMK_extract.exe?dl=1'
$fldr = 'Extract.exe'
$hInet = InetGet($AppUrl, $fldr, 1, 1)
$URLSize = InetGetSize($AppUrl)
While Not InetGetInfo($hInet, 2)
;		MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "Error", "Failed to download. Please try again.")
Sleep(100)
$Size = InetGetInfo($hInet, 0)
$Percentage = Int($Size / $URLSize * 100)
$iSize = $URLSize - $Size
select
case $sLanguage ="Es"
$m2="Descargando..."
ProgressSet($Percentage, $m2, _GetDisplaySize($iSize, $iPlaces = 2) & " restante(s) " & $Percentage & " porciento completado")
case $sLanguage ="Eng"
ProgressSet($Percentage, _GetDisplaySize($iSize, $iPlaces = 2) & " remaining " & $Percentage & " percent completed.")
endselect
If _ispressed($I) Then
speaking("FileSize in bites:" & $URLSize & ". Downloaded: " & $Size& ". Progress: " & $Percentage & "%. Remaining: " & $iSize)
endif
WEnd
select
case $sLanguage ="Es"
	ProgressSet(90, "Acabando", "Acabando...")
case $sLanguage ="Eng"
	ProgressSet(90, "ending up", "ending up... Please wait.")
endselect
select
case $sLanguage ="Es"
	ProgressSet(99, "Instalando la actualización.", "Emulate keys se está instalando.")
case $sLanguage ="Eng"
	ProgressSet(99, "Installing update.", "Emulate keys is installing.")
endselect
sleep(4000)
$process = ProcessExists("EMK.exe")
If NOT $process = 0 Then
	ProcessClose("EMK.exe")
EndIf
runWait("extract.exe")
sleep(3000)
FileDelete("extract.exe")
;run("EMK.exe")
ProgressOff()
exitpersonaliced()
endfunc