#include-once
#include <keyinput.au3>
#include "NVDAControllerClient.au3"
Func Reader_create_menu($description,$options)
	If $description = "" Then Return 0
	If $options = "" Then Return 0
	$selection = 1
	$items = StringSplit($options, ",")
	If @error Then Return 0
	$menu_length = $items[0]
Speaking($description)
	While 1
		$active_window = WinGetProcess("")
		If $active_window = @AutoItPID Then
		Else
			Sleep(10)
			ContinueLoop 
		EndIf
		$menu_key = ""
		$capt = check_key("26", 2)
		If $capt = 1 Then
			$menu_key = "up arrow"
		EndIf
		$capt = check_key("28", 3)
		If $capt = 1 Then
			$menu_key = "down arrow"
		EndIf
		$capt = check_key("0D", 5)
		If $capt = 1 Then
			$menu_key = "enter"
		EndIf
		If $menu_key = "" Then
			Sleep(10)
			ContinueLoop 
		EndIf
		If $menu_key = "enter" Then
			If $selection > 0 Then
				$menu = ""
Speaking("OK")
				Return $selection
			EndIf
		EndIf
		If $menu_key = "up arrow" Then
			$selection = $selection - 1
			If $selection < 1 Then
				$selection = $menu_length
			EndIf
			$file_to_open = $items[$selection]
SoundPlay(@TempDir &"\sounds\soundsdata.dat\bound.mp3",0)
Speaking($file_to_open)
		EndIf
		If $menu_key = "down arrow" Then
			$selection = $selection + 1
			$limit = $menu_length + 1
			If $selection = $limit Then
				$selection = 1
			EndIf
			$file_to_open = $items[$selection]
SoundPlay(@TempDir &"\sounds\soundsdata.dat\bound.mp3",0)
Speaking($file_to_open)
		EndIf
		Sleep(10)
	WEnd
EndFunc