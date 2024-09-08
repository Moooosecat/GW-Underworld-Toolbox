#cs
#################################
#                               #
#     	Underworld TB			#
#  Updated and maintained by:	#
#      Leonidas		     		#
#  Sourced From:   				#
#      	GWA2 Project		  	#
#								#
#################################


##################### Change Log #####################
9/7/24
Updated teleport dialog codes to work. Cleared excess variables from framework.
Fixed UI to be more centered.
Added Auto DB toggle and function
	-Checks where your skills are located for QZ,SQ, and PI. If the build is not using PI, it will not run.
	-Checks to make sure you are in range of dhuum chamber.
	-Will check if dhuum is casting, and then immediately go through DB chain if true.
Added Fuse pull for emo
	-will automatically run to casting range and cast fuse on first M/E or M/A within 4500 range.
	-Only available in UI if primary is an elementalist to prevent accidental clicks and ruining terra runs.



######################################################





-16253.44, 17284.37 = doom standing spot
3085 = dhuums judgement
2346 = dhuum modelid


#ce
#AutoIt3Wrapper_Run_AU3Check=Y
#RequireAdmin
#NoTrayIcon
#include "GWA2_Headers.au3"
#include "GWA2.au3"
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <GuiEdit.au3>
Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)
Opt("MustDeclareVars", True)


#Region Declarations / variables
; ==== Constants ====
; ================== CONFIGURATION ==================
; True or false to load the list of logged in characters or not
Global Const $doLoadLoggedChars = True
; ================ END CONFIGURATION ================

; ==== Bot global variables ====
;~ Global $color2 = 0xB19CD9
Global $color2 = 0
Global $color1 = 0x00FF11
Global $RenderingEnabled = True
Global $BotRunning = False
Global $BotInitialized = False
Global $ChatStuckTimer = TimerInit()
Global $BAG_SLOTS[18] = [0, 20, 5, 10, 10, 20, 41, 12, 20, 20, 20, 20, 20, 20, 20, 20, 20, 9]
Global $DBToggle = False
Global $gPILocation = -1
Global $gSQLocation = -1
Global $gQZLocation = -1
Global $gInfuseHealthLocation = -1

#EndRegion Declarations / variables

#Region GUI
Global Const $mainGui = GUICreate("Underworld Toolbox V1.1", 310, 310, -1, -1, -1, $WS_EX_TOPMOST)
GUISetOnEvent($GUI_EVENT_CLOSE, "Exit2")

Func exit2()
	Exit
EndFunc   ;==>exit2

Global $Input
If $doLoadLoggedChars Then
	$Input = GUICtrlCreateCombo("<Character Name>", 3, 8, 150, 21)
	GUICtrlSetData(-1, GetLoggedCharNames())
Else
	$Input = GUICtrlCreateInput("<Type Character Name>", 3, 8, 150, 21)
EndIf

Global $GLOGBOX = GUICtrlCreateEdit("Created By Leonidas", 3, 220, 307, 35, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
GUICtrlSetColor($GLOGBOX, 0)
GUICtrlSetBkColor($GLOGBOX, 0x00FF22)
GUISetState(@SW_SHOW)

#Region ████████████████████████████████████████████ Buttons ████████████████████████████████████████████

;Description:  Creates text, text field, and button for SubmitDialog()
Global $InputFieldText = GUICtrlCreateLabel("Custom Dialog Input:", 5, 260, 110, 21)
Global $Dialog_Input = GUICtrlCreateInput("0x", 110, 257, 90, 21)
Global $Dialog_Submit = GUICtrlCreateButton("Send:", 205, 257, 50, 21)
GUICtrlSetOnEvent(-1, "SubmitDialog")
Func SubmitDialog()
	Local $inputText = GUICtrlRead($Dialog_Input)
	Out("Submitted Dialog:  " & $inputText)
	Dialog($inputText)
	Sleep(100)
EndFunc   ;==>SubmitDialog

;Description: Initiates GUIButtonHandler to inject bot.
Global Const $Button = GUICtrlCreateButton("Inject", 155, 5, 150, 25)
GUICtrlSetColor($Button, 0)
GUICtrlSetBkColor($Button, 0x00FF11)
GUICtrlSetOnEvent(-1, "GuiButtonHandler")

;Description: All of the buttons to take quests in UW
GUICtrlCreateGroup("_______________Quest Dialogs____________________", 5, 35, 300, 65, $SS_Center)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

Global Const $ChamberQButton = GUICtrlCreateButton("Chamber", 10, 55, 50, 20)
GUICtrlSetOnEvent(-1, "ChamberQButton")
Func ChamberQButton()
	Out("Chamber Quest Take")
	Dialog(0x806501)
	Sleep(100)
EndFunc   ;==>ChamberQButton

Global Const $RestoreButton = GUICtrlCreateButton("Restore", 70, 55, 50, 20)
GUICtrlSetOnEvent(-1, "RestoreButton")
Func RestoreButton()
	Out("Restore Quest Take")
	Dialog(0x806D01)
	Sleep(100)
EndFunc   ;==>RestoreButton

Global Const $EscortButton = GUICtrlCreateButton("Escort", 130, 55, 50, 20)
GUICtrlSetOnEvent(-1, "EscortButton")
Func EscortButton()
	Out("Escort Quest Take")
	Dialog(0x806C01)
	Sleep(100)
EndFunc   ;==>EscortButton

Global Const $UWGButton = GUICtrlCreateButton("UWG", 190, 55, 50, 20)
GUICtrlSetOnEvent(-1, "UWGButton")
Func UWGButton()
	Out("UWG Quest Take")
	Dialog(0x806701)
	Sleep(100)
EndFunc   ;==>UWGButton

Global Const $ValeQButton = GUICtrlCreateButton("ValeQ", 250, 55, 50, 20)
GUICtrlSetOnEvent(-1, "ValeQButton")
Func ValeQButton()
	Out("Vale Quest Take")
	Dialog(0x806E01)
	Sleep(100)
EndFunc   ;==>ValeQButton

Global Const $MtnsQButton = GUICtrlCreateButton("MtnsQ", 10, 75, 50, 20)
GUICtrlSetOnEvent(-1, "MtnsQButton")
Func MtnsQButton()
	Out("Mtns Quest Take")
	Dialog(0x806801)
	Sleep(100)
EndFunc   ;==>MtnsQButton


Global Const $PoolsQButton = GUICtrlCreateButton("PoolsQ", 70, 75, 50, 20)
GUICtrlSetOnEvent(-1, "PoolsQButton")
Func PoolsQButton()
	Out("Pools Quest Take")
	Dialog(0x806B01)
	Sleep(100)
EndFunc   ;==>PoolsQButton

Global Const $PitsQButton = GUICtrlCreateButton("PitsQ", 130, 75, 50, 20)
GUICtrlSetOnEvent(-1, "PitsQButton")
Func PitsQButton()
	Out("Pits Quest Take")
	Dialog(0x806801)
	Sleep(100)
EndFunc   ;==>PitsQButton

Global Const $PlainsQButton = GUICtrlCreateButton("PlainsQ", 190, 75, 50, 20)
GUICtrlSetOnEvent(-1, "PlainsQButton")
Func PlainsQButton()
	Out("Plains Quest Take")
	Dialog(0x806801)
	Sleep(100)
EndFunc   ;==>PlainsQButton

Global Const $WastesQButton = GUICtrlCreateButton("WastesQ", 250, 75, 50, 20)
GUICtrlSetOnEvent(-1, "WastesQButton")
Func WastesQButton()
	Out("Wastes Quest Take")
	Dialog(0x806601)
	Sleep(100)
EndFunc   ;==>WastesQButton

;Description: Dialogs for Teleporting in UW
GUICtrlCreateGroup("_____________Teleport Dialogs____________", 5, 100, 240, 65, $SS_Center)
GUICtrlSetResizing(-1, $GUI_DOCKALL)


Global Const $LabTeleButton = GUICtrlCreateButton("Lab", 10, 120, 50, 20)
GUICtrlSetOnEvent(-1, "LabTeleButton")
Func LabTeleButton()
	Out("Lab Tele")
	Dialog(0x8D)
	Sleep(100)
EndFunc   ;==>LabTeleButton

Global Const $ValeTeleButton = GUICtrlCreateButton("Vale", 10, 140, 50, 20)
GUICtrlSetOnEvent(-1, "ValeTeleButton")
Func ValeTeleButton()
	Out("Vale Tele")
	Dialog(0x91)
	Sleep(100)
EndFunc   ;==>ValeTeleButton

Global Const $MtnTeleButton = GUICtrlCreateButton("Mtns", 70, 120, 50, 20)
GUICtrlSetOnEvent(-1, "MtnTeleButton")
Func MtnTeleButton()
	Out("Mtn Tele")
	Dialog(0x8E)
	Sleep(100)
EndFunc   ;==>MtnTeleButton

Global Const $PoolsTeleButton = GUICtrlCreateButton("Pools", 70, 140, 50, 20)
GUICtrlSetOnEvent(-1, "PoolsTeleButton")
Func PoolsTeleButton()
	Out("Pools Tele")
	Dialog(0x90)
	Sleep(100)
EndFunc   ;==>PoolsTeleButton

Global Const $PitsTeleButton = GUICtrlCreateButton("Pits", 130, 120, 50, 20)
GUICtrlSetOnEvent(-1, "PitsTeleButton")
Func PitsTeleButton()
	Out("Pits Tele")
	Dialog(0x8F)
	Sleep(100)
EndFunc   ;==>PitsTeleButton

Global Const $PlainsTeleButton = GUICtrlCreateButton("Plains", 130, 140, 50, 20)
GUICtrlSetOnEvent(-1, "PlainsTeleButton")
Func PlainsTeleButton()
	Out("Plains Tele")
	Dialog(0x8B)
	Sleep(100)
EndFunc   ;==>PlainsTeleButton

Global Const $WastesTeleButton = GUICtrlCreateButton("Wastes", 190, 120, 50, 20)
GUICtrlSetOnEvent(-1, "WastesTeleButton")
Func WastesTeleButton()
	Out("Wastes Tele")
	Dialog(0x8C)
	Sleep(100)
EndFunc   ;==>WastesTeleButton


#Region ██████████████████████████████████Target Minipets ████████████████████████████████████████
Global Const $MiniButton = GUICtrlCreateButton("EE Mini", 250, 120, 50, 20)
GUICtrlSetOnEvent(-1, "MiniButton")
Func MiniButton()
	GUICtrlSetState($MiniButton, $GUI_DISABLE)
	Out("Target mini")
	Useskill(8, Getagentbymodelid(350))
	Sleep(100)
	GUICtrlSetState($MiniButton, $GUI_ENABLE)
EndFunc   ;==>MiniButton

;~ HotKeySet(",", "HotkeyTargetMini")
Func HotkeyTargetMini()
;~ 	Useskill(8,GetNearestAgentToAgent(-2))
	Useskill(8, Getagentbymodelid(350))
	Sleep(750)
EndFunc   ;==>HotkeyTargetMini

Global Const $FusePull = GUICtrlCreateButton("FusePull", 250, 100, 50, 20)
GUICtrlSetOnEvent(-1, "FusePull")

Func FusePull()
	GUICtrlSetState($FusePull, $GUI_DISABLE)
	Local $PartyArray = getparty()
	Local $primaryProfession, $secondaryProfession
	Local $timeout = 0

	For $i = 1 To UBound($PartyArray) - 1
		$timeout = 0
		Out("Array Value: " & $PartyArray[$i])
		$primaryProfession = DllStructGetData($PartyArray[$i], "Primary")
		$secondaryProfession = DllStructGetData($PartyArray[$i], "Secondary")
		Out($i & "  " & $primaryProfession & "  " & $secondaryProfession)
		If $primaryProfession = 5 And ($secondaryProfession = 7 Or $secondaryProfession = 6) and GetDistance($PartyArray[$i], -2) < 4500 Then
			Out("Moving to Tank")
;~ 			Do
			While GetDistance($PartyArray[$i], -2) > 1300 Or $timeout > 1000
				If GetDistance($PartyArray[$i], -2) > 1300 Then Move(DllStructGetData($PartyArray[$i], "X"), DllStructGetData($PartyArray[$i], "Y"))
				Sleep(5)
				$timeout += 5
			WEnd
			If $timeout > 999 Then Out("Time out")
			CancelAction()
			CancelAction()
			CancelAction()
			CancelAction()
			Sleep(100)
			While GetIsCasting(-2)
				Sleep(100)
			WEnd
			If GetDistance($PartyArray[$i], -2) < 1300 Then Useskill(1, $PartyArray[$i])
			Out("Distance: " & GetDistance($PartyArray[$i], -2))
			$timeout = 0
			GUICtrlSetState($FusePull, $GUI_ENABLE)
			Return True
		EndIf
	Next
	GUICtrlSetState($FusePull, $GUI_ENABLE)
	Return False
EndFunc   ;==>FusePull




#EndRegion ██████████████████████████████████Target Minipets ████████████████████████████████████████
#Region ██████████████████████████████████Hotkey options ████████████████████████████████████████
Global $Hotkey1Text = GUICtrlCreateLabel("Hotkey 1:", 5, 173, 55, 17)
Global $Hotkey1Input = GUICtrlCreateInput("<Assign Key>", 55, 170, 70, 21)
Global Const $Hotkey1_Dropdown = GUICtrlCreateCombo("<SELECT ACTION>", 130, 170, 120, 21, BitOR($CBS_DROPDOWN, $WS_VSCROLL))
GUICtrlSetData(-1, "Q Chamber|Q Restore|Q Escort|Q UWG|Q Vale|Q Mtns|Q Pools|Q Pits|Q Plains|Q Wastes|Tele Lab|Tele Vale|Tele Mtns|Tele Pools|Tele Pits|Tele Plains|Tele Wastes|EE Mini")
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Hotkey1_Submit = GUICtrlCreateButton("Update", 255, 170, 50, 21)
GUICtrlSetOnEvent(-1, "Hotkey1_Submit")

Func Hotkey1_Submit()
	Local $inputValue = GUICtrlRead($Hotkey1Input)
	Local $dropdownValue = GUICtrlRead($Hotkey1_Dropdown)
	If StringLen($inputValue) = 1 And $inputValue <> "" Then
		HotKeySet($inputValue)
		HotKeySet($inputValue, "HotKeyInputCheck1")
		Out("Hotkey 1: " & $inputValue & " -- " & $dropdownValue)
		Sleep(100)
	EndIf
EndFunc   ;==>Hotkey1_Submit

Func HotKeyInputCheck1()
	If $Hotkey1_Dropdown = "<SELECT ACTION>" Or $Hotkey1_Dropdown = "" Then Return False
	Switch GUICtrlRead($Hotkey1_Dropdown)
		Case "Q Chamber"
			ChamberQButton()
		Case "Q Restore"
			RestoreButton()
		Case "Q Escort"
			EscortButton()
		Case "Q UWG"
			UWGButton()
		Case "Q Vale"
			ValeQButton()
		Case "Q Mtns"
			MtnsQButton()
		Case "Q Pools"
			PoolsQButton()
		Case "Q Pits"
			PitsQButton()
		Case "Q Plains"
			PlainsQButton()
		Case "Q Wastes"
			WastesQButton()
		Case "Tele Lab"
			LabTeleButton()
		Case "Tele Vale"
			ValeTeleButton()
		Case "Tele Mtns"
			MtnTeleButton()
		Case "Tele Pools"
			PoolsTeleButton()
		Case "Tele Pits"
			PitsTeleButton()
		Case "Tele Plains"
			PlainsTeleButton()
		Case "Tele Wastes"
			WastesTeleButton()
		Case "EE Mini"
			MiniButton()
	EndSwitch
EndFunc   ;==>HotKeyInputCheck1

Global $Hotkey2Text = GUICtrlCreateLabel("Hotkey 2:", 5, 193, 55, 17)
Global $Hotkey2Input = GUICtrlCreateInput("<Assign Key>", 55, 190, 70, 21)
;~ GUICtrlSetState($Hotkey1Input, $GUI_DISABLE)

Global Const $Hotkey2_Dropdown = GUICtrlCreateCombo("<SELECT ACTION>", 130, 190, 120, 21, BitOR($CBS_DROPDOWN, $WS_VSCROLL))
GUICtrlSetData(-1, "Q Chamber|Q Restore|Q Escort|Q UWG|Q Vale|Q Mtns|Q Pools|Q Pits|Q Plains|Q Wastes|Tele Lab|Tele Vale|Tele Mtns|Tele Pools|Tele Pits|Tele Plains|Tele Wastes|EE Mini")
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Hotkey2_Submit = GUICtrlCreateButton("Update", 255, 190, 50, 21)
GUICtrlSetOnEvent(-1, "Hotkey2_Submit")

Func Hotkey2_Submit()
	Local $inputValue = GUICtrlRead($Hotkey2Input)
	Local $dropdownValue = GUICtrlRead($Hotkey2_Dropdown)

	If StringLen($inputValue) = 1 And $inputValue <> "" Then
		HotKeySet($inputValue)
		HotKeySet($inputValue, "HotKeyInputCheck2")
		Out("Hotkey 2: " & $inputValue & " -- " & $dropdownValue)
		Sleep(100)
	EndIf
EndFunc   ;==>Hotkey2_Submit

Func HotKeyInputCheck2()
	If $Hotkey2_Dropdown = "<SELECT ACTION>" Or $Hotkey2_Dropdown = "" Then Return False
	Switch GUICtrlRead($Hotkey2_Dropdown)
		Case "Q Chamber"
			ChamberQButton()
		Case "Q Restore"
			RestoreButton()
		Case "Q Escort"
			EscortButton()
		Case "Q UWG"
			UWGButton()
		Case "Q Vale"
			ValeQButton()
		Case "Q Mtns"
			MtnsQButton()
		Case "Q Pools"
			PoolsQButton()
		Case "Q Pits"
			PitsQButton()
		Case "Q Plains"
			PlainsQButton()
		Case "Q Wastes"
			WastesQButton()
		Case "Tele Lab"
			LabTeleButton()
		Case "Tele Vale"
			ValeTeleButton()
		Case "Tele Mtns"
			MtnTeleButton()
		Case "Tele Pools"
			PoolsTeleButton()
		Case "Tele Pits"
			PitsTeleButton()
		Case "Tele Plains"
			PlainsTeleButton()
		Case "Tele Wastes"
			WastesTeleButton()
		Case "EE Mini"
			MiniButton()
	EndSwitch
EndFunc   ;==>HotKeyInputCheck2

#EndRegion ██████████████████████████████████Hotkey options ████████████████████████████████████████


#EndRegion ████████████████████████████████████████████ Buttons ████████████████████████████████████████████




Global Const $AutoDBCheckbox = GUICtrlCreateCheckbox("Auto DB", 5, 280, 129, 15)
GUICtrlSetState(-1, $GUI_UNCHECKED)
GUICtrlSetOnEvent(-1, "DhuumBitchToggle")

Func DhuumBitchToggle()
	If $DBToggle = True Then
		$DBToggle = False
		GUICtrlSetState(-1, $GUI_UNCHECKED)
		Out("Dhuum Bitch toggle off")
		Return False
	EndIf
	If $DBToggle = False Then
		$DBToggle = True
		GUICtrlSetState(-1, $GUI_CHECKED)
		Out("Dhuum Bitch toggle on")
		For $i = 1 To 8
			Switch getskillbarskillid($i)
				Case 2418 ;Paininverter
					$gPILocation = $i
					Out("Pain Inverter Skill Slot: " & $gPILocation)
				Case 475 ;QZ
					$gQZLocation = $i
					Out("QZ Skill Slot: " & $gQZLocation)
				Case 456 ;SQ
					$gSQLocation = $i
					Out("SQ Skill Slot: " & $gSQLocation)
			EndSwitch
		Next
	EndIf
EndFunc   ;==>DhuumBitchToggle

Func DhuumBitch()
	If $gPILocation = -1 Then
		Out("You do not have PI Equipped")
		DhuumBitchToggle()
		Return False
	EndIf
	If Checkarea(-16253, 17284, 3500) = False Then
		Out("Not in Dhuum area")
		DhuumBitchToggle()
		Return False
	EndIf
	Local $dhuum = Getagentbymodelid(2346)
	If GetIsCasting($dhuum) = True Then
		Out("Casting PI On dhuum")
		Useskill($gPILocation, $dhuum)
		Sleep(1750)
		If $gSQLocation <> -1 Then
			Useskill($gSQLocation, -2)
			Sleep(200)
		EndIf
		If $gQZLocation <> -1 Then
			Useskill($gQZLocation, -2)
			Sleep(5000)
		EndIf
	EndIf
EndFunc   ;==>DhuumBitch


GUICtrlSetState($ChamberQButton, $GUI_DISABLE)
GUICtrlSetState($RestoreButton, $GUI_DISABLE)
GUICtrlSetState($EscortButton, $GUI_DISABLE)
GUICtrlSetState($UWGButton, $GUI_DISABLE)
GUICtrlSetState($ValeQButton, $GUI_DISABLE)
GUICtrlSetState($MtnsQButton, $GUI_DISABLE)
GUICtrlSetState($PoolsQButton, $GUI_DISABLE)
GUICtrlSetState($PitsQButton, $GUI_DISABLE)
GUICtrlSetState($PlainsQButton, $GUI_DISABLE)
GUICtrlSetState($WastesQButton, $GUI_DISABLE)
GUICtrlSetState($LabTeleButton, $GUI_DISABLE)
GUICtrlSetState($ValeTeleButton, $GUI_DISABLE)
GUICtrlSetState($MtnTeleButton, $GUI_DISABLE)
GUICtrlSetState($PoolsTeleButton, $GUI_DISABLE)
GUICtrlSetState($PitsTeleButton, $GUI_DISABLE)
GUICtrlSetState($PlainsTeleButton, $GUI_DISABLE)
GUICtrlSetState($WastesTeleButton, $GUI_DISABLE)
GUICtrlSetState($MiniButton, $GUI_DISABLE)
GUICtrlSetState($Hotkey1Text, $GUI_DISABLE)
GUICtrlSetState($Hotkey1Input, $GUI_DISABLE)
GUICtrlSetState($Hotkey1_Dropdown, $GUI_DISABLE)
GUICtrlSetState($Hotkey1_Submit, $GUI_DISABLE)
GUICtrlSetState($Hotkey2Text, $GUI_DISABLE)
GUICtrlSetState($Hotkey2Input, $GUI_DISABLE)
GUICtrlSetState($Hotkey2_Dropdown, $GUI_DISABLE)
GUICtrlSetState($Hotkey2_Submit, $GUI_DISABLE)
GUICtrlSetState($InputFieldText, $GUI_DISABLE)
GUICtrlSetState($Dialog_Input, $GUI_DISABLE)
GUICtrlSetState($Dialog_Submit, $GUI_DISABLE)
GUICtrlSetState($FusePull, $GUI_DISABLE)
GUICtrlSetState($AutoDBCheckbox, $GUI_DISABLE)


Func GuiButtonHandler()
	If $BotInitialized Then
		GUICtrlSetData($Button, "Restart Bot To Change Toons")
		$BotRunning = True
	Else
		Out("Initializing")
		Local $CharName = GUICtrlRead($Input)
		If $CharName == "" Then
			If Initialize(ProcessExists("gw.exe")) = False Then
				MsgBox(0, "Error", "Guild Wars is not running.")
				Exit
			EndIf
		Else
			If Initialize($CharName) = False Then
				MsgBox(0, "Error", "Could not find a Guild Wars client with a character named '" & $CharName & "'")
				Exit
			EndIf
		EndIf
		GUICtrlSetState($Input, $GUI_DISABLE)
		GUICtrlSetData($Button, "Restart Bot To Change Toons")
;~ 		Out("basepointer:" & Hex($mBasePointer, 8))
		$BotRunning = True
		$BotInitialized = True
				Global $gPrimary = DllStructGetData(GetAgentbyID(-2), "Primary")
		Global $gSecondary = DllStructGetData(GetAgentbyID(-2), "Secondary")
		Out("--------------------------------------------------------")
		;Change Color of UI to signify initiation
		GUICtrlSetColor($Button, $color1)
		GUICtrlSetBkColor($Button, $color2)
		GUICtrlSetBkColor($GLOGBOX, $color2)
		GUICtrlSetColor($GLOGBOX, $color1)
		GUICtrlSetColor($ChamberQButton, $color1)
		GUICtrlSetBkColor($ChamberQButton, $color2)
		GUICtrlSetColor($RestoreButton, $color1)
		GUICtrlSetBkColor($RestoreButton, $color2)
		GUICtrlSetColor($EscortButton, $color1)
		GUICtrlSetBkColor($EscortButton, $color2)
		GUICtrlSetColor($UWGButton, $color1)
		GUICtrlSetBkColor($UWGButton, $color2)
		GUICtrlSetColor($ValeQButton, $color1)
		GUICtrlSetBkColor($ValeQButton, $color2)
		GUICtrlSetColor($MtnsQButton, $color1)
		GUICtrlSetBkColor($MtnsQButton, $color2)
		GUICtrlSetColor($PoolsQButton, $color1)
		GUICtrlSetBkColor($PoolsQButton, $color2)
		GUICtrlSetColor($PitsQButton, $color1)
		GUICtrlSetBkColor($PitsQButton, $color2)
		GUICtrlSetColor($PlainsQButton, $color1)
		GUICtrlSetBkColor($PlainsQButton, $color2)
		GUICtrlSetColor($WastesQButton, $color1)
		GUICtrlSetBkColor($WastesQButton, $color2)
		GUICtrlSetColor($LabTeleButton, $color1)
		GUICtrlSetBkColor($LabTeleButton, $color2)
		GUICtrlSetColor($ValeTeleButton, $color1)
		GUICtrlSetBkColor($ValeTeleButton, $color2)
		GUICtrlSetColor($MtnTeleButton, $color1)
		GUICtrlSetBkColor($MtnTeleButton, $color2)
		GUICtrlSetColor($PoolsTeleButton, $color1)
		GUICtrlSetBkColor($PoolsTeleButton, $color2)
		GUICtrlSetColor($PitsTeleButton, $color1)
		GUICtrlSetBkColor($PitsTeleButton, $color2)
		GUICtrlSetColor($PlainsTeleButton, $color1)
		GUICtrlSetBkColor($PlainsTeleButton, $color2)
		GUICtrlSetColor($WastesTeleButton, $color1)
		GUICtrlSetBkColor($WastesTeleButton, $color2)
		GUICtrlSetColor($Hotkey1_Submit, $color1)
		GUICtrlSetBkColor($Hotkey1_Submit, $color2)
		GUICtrlSetColor($Hotkey2_Submit, $color1)
		GUICtrlSetBkColor($Hotkey2_Submit, $color2)
		GUICtrlSetColor($Dialog_Input, $color1)
		GUICtrlSetBkColor($Dialog_Input, $color2)
		GUICtrlSetColor($Dialog_Submit, $color1)
		GUICtrlSetBkColor($Dialog_Submit, $color2)
		GUICtrlSetColor($FusePull, 0x00FFFF)
		GUICtrlSetBkColor($FusePull, $color2)
		GUICtrlSetColor($MiniButton, 0xAD03DE)
		GUICtrlSetBkColor($MiniButton, $color2)
		;Enable GUI
				GUICtrlSetState($ChamberQButton, $GUI_ENABLE)
		GUICtrlSetState($RestoreButton, $GUI_ENABLE)
		GUICtrlSetState($EscortButton, $GUI_ENABLE)
		GUICtrlSetState($UWGButton, $GUI_ENABLE)
		GUICtrlSetState($ValeQButton, $GUI_ENABLE)
		GUICtrlSetState($MtnsQButton, $GUI_ENABLE)
		GUICtrlSetState($PoolsQButton, $GUI_ENABLE)
		GUICtrlSetState($PitsQButton, $GUI_ENABLE)
		GUICtrlSetState($PlainsQButton, $GUI_ENABLE)
		GUICtrlSetState($WastesQButton, $GUI_ENABLE)
		GUICtrlSetState($LabTeleButton, $GUI_ENABLE)
		GUICtrlSetState($ValeTeleButton, $GUI_ENABLE)
		GUICtrlSetState($MtnTeleButton, $GUI_ENABLE)
		GUICtrlSetState($PoolsTeleButton, $GUI_ENABLE)
		GUICtrlSetState($PitsTeleButton, $GUI_ENABLE)
		GUICtrlSetState($PlainsTeleButton, $GUI_ENABLE)
		GUICtrlSetState($WastesTeleButton, $GUI_ENABLE)
		GUICtrlSetState($MiniButton, $GUI_ENABLE)
		GUICtrlSetState($Hotkey1Text, $GUI_ENABLE)
		GUICtrlSetState($Hotkey1Input, $GUI_ENABLE)
		GUICtrlSetState($Hotkey1_Dropdown, $GUI_ENABLE)
		GUICtrlSetState($Hotkey1_Submit, $GUI_ENABLE)
		GUICtrlSetState($Hotkey2Text, $GUI_ENABLE)
		GUICtrlSetState($Hotkey2Input, $GUI_ENABLE)
		GUICtrlSetState($Hotkey2_Dropdown, $GUI_ENABLE)
		GUICtrlSetState($Hotkey2_Submit, $GUI_ENABLE)
		GUICtrlSetState($InputFieldText, $GUI_ENABLE)
		GUICtrlSetState($Dialog_Input, $GUI_ENABLE)
		GUICtrlSetState($Dialog_Submit, $GUI_ENABLE)
		GUICtrlSetState($AutoDBCheckbox, $GUI_ENABLE)
		If $gPrimary = 6 Then GUICtrlSetState($FusePull, $GUI_ENABLE)

	EndIf
EndFunc   ;==>GuiButtonHandler

Func GetChecked($GUICtrl)
	Return (GUICtrlRead($GUICtrl) == $GUI_Checked)
EndFunc   ;==>GetChecked

#EndRegion GUI

While Not $BotRunning
	Sleep(100)
WEnd
While 1
	Sleep(100)
	If $DBToggle = True Then
		DhuumBitch()
	EndIf
WEnd

#Region Display/Counting Things
Func DisplayCounts()
	Local $Mobstoppers = GetItemCountInventory(32558)
	Local $CapturedSkeles = GetItemCountInventory(32559)
	Local $Tots = GetItemCountInventory($ITEM_ID_ToT)

	If $Mobstoppers > 0 Then Out("MobStoppers:" & $Mobstoppers)
	If $CapturedSkeles > 0 Then Out("Captured Skeles:" & $CapturedSkeles)
	If $Tots > 0 Then Out("Trick Or Treat Bags:" & $Tots)

EndFunc   ;==>DisplayCounts

#EndRegion Display/Counting Things


;~ Description: Print to console with timestamp
Func Out($TEXT)
	Local $TEXTLEN = StringLen($TEXT)
	Local $CONSOLELEN = _GUICtrlEdit_GetTextLen($GLOGBOX)
	If $TEXTLEN + $CONSOLELEN > 30000 Then GUICtrlSetData($GLOGBOX, StringRight(_GUICtrlEdit_GetText($GLOGBOX), 30000 - $TEXTLEN - 1000))
	_GUICtrlEdit_AppendText($GLOGBOX, @CRLF & "[" & @HOUR & ":" & @MIN & ":" & @SEC & "] " & $TEXT)
	_GUICtrlEdit_Scroll($GLOGBOX, 1)
EndFunc   ;==>Out

