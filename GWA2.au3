#include-once
#RequireAdmin
#include "GWA2_Headers.au3"
#include "Constants.au3"
If @AutoItX64 Then
	MsgBox(16, "Error!", "Please run all bots in 32-bit (x86) mode.")
	Exit
EndIf

#Region Headers

#EndRegion Headers

#Region Declarations
ConsoleWrite($BotName & @CRLF)

If $BotName = "Vaettir" Then
	Global $identifyKitnum = 6
	Global $IdentPrice = 500
	Global $salvageKitnum = 2
	Global $maxIdentyfyKit = 3
	Global $maxSalvageKit = 11
	Global $BAG_SLOT[4] = [20, 10, 15, 15]
	ConsoleWrite("Vaettir merch variables" & @CRLF)


ElseIf $BotName <> "Vaettir" Then
	Global $identifyKitnum = 5
	Global $IdentPrice = 100
	Global $salvageKitnum = 2
	Global $maxIdentyfyKit = 1
	Global $maxSalvageKit = 1
	Global $BAG_SLOT[4] = [20, 5, 15, 15]
	ConsoleWrite("Standard Merch Variables" & @CRLF)
EndIf

;~ Global $MerchTown
;~ Global $Return
;~ Global $skillCost
;~ Global $Bool_M4M = False
;~ Global $Bool_Sell = True
;~ Global $Bool_Salvage = True
;~ Global $Bool_Conches = False
;~ Global $Bool_SageBlade = False
;~ Global $Bool_PickUpArmor = False
;~ Global $Bool_PickUpGolds = True
;~ Global $Bool_StoreGoodies = True
;~ Global $Bool_EventMode = True

Global $ChatStuckTimer = TimerInit()
Global Enum $DIFFICULTY_NORMAL, $DIFFICULTY_HARD
Global Enum $INSTANCETYPE_OUTPOST, $INSTANCETYPE_EXPLORABLE, $INSTANCETYPE_LOADING
Global Enum $RANGE_ADJACENT = 156, $RANGE_NEARBY = 240, $RANGE_AREA = 312, $RANGE_EARSHOT = 1000, $RANGE_SPELLCAST = 1085, $RANGE_SPIRIT = 2500, $RANGE_COMPASS = 5000
Global Enum $RANGE_ADJACENT_2 = 156 ^ 2, $RANGE_NEARBY_2 = 240 ^ 2, $RANGE_AREA_2 = 312 ^ 2, $RANGE_EARSHOT_2 = 1000 ^ 2, $RANGE_SPELLCAST_2 = 1085 ^ 2, $RANGE_SPIRIT_2 = 2500 ^ 2, $RANGE_COMPASS_2 = 5000 ^ 2
Global Enum $PROF_NONE, $PROF_WARRIOR, $PROF_RANGER, $PROF_MONK, $PROF_NECROMANCER, $PROF_MESMER, $PROF_ELEMENTALIST, $PROF_ASSASSIN, $PROF_RITUALIST, $PROF_PARAGON, $PROF_DERVISH
Global $BAG_SLOTS[18] = [0, 20, 5, 10, 10, 20, 41, 12, 20, 20, 20, 20, 20, 20, 20, 20, 20, 9]
;~ General Items
Global $General_Items_Array[6] = [2989, 2991, 2992, 5899, 5900, 22751]  ;merch items that are important: ID kits, salvage kits, lockpicks

Global $intSkillEnergy[8] = [10, 5, 5, 5, 5, 10, 10, 10]
Global $intSkillAdrenaline[8] = [0, 0, 0, 0, 0, 0, 0, 0]
Global $intSkillCastTime[8] = [1250, 1000, 1000, 250, 1250, 1250, 1250, 1250]


;~ Zchest Goodies
Global $Array_Zchest[43] = [1055, 1058, 1060, 1064, 1752, 1065, 1066, 1067, 1768, 1769, 1770, 1771, 1772, 1773, 1870, 1879, 1880, 1881, 1883, 1884, 1885, 1045, 2071, 22193, 31021, 30827, 23242, 29241, 34156, 30627, 30633, 30625, 31173, 30643, 30635, 30639, 30631, 30629, 30637, 30641, 30647, 15528, 2513]

Global $Array_Store_ModelIDs460[147] = [474, 476, 486, 522, 525, 811, 819, 822, 835, 610, 2994, 19185, 22751, 4629, 24630, 4631, 24632, 27033, 27035, 27044, 27046, 27047, 7052, 5123 _
		, 1796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 1805, 910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682 _
		, 6376, 6368, 6369, 21809, 21810, 21813, 29436, 29543, 36683, 4730, 15837, 21490, 22192, 30626, 30630, 30638, 30642, 30646, 30648, 31020, 31141, 31142, 31144, 1172, 15528 _
		, 15479, 19170, 21492, 21812, 22269, 22644, 22752, 28431, 28432, 28436, 1150, 35125, 36681, 3256, 3746, 5594, 5595, 5611, 5853, 5975, 5976, 21233, 22279, 22280, 6370, 21488 _
		, 21489, 22191, 35127, 26784, 28433, 18345, 21491, 28434, 35121, 921, 922, 923, 926, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943 _
		, 944, 945, 946, 948, 949, 951, 952, 953, 954, 956, 6532, 6533]

;~ Stackable Salvage Trophies
Global $Array_Trophies[189] = [423, 424, 434, 435, 436, 439, 440, 441, 442, 443, 444, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 457, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 70, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 482, 483, 484, 485, 486, 487, 488, 489, 490, 492, 493, 494, 495, 496, 497, 498, 499, 500, 502, 503, 504, 505, 506, 508, 510, 511, 513, 514, 518, 519, 520, 522, 523, 525, 526, 532, 604, 809, 810, 811, 813, 814, 815, 816, 817, 818, 819, 820, 822, 824, 825, 826, 827, 829, 833, 835, 836, 838, 841, 842, 843, 844, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 1009, 1577, 1578, 1579, 1580, 1581, 1582, 1583, 1584, 1587, 1588, 1590, 1597, 1598, 1600, 1601, 1603, 1604, 1605, 1609, 1610, 1617, 1619, 1620, 1629, 1668, 1671, 1675, 1681, 1682, 1686, 19183, 19184, 19185, 19187, 19188, 19198, 19199, 24354, 27033, 27034, 27035, 27036, 27037, 27038, 27039, 27040, 27041, 27042, 27043, 27044, 27045, 27046, 27047, 27048, 27049, 27050, 27052, 27053, 27054, 27055, 27057, 27060, 27061, 27062, 27065, 27066, 27067, 27069, 27070, 27071, 27729, 27974]




;~ General Items
Global $General_Items_Array[6] = [2989, 2991, 2992, 5899, 5900, 22751]  ;merch items that are important: ID kits, salvage kits, lockpicks



;~ Zchest Goodies
Global $Array_Zchest[43] = [1055, 1058, 1060, 1064, 1752, 1065, 1066, 1067, 1768, 1769, 1770, 1771, 1772, 1773, 1870, 1879, 1880, 1881, 1883, 1884, 1885, 1045, 2071, 22193, 31021, 30827, 23242, 29241, 34156, 30627, 30633, 30625, 31173, 30643, 30635, 30639, 30631, 30629, 30637, 30641, 30647, 15528, 2513]

Global $Array_Store_ModelIDs460[147] = [474, 476, 486, 522, 525, 811, 819, 822, 835, 610, 2994, 19185, 22751, 4629, 24630, 4631, 24632, 27033, 27035, 27044, 27046, 27047, 7052, 5123 _
		, 1796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 1805, 910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682 _
		, 6376, 6368, 6369, 21809, 21810, 21813, 29436, 29543, 36683, 4730, 15837, 21490, 22192, 30626, 30630, 30638, 30642, 30646, 30648, 31020, 31141, 31142, 31144, 1172, 15528 _
		, 15479, 19170, 21492, 21812, 22269, 22644, 22752, 28431, 28432, 28436, 1150, 35125, 36681, 3256, 3746, 5594, 5595, 5611, 5853, 5975, 5976, 21233, 22279, 22280, 6370, 21488 _
		, 21489, 22191, 35127, 26784, 28433, 18345, 21491, 28434, 35121, 921, 922, 923, 926, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943 _
		, 944, 945, 946, 948, 949, 951, 952, 953, 954, 956, 6532, 6533]

;~ Stackable Salvage Trophies
Global $Array_Trophies[189] = [423, 424, 434, 435, 436, 439, 440, 441, 442, 443, 444, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 457, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 70, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 482, 483, 484, 485, 486, 487, 488, 489, 490, 492, 493, 494, 495, 496, 497, 498, 499, 500, 502, 503, 504, 505, 506, 508, 510, 511, 513, 514, 518, 519, 520, 522, 523, 525, 526, 532, 604, 809, 810, 811, 813, 814, 815, 816, 817, 818, 819, 820, 822, 824, 825, 826, 827, 829, 833, 835, 836, 838, 841, 842, 843, 844, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 1009, 1577, 1578, 1579, 1580, 1581, 1582, 1583, 1584, 1587, 1588, 1590, 1597, 1598, 1600, 1601, 1603, 1604, 1605, 1609, 1610, 1617, 1619, 1620, 1629, 1668, 1671, 1675, 1681, 1682, 1686, 19183, 19184, 19185, 19187, 19188, 19198, 19199, 24354, 27033, 27034, 27035, 27036, 27037, 27038, 27039, 27040, 27041, 27042, 27043, 27044, 27045, 27046, 27047, 27048, 27049, 27050, 27052, 27053, 27054, 27055, 27057, 27060, 27061, 27062, 27065, 27066, 27067, 27069, 27070, 27071, 27729, 27974]


Local $mKernelHandle
Local $mGWProcHandle
Local $mMemory
Local $mLabels[1][2]
Local $mBase = 0x00C50000
Local $mASMString, $mASMSize, $mASMCodeOffset
Local $SecondInject

Local $mGUI = GUICreate('GWA�'), $mSkillActivate, $mSkillCancel, $mSkillComplete, $mChatReceive, $mLoadFinished
Local $mSkillLogStruct = DllStructCreate('dword;dword;dword;float')
Local $mSkillLogStructPtr = DllStructGetPtr($mSkillLogStruct)
Local $mChatLogStruct = DllStructCreate('dword;wchar[256]')
Local $mChatLogStructPtr = DllStructGetPtr($mChatLogStruct)
GUIRegisterMsg(0x501, 'Event')

Local $mQueueCounter, $mQueueSize, $mQueueBase
Local $mGWWindowHandle
Local $mTargetLogBase
Local $mStringLogBase
Local $mSkillBase
Local $mEnsureEnglish
Local $mMyID, $mCurrentTarget
Local $mAgentBase
Local $mBasePointer
Local $mRegion, $mLanguage
Local $mPing
Local $mCharname
Local $mMapID
Local $mMaxAgents
Local $mMapLoading
Local $mMapIsLoaded
Local $mLoggedIn
Local $mStringHandlerPtr
Local $mWriteChatSender
Local $mTraderQuoteID, $mTraderCostID, $mTraderCostValue
Local $mSkillTimer
Local $mBuildNumber
Local $mZoomStill, $mZoomMoving
Local $mDisableRendering
Local $mAgentCopyCount
Local $mAgentCopyBase
Local $mCurrentStatus
Local $mLastDialogID
Local $mAgentNameLogBase

Local $mUseStringLog
Local $mUseEventSystem
#EndRegion Declarations


#Region Weapon Detect Functions
Func IsPerfectShield($aItem)
	Local $ModStruct = GetModStruct($aItem)
	; Universal mods
	Local $Plus30 = StringInStr($ModStruct, "1E4823", 0, 1) ; Mod struct for +30 (shield only?)
	Local $Minus3Hex = StringInStr($ModStruct, "3009820", 0, 1) ; Mod struct for -3wHex (shield only?)
	Local $Minus2Stance = StringInStr($ModStruct, "200A820", 0, 1) ; Mod Struct for -2Stance
	Local $Minus2Ench = StringInStr($ModStruct, "2008820", 0, 1) ; Mod struct for -2Ench
	Local $Plus45Stance = StringInStr($ModStruct, "02D8823", 0, 1) ; For +45Stance
	Local $Plus45Ench = StringInStr($ModStruct, "02D6823", 0, 1) ; Mod struct for +45ench
	Local $Plus44Ench = StringInStr($ModStruct, "02C6823", 0, 1) ; For +44/+10Demons
	Local $Minus520 = StringInStr($ModStruct, "5147820", 0, 1) ; For -5(20%)
	; +1 20% Mods ~ Updated 08/10/2018 - FINISHED
	Local $PlusIllusion = StringInStr($ModStruct, "0118240", 0, 1) ; +1 Illu 20%
	Local $PlusDomination = StringInStr($ModStruct, "0218240", 0, 1) ; +1 Dom 20%
	Local $PlusInspiration = StringInStr($ModStruct, "0318240", 0, 1) ; +1 Insp 20%
	Local $PlusBlood = StringInStr($ModStruct, "0418240", 0, 1) ; +1 Blood 20%
	Local $PlusDeath = StringInStr($ModStruct, "0518240", 0, 1) ; +1 Death 20%
	Local $PlusSoulReap = StringInStr($ModStruct, "0618240", 0, 1) ; +1 SoulR 20%
	Local $PlusCurses = StringInStr($ModStruct, "0718240", 0, 1) ; +1 Curses 20%
	Local $PlusAir = StringInStr($ModStruct, "0818240", 0, 1) ; +1 Air 20%
	Local $PlusEarth = StringInStr($ModStruct, "0918240", 0, 1) ; +1 Earth 20%
	Local $PlusFire = StringInStr($ModStruct, "0A18240", 0, 1) ; +1 Fire 20%
	Local $PlusWater = StringInStr($ModStruct, "0B18240", 0, 1) ; +1 Water 20%
	Local $PlusHealing = StringInStr($ModStruct, "0D18240", 0, 1) ; +1 Heal 20%
	Local $PlusSmite = StringInStr($ModStruct, "0E18240", 0, 1) ; +1 Smite 20%
	Local $PlusProt = StringInStr($ModStruct, "0F18240", 0, 1) ; +1 Prot 20%
	Local $PlusDivine = StringInStr($ModStruct, "1018240", 0, 1) ; +1 Divine 20%
	; +10vsMonster Mods
	Local $PlusDemons = StringInStr($ModStruct, "A0848210", 0, 1) ; +10vs Demons
	Local $PlusDragons = StringInStr($ModStruct, "A0948210", 0, 1) ; +10vs Dragons
	Local $PlusPlants = StringInStr($ModStruct, "A0348210", 0, 1) ; +10vs Plants
	Local $PlusUndead = StringInStr($ModStruct, "A0048210", 0, 1) ; +10vs Undead
	Local $PlusTengu = StringInStr($ModStruct, "A0748210", 0, 1) ; +10vs Tengu
	; New +10vsMonster Mods 07/10/2018 - Thanks to Savsuds
	Local $PlusCharr = StringInStr($ModStruct, "0A014821", 0, 1) ; +10vs Charr
	Local $PlusTrolls = StringInStr($ModStruct, "0A024821", 0, 1) ; +10vs Trolls
	Local $PlusSkeletons = StringInStr($ModStruct, "0A044821", 0, 1) ; +10vs Skeletons
	Local $PlusGiants = StringInStr($ModStruct, "0A054821", 0, 1) ; +10vs Giants
	Local $PlusDwarves = StringInStr($ModStruct, "0A064821", 0, 1) ; +10vs Dwarves
	$PlusDragons = StringInStr($ModStruct, "0A094821", 0, 1) ; +10vs Dragons
	Local $PlusOgres = StringInStr($ModStruct, "0A0A4821", 0, 1) ; +10vs Ogres
	; +10vs Dmg
	Local $PlusPiercing = StringInStr($ModStruct, "A0118210", 0, 1) ; +10vs Piercing
	Local $PlusLightning = StringInStr($ModStruct, "A0418210", 0, 1) ; +10vs Lightning
	Local $PlusVsEarth = StringInStr($ModStruct, "A0B18210", 0, 1) ; +10vs Earth
	Local $PlusCold = StringInStr($ModStruct, "A0318210", 0, 1) ; +10 vs Cold
	Local $PlusSlashing = StringInStr($ModStruct, "A0218210", 0, 1) ; +10vs Slashing
	Local $PlusVsFire = StringInStr($ModStruct, "A0518210", 0, 1) ; +10vs Fire
	; New +10vs Dmg 08/10/2018
	Local $PlusBlunt = StringInStr($ModStruct, "A0018210", 0, 1) ; +10vs Blunt

	If $Plus30 > 0 Then
		If $PlusDemons > 0 Or $PlusPiercing > 0 Or $PlusDragons > 0 Or $PlusLightning > 0 Or $PlusVsEarth > 0 Or $PlusPlants > 0 Or $PlusCold > 0 Or $PlusUndead > 0 Or $PlusSlashing > 0 Or $PlusTengu > 0 Or $PlusVsFire > 0 Then
			Return True
		ElseIf $PlusCharr > 0 Or $PlusTrolls > 0 Or $PlusSkeletons > 0 Or $PlusGiants > 0 Or $PlusDwarves > 0 Or $PlusDragons > 0 Or $PlusOgres > 0 Or $PlusBlunt > 0 Then
			Return True
		ElseIf $PlusDomination > 0 Or $PlusDivine > 0 Or $PlusSmite > 0 Or $PlusHealing > 0 Or $PlusProt > 0 Or $PlusFire > 0 Or $PlusWater > 0 Or $PlusAir > 0 Or $PlusEarth > 0 Or $PlusDeath > 0 Or $PlusBlood > 0 Or $PlusIllusion > 0 Or $PlusInspiration > 0 Or $PlusSoulReap > 0 Or $PlusCurses > 0 Then
			Return True
		ElseIf $Minus2Stance > 0 Or $Minus2Ench > 0 Or $Minus520 > 0 Or $Minus3Hex > 0 Then
			Return True
		Else
			Return False
		EndIf
	EndIf
	If $Plus45Ench > 0 Then
		If $PlusDemons > 0 Or $PlusPiercing > 0 Or $PlusDragons > 0 Or $PlusLightning > 0 Or $PlusVsEarth > 0 Or $PlusPlants > 0 Or $PlusCold > 0 Or $PlusUndead > 0 Or $PlusSlashing > 0 Or $PlusTengu > 0 Or $PlusVsFire > 0 Then
			Return True
		ElseIf $PlusCharr > 0 Or $PlusTrolls > 0 Or $PlusSkeletons > 0 Or $PlusGiants > 0 Or $PlusDwarves > 0 Or $PlusDragons > 0 Or $PlusOgres > 0 Or $PlusBlunt > 0 Then
			Return True
		ElseIf $Minus2Ench > 0 Then
			Return True
		ElseIf $PlusDomination > 0 Or $PlusDivine > 0 Or $PlusSmite > 0 Or $PlusHealing > 0 Or $PlusProt > 0 Or $PlusFire > 0 Or $PlusWater > 0 Or $PlusAir > 0 Or $PlusEarth > 0 Or $PlusDeath > 0 Or $PlusBlood > 0 Or $PlusIllusion > 0 Or $PlusInspiration > 0 Or $PlusSoulReap > 0 Or $PlusCurses > 0 Then
			Return True
		Else
			Return False
		EndIf
	EndIf
	If $Minus2Ench > 0 Then
		If $PlusDemons > 0 Or $PlusPiercing > 0 Or $PlusDragons > 0 Or $PlusLightning > 0 Or $PlusVsEarth > 0 Or $PlusPlants > 0 Or $PlusCold > 0 Or $PlusUndead > 0 Or $PlusSlashing > 0 Or $PlusTengu > 0 Or $PlusVsFire > 0 Then
			Return True
		ElseIf $PlusCharr > 0 Or $PlusTrolls > 0 Or $PlusSkeletons > 0 Or $PlusGiants > 0 Or $PlusDwarves > 0 Or $PlusDragons > 0 Or $PlusOgres > 0 Or $PlusBlunt > 0 Then
			Return True
		EndIf
	EndIf
	If $Plus44Ench > 0 Then
		If $PlusDemons > 0 Then
			Return True
		EndIf
	EndIf
	If $Plus45Stance > 0 Then
		If $Minus2Stance > 0 Then
			Return True
		EndIf
	EndIf
	Return False
EndFunc   ;==>IsPerfectShield
Func IsPerfectStaff($aItem)
	Local $ModStruct = GetModStruct($aItem)
	Local $A = GetItemAttribute($aItem)
	; Ele mods
	Local $Fire20Casting = StringInStr($ModStruct, "0A141822", 0, 1) ; Mod struct for 20% fire
	Local $Water20Casting = StringInStr($ModStruct, "0B141822", 0, 1) ; Mod struct for 20% water
	Local $Air20Casting = StringInStr($ModStruct, "08141822", 0, 1) ; Mod struct for 20% air
	Local $Earth20Casting = StringInStr($ModStruct, "09141822", 0, 1) ; Mod Struct for 20% Earth
	;Local $Energy20Casting = StringInStr($ModStruct, "0C141822", 0, 1) ; Mod Struct for 20% Energy Storage (Doesnt drop)
	; Monk mods
	Local $Smite20Casting = StringInStr($ModStruct, "0E141822", 0, 1) ; Mod struct for 20% smite
	Local $Divine20Casting = StringInStr($ModStruct, "10141822", 0, 1) ; Mod struct for 20% divine
	Local $Healing20Casting = StringInStr($ModStruct, "0D141822", 0, 1) ; Mod struct for 20% healing
	Local $Protection20Casting = StringInStr($ModStruct, "0F141822", 0, 1) ; Mod struct for 20% protection
	; Rit mods
	Local $Channeling20Casting = StringInStr($ModStruct, "22141822", 0, 1) ; Mod struct for 20% channeling
	Local $Restoration20Casting = StringInStr($ModStruct, "21141822", 0, 1) ; Mod Struct for 20% Restoration
	Local $Communing20Casting = StringInStr($ModStruct, "20141822", 0, 1) ; Mod Struct for 20% Communing
	Local $Spawning20Casting = StringInStr($ModStruct, "24141822", 0, 1) ; Mod Struct for 20% Spawning (Unconfirmed)
	; Mes mods
	Local $Illusion20Casting = StringInStr($ModStruct, "01141822", 0, 1) ; Mod struct for 20% Illusion
	Local $Domination20Casting = StringInStr($ModStruct, "02141822", 0, 1) ; Mod struct for 20% domination
	Local $Inspiration20Casting = StringInStr($ModStruct, "03141822", 0, 1) ; Mod struct for 20% Inspiration
	; Necro mods
	Local $Death20Casting = StringInStr($ModStruct, "05141822", 0, 1) ; Mod struct for 20% death
	Local $Blood20Casting = StringInStr($ModStruct, "04141822", 0, 1) ; Mod Struct for 20% Blood
	Local $SoulReap20Casting = StringInStr($ModStruct, "06141822", 0, 1) ; Mod Struct for 20% Soul Reap (Doesnt drop)
	Local $Curses20Casting = StringInStr($ModStruct, "07141822", 0, 1) ; Mod Struct for 20% Curses

	Switch $A
		Case 1 ; Illusion
			If $Illusion20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 2 ; Domination
			If $Domination20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 3 ; Inspiration - Doesnt Drop
			If $Inspiration20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 4 ; Blood
			If $Blood20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 5 ; Death
			If $Death20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 6 ; SoulReap - Doesnt Drop
			If $SoulReap20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 7 ; Curses
			If $Curses20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 8 ; Air
			If $Air20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 9 ; Earth
			If $Earth20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 10 ; Fire
			If $Fire20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 11 ; Water
			If $Water20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 12 ; Energy Storage
			If $Air20Casting > 0 Or $Earth20Casting > 0 Or $Fire20Casting > 0 Or $Water20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 13 ; Healing
			If $Healing20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 14 ; Smiting
			If $Smite20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 15 ; Protection
			If $Protection20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 16 ; Divine
			If $Healing20Casting > 0 Or $Protection20Casting > 0 Or $Divine20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 32 ; Communing
			If $Communing20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 33 ; Restoration
			If $Restoration20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 34 ; Channeling
			If $Channeling20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
		Case 36 ; Spawning - Unconfirmed
			If $Spawning20Casting > 0 Then
				Return True
			Else
				Return False
			EndIf
	EndSwitch
	Return False
EndFunc   ;==>IsPerfectStaff

Func IsPerfectCaster($aItem)
	Local $ModStruct = GetModStruct($aItem)
	Local $A = GetItemAttribute($aItem)
	; Universal mods
	Local $PlusFive = StringInStr($ModStruct, "5320823", 0, 1) ; Mod struct for +5^50
	Local $PlusFiveEnch = StringInStr($ModStruct, "500F822", 0, 1)
	Local $10Cast = StringInStr($ModStruct, "A0822", 0, 1) ; Mod struct for 10% cast
	Local $10Recharge = StringInStr($ModStruct, "AA823", 0, 1) ; Mod struct for 10% recharge
	; Ele mods
	Local $Fire20Casting = StringInStr($ModStruct, "0A141822", 0, 1) ; Mod struct for 20% fire
	Local $Fire20Recharge = StringInStr($ModStruct, "0A149823", 0, 1)
	Local $Water20Casting = StringInStr($ModStruct, "0B141822", 0, 1) ; Mod struct for 20% water
	Local $Water20Recharge = StringInStr($ModStruct, "0B149823", 0, 1)
	Local $Air20Casting = StringInStr($ModStruct, "08141822", 0, 1) ; Mod struct for 20% air
	Local $Air20Recharge = StringInStr($ModStruct, "08149823", 0, 1)
	Local $Earth20Casting = StringInStr($ModStruct, "09141822", 0, 1)
	Local $Earth20Recharge = StringInStr($ModStruct, "09149823", 0, 1)
	Local $Energy20Casting = StringInStr($ModStruct, "0C141822", 0, 1)
	Local $Energy20Recharge = StringInStr($ModStruct, "0C149823", 0, 1)
	; Monk mods
	Local $Smiting20Casting = StringInStr($ModStruct, "0E141822", 0, 1) ; Mod struct for 20% smite
	Local $Smiting20Recharge = StringInStr($ModStruct, "0E149823", 0, 1)
	Local $Divine20Casting = StringInStr($ModStruct, "10141822", 0, 1) ; Mod struct for 20% divine
	Local $Divine20Recharge = StringInStr($ModStruct, "10149823", 0, 1)
	Local $Healing20Casting = StringInStr($ModStruct, "0D141822", 0, 1) ; Mod struct for 20% healing
	Local $Healing20Recharge = StringInStr($ModStruct, "0D149823", 0, 1)
	Local $Protection20Casting = StringInStr($ModStruct, "0F141822", 0, 1) ; Mod struct for 20% protection
	Local $Protection20Recharge = StringInStr($ModStruct, "0F149823", 0, 1)
	; Rit mods
	Local $Channeling20Casting = StringInStr($ModStruct, "22141822", 0, 1) ; Mod struct for 20% channeling
	Local $Channeling20Recharge = StringInStr($ModStruct, "22149823", 0, 1)
	Local $Restoration20Casting = StringInStr($ModStruct, "21141822", 0, 1)
	Local $Restoration20Recharge = StringInStr($ModStruct, "21149823", 0, 1)
	Local $Communing20Casting = StringInStr($ModStruct, "20141822", 0, 1)
	Local $Communing20Recharge = StringInStr($ModStruct, "20149823", 0, 1)
	Local $Spawning20Casting = StringInStr($ModStruct, "24141822", 0, 1) ; Spawning - Unconfirmed
	Local $Spawning20Recharge = StringInStr($ModStruct, "24149823", 0, 1) ; Spawning - Unconfirmed
	; Mes mods
	Local $Illusion20Recharge = StringInStr($ModStruct, "01149823", 0, 1)
	Local $Illusion20Casting = StringInStr($ModStruct, "01141822", 0, 1)
	Local $Domination20Casting = StringInStr($ModStruct, "02141822", 0, 1) ; Mod struct for 20% domination
	Local $Domination20Recharge = StringInStr($ModStruct, "02149823", 0, 1) ; Mod struct for 20% domination recharge
	Local $Inspiration20Recharge = StringInStr($ModStruct, "03149823", 0, 1)
	Local $Inspiration20Casting = StringInStr($ModStruct, "03141822", 0, 1)
	; Necro mods
	Local $Death20Casting = StringInStr($ModStruct, "05141822", 0, 1) ; Mod struct for 20% death
	Local $Death20Recharge = StringInStr($ModStruct, "05149823", 0, 1)
	Local $Blood20Recharge = StringInStr($ModStruct, "04149823", 0, 1)
	Local $Blood20Casting = StringInStr($ModStruct, "04141822", 0, 1)
	Local $SoulReap20Recharge = StringInStr($ModStruct, "06149823", 0, 1)
	Local $SoulReap20Casting = StringInStr($ModStruct, "06141822", 0, 1)
	Local $Curses20Recharge = StringInStr($ModStruct, "07149823", 0, 1)
	Local $Curses20Casting = StringInStr($ModStruct, "07141822", 0, 1)

	Switch $A
		Case 1 ; Illusion
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Illusion20Casting > 0 Or $Illusion20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Illusion20Recharge > 0 Or $Illusion20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Illusion20Recharge > 0 Then
				If $Illusion20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 2 ; Domination
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Domination20Casting > 0 Or $Domination20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Domination20Recharge > 0 Or $Domination20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Domination20Recharge > 0 Then
				If $Domination20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 3 ; Inspiration
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Inspiration20Casting > 0 Or $Inspiration20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Inspiration20Recharge > 0 Or $Inspiration20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Inspiration20Recharge > 0 Then
				If $Inspiration20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 4 ; Blood
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Blood20Casting > 0 Or $Blood20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Blood20Recharge > 0 Or $Blood20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Blood20Recharge > 0 Then
				If $Blood20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 5 ; Death
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Death20Casting > 0 Or $Death20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Death20Recharge > 0 Or $Death20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Death20Recharge > 0 Then
				If $Death20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 6 ; SoulReap - Doesnt drop?
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $SoulReap20Casting > 0 Or $SoulReap20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $SoulReap20Recharge > 0 Or $SoulReap20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $SoulReap20Recharge > 0 Then
				If $SoulReap20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 7 ; Curses
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Curses20Casting > 0 Or $Curses20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Curses20Recharge > 0 Or $Curses20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Curses20Recharge > 0 Then
				If $Curses20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 8 ; Air
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Air20Casting > 0 Or $Air20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Air20Recharge > 0 Or $Air20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Air20Recharge > 0 Then
				If $Air20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 9 ; Earth
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Earth20Casting > 0 Or $Earth20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Earth20Recharge > 0 Or $Earth20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Earth20Recharge > 0 Then
				If $Earth20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 10 ; Fire
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Fire20Casting > 0 Or $Fire20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Fire20Recharge > 0 Or $Fire20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Fire20Recharge > 0 Then
				If $Fire20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 11 ; Water
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Water20Casting > 0 Or $Water20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Water20Recharge > 0 Or $Water20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Water20Recharge > 0 Then
				If $Water20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 12 ; Energy Storage
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Energy20Casting > 0 Or $Energy20Recharge > 0 Or $Water20Casting > 0 Or $Water20Recharge > 0 Or $Fire20Casting > 0 Or $Fire20Recharge > 0 Or $Earth20Casting > 0 Or $Earth20Recharge > 0 Or $Air20Casting > 0 Or $Air20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Energy20Recharge > 0 Or $Energy20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Or $Water20Casting > 0 Or $Water20Recharge > 0 Or $Fire20Casting > 0 Or $Fire20Recharge > 0 Or $Earth20Casting > 0 Or $Earth20Recharge > 0 Or $Air20Casting > 0 Or $Air20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Energy20Recharge > 0 Then
				If $Energy20Casting > 0 Then
					Return True
				EndIf
			EndIf
			If $10Cast > 0 Or $10Recharge > 0 Then
				If $Water20Casting > 0 Or $Water20Recharge > 0 Or $Fire20Casting > 0 Or $Fire20Recharge > 0 Or $Earth20Casting > 0 Or $Earth20Recharge > 0 Or $Air20Casting > 0 Or $Air20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 13 ; Healing
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Healing20Casting > 0 Or $Healing20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Healing20Recharge > 0 Or $Healing20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Healing20Recharge > 0 Then
				If $Healing20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 14 ; Smiting
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Smiting20Recharge > 0 Or $Smiting20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Smiting20Recharge > 0 Then
				If $Smiting20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 15 ; Protection
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Protection20Recharge > 0 Or $Protection20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Protection20Recharge > 0 Then
				If $Protection20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 16 ; Divine
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Divine20Casting > 0 Or $Divine20Recharge > 0 Or $Healing20Casting > 0 Or $Healing20Recharge > 0 Or $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Or $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Divine20Recharge > 0 Or $Divine20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Or $Healing20Casting > 0 Or $Healing20Recharge > 0 Or $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Or $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Divine20Recharge > 0 Then
				If $Divine20Casting > 0 Then
					Return True
				EndIf
			EndIf
			If $10Cast > 0 Or $10Recharge > 0 Then
				If $Healing20Casting > 0 Or $Healing20Recharge > 0 Or $Smiting20Casting > 0 Or $Smiting20Recharge > 0 Or $Protection20Casting > 0 Or $Protection20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 32 ; Communing
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Communing20Casting > 0 Or $Communing20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Communing20Recharge > 0 Or $Communing20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Communing20Recharge > 0 Then
				If $Communing20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 33 ; Restoration
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Restoration20Casting > 0 Or $Restoration20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Restoration20Recharge > 0 Or $Restoration20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Restoration20Recharge > 0 Then
				If $Restoration20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 34 ; Channeling
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Channeling20Casting > 0 Or $Channeling20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Channeling20Recharge > 0 Or $Channeling20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Channeling20Recharge > 0 Then
				If $Channeling20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
		Case 36 ; Spawning - Unconfirmed
			If $PlusFive > 0 Or $PlusFiveEnch > 0 Then
				If $Spawning20Casting > 0 Or $Spawning20Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Spawning20Recharge > 0 Or $Spawning20Casting > 0 Then
				If $10Cast > 0 Or $10Recharge > 0 Then
					Return True
				EndIf
			EndIf
			If $Spawning20Recharge > 0 Then
				If $Spawning20Casting > 0 Then
					Return True
				EndIf
			EndIf
			Return False
	EndSwitch
	Return False
EndFunc   ;==>IsPerfectCaster
Func IsRareRune($aItem)
	Local $ModStruct = GetModStruct($aItem)
	Local $SupVigor = StringInStr($ModStruct, "C202EA27", 0, 1) ; Mod struct for Sup vigor rune 55
	Local $MajorVigor = StringInStr($ModStruct, "C202E927", 0, 1)
	Local $MinorVigor = StringInStr($ModStruct, "C202E827", 0, 1)
	Local $Vitae = StringInStr($ModStruct, "000A4823", 0, 1)
	Local $Attunement = StringInStr($ModStruct, "0200D822", 0, 1)
;~ 	Local $Clarity = StringInStr($ModStruct, "01087827", 0, 1)
	Local $MinorInspiration = StringInStr($ModStruct, "0103E821", 0, 1)
	Local $SupDom = StringInStr($ModStruct, "30250302E821770", 0, 1) ; Superior Domination 22
	Local $Supfast = StringInStr($ModStruct, "E821770130254B00D82", 0, 1) ; Superior fastcast
	Local $Prodigy = StringInStr($ModStruct, "C60330A5000528A7", 0, 1) ; Prodigy insig 13
	;Local $MinorProt = StringInStr($ModStruct, "010FE821", 0, 1)
;~ 	Local $Minordivine = StringInStr($ModStruct, "0110E821", 0, 1)
;~ 	Local $MajorSoul = StringInStr($ModStruct, "0206E8216D01", 0, 1)
	Local $WindWalker = StringInStr($ModStruct, "040430A5060518A7", 0, 1) ; Windwalker insig 8.5
	Local $MinorMyst = StringInStr($ModStruct, "05033025012CE821", 0, 1) ; Minor Mysticism 2
	;Local $Minortactics  = StringInStr($ModStruct, "B3000824670130250115E821", 0, 1)
	;Local $Sentinels  = StringInStr($ModStruct, "F60330A5140028A1", 0, 1)
	Local $Str = StringInStr($ModStruct, "0111E821", 0, 1)
	;Local $MinorCrit = StringInStr($ModStruct, "0123E821", 0, 1)
	Local $MinorScythe = StringInStr($ModStruct, "0129E821", 0, 1)
;~ 	Local $Centurion = StringInStr($ModStruct, "07020824", 0, 1)

	;Local $SupEarthPrayers = StringInStr($ModStruct, "32BE82109033025", 0, 1) ; Sup earth prayers
	Local $Shamans = StringInStr($ModStruct, "080430A50005F8A", 0, 1) ; Shamans insig 9.5
	Local $MinorSpawning = StringInStr($ModStruct, "0124E821", 0, 1) ; Minor Spawning 4.8
;~ 	Local $MinorEnergyStorage = StringInStr($ModStruct, "010CE821", 0, 1) ; Minor Energy Storage .8
	Local $MinorFastCasting = StringInStr($ModStruct, "0100E821", 0, 1) ; Minor Fast Casting 2.9
	;Local $MinorIllusion = StringInStr($ModStruct, "0101E821", 0, 1) ; Minor Illusion
;~ 	Local $MinorSoulReap = StringInStr($ModStruct, "0106E821", 0, 1) ; Minor SoulReaping 2.5
	;Local $Tormentor = StringInStr($ModStruct, "D80330A5000AF8A", 0, 1)
	Local $Blessed = StringInStr($ModStruct, "D20330A5000AF8A", 0, 1)
	;Local $MajorSoul = StringInStr($ModStruct, "0206E821", 0, 1)
	Local $Minorfast = StringInStr($ModStruct, "0100E821", 0, 1)
	Local $MajorFastCasting = StringInStr($ModStruct, "0200E821", 0, 1)
	;Local $MajorDominationMagic = StringInStr($ModStruct, "0202E821", 0, 1)
	Local $Nightstalker = StringInStr($ModStruct, "E1010824", 0, 1)

	If $SupVigor > 0 Or $WindWalker > 0 Or $MinorMyst > 0 Or $MinorInspiration > 0 Or $MajorFastCasting > 0 Or $Minorfast > 0 Or $Prodigy > 0 Or $SupDom > 0 Or $Supfast > 0 Or $MinorVigor > 0 Or $MajorVigor > 0 Or $Vitae > 0 Or $Attunement  > 0 Or $MinorSpawning > 0 Or $Str > 0 Or $MinorScythe > 0 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>IsRareRune



Func GetItemMaxReq8($aItem)
	Local $Type = DllStructGetData($aItem, "Type")
	Local $Dmg = GetItemMaxDmg($aItem)
	Local $Req = GetItemReq($aItem)

	Switch $Type
		Case 12 ;~ Offhand
			If $Dmg == 12 And $Req == 8 Then
				Return True
			Else
				Return False
			EndIf
		Case 24 ;~ Shield
			If $Dmg == 16 And $Req == 8 Then
				Return True
			Else
				Return False
			EndIf
		Case 27 ;~ Sword
			If $Dmg == 22 And $Req == 8 Then
				Return True
			Else
				Return False
			EndIf
	EndSwitch
EndFunc   ;==>GetItemMaxReq8
Func GetItemMaxReq7($aItem)
	Local $Type = DllStructGetData($aItem, "Type")
	Local $Dmg = GetItemMaxDmg($aItem)
	Local $Req = GetItemReq($aItem)

	Switch $Type
		Case 12 ;~ Offhand
			If $Dmg == 11 And $Req == 7 Then
				Return True
			Else
				Return False
			EndIf
		Case 24 ;~ Shield
			If $Dmg == 15 And $Req == 7 Then
				Return True
			Else
				Return False
			EndIf
		Case 27 ;~ Sword
			If $Dmg == 21 And $Req == 7 Then
				Return True
			Else
				Return False
			EndIf
	EndSwitch
EndFunc   ;==>GetItemMaxReq7
Func IsReq8Max($aItem)
	Local $Type = DllStructGetData($aItem, "Type")
	Local $Rarity = GetRarity($aItem)
	Local $MaxDmgOffHand = GetItemMaxReq8($aItem)
	Local $MaxDmgShield = GetItemMaxReq8($aItem)
	Local $MaxDmgSword = GetItemMaxReq8($aItem)

	Switch $Rarity
		Case 2624 ;~ Gold
			Switch $Type
				Case 12 ;~ Offhand
					If $MaxDmgOffHand = True Then
						Return True
					Else
						Return False
					EndIf
				Case 24 ;~ Shield
					If $MaxDmgShield = True Then
						Return True
					Else
						Return False
					EndIf
				Case 27 ;~ Sword
					If $MaxDmgSword = True Then
						Return True
					Else
						Return False
					EndIf
			EndSwitch
		Case 2623 ;~ Purple?
			Switch $Type
				Case 12 ;~ Offhand
					If $MaxDmgOffHand = True Then
						Return True
					Else
						Return False
					EndIf
				Case 24 ;~ Shield
					If $MaxDmgShield = True Then
						Return True
					Else
						Return False
					EndIf
				Case 27 ;~ Sword
					If $MaxDmgSword = True Then
						Return True
					Else
						Return False
					EndIf
			EndSwitch
		Case 2626 ;~ Blue?
			Switch $Type
				Case 12 ;~ Offhand
					If $MaxDmgOffHand = True Then
						Return True
					Else
						Return False
					EndIf
				Case 24 ;~ Shield
					If $MaxDmgShield = True Then
						Return True
					Else
						Return False
					EndIf
				Case 27 ;~ Sword
					If $MaxDmgSword = True Then
						Return True
					Else
						Return False
					EndIf
			EndSwitch
	EndSwitch
	Return False
EndFunc   ;==>IsReq8Max
Func IsReq7Max($aItem)
	Local $Type = DllStructGetData($aItem, "Type")
	Local $Rarity = GetRarity($aItem)
	Local $MaxDmgOffHand = GetItemMaxReq7($aItem)
	Local $MaxDmgShield = GetItemMaxReq7($aItem)
	Local $MaxDmgSword = GetItemMaxReq7($aItem)

	Switch $Rarity
		Case 2624 ;~ Gold
			Switch $Type
				Case 12 ;~ Offhand
					If $MaxDmgOffHand = True Then
						Return True
					Else
						Return False
					EndIf
				Case 24 ;~ Shield
					If $MaxDmgShield = True Then
						Return True
					Else
						Return False
					EndIf
				Case 27 ;~ Sword
					If $MaxDmgSword = True Then
						Return True
					Else
						Return False
					EndIf
			EndSwitch
		Case 2623 ;~ Purple?
			Switch $Type
				Case 12 ;~ Offhand
					If $MaxDmgOffHand = True Then
						Return True
					Else
						Return False
					EndIf
				Case 24 ;~ Shield
					If $MaxDmgShield = True Then
						Return True
					Else
						Return False
					EndIf
				Case 27 ;~ Sword
					If $MaxDmgSword = True Then
						Return True
					Else
						Return False
					EndIf
			EndSwitch
		Case 2626 ;~ Blue?
			Switch $Type
				Case 12 ;~ Offhand
					If $MaxDmgOffHand = True Then
						Return True
					Else
						Return False
					EndIf
				Case 24 ;~ Shield
					If $MaxDmgShield = True Then
						Return True
					Else
						Return False
					EndIf
				Case 27 ;~ Sword
					If $MaxDmgSword = True Then
						Return True
					Else
						Return False
					EndIf
			EndSwitch
	EndSwitch
	Return False
EndFunc   ;==>IsReq7Max
Func GetItemMaxDmg($aItem)
	If Not IsDllStruct($aItem) Then $aItem = GetItemByItemID($aItem)
	Local $lModString = GetModStruct($aItem)
	Local $lPos = StringInStr($lModString, "A8A7") ; Weapon Damage
	If $lPos = 0 Then $lPos = StringInStr($lModString, "C867") ; Energy (focus)
	If $lPos = 0 Then $lPos = StringInStr($lModString, "B8A7") ; Armor (shield)
	If $lPos = 0 Then Return 0
	Return Int("0x" & StringMid($lModString, $lPos - 2, 2))
EndFunc   ;==>GetItemMaxDmg

Func IsPcon($aItem)
	Local $ModelID = DllStructGetData($aItem, "ModelID")

	Switch $ModelID
		Case 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 24593, 30855, 31145, 31146, 35124, 36682 ;;28435 hard apple cider, 910 = hunters ales
			Return True ; Alcohol
		Case 6376, 36683 ;;21809. = bottle rocket, champagne poppers = 21810, 21813 = sparkler
			Return True ; Party
		Case 21492, 21812, 22269, 22644, 22752, 28436
			Return True ; Sweets
		Case 6370, 21488, 21489, 22191, 26784, 28433
			Return True ; DP Removal
		Case 15837, 21490, 30648, 31020
			Return True ; Tonic
	EndSwitch
	Return False
EndFunc   ;==>IsPcon

#EndRegion Weapon Detect Functions



#Region CommandStructs
Local $mInviteGuild = DllStructCreate('ptr;dword;dword header;dword counter;wchar name[32];dword type')
Local $mInviteGuildPtr = DllStructGetPtr($mInviteGuild)

Local $mUseSkill = DllStructCreate('ptr;dword;dword;dword')
Local $mUseSkillPtr = DllStructGetPtr($mUseSkill)

Local $mMove = DllStructCreate('ptr;float;float;float')
Local $mMovePtr = DllStructGetPtr($mMove)

Local $mChangeTarget = DllStructCreate('ptr;dword')
Local $mChangeTargetPtr = DllStructGetPtr($mChangeTarget)

Local $mPacket = DllStructCreate('ptr;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword')
Local $mPacketPtr = DllStructGetPtr($mPacket)

Local $mWriteChat = DllStructCreate('ptr')
Local $mWriteChatPtr = DllStructGetPtr($mWriteChat)

Local $mSellItem = DllStructCreate('ptr;dword;dword;dword')
Local $mSellItemPtr = DllStructGetPtr($mSellItem)

Local $mAction = DllStructCreate('ptr;dword;dword;')
Local $mActionPtr = DllStructGetPtr($mAction)

Local $mToggleLanguage = DllStructCreate('ptr;dword')
Local $mToggleLanguagePtr = DllStructGetPtr($mToggleLanguage)

Local $mUseHeroSkill = DllStructCreate('ptr;dword;dword;dword')
Local $mUseHeroSkillPtr = DllStructGetPtr($mUseHeroSkill)

Local $mBuyItem = DllStructCreate('ptr;dword;dword;dword;dword')
Local $mBuyItemPtr = DllStructGetPtr($mBuyItem)

Local $mCraftItemEx = DllStructCreate('ptr;dword;dword;ptr;dword;dword')
Local $mCraftItemExPtr = DllStructGetPtr($mCraftItemEx)

Local $mSendChat = DllStructCreate('ptr;dword')
Local $mSendChatPtr = DllStructGetPtr($mSendChat)

Local $mRequestQuote = DllStructCreate('ptr;dword')
Local $mRequestQuotePtr = DllStructGetPtr($mRequestQuote)

Local $mRequestQuoteSell = DllStructCreate('ptr;dword')
Local $mRequestQuoteSellPtr = DllStructGetPtr($mRequestQuoteSell)

Local $mTraderBuy = DllStructCreate('ptr')
Local $mTraderBuyPtr = DllStructGetPtr($mTraderBuy)

Local $mTraderSell = DllStructCreate('ptr')
Local $mTraderSellPtr = DllStructGetPtr($mTraderSell)

Local $mSalvage = DllStructCreate('ptr;dword;dword;dword')
Local $mSalvagePtr = DllStructGetPtr($mSalvage)

Local $mIncreaseAttribute = DllStructCreate('ptr;dword;dword')
Local $mIncreaseAttributePtr = DllStructGetPtr($mIncreaseAttribute)

Local $mDecreaseAttribute = DllStructCreate('ptr;dword;dword')
Local $mDecreaseAttributePtr = DllStructGetPtr($mDecreaseAttribute)

Local $mMaxAttributes = DllStructCreate("ptr;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword")
Local $mMaxAttributesPtr = DllStructGetPtr($mMaxAttributes)

Local $mSetAttributes = DllStructCreate("ptr;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword;dword")
Local $mSetAttributesPtr = DllStructGetPtr($mSetAttributes)

Local $mMakeAgentArray = DllStructCreate('ptr;dword')
Local $mMakeAgentArrayPtr = DllStructGetPtr($mMakeAgentArray)

Local $mChangeStatus = DllStructCreate('ptr;dword')
Local $mChangeStatusPtr = DllStructGetPtr($mChangeStatus)

Global $MTradeHackAddress
#EndRegion CommandStructs

#Region Memory
;~ Description: Internal use only.
Func MemoryOpen($aPID)
	$mKernelHandle = DllOpen('kernel32.dll')
	Local $lOpenProcess = DllCall($mKernelHandle, 'int', 'OpenProcess', 'int', 0x1F0FFF, 'int', 1, 'int', $aPID)
	$mGWProcHandle = $lOpenProcess[0]
EndFunc   ;==>MemoryOpen

;~ Description: Internal use only.
Func MemoryClose()
	DllCall($mKernelHandle, 'int', 'CloseHandle', 'int', $mGWProcHandle)
	DllClose($mKernelHandle)
EndFunc   ;==>MemoryClose

;~ Description: Internal use only.
Func WriteBinary($aBinaryString, $aAddress)
	Local $lData = DllStructCreate('byte[' & 0.5 * StringLen($aBinaryString) & ']'), $i
	For $i = 1 To DllStructGetSize($lData)
		DllStructSetData($lData, 1, Dec(StringMid($aBinaryString, 2 * $i - 1, 2)), $i)
	Next
	DllCall($mKernelHandle, 'int', 'WriteProcessMemory', 'int', $mGWProcHandle, 'ptr', $aAddress, 'ptr', DllStructGetPtr($lData), 'int', DllStructGetSize($lData), 'int', 0)
EndFunc   ;==>WriteBinary

;~ Description: Internal use only.
Func MemoryWrite($aAddress, $aData, $aType = 'dword')
	Local $lBuffer = DllStructCreate($aType)
	DllStructSetData($lBuffer, 1, $aData)
	DllCall($mKernelHandle, 'int', 'WriteProcessMemory', 'int', $mGWProcHandle, 'int', $aAddress, 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')
EndFunc   ;==>MemoryWrite

;~ Description: Internal use only.
Func MemoryRead($aAddress, $aType = 'dword')
	Local $lBuffer = DllStructCreate($aType)
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $aAddress, 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')
	Return DllStructGetData($lBuffer, 1)
EndFunc   ;==>MemoryRead

;~ Description: Internal use only.
Func MemoryReadPtr($aAddress, $aOffset, $aType = 'dword')
	Local $lPointerCount = UBound($aOffset) - 2
	Local $lBuffer = DllStructCreate('dword')
	For $i = 0 To $lPointerCount
		$aAddress += $aOffset[$i]
		DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $aAddress, 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')
		$aAddress = DllStructGetData($lBuffer, 1)
		If $aAddress == 0 Then
			Local $lData[2] = [0, 0]
			Return $lData
		EndIf
	Next
	$aAddress += $aOffset[$lPointerCount + 1]
	$lBuffer = DllStructCreate($aType)
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $aAddress, 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')
	Local $lData[2] = [$aAddress, DllStructGetData($lBuffer, 1)]
	Return $lData
EndFunc   ;==>MemoryReadPtr

;~ Description: Internal use only.
Func SwapEndian($aHex)
	Return StringMid($aHex, 7, 2) & StringMid($aHex, 5, 2) & StringMid($aHex, 3, 2) & StringMid($aHex, 1, 2)
EndFunc   ;==>SwapEndian
#EndRegion Memory

#Region Initialisation
;~ Description: Returns a list of logged characters
Func GetLoggedCharNames()
	Local $array = ScanGW()
	If $array[0] == 1 Then Return $array[1]
	If $array[0] < 1 Then Return ''
	Local $ret = $array[1]
	For $i = 2 To $array[0]
		$ret &= "|"
		$ret &= $array[$i]
	Next
	Return $ret
EndFunc   ;==>GetLoggedCharNames

Func ScanGW()
	Local $lProcessList = ProcessList("gw.exe")
	Local $lReturnArray[1] = [0]
	Local $lPid

	For $i = 1 To $lProcessList[0][0]
		MemoryOpen($lProcessList[$i][1])

		If $mGWProcHandle Then
			$lReturnArray[0] += 1
			ReDim $lReturnArray[$lReturnArray[0] + 1]
			$lReturnArray[$lReturnArray[0]] = ScanForCharname()
		EndIf

		MemoryClose()

		$mGWProcHandle = 0
	Next

	Return $lReturnArray
EndFunc   ;==>ScanGW

Func GetHwnd($aProc)
	Local $wins = WinList()
	For $i = 1 To UBound($wins) - 1
		If (WinGetProcess($wins[$i][1]) == $aProc) And (BitAND(WinGetState($wins[$i][1]), 2)) Then Return $wins[$i][1]
	Next
EndFunc   ;==>GetHwnd

;~ Description: Injects GWA� into the game client.
Func Initialize($aGW, $bChangeTitle = True, $aUseStringLog = False, $aUseEventSystem = True)
	Local $lWinList, $lWinList2, $mGWProcessId
	$mUseStringLog = $aUseStringLog
	$mUseEventSystem = $aUseEventSystem

	If IsString($aGW) Then
		Local $lProcessList = ProcessList("gw.exe")
		For $i = 1 To $lProcessList[0][0]
			$mGWProcessId = $lProcessList[$i][1]
			$mGWWindowHandle = GetHwnd($mGWProcessId)
			MemoryOpen($mGWProcessId)
			If $mGWProcHandle Then
				;If StringRegExp(ScanForCharname(), $aGW) = 1 Then ExitLoop
				If ScanForCharname() == $aGW Then ExitLoop
			EndIf
			MemoryClose()
			$mGWProcHandle = 0
		Next
	Else                      ;=███████.██████.██████.██████.██████.██████.No Memoryclose() may cause allocation issue██████.██████.██████.██████.
		$mGWProcessId = $aGW
		$mGWWindowHandle = GetHwnd($mGWProcessId)
		MemoryOpen($aGW)
		ScanForCharname()
	EndIf

	If $mGWProcHandle = 0 Then Return 0

	Scan()

	Local $lTemp
	$mBasePointer = MemoryRead(GetScannedAddress('ScanBasePointer', 8)) ;-3
	SetValue('BasePointer', '0x' & Hex($mBasePointer, 8))
	$mAgentBase = MemoryRead(GetScannedAddress('ScanAgentBasePointer', 8) + 0xD) - 8
	SetValue('AgentBase', '0x' & Hex($mAgentBase, 8))
	$mMaxAgents = $mAgentBase + 8
	SetValue('MaxAgents', '0x' & Hex($mMaxAgents, 8))
	$mMyID = MemoryRead(GetScannedAddress('ScanMyID', -3)) ;$mMyID = $mAgentBase - 84
	SetValue('MyID', '0x' & Hex($mMyID, 8))
	$mCurrentTarget = MemoryRead(GetScannedAddress('ScanCurrentTarget', -14)) ;$mAgentBase - 1280
	SetValue('PacketLocation', '0x' & Hex(MemoryRead(GetScannedAddress('ScanBaseOffset', 11)), 8))
	$mPing = MemoryRead(GetScannedAddress('ScanPing', -8))
	$mMapID = MemoryRead(GetScannedAddress('ScanMapID', 28))
	$mMapLoading = MemoryRead(GetScannedAddress('ScanMapLoading', 44))
	$mLoggedIn = MemoryRead(GetScannedAddress('ScanLoggedIn', -3)) - 0x198
	$mLanguage = MemoryRead(GetScannedAddress('ScanMapInfo', 11)) + 0xC
	$mRegion = $mLanguage + 4
	$mSkillBase = MemoryRead(GetScannedAddress('ScanSkillBase', 8))
	$mSkillTimer = MemoryRead(GetScannedAddress('ScanSkillTimer', -3))
	$lTemp = GetScannedAddress('ScanBuildNumber', 0x2C)
	$mBuildNumber = MemoryRead($lTemp + MemoryRead($lTemp) + 5)
	$mZoomStill = GetScannedAddress("ScanZoomStill", 0x33)
	$mZoomMoving = GetScannedAddress("ScanZoomMoving", 0x21)
	$mCurrentStatus = MemoryRead(GetScannedAddress('ScanChangeStatusFunction', 35))

	$lTemp = GetScannedAddress('ScanEngine', -0x6E) ;-16
	SetValue('MainStart', '0x' & Hex($lTemp, 8))
	SetValue('MainReturn', '0x' & Hex($lTemp + 5, 8))
	$lTemp = GetScannedAddress('ScanRenderFunc', -0x67)
	SetValue('RenderingMod', '0x' & Hex($lTemp, 8))
	SetValue('RenderingModReturn', '0x' & Hex($lTemp + 10, 8))
	$lTemp = GetScannedAddress('ScanTargetLog', 1)
	SetValue('TargetLogStart', '0x' & Hex($lTemp, 8))
	SetValue('TargetLogReturn', '0x' & Hex($lTemp + 5, 8))
	$lTemp = GetScannedAddress('ScanSkillLog', 1)
	SetValue('SkillLogStart', '0x' & Hex($lTemp, 8))
	SetValue('SkillLogReturn', '0x' & Hex($lTemp + 5, 8))
	$lTemp = GetScannedAddress('ScanSkillCompleteLog', -4)
	SetValue('SkillCompleteLogStart', '0x' & Hex($lTemp, 8))
	SetValue('SkillCompleteLogReturn', '0x' & Hex($lTemp + 5, 8))
	$lTemp = GetScannedAddress('ScanSkillCancelLog', 5)
	SetValue('SkillCancelLogStart', '0x' & Hex($lTemp, 8))
	SetValue('SkillCancelLogReturn', '0x' & Hex($lTemp + 6, 8))
	$lTemp = GetScannedAddress('ScanChatLog', 18)
	SetValue('ChatLogStart', '0x' & Hex($lTemp, 8))
	SetValue('ChatLogReturn', '0x' & Hex($lTemp + 6, 8))
	$lTemp = GetScannedAddress('ScanTraderHook', -7)
	SetValue('TraderHookStart', '0x' & Hex($lTemp, 8))
	SetValue('TraderHookReturn', '0x' & Hex($lTemp + 5, 8))

	$lTemp = GetScannedAddress('ScanDialogLog', -4)
	SetValue('DialogLogStart', '0x' & Hex($lTemp, 8))
	SetValue('DialogLogReturn', '0x' & Hex($lTemp + 5, 8))
	$lTemp = GetScannedAddress('ScanStringFilter1', -5) ; was -0x23
	SetValue('StringFilter1Start', '0x' & Hex($lTemp, 8))
	SetValue('StringFilter1Return', '0x' & Hex($lTemp + 5, 8))
	$lTemp = GetScannedAddress('ScanStringFilter2', 0x16) ; was 0x61
	SetValue('StringFilter2Start', '0x' & Hex($lTemp, 8))
	SetValue('StringFilter2Return', '0x' & Hex($lTemp + 5, 8))
	SetValue('StringLogStart', '0x' & Hex(GetScannedAddress('ScanStringLog', 0x16), 8))

	SetValue('LoadFinishedStart', '0x' & Hex(GetScannedAddress('ScanLoadFinished', 1), 8))
	SetValue('LoadFinishedReturn', '0x' & Hex(GetScannedAddress('ScanLoadFinished', 6), 8))

	SetValue('PostMessage', '0x' & Hex(MemoryRead(GetScannedAddress('ScanPostMessage', 11)), 8))
	SetValue('Sleep', MemoryRead(MemoryRead(GetValue('ScanSleep') + 8) + 3))
	;SetValue('SalvageFunction', MemoryRead(GetValue('ScanSalvageFunction') + 8) - 18)
	SetValue('SalvageFunction', '0x' & Hex(GetScannedAddress('ScanSalvageFunction', -10), 8))
	SetValue('SalvageGlobal', '0x' & Hex(MemoryRead(GetScannedAddress('ScanSalvageGlobal', 1) - 0x4), 8))
	;SetValue('SalvageGlobal', MemoryRead(MemoryRead(GetValue('ScanSalvageGlobal') + 8) + 1))
	SetValue('IncreaseAttributeFunction', '0x' & Hex(GetScannedAddress('ScanIncreaseAttributeFunction', -0x5A), 8))
	SetValue("DecreaseAttributeFunction", "0x" & Hex(GetScannedAddress("ScanDecreaseAttributeFunction", 25), 8))
	SetValue('MoveFunction', '0x' & Hex(GetScannedAddress('ScanMoveFunction', 1), 8))
	SetValue('UseSkillFunction', '0x' & Hex(GetScannedAddress('ScanUseSkillFunction', -0x125), 8))
	SetValue('ChangeTargetFunction', '0x' & Hex(GetScannedAddress('ScanChangeTargetFunction', -0x0089) + 1, 8))
	SetValue('WriteChatFunction', '0x' & Hex(GetScannedAddress('ScanWriteChatFunction', -0x3D), 8))
	SetValue('SellItemFunction', '0x' & Hex(GetScannedAddress('ScanSellItemFunction', -85), 8))
	SetValue('PacketSendFunction', '0x' & Hex(GetScannedAddress('ScanPacketSendFunction', -0xC2), 8))
	SetValue('ActionBase', '0x' & Hex(MemoryRead(GetScannedAddress('ScanActionBase', -3)), 8))
	SetValue('ActionFunction', '0x' & Hex(GetScannedAddress('ScanActionFunction', -3), 8))
	SetValue('UseHeroSkillFunction', '0x' & Hex(GetScannedAddress('ScanUseHeroSkillFunction', -0x59), 8))
	SetValue('BuyItemBase', '0x' & Hex(MemoryRead(GetScannedAddress('ScanBuyItemBase', 15)), 8))
	SetValue('TransactionFunction', '0x' & Hex(GetScannedAddress('ScanTransactionFunction', -0x7E), 8))
	SetValue('RequestQuoteFunction', '0x' & Hex(GetScannedAddress('ScanRequestQuoteFunction', -0x34), 8)) ;-2
	SetValue('TraderFunction', '0x' & Hex(GetScannedAddress('ScanTraderFunction', -71), 8))
	SetValue('ClickToMoveFix', '0x' & Hex(GetScannedAddress("ScanClickToMoveFix", 1), 8))
	SetValue('ChangeStatusFunction', '0x' & Hex(GetScannedAddress("ScanChangeStatusFunction", 1), 8))

	SetValue('QueueSize', '0x00000010')
	SetValue('SkillLogSize', '0x00000010')
	SetValue('ChatLogSize', '0x00000010')
	SetValue('TargetLogSize', '0x00000200')
	SetValue('StringLogSize', '0x00000200')
	SetValue('CallbackEvent', '0x00000501')
	$MTradeHackAddress = GetScannedAddress("ScanTradeHack", 0)

	ModifyMemory()

	$mQueueCounter = MemoryRead(GetValue('QueueCounter'))
	$mQueueSize = GetValue('QueueSize') - 1
	$mQueueBase = GetValue('QueueBase')
	$mTargetLogBase = GetValue('TargetLogBase')
	$mStringLogBase = GetValue('StringLogBase')
	$mMapIsLoaded = GetValue('MapIsLoaded')
	$mEnsureEnglish = GetValue('EnsureEnglish')
	$mTraderQuoteID = GetValue('TraderQuoteID')
	$mTraderCostID = GetValue('TraderCostID')
	$mTraderCostValue = GetValue('TraderCostValue')
	$mDisableRendering = GetValue('DisableRendering')
	$mAgentCopyCount = GetValue('AgentCopyCount')
	$mAgentCopyBase = GetValue('AgentCopyBase')
	$mLastDialogID = GetValue('LastDialogID')
	$mAgentNameLogBase = GetValue('AgentNameLogBase')

	If $mUseEventSystem Then MemoryWrite(GetValue('CallbackHandle'), $mGUI)

	DllStructSetData($mInviteGuild, 1, GetValue('CommandPacketSend'))
	DllStructSetData($mInviteGuild, 2, 0x4C)
	DllStructSetData($mUseSkill, 1, GetValue('CommandUseSkill'))
	DllStructSetData($mMove, 1, GetValue('CommandMove'))
	DllStructSetData($mChangeTarget, 1, GetValue('CommandChangeTarget'))
	DllStructSetData($mPacket, 1, GetValue('CommandPacketSend'))
	DllStructSetData($mSellItem, 1, GetValue('CommandSellItem'))
	DllStructSetData($mAction, 1, GetValue('CommandAction'))
	DllStructSetData($mToggleLanguage, 1, GetValue('CommandToggleLanguage'))

	DllStructSetData($mUseHeroSkill, 1, GetValue('CommandUseHeroSkill'))

	DllStructSetData($mBuyItem, 1, GetValue('CommandBuyItem'))
	DllStructSetData($mSendChat, 1, GetValue('CommandSendChat'))
	DllStructSetData($mSendChat, 2, $HEADER_SEND_CHAT)
	DllStructSetData($mWriteChat, 1, GetValue('CommandWriteChat'))
	DllStructSetData($mRequestQuote, 1, GetValue('CommandRequestQuote'))
	DllStructSetData($mRequestQuoteSell, 1, GetValue('CommandRequestQuoteSell'))
	DllStructSetData($mTraderBuy, 1, GetValue('CommandTraderBuy'))
	DllStructSetData($mTraderSell, 1, GetValue('CommandTraderSell'))
	DllStructSetData($mSalvage, 1, GetValue('CommandSalvage'))
	DllStructSetData($mIncreaseAttribute, 1, GetValue('CommandIncreaseAttribute'))
	DllStructSetData($mDecreaseAttribute, 1, GetValue('CommandDecreaseAttribute'))
	DllStructSetData($mMakeAgentArray, 1, GetValue('CommandMakeAgentArray'))
	DllStructSetData($mChangeStatus, 1, GetValue('CommandChangeStatus'))
	If $bChangeTitle Then WinSetTitle($mGWWindowHandle, '', 'Guild Wars - ' & GetCharname())
	Return $mGWWindowHandle
EndFunc   ;==>Initialize

;~ Description: Internal use only.
Func GetValue($aKey)
	For $i = 1 To $mLabels[0][0]
		If $mLabels[$i][0] = $aKey Then Return Number($mLabels[$i][1])
	Next
	Return -1
EndFunc   ;==>GetValue

;~ Description: Internal use only.
Func SetValue($aKey, $aValue)
	$mLabels[0][0] += 1
	ReDim $mLabels[$mLabels[0][0] + 1][2]
	$mLabels[$mLabels[0][0]][0] = $aKey
	$mLabels[$mLabels[0][0]][1] = $aValue
EndFunc   ;==>SetValue

;~ Description: Internal use only.
Func Scan()
	Local $lGwBase = ScanForProcess()
	$mASMSize = 0
	$mASMCodeOffset = 0
	$mASMString = ''

	_('MainModPtr/4')
	_('ScanBasePointer:')
	AddPattern('506A0F6A00FF35') ;85C0750F8BCE
	_('ScanAgentBasePointer:')
	AddPattern('FF50104783C6043BFB75E1')
	_('ScanCurrentTarget:')
	AddPattern('83C4085B8BE55DC355')
	_('ScanAgentBasePointer:')
	AddPattern('FF50104783C6043BFB75E1')
	_('ScanMyID:')
	AddPattern('83EC08568BF13B15')
	_('ScanEngine:')
	AddPattern('56FFD083C4048B4E0485C9') ;old 5356DFE0F6C441
	_('ScanRenderFunc:')
	AddPattern('F6C401741C68B1010000BA')
	_('ScanLoadFinished:')
	AddPattern('8B561C8BCF52E8')
	_('ScanPostMessage:')
	AddPattern('6A00680080000051FF15')
	_('ScanTargetLog:')
	AddPattern('5356578BFA894DF4E8')
	_('ScanChangeTargetFunction:')
	AddPattern('3BDF0F95') ;33C03BDA0F95C033
	_('ScanMoveFunction:')
	AddPattern('558BEC83EC208D45F0') ;558BEC83EC2056578BF98D4DF0
	_('ScanPing:')
	AddPattern('908D41248B49186A30')
	_('ScanMapID:')
	AddPattern('558BEC8B450885C074078B') ;B07F8D55
	_('ScanMapLoading:')
	AddPattern('6A2C50E8')
	_('ScanLoggedIn:')
	AddPattern('85C07411B807')
	_('ScanMapInfo:')
	AddPattern('8BF0EB038B750C3B') ;83F9FD7406
	_('ScanUseSkillFunction:')
	AddPattern('85F6745B83FE1174') ;558BEC83EC1053568BD9578BF2895DF0
	_('ScanPacketSendFunction:')
	AddPattern('F7D9C74754010000001BC981') ;558BEC83EC2C5356578BF985
	_('ScanBaseOffset:')
	AddPattern('83C40433C08BE55DC3A1') ;5633F63BCE740E5633D2
	_('ScanWriteChatFunction:')
	AddPattern('8D85E0FEFFFF50681C01') ;558BEC5153894DFC8B4D0856578B
	_('ScanSkillLog:')
	AddPattern('408946105E5B5D')
	_('ScanSkillCompleteLog:')
	AddPattern('741D6A006A40')
	_('ScanSkillCancelLog:')
	AddPattern('741D6A006A48')
	_('ScanChatLog:')
	AddPattern('8B45F48B138B4DEC50')
	_('ScanSellItemFunction:')
	AddPattern('8B4D2085C90F858E')
	_('ScanStringLog:')
	AddPattern('893E8B7D10895E04397E08')
	_('ScanStringFilter1:')
	AddPattern('8B368B4F2C6A006A008B06')
	_('ScanStringFilter2:')
	AddPattern('515356578BF933D28B4F2C')
	_('ScanActionFunction:')
	AddPattern('8B7508578BF983FE09750C6876') ;8B7D0883FF098BF175116876010000
	_('ScanActionBase:')
	AddPattern('8D1C87899DF4FEFFFF8BC32BC7C1F802') ;8B4208A80175418B4A08
	_('ScanSkillBase:')
	AddPattern('8D04B6C1E00505')
	_('ScanUseHeroSkillFunction:')
	AddPattern('BA02000000B954080000')
	_('ScanTransactionFunction:')
	AddPattern('85FF741D8B4D14EB08') ;558BEC81ECC000000053568B75085783FE108BFA8BD97614
	_('ScanBuyItemBase:')
	AddPattern('D9EED9580CC74004')
	_('ScanRequestQuoteFunction:')
	AddPattern('8B752083FE107614') ;53568B750C5783FE10
	_('ScanTraderFunction:')
	AddPattern('8B45188B551085')
	_('ScanTraderHook:')
	AddPattern('8955FC6A008D55F8B9BB') ;007BA579
	_('ScanSleep:')
	AddPattern('5F5E5B741A6860EA0000')
	_('ScanSalvageFunction:')
	AddPattern('33C58945FC8B45088945F08B450C8945F48B45108945F88D45EC506A10C745EC75')
	;AddPattern('8BFA8BD9897DF0895DF4')
	_('ScanSalvageGlobal:')
	AddPattern('8B5104538945F48B4108568945E88B410C578945EC8B4110528955E48945F0')
	;AddPattern('8B018B4904A3')
	_('ScanIncreaseAttributeFunction:')
	AddPattern('8B7D088B702C8B1F3B9E00050000') ;8B702C8B3B8B86
	_("ScanDecreaseAttributeFunction:")
	AddPattern("8B8AA800000089480C5DC3CC") ;8B402C8BCE059C0000008B1089118B50
	_('ScanSkillTimer:')
	AddPattern('FFD68B4DF08BD88B4708') ;85c974158bd62bd183fa64
	_('ScanClickToMoveFix:')
	AddPattern('3DD301000074')
	_('ScanZoomStill:')
	AddPattern('558BEC8B41085685C0')
	_('ScanZoomMoving:')
	AddPattern('EB358B4304')
	_('ScanBuildNumber:')
	AddPattern('558BEC83EC4053568BD9')
	_('ScanChangeStatusFunction:')
	AddPattern('558BEC568B750883FE047C14') ;568BF183FE047C14682F020000
	_('ScanReadChatFunction:')
	AddPattern('A128B6EB00')
	_('ScanDialogLog:')
	AddPattern('8B45088945FC8D45F8506A08C745F841') ;558BEC83EC285356578BF28BD9
	_("ScanTradeHack:")
	AddPattern("8BEC8B450883F846")
	_("ScanClickCoords:")
	AddPattern("8B451C85C0741CD945F8")
	_('ScanProc:')
	_('pushad')
	_('mov ecx,' & Hex($lGwBase, 8)) ;401000
	_('mov esi,ScanProc')
	_('ScanLoop:')
	_('inc ecx')
	_('mov al,byte[ecx]')
	_('mov edx,ScanBasePointer')

	_('ScanInnerLoop:')
	_('mov ebx,dword[edx]')
	_('cmp ebx,-1')
	_('jnz ScanContinue')
	_('add edx,50')
	_('cmp edx,esi')
	_('jnz ScanInnerLoop')
	_('cmp ecx,' & SwapEndian(Hex($lGwBase + 5238784, 8))) ;+4FF000
	_('jnz ScanLoop')
	_('jmp ScanExit')

	_('ScanContinue:')
	_('lea edi,dword[edx+ebx]')
	_('add edi,C')
	_('mov ah,byte[edi]')
	_('cmp al,ah')
	_('jz ScanMatched')
	_('mov dword[edx],0')
	_('add edx,50')
	_('cmp edx,esi')
	_('jnz ScanInnerLoop')
	_('cmp ecx,' & SwapEndian(Hex($lGwBase + 5238784, 8)))
	_('jnz ScanLoop')
	_('jmp ScanExit')

	_('ScanMatched:')
	_('inc ebx')
	_('mov edi,dword[edx+4]')
	_('cmp ebx,edi')
	_('jz ScanFound')
	_('mov dword[edx],ebx')
	_('add edx,50')
	_('cmp edx,esi')
	_('jnz ScanInnerLoop')
	_('cmp ecx,' & SwapEndian(Hex($lGwBase + 5238784, 8)))
	_('jnz ScanLoop')
	_('jmp ScanExit')

	_('ScanFound:')
	_('lea edi,dword[edx+8]')
	_('mov dword[edi],ecx')
	_('mov dword[edx],-1')
	_('add edx,50')
	_('cmp edx,esi')
	_('jnz ScanInnerLoop')
	_('cmp ecx,' & SwapEndian(Hex($lGwBase + 5238784, 8)))
	_('jnz ScanLoop')

	_('ScanExit:')
	_('popad')
	_('retn')

	$mBase = $lGwBase + 0x9DF000
	Local $lScanMemory = MemoryRead($mBase, 'ptr')
	If $lScanMemory = 0 Then
		$mMemory = DllCall($mKernelHandle, 'ptr', 'VirtualAllocEx', 'handle', $mGWProcHandle, 'ptr', 0, 'ulong_ptr', $mASMSize, 'dword', 0x1000, 'dword', 0x40)
		$mMemory = $mMemory[0]
		MemoryWrite($mBase, $mMemory)
;~ 		out("First Inject: " & $mMemory)
	Else
		$mMemory = $lScanMemory
	EndIf

	CompleteASMCode()

	If $lScanMemory = 0 Then
		WriteBinary($mASMString, $mMemory + $mASMCodeOffset)
		Local $lThread = DllCall($mKernelHandle, 'int', 'CreateRemoteThread', 'int', $mGWProcHandle, 'ptr', 0, 'int', 0, 'int', GetLabelInfo('ScanProc'), 'ptr', 0, 'int', 0, 'int', 0)
		$lThread = $lThread[0]
		Local $lResult
		Do
			$lResult = DllCall($mKernelHandle, 'int', 'WaitForSingleObject', 'int', $lThread, 'int', 50)
		Until $lResult[0] <> 258
		DllCall($mKernelHandle, 'int', 'CloseHandle', 'int', $lThread)
	EndIf
EndFunc   ;==>Scan

Func ScanForProcess()
	Local $lCharNameCode = BinaryToString('0x558BEC83EC105356578B7D0833F63BFE')
	Local $lCurrentSearchAddress = 0x00000000
	Local $lMBI[7], $lMBIBuffer = DllStructCreate('dword;dword;dword;dword;dword;dword;dword')
	Local $lSearch, $lTmpMemData, $lTmpAddress, $lTmpBuffer = DllStructCreate('ptr'), $i

	While $lCurrentSearchAddress < 0x01F00000
		Local $lMBI[7]
		DllCall($mKernelHandle, 'int', 'VirtualQueryEx', 'int', $mGWProcHandle, 'int', $lCurrentSearchAddress, 'ptr', DllStructGetPtr($lMBIBuffer), 'int', DllStructGetSize($lMBIBuffer))
		For $i = 0 To 6
			$lMBI[$i] = StringStripWS(DllStructGetData($lMBIBuffer, ($i + 1)), 3)
		Next
		If $lMBI[4] = 4096 Then
			Local $lBuffer = DllStructCreate('byte[' & $lMBI[3] & ']')
			DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lCurrentSearchAddress, 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')

			$lTmpMemData = DllStructGetData($lBuffer, 1)
			$lTmpMemData = BinaryToString($lTmpMemData)

			$lSearch = StringInStr($lTmpMemData, $lCharNameCode, 2)
			If $lSearch > 0 Then
				Return $lMBI[0]
			EndIf
		EndIf
		$lCurrentSearchAddress += $lMBI[3]
	WEnd
	Return ''
EndFunc   ;==>ScanForProcess

;~ Description: Internal use only.
Func AddPattern($aPattern)
	Local $lSize = Int(0.5 * StringLen($aPattern))
	$mASMString &= '00000000' & SwapEndian(Hex($lSize, 8)) & '00000000' & $aPattern
	$mASMSize += $lSize + 12
	For $i = 1 To 68 - $lSize
		$mASMSize += 1
		$mASMString &= '00'
	Next
EndFunc   ;==>AddPattern

;~ Description: Internal use only.
Func GetScannedAddress($aLabel, $aOffset)
	Return MemoryRead(GetLabelInfo($aLabel) + 8) - MemoryRead(GetLabelInfo($aLabel) + 4) + $aOffset
EndFunc   ;==>GetScannedAddress

;~ Description: Internal use only.
Func ScanForCharname()
	Local $lCharNameCode = BinaryToString('0xCCCCCC558BEC5166') ;0x90909066C705
	Local $lCurrentSearchAddress = 0x00000000 ;0x00401000
	Local $lMBI[7], $lMBIBuffer = DllStructCreate('dword;dword;dword;dword;dword;dword;dword')
	Local $lSearch, $lTmpMemData, $lTmpAddress, $lTmpBuffer = DllStructCreate('ptr'), $i

	While $lCurrentSearchAddress < 0x01F00000
		Local $lMBI[7]
		DllCall($mKernelHandle, 'int', 'VirtualQueryEx', 'int', $mGWProcHandle, 'int', $lCurrentSearchAddress, 'ptr', DllStructGetPtr($lMBIBuffer), 'int', DllStructGetSize($lMBIBuffer))
		For $i = 0 To 6
			$lMBI[$i] = StringStripWS(DllStructGetData($lMBIBuffer, ($i + 1)), 3)
		Next
		If $lMBI[4] = 4096 Then
			Local $lBuffer = DllStructCreate('byte[' & $lMBI[3] & ']')
			DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lCurrentSearchAddress, 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')

			$lTmpMemData = DllStructGetData($lBuffer, 1)
			$lTmpMemData = BinaryToString($lTmpMemData)

			$lSearch = StringInStr($lTmpMemData, $lCharNameCode, 2)
			If $lSearch > 0 Then
				$lTmpAddress = $lCurrentSearchAddress + $lSearch - 1
				DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lTmpAddress + 10, 'ptr', DllStructGetPtr($lTmpBuffer), 'int', DllStructGetSize($lTmpBuffer), 'int', '')
				$mCharname = DllStructGetData($lTmpBuffer, 1)
				Return GetCharname()
			EndIf
		EndIf
		$lCurrentSearchAddress += $lMBI[3]
	WEnd
	Return ''
EndFunc   ;==>ScanForCharname
#EndRegion Initialisation

#Region Commands
#Region Item
;~ Description: Starts a salvaging session of an item.
Func StartSalvage($aItem)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x690]
	Local $lSalvageSessionID = MemoryReadPtr($mBasePointer, $lOffset)

	If IsDllStruct($aItem) = 0 Then
		Local $lItemID = $aItem
	Else
		Local $lItemID = DllStructGetData($aItem, 'ID')
	EndIf

	Local $lSalvageKit = FindSalvageKit()
	If $lSalvageKit = 0 Then Return

	DllStructSetData($mSalvage, 2, $lItemID)
	DllStructSetData($mSalvage, 3, FindSalvageKit())
	DllStructSetData($mSalvage, 4, $lSalvageSessionID[1])

	Enqueue($mSalvagePtr, 16)
EndFunc   ;==>StartSalvage

;~ Description: Salvage the materials out of an item.
Func SalvageMaterials()
	Return SendPacket(0x4, $HEADER_SALVAGE_MATS)
EndFunc   ;==>SalvageMaterials

;~ Description: Salvages a mod out of an item.
Func SalvageMod($aModIndex)
	Return SendPacket(0x8, $HEADER_SALVAGE_MODS, $aModIndex)
EndFunc   ;==>SalvageMod

;~ Description: Identifies an item.
Func IdentifyItem($aItem)
	If GetIsIDed($aItem) Then Return

	Local $lItemID
	If IsDllStruct($aItem) = 0 Then
		$lItemID = $aItem
	Else
		$lItemID = DllStructGetData($aItem, 'ID')
	EndIf

	Local $lIDKit = FindIDKit()
	If $lIDKit == 0 Then Return

	SendPacket(0xC, $HEADER_ITEM_ID, $lIDKit, $lItemID)

	Local $lDeadlock = TimerInit()
	Do
		Sleep(20)
	Until GetIsIDed($lItemID) Or TimerDiff($lDeadlock) > 5000
	If Not GetIsIDed($lItemID) Then IdentifyItem($aItem)
EndFunc   ;==>IdentifyItem

;~ Description: Identifies all items in a bag.
Func IdentifyBag($aBag, $aWhites = False, $aGolds = True)
	Local $lItem
	If Not IsDllStruct($aBag) Then $aBag = GetBag($aBag)
	For $i = 1 To DllStructGetData($aBag, 'Slots')
		$lItem = GetItemBySlot($aBag, $i)
		If DllStructGetData($lItem, 'ID') == 0 Then ContinueLoop
		If GetRarity($lItem) == 2621 And $aWhites == False Then ContinueLoop
		If GetRarity($lItem) == 2624 And $aGolds == False Then ContinueLoop
		IdentifyItem($lItem)
		Sleep(GetPing())
	Next
EndFunc   ;==>IdentifyBag

;~ Description: Equips an item.
Func EquipItem($aItem)
	Local $lItemID

	If IsDllStruct($aItem) = 0 Then
		$lItemID = $aItem
	Else
		$lItemID = DllStructGetData($aItem, 'ID')
	EndIf

	Return SendPacket(0x8, $HEADER_ITEM_EQUIP, $lItemID)
EndFunc   ;==>EquipItem

; Description: Uses an item.
Func UseItem($aItem)
	Local $lItemID

	If IsDllStruct($aItem) = 0 Then
		$lItemID = $aItem
		$aItem = GetItemByItemID($lItemID)
		If $lItemID = 0 Then Return False
		If DllStructGetData($aItem, 'bag') = 0 Then Return False
	Else

		$lItemID = DllStructGetData($aItem, 'ID')
		If $lItemID = 0 Then Return False
		If DllStructGetData($aItem, 'bag') = 0 Then Return False
	EndIf
	Return SendPacket(0x8, $HEADER_ITEM_USE, $lItemID)
EndFunc   ;==>UseItem

;~ Description: Picks up an item.
Func PickUpItem($aItem)
	Local $lAgentID

	If IsDllStruct($aItem) = 0 Then
		$lAgentID = $aItem
	ElseIf DllStructGetSize($aItem) < 400 Then
		$lAgentID = DllStructGetData($aItem, 'AgentID')
	Else
		$lAgentID = DllStructGetData($aItem, 'ID')
	EndIf

	Return SendPacket(0xC, $HEADER_ITEM_PICKUP, $lAgentID, 0)
EndFunc   ;==>PickUpItem

;~ Description: Drops an item.
Func DropItem($aItem, $aAmount = 0)
	Local $lItemID, $lAmount

	If IsDllStruct($aItem) = 0 Then
		$lItemID = $aItem
		If $aAmount > 0 Then
			$lAmount = $aAmount
		Else
			$lAmount = DllStructGetData(GetItemByItemID($aItem), 'Quantity')
		EndIf
	Else
		$lItemID = DllStructGetData($aItem, 'ID')
		If $aAmount > 0 Then
			$lAmount = $aAmount
		Else
			$lAmount = DllStructGetData($aItem, 'Quantity')
		EndIf
	EndIf

	Return SendPacket(0xC, $HEADER_ITEM_DROP, $lItemID, $lAmount)
EndFunc   ;==>DropItem

;~ Description: Moves an item.
Func MoveItem($aItem, $aBag, $aSlot)
	Local $lItemID, $lBagID

	If IsDllStruct($aItem) = 0 Then
		$lItemID = $aItem
	Else
		$lItemID = DllStructGetData($aItem, 'ID')
	EndIf

	If IsDllStruct($aBag) = 0 Then
		$lBagID = DllStructGetData(GetBag($aBag), 'ID')
	Else
		$lBagID = DllStructGetData($aBag, 'ID')
	EndIf

	Return SendPacket(0x10, $HEADER_ITEM_MOVE, $lItemID, $lBagID, $aSlot - 1)
EndFunc   ;==>MoveItem

;~ Description: Accepts unclaimed items after a mission.
Func AcceptAllItems()
	Return SendPacket(0x8, $HEADER_ITEMS_ACCEPT_UNCLAIMED, DllStructGetData(GetBag(7), 'ID'))
EndFunc   ;==>AcceptAllItems

;~ Description: Sells an item.
Func SellItem($aItem, $aQuantity = 0)
	If IsDllStruct($aItem) = 0 Then $aItem = GetItemByItemID($aItem)
	If $aQuantity = 0 Or $aQuantity > DllStructGetData($aItem, 'Quantity') Then $aQuantity = DllStructGetData($aItem, 'Quantity')

	DllStructSetData($mSellItem, 2, $aQuantity * DllStructGetData($aItem, 'Value'))
	DllStructSetData($mSellItem, 3, DllStructGetData($aItem, 'ID'))
	DllStructSetData($mSellItem, 4, MemoryRead(GetScannedAddress('ScanBuyItemBase', 15)))
	Enqueue($mSellItemPtr, 16)
EndFunc   ;==>SellItem

;~ Description: Buys an item.
Func BuyItem($aItem, $aQuantity, $aValue)
	Local $lMerchantItemsBase = GetMerchantItemsBase()

	If Not $lMerchantItemsBase Then Return
	If $aItem < 1 Or $aItem > GetMerchantItemsSize() Then Return

	DllStructSetData($mBuyItem, 2, $aQuantity)
	DllStructSetData($mBuyItem, 3, MemoryRead($lMerchantItemsBase + 4 * ($aItem - 1)))
	DllStructSetData($mBuyItem, 4, $aQuantity * $aValue)
	DllStructSetData($mBuyItem, 5, MemoryRead(GetScannedAddress('ScanBuyItemBase', 15)))
	Enqueue($mBuyItemPtr, 20)
EndFunc   ;==>BuyItem

;~ Description: Buys an ID kit.
Func BuyIDKit()
	BuyItem(5, 1, 100)
EndFunc   ;==>BuyIDKit

;~ Description: Buys a superior ID kit.
Func BuySuperiorIDKit()
	BuyItem(6, 1, 500)
EndFunc   ;==>BuySuperiorIDKit

Func CraftItemEx($aModelID, $aQuantity, $aGold, ByRef $aMatsArray)
	Local $pSrcItem = GetInventoryItemPtrByModelId($aMatsArray[0][0])
	If ((Not $pSrcItem) Or (MemoryRead($pSrcItem + 0x4B) < $aMatsArray[0][1])) Then Return 0
	Local $pDstItem = MemoryRead(GetMerchantItemPtrByModelId($aModelID))
	If (Not $pDstItem) Then Return 0
	Local $lMatString = ''
	Local $lMatCount = 0
	If IsArray($aMatsArray) = 0 Then Return 0 ; mats are not in an array
	Local $lMatsArraySize = UBound($aMatsArray) - 1
	For $i = $lMatsArraySize To 0 Step -1
		$lCheckQuantity = CountItemInBagsByModelID($aMatsArray[$i][0])
		If $aMatsArray[$i][1] * $aQuantity > $lCheckQuantity Then ; not enough mats in inventory
			Return SetExtended($aMatsArray[$i][1] * $aQuantity - $lCheckQuantity, $aMatsArray[$i][0]) ; amount of missing mats in @extended
		EndIf
	Next
	$lCheckGold = GetGoldCharacter()
;~ 	out($lMatsArraySize)

	For $i = 0 To $lMatsArraySize
		$lMatString &= GetItemIDfromMobelID($aMatsArray[$i][0]) & ';' ;GetCraftMatsString($aMatsArray[$i][0], $aQuantity * $aMatsArray[$i][1])
;~ 		out($lMatString)
		$lMatCount += 1 ;@extended
;~ 		out($lMatCount)
	Next

	$CraftMatsType = 'dword'
	For $i = 1 To $lMatCount - 1
		$CraftMatsType &= ';dword'
	Next
	$CraftMatsBuffer = DllStructCreate($CraftMatsType)
	$CraftMatsPointer = DllStructGetPtr($CraftMatsBuffer)
	For $i = 1 To $lMatCount
		$lSize = StringInStr($lMatString, ';')
;~ 		out("Mat: " & StringLeft($lMatString, $lSize - 1))
		DllStructSetData($CraftMatsBuffer, $i, StringLeft($lMatString, $lSize - 1))
		$lMatString = StringTrimLeft($lMatString, $lSize)
	Next
	Local $lMemSize = $lMatCount * 4
	Local $lBufferMemory = DllCall($mKernelHandle, 'ptr', 'VirtualAllocEx', 'handle', $mGWProcHandle, 'ptr', 0, 'ulong_ptr', $lMemSize, 'dword', 0x1000, 'dword', 0x40)
	If $lBufferMemory = 0 Then Return 0 ; couldnt allocate enough memory
	Local $lBuffer = DllCall($mKernelHandle, 'int', 'WriteProcessMemory', 'int', $mGWProcHandle, 'int', $lBufferMemory[0], 'ptr', $CraftMatsPointer, 'int', $lMemSize, 'int', '')
	If $lBuffer = 0 Then Return
;~ 	Out($lBuffer[0] & " " & $lBuffer[1] & " " & $lBuffer[2] & " " & $lBuffer[3] & " " & $lBuffer[4] & " " & $lBuffer[5])
	DllStructSetData($mCraftItemEx, 1, GetValue('CommandCraftItemEx'))
	DllStructSetData($mCraftItemEx, 2, $aQuantity)
;~ 	Out($aQuantity)
;~     Sleep(3000)
	DllStructSetData($mCraftItemEx, 3, $pDstItem)
;~ 	Out($pDstItem)
;~     Sleep(3000)
	DllStructSetData($mCraftItemEx, 4, $lBufferMemory[0])
;~ 	Out($lBufferMemory[0])
;~     Sleep(3000)
	DllStructSetData($mCraftItemEx, 5, $lMatCount)
;~ 	Out($lMatCount)
;~     Sleep(3000)
	DllStructSetData($mCraftItemEx, 6, $aQuantity * $aGold)
;~ 	Out($aQuantity * $aGold)
;~     Sleep(3000)
	Enqueue($mCraftItemExPtr, 24)
	$lDeadlock = TimerInit()
	Do
		Sleep(250)
		$lCurrentQuantity = CountItemInBagsByModelID($aMatsArray[0][0])
	Until $lCurrentQuantity <> $lCheckQuantity Or $lCheckGold <> GetGoldCharacter() Or TimerDiff($lDeadlock) > 5000
	DllCall($mKernelHandle, 'ptr', 'VirtualFreeEx', 'handle', $mGWProcHandle, 'ptr', $lBufferMemory[0], 'int', 0, 'dword', 0x8000)
	Return SetExtended($lCheckQuantity - $lCurrentQuantity - $aMatsArray[0][1] * $aQuantity, True) ; should be zero if items were successfully crafter
EndFunc   ;==>CraftItemEx

Func GetCraftMatsString($aModelID, $aAmount)
	Local $lCount = 0
	Local $lQuantity = 0
	Local $lMatString = ''
	For $bag = 1 To 4
		$lBagPtr = GetBagPtr($bag)
		If $lBagPtr = 0 Then ContinueLoop ; no valid bag
		For $SLOT = 1 To MemoryRead($lBagPtr + 32, 'long')
			$lSlotPtr = GetItemPtrBySlot($lBagPtr, $SLOT)
			If $lSlotPtr = 0 Then ContinueLoop ; empty slot
			If MemoryRead($lSlotPtr + 44, 'long') = $aModelID Then
				$lMatString &= MemoryRead($lSlotPtr, 'long') & ';'
				$lCount += 1
				$lQuantity += MemoryRead($lSlotPtr + 75, 'byte')
				If $lQuantity >= $aAmount Then
					Return SetExtended($lCount, $lMatString)
				EndIf
			EndIf
		Next
	Next
EndFunc   ;==>GetCraftMatsString

Func GetItemIDfromMobelID($aModelID)
	For $i = 1 To 4
		For $j = 1 To DllStructGetData(GetBag($i), 'slots')
			Local $item = GetItemBySlot($i, $j)
			If DllStructGetData($item, 'ModelId') == $aModelID Then Return DllStructGetData($item, 'Id')
		Next
	Next
EndFunc   ;==>GetItemIDfromMobelID

Func GetMerchantItemPtrByModelId($nModelId)
	Local $aOffsets[5] = [0, 0x18, 0x40, 0xB8]
	Local $pMerchantBase = GetMerchantItemsBase()
	Local $nItemId = 0
	Local $nItemPtr = 0

	For $i = 0 To GetMerchantItemsSize() -1
		$nItemId = MemoryRead($pMerchantBase + 4 * $i)

		If ($nItemId) Then
			$aOffsets[4] = 4 * $nItemId
			$nItemPtr = MemoryReadPtr($mBasePointer, $aOffsets)[1]

			If (MemoryRead($nItemPtr + 0x2C) = $nModelId) Then
				Return Ptr($nItemPtr)
			EndIf
		EndIf
	Next
EndFunc   ;==>GetMerchantItemPtrByModelId
Func GetInventoryItemPtrByModelId($nModelId)
	Local $aOffsets[5] = [0, 0x18, 0x40, 0xF8]
	Local $pItemArray = 0
	Local $pBagStruct = 0
	Local $pItemStruct = 0

	For $i = 1 To 4
		$aOffsets[4] = 4 * $i
		$pBagStruct = MemoryReadPtr($mBasePointer, $aOffsets)[1]
		$pItemArray = MemoryRead($pBagStruct + 0x18)

		For $j = 0 To MemoryRead($pBagStruct + 0x20) - 1
			$pItemStruct = MemoryRead($pItemArray + 4 * $j)

			If (($pItemStruct) And (MemoryRead($pItemStruct + 0x2C) = $nModelId)) Then
				Return Ptr($pItemStruct)
			EndIf
		Next
	Next
EndFunc   ;==>GetInventoryItemPtrByModelId

;~ Description: Request a quote to buy an item from a trader. Returns true if successful.
Func TraderRequest($aModelID, $aExtraID = -1)
	Local $lItemStruct = DllStructCreate('long Id;long AgentId;byte Unknown1[4];ptr Bag;ptr ModStruct;long ModStructSize;ptr Customized;byte unknown2[4];byte Type;byte unknown4;short ExtraId;short Value;byte unknown4[2];short Interaction;long ModelId;ptr ModString;byte unknown5[4];ptr NameString;ptr SingleItemName;byte Unknown4[10];byte IsSalvageable;byte Unknown6;byte Quantity;byte Equiped;byte Profession;byte Type2;byte Slot')

	Local $lOffset[4] = [0, 0x18, 0x40, 0xC0]
	Local $lItemArraySize = MemoryReadPtr($mBasePointer, $lOffset)
	Local $lOffset[5] = [0, 0x18, 0x40, 0xB8, 0]
	Local $lItemPtr, $lItemID
	Local $lFound = False
	Local $lQuoteID = MemoryRead($mTraderQuoteID)

	For $lItemID = 1 To $lItemArraySize[1]
		$lOffset[4] = 0x4 * $lItemID
		$lItemPtr = MemoryReadPtr($mBasePointer, $lOffset)
		If $lItemPtr[1] = 0 Then ContinueLoop

		DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemPtr[1], 'ptr', DllStructGetPtr($lItemStruct), 'int', DllStructGetSize($lItemStruct), 'int', '')
		If DllStructGetData($lItemStruct, 'ModelID') = $aModelID And DllStructGetData($lItemStruct, 'bag') = 0 And DllStructGetData($lItemStruct, 'AgentID') == 0 Then
			If $aExtraID = -1 Or DllStructGetData($lItemStruct, 'ExtraID') = $aExtraID Then
				$lFound = True
				ExitLoop
			EndIf
		EndIf
	Next
	If Not $lFound Then Return False

	DllStructSetData($mRequestQuote, 2, DllStructGetData($lItemStruct, 'ID'))
	Enqueue($mRequestQuotePtr, 8)

	Local $lDeadlock = TimerInit()
	$lFound = False
	Do
		Sleep(20)
		$lFound = MemoryRead($mTraderQuoteID) <> $lQuoteID
	Until $lFound Or TimerDiff($lDeadlock) > GetPing() + 5000
	Return $lFound
EndFunc   ;==>TraderRequest

;~ Description: Buy the requested item.
Func TraderBuy()
	If Not GetTraderCostID() Or Not GetTraderCostValue() Then Return False
	Enqueue($mTraderBuyPtr, 4)
	Return True
EndFunc   ;==>TraderBuy

;~ Description: Request a quote to sell an item to the trader.
Func TraderRequestSell($aItem)
	Local $lItemID
	Local $lFound = False
	Local $lQuoteID = MemoryRead($mTraderQuoteID)

	If IsDllStruct($aItem) = 0 Then
		$lItemID = $aItem
	Else
		$lItemID = DllStructGetData($aItem, 'ID')
	EndIf

	DllStructSetData($mRequestQuoteSell, 2, $lItemID)
	Enqueue($mRequestQuoteSellPtr, 8)

	Local $lDeadlock = TimerInit()
	Do
		Sleep(20)
		$lFound = MemoryRead($mTraderQuoteID) <> $lQuoteID
	Until $lFound Or TimerDiff($lDeadlock) > GetPing() + 5000
	Return $lFound
EndFunc   ;==>TraderRequestSell

;~ Description: ID of the item item being sold.
Func TraderSell()
	If Not GetTraderCostID() Or Not GetTraderCostValue() Then Return False
	Enqueue($mTraderSellPtr, 4)
	Return True
EndFunc   ;==>TraderSell

;~ Description: Drop gold on the ground.
Func DropGold($aAmount = 0)
	Local $lAmount

	If $aAmount > 0 Then
		$lAmount = $aAmount
	Else
		$lAmount = GetGoldCharacter()
	EndIf

	Return SendPacket(0x8, $HEADER_GOLD_DROP, $lAmount)
EndFunc   ;==>DropGold

;~ Description: Deposit gold into storage.
Func DepositGold($aAmount = 0)
	Local $lAmount
	Local $lStorage = GetGoldStorage()
	Local $lCharacter = GetGoldCharacter()

	If $aAmount > 0 And $lCharacter >= $aAmount Then
		$lAmount = $aAmount
	Else
		$lAmount = $lCharacter
	EndIf

	If $lStorage + $lAmount > 1000000 Then $lAmount = 1000000 - $lStorage

	ChangeGold($lCharacter - $lAmount, $lStorage + $lAmount)
EndFunc   ;==>DepositGold

;~ Description: Withdraw gold from storage.
Func WithdrawGold($aAmount = 0)
	Local $lAmount
	Local $lStorage = GetGoldStorage()
	Local $lCharacter = GetGoldCharacter()

	If $aAmount > 0 And $lStorage >= $aAmount Then
		$lAmount = $aAmount
	Else
		$lAmount = $lStorage
	EndIf

	If $lCharacter + $lAmount > 100000 Then $lAmount = 100000 - $lCharacter
	ChangeGold($lCharacter + $lAmount, $lStorage - $lAmount)
EndFunc   ;==>WithdrawGold

;~ Description: Internal use for moving gold.
Func ChangeGold($aCharacter, $aStorage)
	Return SendPacket(0xC, $HEADER_CHANGE_GOLD, $aCharacter, $aStorage) ;0x75
EndFunc   ;==>ChangeGold
#EndRegion Item

#Region H&H
;~ Description: Adds a hero to the party.
Func AddHero($aHeroId)
	Return SendPacket(0x8, $HEADER_HERO_ADD, $aHeroId)
EndFunc   ;==>AddHero

;~ Description: Kicks a hero from the party.
Func KickHero($aHeroId)
	Return SendPacket(0x8, $HEADER_HERO_KICK, $aHeroId)
EndFunc   ;==>KickHero

;~ Description: Kicks all heroes from the party.
Func KickAllHeroes()
	Return SendPacket(0x8, $HEADER_HEROES_KICK, 0x26)
EndFunc   ;==>KickAllHeroes

;~ Description: Add a henchman to the party.
Func AddNpc($aNpcId)
	Return SendPacket(0x8, $HEADER_HENCHMAN_ADD, $aNpcId)
EndFunc   ;==>AddNpc

;~ Description: Kick a henchman from the party.
Func KickNpc($aNpcId)
	Return SendPacket(0x8, $HEADER_HENCHMAN_KICK, $aNpcId)
EndFunc   ;==>KickNpc

;~ Description: Clear the position flag from a hero.
Func CancelHero($aHeroNumber)
	Local $lAgentID = GetHeroID($aHeroNumber)
	Return SendPacket(0x14, $HEADER_HERO_CLEAR_FLAG, $lAgentID, 0x7F800000, 0x7F800000, 0)
EndFunc   ;==>CancelHero

;~ Description: Clear the position flag from all heroes.
Func CancelAll()
	Return SendPacket(0x10, $HEADER_PARTY_CLEAR_FLAG, 0x7F800000, 0x7F800000, 0)
EndFunc   ;==>CancelAll

;~ Description: Place a hero's position flag.
Func CommandHero($aHeroNumber, $aX, $aY)
	Return SendPacket(0x14, $HEADER_HERO_PLACE_FLAG, GetHeroID($aHeroNumber), FloatToInt($aX), FloatToInt($aY), 0)
EndFunc   ;==>CommandHero

;~ Description: Place the full-party position flag.
Func CommandAll($aX, $aY)
	Return SendPacket(0x10, $HEADER_PARTY_PLACE_FLAG, FloatToInt($aX), FloatToInt($aY), 0)
EndFunc   ;==>CommandAll

;~ Description: Lock a hero onto a target.
Func LockHeroTarget($aHeroNumber, $aAgentID = 0) ;$aAgentID=0 Cancels Lock
	Local $lHeroID = GetHeroID($aHeroNumber)
	Return SendPacket(0xC, $HEADER_HERO_LOCK, $lHeroID, $aAgentID)
EndFunc   ;==>LockHeroTarget

;~ Description: Change a hero's aggression level.
Func SetHeroAggression($aHeroNumber, $aAggression) ;0=Fight, 1=Guard, 2=Avoid
	Local $lHeroID = GetHeroID($aHeroNumber)
	Return SendPacket(0xC, $HEADER_HERO_AGGRESSION, $lHeroID, $aAggression)
EndFunc   ;==>SetHeroAggression

;~ Description: Disable a skill on a hero's skill bar.
Func DisableHeroSkillSlot($aHeroNumber, $aSkillSlot)
	If Not GetIsHeroSkillSlotDisabled($aHeroNumber, $aSkillSlot) Then ChangeHeroSkillSlotState($aHeroNumber, $aSkillSlot)
EndFunc   ;==>DisableHeroSkillSlot

;~ Description: Enable a skill on a hero's skill bar.
Func EnableHeroSkillSlot($aHeroNumber, $aSkillSlot)
	If GetIsHeroSkillSlotDisabled($aHeroNumber, $aSkillSlot) Then ChangeHeroSkillSlotState($aHeroNumber, $aSkillSlot)
EndFunc   ;==>EnableHeroSkillSlot

;~ Description: Internal use for enabling or disabling hero skills
Func ChangeHeroSkillSlotState($aHeroNumber, $aSkillSlot)
	Return SendPacket(0xC, $HEADER_HERO_TOGGLE_SKILL, GetHeroID($aHeroNumber), $aSkillSlot - 1)
EndFunc   ;==>ChangeHeroSkillSlotState

;~ Description: Order a hero to use a skill.
Func UseHeroSkill($aHero, $aSkillSlot, $aTarget = 0)
	Local $lTargetID

	If IsDllStruct($aTarget) = 0 Then
		$lTargetID = ConvertID($aTarget)
	Else
		$lTargetID = DllStructGetData($aTarget, 'ID')
	EndIf

	DllStructSetData($mUseHeroSkill, 2, GetHeroID($aHero))
	DllStructSetData($mUseHeroSkill, 3, $lTargetID)
	DllStructSetData($mUseHeroSkill, 4, $aSkillSlot - 1)
	Enqueue($mUseHeroSkillPtr, 16)
EndFunc   ;==>UseHeroSkill
#EndRegion H&H

#Region Movement
;~ Description: Move to a location.
Func Move($aX, $aY, $aRandom = 50)
	;returns true if successful
	If GetAgentExists(-2) Then
		DllStructSetData($mMove, 2, $aX + Random(-$aRandom, $aRandom))
		DllStructSetData($mMove, 3, $aY + Random(-$aRandom, $aRandom))
		Enqueue($mMovePtr, 16)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>Move

;~ Description: Move to a location and wait until you reach it.
Func MoveTo($aX, $aY, $aRandom = 10)
	Local $lBlocked = 0
	Local $lMe
	Local $lMapLoading = GetMapLoading(), $lMapLoadingOld
	Local $lDestX = $aX + Random(-$aRandom, $aRandom)
	Local $lDestY = $aY + Random(-$aRandom, $aRandom)

	Move($lDestX, $lDestY, 0)

	Do
		Sleep(100)
		$lMe = GetAgentByID(-2)

		If DllStructGetData($lMe, 'HP') <= 0 Then ExitLoop

		$lMapLoadingOld = $lMapLoading
		$lMapLoading = GetMapLoading()
		If $lMapLoading <> $lMapLoadingOld Then ExitLoop

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			$lDestX = $aX + Random(-$aRandom, $aRandom)
			$lDestY = $aY + Random(-$aRandom, $aRandom)
			Move($lDestX, $lDestY, 0)
		EndIf
	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 25 Or $lBlocked > 14 Or GetIsDead(-2)
EndFunc   ;==>MoveTo

;~ Description: Run to or follow a player.
Func GoPlayer($aAgent)
	Local $lAgentID

	If IsDllStruct($aAgent) = 0 Then
		$lAgentID = ConvertID($aAgent)
	Else
		$lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf

	Return SendPacket(0x8, $HEADER_AGENT_FOLLOW, $lAgentID)
EndFunc   ;==>GoPlayer

;~ Description: Talk to an NPC
Func GoNPC($aAgent)
	Local $lAgentID

	If IsDllStruct($aAgent) = 0 Then
		$lAgentID = ConvertID($aAgent)
	Else
		$lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf

	Return SendPacket(0xC, $HEADER_NPC_TALK, $lAgentID)
EndFunc   ;==>GoNPC

;~ Description: Talks to NPC and waits until you reach them.
Func GoToNPC($aAgent)
	If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)
	Local $lMe
	Local $lBlocked = 0
	Local $lMapLoading = GetMapLoading(), $lMapLoadingOld

	Move(DllStructGetData($aAgent, 'X'), DllStructGetData($aAgent, 'Y'), 100)
	Sleep(100)
	GoNPC($aAgent)

	Do
		Sleep(100)
		$lMe = GetAgentByID(-2)

		If DllStructGetData($lMe, 'HP') <= 0 Then ExitLoop

		$lMapLoadingOld = $lMapLoading
		$lMapLoading = GetMapLoading()
		If $lMapLoading <> $lMapLoadingOld Then ExitLoop

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			Move(DllStructGetData($aAgent, 'X'), DllStructGetData($aAgent, 'Y'), 100)
			Sleep(100)
			GoNPC($aAgent)
		EndIf
	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), DllStructGetData($aAgent, 'X'), DllStructGetData($aAgent, 'Y')) < 250 Or $lBlocked > 14
	Sleep(GetPing() + Random(1500, 2000, 1))
EndFunc   ;==>GoToNPC

;~ Description: Run to a signpost.
Func GoSignpost($aAgent)
	Local $lAgentID

	If IsDllStruct($aAgent) = 0 Then
		$lAgentID = ConvertID($aAgent)
	Else
		$lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf

	Return SendPacket(0xC, $HEADER_SIGNPOST_RUN, $lAgentID, 0)
EndFunc   ;==>GoSignpost

;~ Description: Go to signpost and waits until you reach it.
Func GoToSignpost($aAgent)
	If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)
	Local $lMe
	Local $lBlocked = 0
	Local $lMapLoading = GetMapLoading(), $lMapLoadingOld

	Move(DllStructGetData($aAgent, 'X'), DllStructGetData($aAgent, 'Y'), 100)
	Sleep(100)
	GoSignpost($aAgent)

	Do
		Sleep(100)
		$lMe = GetAgentByID(-2)

		If DllStructGetData($lMe, 'HP') <= 0 Then ExitLoop

		$lMapLoadingOld = $lMapLoading
		$lMapLoading = GetMapLoading()
		If $lMapLoading <> $lMapLoadingOld Then ExitLoop

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			Move(DllStructGetData($aAgent, 'X'), DllStructGetData($aAgent, 'Y'), 100)
			Sleep(100)
			GoSignpost($aAgent)
		EndIf
	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), DllStructGetData($aAgent, 'X'), DllStructGetData($aAgent, 'Y')) < 250 Or $lBlocked > 14
	Sleep(GetPing() + Random(1500, 2000, 1))
EndFunc   ;==>GoToSignpost

;~ Description: Attack an agent.
Func Attack($aAgent, $aCallTarget = False)
	Local $lAgentID

	If IsDllStruct($aAgent) = 0 Then
		$lAgentID = ConvertID($aAgent)
	Else
		$lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf

	Return SendPacket(0xC, $HEADER_ATTACK_AGENT, $lAgentID, $aCallTarget)
EndFunc   ;==>Attack

;~ Description: Turn character to the left.
Func TurnLeft($aTurn)
	If $aTurn Then
		Return PerformAction(0xA2, 0x1E)
	Else
		Return PerformAction(0xA2, 0x20)
	EndIf
EndFunc   ;==>TurnLeft

;~ Description: Turn character to the right.
Func TurnRight($aTurn)
	If $aTurn Then
		Return PerformAction(0xA3, 0x1E)
	Else
		Return PerformAction(0xA3, 0x20)
	EndIf
EndFunc   ;==>TurnRight

;~ Description: Move backwards.
Func MoveBackward($aMove)
	If $aMove Then
		Return PerformAction(0xAC, 0x1E)
	Else
		Return PerformAction(0xAC, 0x20)
	EndIf
EndFunc   ;==>MoveBackward

;~ Description: Run forwards.
Func MoveForward($aMove)
	If $aMove Then
		Return PerformAction(0xAD, 0x1E)
	Else
		Return PerformAction(0xAD, 0x20)
	EndIf
EndFunc   ;==>MoveForward

;~ Description: Strafe to the left.
Func StrafeLeft($aStrafe)
	If $aStrafe Then
		Return PerformAction(0x91, 0x1E)
	Else
		Return PerformAction(0x91, 0x20)
	EndIf
EndFunc   ;==>StrafeLeft

;~ Description: Strafe to the right.
Func StrafeRight($aStrafe)
	If $aStrafe Then
		Return PerformAction(0x92, 0x1E)
	Else
		Return PerformAction(0x92, 0x20)
	EndIf
EndFunc   ;==>StrafeRight

;~ Description: Auto-run.
Func ToggleAutoRun()
	Return PerformAction(0xB7, 0x1E)
EndFunc   ;==>ToggleAutoRun

;~ Description: Turn around.
Func ReverseDirection()
	Return PerformAction(0xB1, 0x1E)
EndFunc   ;==>ReverseDirection
#EndRegion Movement

#Region Travel
Func RndTravel($aMapID) ;Travel to a random region in the outpost
	Local $UseDistricts = 11 ; 7=eu-only, 8=eu+int, 11=all(excluding America)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$random], 0, $Language[$random])
	WaitMapLoading($aMapID)
EndFunc   ;==>RndTravel


;~ Description: Map travel to an outpost.
Func TravelTo($aMapID, $aDis = 0)
	;returns true if successful
	If GetMapID() = $aMapID And $aDis = 0 And GetMapLoading() = 0 Then Return True
	ZoneMap($aMapID, $aDis)
	Return WaitMapLoading($aMapID)
EndFunc   ;==>TravelTo

;~ Description: Internal use for map travel.
Func ZoneMap($aMapID, $aDistrict = 0)
	MoveMap($aMapID, GetRegion(), $aDistrict, GetLanguage()) ;
EndFunc   ;==>ZoneMap

;~ Description: Internal use for map travel.
Func MoveMap($aMapID, $aRegion, $aDistrict, $aLanguage)
	Return SendPacket(0x18, $HEADER_MAP_TRAVEL, $aMapID, $aRegion, $aDistrict, $aLanguage, False)
EndFunc   ;==>MoveMap

;~ Description: Returns to outpost after resigning/failure.
Func ReturnToOutpost()
	Return SendPacket(0x4, $HEADER_OUTPOST_RETURN)
EndFunc   ;==>ReturnToOutpost

;~ Description: Enter a challenge mission/pvp.
Func EnterChallenge()
	Return SendPacket(0x8, $HEADER_MISSION_ENTER, 1)
EndFunc   ;==>EnterChallenge

;~ Description: Enter a foreign challenge mission/pvp.
Func EnterChallengeForeign()
	Return SendPacket(0x8, $HEADER_MISSION_FOREIGN_ENTER, 0)
EndFunc   ;==>EnterChallengeForeign

;~ Description: Travel to your guild hall.
Func TravelGH()
	Local $lOffset[3] = [0, 0x18, 0x3C]
	Local $lGH = MemoryReadPtr($mBasePointer, $lOffset)
	SendPacket(0x18, $HEADER_GUILDHALL_TRAVEL, MemoryRead($lGH[1] + 0x64), MemoryRead($lGH[1] + 0x68), MemoryRead($lGH[1] + 0x6C), MemoryRead($lGH[1] + 0x70), 1)
	Return WaitMapLoading()
EndFunc   ;==>TravelGH

;~ Description: Leave your guild hall.
Func LeaveGH()
	SendPacket(0x8, $HEADER_GUILDHALL_LEAVE, 1)
	Return WaitMapLoading()
EndFunc   ;==>LeaveGH
#EndRegion Travel

#Region Quest
;~ Description: Accept a quest from an NPC.
Func AcceptQuest($aQuestID)
	Return SendPacket(0x8, $HEADER_QUEST_ACCEPT, '0x008' & Hex($aQuestID, 3) & '01')
EndFunc   ;==>AcceptQuest

;~ Description: Accept the reward for a quest.
Func QuestReward($aQuestID)
	Return SendPacket(0x8, $HEADER_QUEST_REWARD, '0x008' & Hex($aQuestID, 3) & '07')
EndFunc   ;==>QuestReward

;~ Description: Abandon a quest.
Func AbandonQuest($aQuestID)
	Return SendPacket(0x8, $HEADER_QUEST_ABANDON, $aQuestID)
EndFunc   ;==>AbandonQuest
#EndRegion Quest

#Region Windows
;~ Description: Close all in-game windows.
Func CloseAllPanels()
	Return PerformAction(0x85, 0x1E)
EndFunc   ;==>CloseAllPanels

;~ Description: Toggle hero window.
Func ToggleHeroWindow()
	Return PerformAction(0x8A, 0x1E)
EndFunc   ;==>ToggleHeroWindow

;~ Description: Toggle inventory window.
Func ToggleInventory()
	Return PerformAction(0x8B, 0x1E)
EndFunc   ;==>ToggleInventory

;~ Description: Toggle all bags window.
Func ToggleAllBags()
	Return PerformAction(0xB8, 0x1E)
EndFunc   ;==>ToggleAllBags

;~ Description: Toggle world map.
Func ToggleWorldMap()
	Return PerformAction(0x8C, 0x1E)
EndFunc   ;==>ToggleWorldMap

;~ Description: Toggle options window.
Func ToggleOptions()
	Return PerformAction(0x8D, 0x1E)
EndFunc   ;==>ToggleOptions

;~ Description: Toggle quest window.
Func ToggleQuestWindow()
	Return PerformAction(0x8E, 0x1E)
EndFunc   ;==>ToggleQuestWindow

;~ Description: Toggle skills window.
Func ToggleSkillWindow()
	Return PerformAction(0x8F, 0x1E)
EndFunc   ;==>ToggleSkillWindow

;~ Description: Toggle mission map.
Func ToggleMissionMap()
	Return PerformAction(0xB6, 0x1E)
EndFunc   ;==>ToggleMissionMap

;~ Description: Toggle friends list window.
Func ToggleFriendList()
	Return PerformAction(0xB9, 0x1E)
EndFunc   ;==>ToggleFriendList

;~ Description: Toggle guild window.
Func ToggleGuildWindow()
	Return PerformAction(0xBA, 0x1E)
EndFunc   ;==>ToggleGuildWindow

;~ Description: Toggle party window.
Func TogglePartyWindow()
	Return PerformAction(0xBF, 0x1E)
EndFunc   ;==>TogglePartyWindow

;~ Description: Toggle score chart.
Func ToggleScoreChart()
	Return PerformAction(0xBD, 0x1E)
EndFunc   ;==>ToggleScoreChart

;~ Description: Toggle layout window.
Func ToggleLayoutWindow()
	Return PerformAction(0xC1, 0x1E)
EndFunc   ;==>ToggleLayoutWindow

;~ Description: Toggle minions window.
Func ToggleMinionList()
	Return PerformAction(0xC2, 0x1E)
EndFunc   ;==>ToggleMinionList

;~ Description: Toggle a hero panel.
Func ToggleHeroPanel($aHero)
	If $aHero < 4 Then
		Return PerformAction(0xDB + $aHero, 0x1E)
	ElseIf $aHero < 8 Then
		Return PerformAction(0xFE + $aHero, 0x1E)
	EndIf
EndFunc   ;==>ToggleHeroPanel

;~ Description: Toggle hero's pet panel.
Func ToggleHeroPetPanel($aHero)
	If $aHero < 4 Then
		Return PerformAction(0xDF + $aHero, 0x1E)
	ElseIf $aHero < 8 Then
		Return PerformAction(0xFA + $aHero, 0x1E)
	EndIf
EndFunc   ;==>ToggleHeroPetPanel

;~ Description: Toggle pet panel.
Func TogglePetPanel()
	Return PerformAction(0xDF, 0x1E)
EndFunc   ;==>TogglePetPanel

;~ Description: Toggle help window.
Func ToggleHelpWindow()
	Return PerformAction(0xE4, 0x1E)
EndFunc   ;==>ToggleHelpWindow
#EndRegion Windows

#Region Targeting
;~ Description: Target an agent.
Func ChangeTarget($aAgent)
	Local $lAgentID

	If IsDllStruct($aAgent) = 0 Then
		$lAgentID = ConvertID($aAgent)
	Else
		$lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf

	DllStructSetData($mChangeTarget, 2, $lAgentID)
	Enqueue($mChangeTargetPtr, 8)
EndFunc   ;==>ChangeTarget

;~ Description: Call target.
Func CallTarget($aTarget)
	Local $lTargetID

	If IsDllStruct($aTarget) = 0 Then
		$lTargetID = ConvertID($aTarget)
	Else
		$lTargetID = DllStructGetData($aTarget, 'ID')
	EndIf

	Return SendPacket(0xC, $HEADER_CALL_TARGET, 0xA, $lTargetID)
EndFunc   ;==>CallTarget

;~ Description: Clear current target.
Func ClearTarget()
	Return PerformAction(0xE3, 0x1E)
EndFunc   ;==>ClearTarget

;~ Description: Target the nearest enemy.
Func TargetNearestEnemy()
	Return PerformAction(0x93, 0x1E)
EndFunc   ;==>TargetNearestEnemy

;~ Description: Target the next enemy.
Func TargetNextEnemy()
	Return PerformAction(0x95, 0x1E)
EndFunc   ;==>TargetNextEnemy

;~ Description: Target the next party member.
Func TargetPartyMember($aNumber)
	If $aNumber > 0 And $aNumber < 13 Then Return PerformAction(0x95 + $aNumber, 0x1E)
EndFunc   ;==>TargetPartyMember

;~ Description: Target the previous enemy.
Func TargetPreviousEnemy()
	Return PerformAction(0x9E, 0x1E)
EndFunc   ;==>TargetPreviousEnemy

;~ Description: Target the called target.
Func TargetCalledTarget()
	Return PerformAction(0x9F, 0x1E)
EndFunc   ;==>TargetCalledTarget

;~ Description: Target yourself.
Func TargetSelf()
	Return PerformAction(0xA0, 0x1E)
EndFunc   ;==>TargetSelf

;~ Description: Target the nearest ally.
Func TargetNearestAlly()
	Return PerformAction(0xBC, 0x1E)
EndFunc   ;==>TargetNearestAlly

;~ Description: Target the nearest item.
Func TargetNearestItem()
	Return PerformAction(0xC3, 0x1E)
EndFunc   ;==>TargetNearestItem

;~ Description: Target the next item.
Func TargetNextItem()
	Return PerformAction(0xC4, 0x1E) ;PerformAction(0xC4, 0x18)
EndFunc   ;==>TargetNextItem

;~ Description: Target the previous item.
Func TargetPreviousItem()
	Return PerformAction(0xC5, 0x1E)
EndFunc   ;==>TargetPreviousItem

;~ Description: Target the next party member.
Func TargetNextPartyMember()
	Return PerformAction(0xCA, 0x1E)
EndFunc   ;==>TargetNextPartyMember

;~ Description: Target the previous party member.
Func TargetPreviousPartyMember()
	Return PerformAction(0xCB, 0x1E)
EndFunc   ;==>TargetPreviousPartyMember
#EndRegion Targeting

#Region Display
;~ Description: Enable graphics rendering.
Func EnableRendering()
	MemoryWrite($mDisableRendering, 0)
EndFunc   ;==>EnableRendering

;~ Description: Disable graphics rendering.
Func DisableRendering()
	MemoryWrite($mDisableRendering, 1)
EndFunc   ;==>DisableRendering

;~ Description: Display all names.
Func DisplayAll($aDisplay)
	DisplayAllies($aDisplay)
	DisplayEnemies($aDisplay)
EndFunc   ;==>DisplayAll

;~ Description: Display the names of allies.
Func DisplayAllies($aDisplay)
	If $aDisplay Then
		Return PerformAction(0x89, 0x1E)
	Else
		Return PerformAction(0x89, 0x20)
	EndIf
EndFunc   ;==>DisplayAllies

;~ Description: Display the names of enemies.
Func DisplayEnemies($aDisplay)
	If $aDisplay Then
		Return PerformAction(0x94, 0x1E)
	Else
		Return PerformAction(0x94, 0x20)
	EndIf
EndFunc   ;==>DisplayEnemies
#EndRegion Display

#Region Chat
;~ Description: Write a message in chat (can only be seen by botter).
Func WriteChat($aMessage, $aSender = 'GWA�')
	Local $lMessage, $lSender
	Local $lAddress = 256 * $mQueueCounter + $mQueueBase

	If $mQueueCounter = $mQueueSize Then
		$mQueueCounter = 0
	Else
		$mQueueCounter = $mQueueCounter + 1
	EndIf

	If StringLen($aSender) > 19 Then
		$lSender = StringLeft($aSender, 19)
	Else
		$lSender = $aSender
	EndIf

	MemoryWrite($lAddress + 4, $lSender, 'wchar[20]')

	If StringLen($aMessage) > 100 Then
		$lMessage = StringLeft($aMessage, 100)
	Else
		$lMessage = $aMessage
	EndIf

	MemoryWrite($lAddress + 44, $lMessage, 'wchar[101]')
	DllCall($mKernelHandle, 'int', 'WriteProcessMemory', 'int', $mGWProcHandle, 'int', $lAddress, 'ptr', $mWriteChatPtr, 'int', 4, 'int', '')

	If StringLen($aMessage) > 100 Then WriteChat(StringTrimLeft($aMessage, 100), $aSender)
EndFunc   ;==>WriteChat

;~ Description: Send a whisper to another player.
Func SendWhisper($aReceiver, $aMessage)
	Local $lTotal = 'whisper ' & $aReceiver & ',' & $aMessage
	Local $lMessage

	If StringLen($lTotal) > 120 Then
		$lMessage = StringLeft($lTotal, 120)
	Else
		$lMessage = $lTotal
	EndIf

	SendChat($lMessage, '/')

	If StringLen($lTotal) > 120 Then SendWhisper($aReceiver, StringTrimLeft($lTotal, 120))
EndFunc   ;==>SendWhisper

;~ Description: Send a message to chat.
Func SendChat($aMessage, $aChannel = '!')
	Local $lMessage
	Local $lAddress = 256 * $mQueueCounter + $mQueueBase

	If $mQueueCounter = $mQueueSize Then
		$mQueueCounter = 0
	Else
		$mQueueCounter = $mQueueCounter + 1
	EndIf

	If StringLen($aMessage) > 120 Then
		$lMessage = StringLeft($aMessage, 120)
	Else
		$lMessage = $aMessage
	EndIf

	MemoryWrite($lAddress + 12, $aChannel & $lMessage, 'wchar[122]')
	DllCall($mKernelHandle, 'int', 'WriteProcessMemory', 'int', $mGWProcHandle, 'int', $lAddress, 'ptr', $mSendChatPtr, 'int', 8, 'int', '')
EndFunc   ;==>SendChat
#EndRegion Chat

#Region Misc
;~ Description: Change weapon sets.
Func ChangeWeaponSet($aSet)
	Return PerformAction(0x80 + $aSet, 0x1E) ;Return PerformAction(0x80 + $aSet, 0x1E) 0x14A
EndFunc   ;==>ChangeWeaponSet

;~ Description: Use a skill.
Func UseSkill($aSkillSlot, $aTarget, $aCallTarget = False)
	Local $lTargetID

	If IsDllStruct($aTarget) = 0 Then
		$lTargetID = ConvertID($aTarget)
	Else
		$lTargetID = DllStructGetData($aTarget, 'ID')
	EndIf

	DllStructSetData($mUseSkill, 2, $aSkillSlot)
	DllStructSetData($mUseSkill, 3, $lTargetID)
	DllStructSetData($mUseSkill, 4, $aCallTarget)
	Enqueue($mUseSkillPtr, 16)
EndFunc   ;==>UseSkill

Func UseSkillEx2($lSkill, $lTgt = -2, $aTimeout = 3000)
	If GetIsDead(-2) Then Return
	If Not IsRecharged($lSkill) Then Return
	Local $Skill = GetSkillByID(GetSkillbarSkillID($lSkill, 0))
	Local $Energy = StringReplace(StringReplace(StringReplace(StringMid(DllStructGetData($Skill, 'Unknown4'), 6, 1), 'C', '25'), 'B', '15'), 'A', '10')
	If GetEnergy(-2) < $Energy Then Return
	Local $lAftercast = DllStructGetData($Skill, 'Aftercast')
	Local $lDeadlock = TimerInit()
	UseSkill($lSkill, $lTgt)
	Do
		Sleep(50)
		If GetIsDead(-2) = 1 Then Return
	Until (Not IsRecharged($lSkill)) Or (TimerDiff($lDeadlock) > $aTimeout)
	Sleep($lAftercast * 1000)
EndFunc   ;==>UseSkillEx2

Func IsRecharged($lSkill)
	Return GetSkillbarSkillRecharge($lSkill) == 0
EndFunc   ;==>IsRecharged

;~ Description: Cancel current action.
Func CancelAction()
	Return SendPacket(0x4, $HEADER_CANCEL_ACTION)
EndFunc   ;==>CancelAction

;~ Description: Same as hitting spacebar.
Func ActionInteract()
	Return PerformAction(0x80, 0x1E)
EndFunc   ;==>ActionInteract

;~ Description: Follow a player.
Func ActionFollow()
	Return PerformAction(0xCC, 0x1E)
EndFunc   ;==>ActionFollow

;~ Description: Drop environment object.
Func DropBundle()
	Return PerformAction(0xCD, 0x1E)
EndFunc   ;==>DropBundle

;~ Description: Clear all hero flags.
Func ClearPartyCommands()
	Return PerformAction(0xDB, 0x1E)
EndFunc   ;==>ClearPartyCommands

;~ Description: Suppress action.
Func SuppressAction($aSuppress)
	If $aSuppress Then
		Return PerformAction(0xD0, 0x1E)
	Else
		Return PerformAction(0xD0, 0x20)
	EndIf
EndFunc   ;==>SuppressAction

;~ Description: Open a chest.
Func OpenChest()
	Return SendPacket(0x8, $HEADER_CHEST_OPEN, 2)
EndFunc   ;==>OpenChest

;~ Description: Stop maintaining enchantment on target.
Func DropBuff($aSkillID, $aAgentID, $aHeroNumber = 0)
	Local $lBuffStruct = DllStructCreate('long SkillId;byte unknown1[4];long BuffId;long TargetId')
	Local $lBuffCount = GetBuffCount($aHeroNumber)
	Local $lBuffStructAddress
	Local $lOffset[4]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x510
	Local $lCount = MemoryReadPtr($mBasePointer, $lOffset)
	ReDim $lOffset[5]
	$lOffset[3] = 0x508
	Local $lBuffer
	For $i = 0 To $lCount[1] - 1
		$lOffset[4] = 0x24 * $i
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] == GetHeroID($aHeroNumber) Then
			$lOffset[4] = 0x4 + 0x24 * $i
			ReDim $lOffset[6]
			For $j = 0 To $lBuffCount - 1
				$lOffset[5] = 0 + 0x10 * $j
				$lBuffStructAddress = MemoryReadPtr($mBasePointer, $lOffset)
				DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lBuffStructAddress[0], 'ptr', DllStructGetPtr($lBuffStruct), 'int', DllStructGetSize($lBuffStruct), 'int', '')
				If (DllStructGetData($lBuffStruct, 'SkillID') == $aSkillID) And (DllStructGetData($lBuffStruct, 'TargetId') == ConvertID($aAgentID)) Then
;~ 					out(DllStructGetData($lBuffStruct, 'BuffId'))
					Return SendPacket(0x8, $HEADER_STOP_MAINTAIN_ENCH, DllStructGetData($lBuffStruct, 'BuffId'))
					ExitLoop 2
				EndIf
			Next
		EndIf
	Next
EndFunc   ;==>DropBuff

;~ Description: Take a screenshot.
Func MakeScreenshot()
	Return PerformAction(0xAE, 0x1E)
EndFunc   ;==>MakeScreenshot

;~ Description: Invite a player to the party.
Func InvitePlayer($aPlayerName)
	SendChat('invite ' & $aPlayerName, '/')
EndFunc   ;==>InvitePlayer

;~ Description: Leave your party.
Func LeaveGroup($aKickHeroes = True)
	If $aKickHeroes Then KickAllHeroes()
	Return SendPacket(0x4, $HEADER_PARTY_LEAVE)
EndFunc   ;==>LeaveGroup

;~ Description: Switches to/from Hard Mode.
Func SwitchMode($aMode)
	Return SendPacket(0x8, $HEADER_MODE_SWITCH, $aMode)
EndFunc   ;==>SwitchMode

;~ Description: Resign.
Func Resign()
	SendChat('resign', '/')
EndFunc   ;==>Resign

;~ Description: Donate Kurzick or Luxon faction.
Func DonateFaction($aFaction)
	If StringLeft($aFaction, 1) = 'k' Then
		Return SendPacket(0x10, $HEADER_FACTION_DONATE, 0, 0, 5000)
	Else
		Return SendPacket(0x10, $HEADER_FACTION_DONATE, 0, 1, 5000)
	EndIf
EndFunc   ;==>DonateFaction

;~ Description: Open a dialog.
Func Dialog($aDialogID)
	Return SendPacket(0x8, $HEADER_DIALOG, $aDialogID)
EndFunc   ;==>Dialog

;~ Description: Skip a cinematic.
Func SkipCinematic()
	Return SendPacket(0x4, $HEADER_CINEMATIC_SKIP)
EndFunc   ;==>SkipCinematic

;~ Description: Change a skill on the skillbar.
Func SetSkillbarSkill($aSlot, $aSkillID, $aHeroNumber = 0)
	Return SendPacket(0x14, $HEADER_SET_SKILLBAR_SKILL, GetHeroID($aHeroNumber), $aSlot - 1, $aSkillID, 0)
EndFunc   ;==>SetSkillbarSkill

;~ Description: Load all skills onto a skillbar simultaneously.
Func LoadSkillBar($aSkill1 = 0, $aSkill2 = 0, $aSkill3 = 0, $aSkill4 = 0, $aSkill5 = 0, $aSkill6 = 0, $aSkill7 = 0, $aSkill8 = 0, $aHeroNumber = 0)
	SendPacket(0x2C, $HEADER_LOAD_SKILLBAR, GetHeroID($aHeroNumber), 8, $aSkill1, $aSkill2, $aSkill3, $aSkill4, $aSkill5, $aSkill6, $aSkill7, $aSkill8)
EndFunc   ;==>LoadSkillBar

; Description: Loads skill template code.
Func LoadSkillTemplate($aTemplate, $aHeroNumber = 0)
;~ 	Local $lHeroID = GetHeroID($aHeroNumber)
	Local $lSplitTemplate = StringSplit($aTemplate, '')

	Local $lTemplateType ; 4 Bits
;~ 	Local $lVersionNumber ; 4 Bits
	Local $lProfBits ; 2 Bits -> P
	Local $lProfPrimary ; P Bits
	Local $lProfSecondary ; P Bits
	Local $lAttributesCount ; 4 Bits
	Local $lAttributesBits ; 4 Bits -> A
	Local $lAttributes[1][2] ; A Bits + 4 Bits (for each Attribute)
	Local $lSkillsBits ; 4 Bits -> S
	Local $lSkills[8] ; S Bits * 8
;~ 	Local $lOpTail ; 1 Bit

	$aTemplate = ''
	For $i = 1 To $lSplitTemplate[0]
		$aTemplate &= Base64ToBin64($lSplitTemplate[$i])
	Next

	$lTemplateType = Bin64ToDec(StringLeft($aTemplate, 4))
	$aTemplate = StringTrimLeft($aTemplate, 4)
	If $lTemplateType <> 14 Then Return False

;~ 	$lVersionNumber = Bin64ToDec(StringLeft($aTemplate, 4))
	$aTemplate = StringTrimLeft($aTemplate, 4)

	$lProfBits = Bin64ToDec(StringLeft($aTemplate, 2)) * 2 + 4
	$aTemplate = StringTrimLeft($aTemplate, 2)

	$lProfPrimary = Bin64ToDec(StringLeft($aTemplate, $lProfBits))
	$aTemplate = StringTrimLeft($aTemplate, $lProfBits)
	If $lProfPrimary <> GetHeroProfession($aHeroNumber) Then Return False

	$lProfSecondary = Bin64ToDec(StringLeft($aTemplate, $lProfBits))
	$aTemplate = StringTrimLeft($aTemplate, $lProfBits)

	$lAttributesCount = Bin64ToDec(StringLeft($aTemplate, 4))
	$aTemplate = StringTrimLeft($aTemplate, 4)

	$lAttributesBits = Bin64ToDec(StringLeft($aTemplate, 4)) + 4
	$aTemplate = StringTrimLeft($aTemplate, 4)

	$lAttributes[0][0] = $lAttributesCount
	For $i = 1 To $lAttributesCount
		If Bin64ToDec(StringLeft($aTemplate, $lAttributesBits)) == GetProfPrimaryAttribute($lProfPrimary) Then
			$aTemplate = StringTrimLeft($aTemplate, $lAttributesBits)
			$lAttributes[0][1] = Bin64ToDec(StringLeft($aTemplate, 4))
			$aTemplate = StringTrimLeft($aTemplate, 4)
			ContinueLoop
		EndIf
		$lAttributes[0][0] += 1
		ReDim $lAttributes[$lAttributes[0][0] + 1][2]
		$lAttributes[$i][0] = Bin64ToDec(StringLeft($aTemplate, $lAttributesBits))
		$aTemplate = StringTrimLeft($aTemplate, $lAttributesBits)
		$lAttributes[$i][1] = Bin64ToDec(StringLeft($aTemplate, 4))
		$aTemplate = StringTrimLeft($aTemplate, 4)
	Next

	$lSkillsBits = Bin64ToDec(StringLeft($aTemplate, 4)) + 8
	$aTemplate = StringTrimLeft($aTemplate, 4)

	For $i = 0 To 7
		$lSkills[$i] = Bin64ToDec(StringLeft($aTemplate, $lSkillsBits))
		$aTemplate = StringTrimLeft($aTemplate, $lSkillsBits)
	Next

;~ 	$lOpTail = Bin64ToDec($aTemplate)

	$lAttributes[0][0] = $lProfSecondary
	LoadAttributes($lAttributes, $aHeroNumber)
	LoadSkillBar($lSkills[0], $lSkills[1], $lSkills[2], $lSkills[3], $lSkills[4], $lSkills[5], $lSkills[6], $lSkills[7], $aHeroNumber)
EndFunc   ;==>LoadSkillTemplate

; Description: Load attributes from a two dimensional array.
Func LoadAttributes($aAttributesArray, $aHeroNumber = 0)
	Local $lPrimaryAttribute
	Local $lDeadlock
;~ 	Local $lHeroID = GetHeroID($aHeroNumber)
	Local $lLevel

	$lPrimaryAttribute = GetProfPrimaryAttribute(GetHeroProfession($aHeroNumber))

	If $aAttributesArray[0][0] <> 0 And GetHeroProfession($aHeroNumber, True) <> $aAttributesArray[0][0] And GetHeroProfession($aHeroNumber) <> $aAttributesArray[0][0] Then
		Do
			$lDeadlock = TimerInit()
			ChangeSecondProfession($aAttributesArray[0][0], $aHeroNumber)
			Do
				Sleep(20)
			Until GetHeroProfession($aHeroNumber, True) == $aAttributesArray[0][0] Or TimerDiff($lDeadlock) > 5000
		Until GetHeroProfession($aHeroNumber, True) == $aAttributesArray[0][0]
	EndIf

	$aAttributesArray[0][0] = $lPrimaryAttribute
	For $i = 0 To UBound($aAttributesArray) - 1
		If $aAttributesArray[$i][1] > 12 Then $aAttributesArray[$i][1] = 12
		If $aAttributesArray[$i][1] < 0 Then $aAttributesArray[$i][1] = 0
	Next

	While GetAttributeByID($lPrimaryAttribute, False, $aHeroNumber) > $aAttributesArray[0][1]
		$lLevel = GetAttributeByID($lPrimaryAttribute, False, $aHeroNumber)
		$lDeadlock = TimerInit()
		DecreaseAttribute($lPrimaryAttribute, $aHeroNumber)
		Do
			Sleep(20)
		Until GetAttributeByID($lPrimaryAttribute, False, $aHeroNumber) < $lLevel Or TimerDiff($lDeadlock) > 5000
		TolSleep()
	WEnd
	For $i = 1 To UBound($aAttributesArray) - 1
		While GetAttributeByID($aAttributesArray[$i][0], False, $aHeroNumber) > $aAttributesArray[$i][1]
			$lLevel = GetAttributeByID($aAttributesArray[$i][0], False, $aHeroNumber)
			$lDeadlock = TimerInit()
			DecreaseAttribute($aAttributesArray[$i][0], $aHeroNumber)
			Do
				Sleep(20)
			Until GetAttributeByID($aAttributesArray[$i][0], False, $aHeroNumber) < $lLevel Or TimerDiff($lDeadlock) > 5000
			TolSleep()
		WEnd
	Next
	For $i = 0 To 44
		If GetAttributeByID($i, False, $aHeroNumber) > 0 Then
			If $i = $lPrimaryAttribute Then ContinueLoop
			For $j = 1 To UBound($aAttributesArray) - 1
				If $i = $aAttributesArray[$j][0] Then ContinueLoop 2

			Next
			While GetAttributeByID($i, False, $aHeroNumber) > 0
				$lLevel = GetAttributeByID($i, False, $aHeroNumber)
				$lDeadlock = TimerInit()
				DecreaseAttribute($i, $aHeroNumber)
				Do
					Sleep(20)
				Until GetAttributeByID($i, False, $aHeroNumber) < $lLevel Or TimerDiff($lDeadlock) > 5000
				TolSleep()
			WEnd
		EndIf
	Next

	While GetAttributeByID($lPrimaryAttribute, False, $aHeroNumber) < $aAttributesArray[0][1]
		$lLevel = GetAttributeByID($lPrimaryAttribute, False, $aHeroNumber)
		$lDeadlock = TimerInit()
		IncreaseAttribute($lPrimaryAttribute, $aHeroNumber)
		Do
			Sleep(20)
		Until GetAttributeByID($lPrimaryAttribute, False, $aHeroNumber) > $lLevel Or TimerDiff($lDeadlock) > 5000
		TolSleep()
	WEnd
	For $i = 1 To UBound($aAttributesArray) - 1
		While GetAttributeByID($aAttributesArray[$i][0], False, $aHeroNumber) < $aAttributesArray[$i][1]
			$lLevel = GetAttributeByID($aAttributesArray[$i][0], False, $aHeroNumber)
			$lDeadlock = TimerInit()
			IncreaseAttribute($aAttributesArray[$i][0], $aHeroNumber)
			Do
				Sleep(20)
			Until GetAttributeByID($aAttributesArray[$i][0], False, $aHeroNumber) > $lLevel Or TimerDiff($lDeadlock) > 5000
			TolSleep()
		WEnd
	Next
EndFunc   ;==>LoadAttributes

; Description: Increase attribute by 1
Func IncreaseAttribute($aAttributeID, $aHeroNumber = 0)
	DllStructSetData($mIncreaseAttribute, 2, $aAttributeID)
	DllStructSetData($mIncreaseAttribute, 3, GetHeroID($aHeroNumber))
	Enqueue($mIncreaseAttributePtr, 12)
EndFunc   ;==>IncreaseAttribute

; Description: Decrease attribute by 1
Func DecreaseAttribute($aAttributeID, $aHeroNumber = 0)
	DllStructSetData($mDecreaseAttribute, 2, $aAttributeID)
	DllStructSetData($mDecreaseAttribute, 3, GetHeroID($aHeroNumber))
	Enqueue($mDecreaseAttributePtr, 12)
EndFunc   ;==>DecreaseAttribute

; Description: Set all attributes to 0
Func ClearAttributes($aHeroNumber = 0)
	Local $lLevel
	Local $lDeadlock
	If GetMapLoading() <> 0 Then Return
	For $i = 0 To 44
		If GetAttributeByID($i, False, $aHeroNumber) > 0 Then
			Do
				$lLevel = GetAttributeByID($i, False, $aHeroNumber)
				$lDeadlock = TimerInit()
				DecreaseAttribute($i, $aHeroNumber)
				Do
					Sleep(20)
				Until $lLevel > GetAttributeByID($i, False, $aHeroNumber) Or TimerDiff($lDeadlock) > 5000
				Sleep(100)
			Until GetAttributeByID($i, False, $aHeroNumber) == 0
		EndIf
	Next
EndFunc   ;==>ClearAttributes

; Description: Change your secondary profession.
Func ChangeSecondProfession($aProfession, $aHeroNumber = 0)
	Return SendPacket(0xC, $HEADER_CHANGE_SECONDARY, GetHeroID($aHeroNumber), $aProfession)
EndFunc   ;==>ChangeSecondProfession

;~ Description: Sets value of GetMapIsLoaded() to 0.
Func InitMapLoad()
	MemoryWrite($mMapIsLoaded, 0)
EndFunc   ;==>InitMapLoad

;~ Description: Changes game language to english.
Func EnsureEnglish($aEnsure)
	If $aEnsure Then
		MemoryWrite($mEnsureEnglish, 1)
	Else
		MemoryWrite($mEnsureEnglish, 0)
	EndIf
EndFunc   ;==>EnsureEnglish

;~ Description: Change game language.
Func ToggleLanguage()
	DllStructSetData($mToggleLanguage, 2, 0x18)
	Enqueue($mToggleLanguagePtr, 8)
EndFunc   ;==>ToggleLanguage

;~ Description: Changes the maximum distance you can zoom out.
Func ChangeMaxZoom($aZoom = 750)
	MemoryWrite($mZoomStill, $aZoom, "float")
	MemoryWrite($mZoomMoving, $aZoom, "float")
EndFunc   ;==>ChangeMaxZoom

;~ Description: Emptys Guild Wars client memory
Func ClearMemory()
	DllCall($mKernelHandle, 'int', 'SetProcessWorkingSetSize', 'int', $mGWProcHandle, 'int', -1, 'int', -1)
EndFunc   ;==>ClearMemory

;~ Description: Changes the maximum memory Guild Wars can use.
Func SetMaxMemory($aMemory = 157286400)
	DllCall($mKernelHandle, 'int', 'SetProcessWorkingSetSizeEx', 'int', $mGWProcHandle, 'int', 1, 'int', $aMemory, 'int', 6)
EndFunc   ;==>SetMaxMemory
#EndRegion Misc

;~ Description: Internal use only.
Func Enqueue($aPtr, $aSize)
	DllCall($mKernelHandle, 'int', 'WriteProcessMemory', 'int', $mGWProcHandle, 'int', 256 * $mQueueCounter + $mQueueBase, 'ptr', $aPtr, 'int', $aSize, 'int', '')
	If $mQueueCounter = $mQueueSize Then
		$mQueueCounter = 0
	Else
		$mQueueCounter = $mQueueCounter + 1
	EndIf
EndFunc   ;==>Enqueue

;~ Description: Converts float to integer.
Func FloatToInt($nFloat)
	Local $tFloat = DllStructCreate("float")
	Local $tInt = DllStructCreate("int", DllStructGetPtr($tFloat))
	DllStructSetData($tFloat, 1, $nFloat)
	Return DllStructGetData($tInt, 1)
EndFunc   ;==>FloatToInt
#EndRegion Commands

#Region Queries
#Region Titles
;~ Description: Returns Hero title progress.
Func GetHeroTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x4]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetHeroTitle

;~ Description: Returns Gladiator title progress.
Func GetGladiatorTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x7C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetGladiatorTitle

Func GetCodexTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x75C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetCodexTitle

;~ Description: Returns Kurzick title progress.
Func GetKurzickTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0xCC]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetKurzickTitle

;~ Description: Returns Luxon title progress.
Func GetLuxonTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0xF4]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetLuxonTitle

;~ Description: Returns drunkard title progress.
Func GetDrunkardTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x11C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetDrunkardTitle

;~ Description: Returns survivor title progress.
Func GetSurvivorTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x16C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetSurvivorTitle

;~ Description: Returns max titles
Func GetMaxTitles()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x194]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetMaxTitles

;~ Description: Returns lucky title progress.
Func GetLuckyTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x25C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetLuckyTitle

;~ Description: Returns unlucky title progress.
Func GetUnluckyTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x284]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetUnluckyTitle

;~ Description: Returns Sunspear title progress.
Func GetSunspearTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x2AC]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetSunspearTitle

;~ Description: Returns Lightbringer title progress.
Func GetLightbringerTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x324]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetLightbringerTitle

;~ Description: Returns Commander title progress.
Func GetCommanderTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x374]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetCommanderTitle

;~ Description: Returns Gamer title progress.
Func GetGamerTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x39C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetGamerTitle

;~ Description: Returns Legendary Guardian title progress.
Func GetLegendaryGuardianTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x4DC]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetLegendaryGuardianTitle

;~ Description: Returns sweets title progress.
Func GetSweetTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x554]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetSweetTitle

;~ Description: Returns Asura title progress.
Func GetAsuraTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x5F4]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetAsuraTitle

;~ Description: Returns Deldrimor title progress.
Func GetDeldrimorTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x61C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetDeldrimorTitle

;~ Description: Returns Vanguard title progress.
Func GetVanguardTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x644]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetVanguardTitle

;~ Description: Returns Norn title progress.
Func GetNornTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x66C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetNornTitle

;~ Description: Returns mastery of the north title progress.
Func GetNorthMasteryTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x694]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetNorthMasteryTitle

;~ Description: Returns party title progress.
Func GetPartyTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x6BC]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetPartyTitle

;~ Description: Returns Zaishen title progress.
Func GetZaishenTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x6E4]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetZaishenTitle

;~ Description: Returns treasure hunter title progress.
Func GetTreasureTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x70C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetTreasureTitle

;~ Description: Returns wisdom title progress.
Func GetWisdomTitle()
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x81C, 0x734]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetWisdomTitle
#EndRegion Titles

#Region Faction
;~ Description: Returns current Kurzick faction.
Func GetKurzickFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x748]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetKurzickFaction

;~ Description: Returns max Kurzick faction.
Func GetMaxKurzickFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x7B8]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetMaxKurzickFaction

;~ Description: Returns current Luxon faction.
Func GetLuxonFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x758]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetLuxonFaction

;~ Description: Returns max Luxon faction.
Func GetMaxLuxonFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x7BC]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetMaxLuxonFaction

;~ Description: Returns current Balthazar faction.
Func GetBalthazarFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x798]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetBalthazarFaction

;~ Description: Returns max Balthazar faction.
Func GetMaxBalthazarFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x7C0]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetMaxBalthazarFaction

;~ Description: Returns current Imperial faction.
Func GetImperialFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x76C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetImperialFaction

;~ Description: Returns max Imperial faction.
Func GetMaxImperialFaction()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x7C4]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetMaxImperialFaction
#EndRegion Faction

#Region Item
;~ Description: Returns rarity (name color) of an item.
Func GetRarity($aItem)
	If Not IsDllStruct($aItem) Then $aItem = GetItemByItemID($aItem)
	Local $lPtr = DllStructGetData($aItem, 'NameString')
	If $lPtr == 0 Then Return
	Return MemoryRead($lPtr, 'ushort')
EndFunc   ;==>GetRarity

;~ Description: Tests if an item is identified.
Func GetIsIDed($aItem)
	If Not IsDllStruct($aItem) Then $aItem = GetItemByItemID($aItem)
	Return BitAND(DllStructGetData($aItem, 'interaction'), 1) > 0
EndFunc   ;==>GetIsIDed

;~ Description: Returns a weapon or shield's minimum required attribute.
Func GetItemReq($aItem)
	Local $lMod = GetModByIdentifier($aItem, "9827")
	Return $lMod[0]
EndFunc   ;==>GetItemReq

;~ Description: Returns a weapon or shield's required attribute.
Func GetItemAttribute($aItem)
	Local $lMod = GetModByIdentifier($aItem, "9827")
	Return $lMod[1]
EndFunc   ;==>GetItemAttribute

;~ Description: Returns an array of a the requested mod.
Func GetModByIdentifier($aItem, $aIdentifier)
	If Not IsDllStruct($aItem) Then $aItem = GetItemByItemID($aItem)
	Local $lReturn[2]
	Local $lString = StringTrimLeft(GetModStruct($aItem), 2)
	For $i = 0 To StringLen($lString) / 8 - 2
		If StringMid($lString, 8 * $i + 5, 4) == $aIdentifier Then
			$lReturn[0] = Int("0x" & StringMid($lString, 8 * $i + 1, 2))
			$lReturn[1] = Int("0x" & StringMid($lString, 8 * $i + 3, 2))
			ExitLoop
		EndIf
	Next
	Return $lReturn
EndFunc   ;==>GetModByIdentifier

;~ Description: Returns modstruct of an item.
Func GetModStruct($aItem)
	If Not IsDllStruct($aItem) Then $aItem = GetItemByItemID($aItem)
	If DllStructGetData($aItem, 'modstruct') = 0 Then Return
	Return MemoryRead(DllStructGetData($aItem, 'modstruct'), 'Byte[' & DllStructGetData($aItem, 'modstructsize') * 4 & ']')
EndFunc   ;==>GetModStruct

;~ Description: Tests if an item is assigned to you.
Func GetAssignedToMe($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return (DllStructGetData($aAgent, 'Owner') = GetMyID())
EndFunc   ;==>GetAssignedToMe

;~ Description: Tests if you can pick up an item.
Func GetCanPickUp($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	If GetAssignedToMe($aAgent) Or DllStructGetData($aAgent, 'Owner') = 0 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>GetCanPickUp

;~ Description: Returns struct of an inventory bag.
Func GetBag($aBag)
	Local $lOffset[5] = [0, 0x18, 0x40, 0xF8, 0x4 * $aBag]
	Local $lBagStruct = DllStructCreate('byte unknown1[4];long index;long id;ptr containerItem;long ItemsCount;ptr bagArray;ptr itemArray;long fakeSlots;long slots')
	Local $lBagPtr = MemoryReadPtr($mBasePointer, $lOffset)
	If $lBagPtr[1] = 0 Then Return
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lBagPtr[1], 'ptr', DllStructGetPtr($lBagStruct), 'int', DllStructGetSize($lBagStruct), 'int', '')
	Return $lBagStruct
EndFunc   ;==>GetBag

;~ Description: Returns item by slot.
Func GetItemBySlot($aBag, $aSlot)
	Local $lBag

	If IsDllStruct($aBag) = 0 Then
		$lBag = GetBag($aBag)
	Else
		$lBag = $aBag
	EndIf

	Local $lItemPtr = DllStructGetData($lBag, 'ItemArray')
	Local $lBuffer = DllStructCreate('ptr')
	Local $lItemStruct = DllStructCreate('long Id;long AgentId;byte Unknown1[4];ptr Bag;ptr ModStruct;long ModStructSize;ptr Customized;byte unknown2[4];byte Type;byte unknown4;short ExtraId;short Value;byte unknown4[2];short Interaction;long ModelId;ptr ModString;byte unknown5[4];ptr NameString;ptr SingleItemName;byte Unknown4[10];byte IsSalvageable;byte Unknown6;byte Quantity;byte Equiped;byte Profession;byte Type2;byte Slot')
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', DllStructGetData($lBag, 'ItemArray') + 4 * ($aSlot - 1), 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', DllStructGetData($lBuffer, 1), 'ptr', DllStructGetPtr($lItemStruct), 'int', DllStructGetSize($lItemStruct), 'int', '')
	Return $lItemStruct
EndFunc   ;==>GetItemBySlot

;~ Description: Returns item struct.
Func GetItemByItemID($aItemID)
;~ 	Local $lItemStruct = DllStructCreate('long id;long agentId;byte unknown1[4];ptr bag;ptr modstruct;long modstructsize;ptr customized;byte unknown2[4];byte type;byte unknown3;short extraId;short value;byte unknown4[2];short interaction;long modelId;ptr modString;byte unknown5[4];ptr NameString;byte unknown6[15];byte quantity;byte equipped;byte unknown7[1];byte slot')
	Local $lItemStruct = DllStructCreate('long Id;long AgentId;byte Unknown1[4];ptr Bag;ptr ModStruct;long ModStructSize;ptr Customized;byte unknown2[4];byte Type;byte unknown4;short ExtraId;short Value;byte unknown4[2];short Interaction;long ModelId;ptr ModString;byte unknown5[4];ptr NameString;ptr SingleItemName;byte Unknown4[10];byte IsSalvageable;byte Unknown6;byte Quantity;byte Equiped;byte Profession;byte Type2;byte Slot')
	Local $lOffset[5] = [0, 0x18, 0x40, 0xB8, 0x4 * $aItemID]
	Local $lItemPtr = MemoryReadPtr($mBasePointer, $lOffset)
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemPtr[1], 'ptr', DllStructGetPtr($lItemStruct), 'int', DllStructGetSize($lItemStruct), 'int', '')
	Return $lItemStruct
EndFunc   ;==>GetItemByItemID

;~ Description: Returns item by agent ID.
Func GetItemByAgentID($aAgentID)
;~ 	Local $lItemStruct = DllStructCreate('long id;long agentId;byte unknown1[4];ptr bag;ptr modstruct;long modstructsize;ptr customized;byte unknown2[4];byte type;byte unknown3;short extraId;short value;byte unknown4[2];short interaction;long modelId;ptr modString;byte unknown5[4];ptr NameString;byte unknown6[15];byte quantity;byte equipped;byte unknown7[1];byte slot')
	Local $lItemStruct = DllStructCreate('long Id;long AgentId;byte Unknown1[4];ptr Bag;ptr ModStruct;long ModStructSize;ptr Customized;byte unknown2[4];byte Type;byte unknown4;short ExtraId;short Value;byte unknown4[2];short Interaction;long ModelId;ptr ModString;byte unknown5[4];ptr NameString;ptr SingleItemName;byte Unknown4[10];byte IsSalvageable;byte Unknown6;byte Quantity;byte Equiped;byte Profession;byte Type2;byte Slot')
	Local $lOffset[4] = [0, 0x18, 0x40, 0xC0]
	Local $lItemArraySize = MemoryReadPtr($mBasePointer, $lOffset)
	Local $lOffset[5] = [0, 0x18, 0x40, 0xB8, 0]
	Local $lItemPtr, $lItemID
	Local $lAgentID = ConvertID($aAgentID)

	For $lItemID = 1 To $lItemArraySize[1]
		$lOffset[4] = 0x4 * $lItemID
		$lItemPtr = MemoryReadPtr($mBasePointer, $lOffset)
		If $lItemPtr[1] = 0 Then ContinueLoop

		DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemPtr[1], 'ptr', DllStructGetPtr($lItemStruct), 'int', DllStructGetSize($lItemStruct), 'int', '')
		If DllStructGetData($lItemStruct, 'AgentID') = $lAgentID Then Return $lItemStruct
	Next
EndFunc   ;==>GetItemByAgentID

;~ Description: Returns item by model ID.
Func GetItemByModelID($aModelID)
;~ 	Local $lItemStruct = DllStructCreate('long id;long agentId;byte unknown1[4];ptr bag;ptr modstruct;long modstructsize;ptr customized;byte unknown2[4];byte type;byte unknown3;short extraId;short value;byte unknown4[2];short interaction;long modelId;ptr modString;byte unknown5[4];ptr NameString;byte unknown6[15];byte quantity;byte equipped;byte unknown7[1];byte slot')
	Local $lItemStruct = DllStructCreate('long Id;long AgentId;byte Unknown1[4];ptr Bag;ptr ModStruct;long ModStructSize;ptr Customized;byte unknown2[4];byte Type;byte unknown4;short ExtraId;short Value;byte unknown4[2];short Interaction;long ModelId;ptr ModString;byte unknown5[4];ptr NameString;ptr SingleItemName;byte Unknown4[10];byte IsSalvageable;byte Unknown6;byte Quantity;byte Equiped;byte Profession;byte Type2;byte Slot')
	Local $lOffset[4] = [0, 0x18, 0x40, 0xC0]
	Local $lItemArraySize = MemoryReadPtr($mBasePointer, $lOffset)
	Local $lOffset[5] = [0, 0x18, 0x40, 0xB8, 0]
	Local $lItemPtr, $lItemID

	For $lItemID = 1 To $lItemArraySize[1]
		$lOffset[4] = 0x4 * $lItemID
		$lItemPtr = MemoryReadPtr($mBasePointer, $lOffset)
		If $lItemPtr[1] = 0 Then ContinueLoop

		DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lItemPtr[1], 'ptr', DllStructGetPtr($lItemStruct), 'int', DllStructGetSize($lItemStruct), 'int', '')
		If DllStructGetData($lItemStruct, 'ModelID') = $aModelID Then Return $lItemStruct
	Next
EndFunc   ;==>GetItemByModelID

;~ Description: Returns amount of gold in storage.
Func GetGoldStorage()
	Local $lOffset[5] = [0, 0x18, 0x40, 0xF8, 0x94]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetGoldStorage

;~ Description: Returns amount of gold being carried.
Func GetGoldCharacter()
	Local $lOffset[5] = [0, 0x18, 0x40, 0xF8, 0x90]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetGoldCharacter

;~ Description: Returns item ID of salvage kit in inventory.
Func FindSalvageKit()
	Local $lItem
	Local $lKit = 0
	Local $lUses = 101
	For $i = 1 To 16
		For $j = 1 To DllStructGetData(GetBag($i), 'Slots')
			$lItem = GetItemBySlot($i, $j)
			Switch DllStructGetData($lItem, 'ModelID')
				Case 2992 ; reg 25 uses salvage kit
					If DllStructGetData($lItem, 'Value') / 2 < $lUses Then
						$lKit = DllStructGetData($lItem, 'ID')
						$lUses = DllStructGetData($lItem, 'Value') / 2
					EndIf
					;Case 2991 ;Expert salvage kit
					;	If DllStructGetData($lItem, 'Value') / 8 < $lUses Then
					;		$lKit = DllStructGetData($lItem, 'ID')
					;		$lUses = DllStructGetData($lItem, 'Value') / 8
					;	EndIf
					;Case 5900 ;Superior Salvage kit
					;	If DllStructGetData($lItem, 'Value') / 10 < $lUses Then
					;		$lKit = DllStructGetData($lItem, 'ID')
					;		$lUses = DllStructGetData($lItem, 'Value') / 10
					;	EndIf
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return $lKit
EndFunc   ;==>FindSalvageKit

;~ Description: Returns item ID of ID kit in inventory.
Func FindIDKit()
	Local $lItem
	Local $lKit = 0
	Local $lUses = 101
	For $i = 1 To 16
		For $j = 1 To DllStructGetData(GetBag($i), 'Slots')
			$lItem = GetItemBySlot($i, $j)
			Switch DllStructGetData($lItem, 'ModelID')
				Case 2989
					If DllStructGetData($lItem, 'Value') / 2 < $lUses Then
						$lKit = DllStructGetData($lItem, 'ID')
						$lUses = DllStructGetData($lItem, 'Value') / 2
					EndIf
				Case 5899
					If DllStructGetData($lItem, 'Value') / 2.5 < $lUses Then
						$lKit = DllStructGetData($lItem, 'ID')
						$lUses = DllStructGetData($lItem, 'Value') / 2.5
					EndIf
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return $lKit
EndFunc   ;==>FindIDKit

;~ Description: Returns the item ID of the quoted item.
Func GetTraderCostID()
	Return MemoryRead($mTraderCostID)
EndFunc   ;==>GetTraderCostID

;~ Description: Returns the cost of the requested item.
Func GetTraderCostValue()
	Return MemoryRead($mTraderCostValue)
EndFunc   ;==>GetTraderCostValue

;~ Description: Internal use for BuyItem()
Func GetMerchantItemsBase()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x24]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetMerchantItemsBase

;~ Description: Internal use for BuyItem()
Func GetMerchantItemsSize()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x28]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetMerchantItemsSize
#EndRegion Item

#Region H&H
;~ Description: Returns number of heroes you control.
Func GetHeroCount()
	Local $lOffset[5]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x4C
	$lOffset[3] = 0x54
	$lOffset[4] = 0x2C
	Local $lHeroCount = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lHeroCount[1]
EndFunc   ;==>GetHeroCount

;~ Description: Returns agent ID of a hero.
Func GetHeroID($aHeroNumber)
	If $aHeroNumber == 0 Then Return GetMyID()
	Local $lOffset[6]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x4C
	$lOffset[3] = 0x54
	$lOffset[4] = 0x24
	$lOffset[5] = 0x18 * ($aHeroNumber - 1)
	Local $lAgentID = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lAgentID[1]
EndFunc   ;==>GetHeroID

;~ Description: Returns hero number by agent ID.
Func GetHeroNumberByAgentID($aAgentID)
	Local $lAgentID
	Local $lOffset[6]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x4C
	$lOffset[3] = 0x54
	$lOffset[4] = 0x24
	For $i = 1 To GetHeroCount()
		$lOffset[5] = 0x18 * ($i - 1)
		$lAgentID = MemoryReadPtr($mBasePointer, $lOffset)
		If $lAgentID[1] == ConvertID($aAgentID) Then Return $i
	Next
	Return 0
EndFunc   ;==>GetHeroNumberByAgentID

;~ Description: Returns hero number by hero ID.
Func GetHeroNumberByHeroID($aHeroId)
	Local $lAgentID
	Local $lOffset[6]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x4C
	$lOffset[3] = 0x54
	$lOffset[4] = 0x24
	For $i = 1 To GetHeroCount()
		$lOffset[5] = 8 + 0x18 * ($i - 1)
		$lAgentID = MemoryReadPtr($mBasePointer, $lOffset)
		If $lAgentID[1] == ConvertID($aHeroId) Then Return $i
	Next
	Return 0
EndFunc   ;==>GetHeroNumberByHeroID

;~ Description: Returns hero's profession ID (when it can't be found by other means)
Func GetHeroProfession($aHeroNumber, $aSecondary = False)
	Local $lOffset[5] = [0, 0x18, 0x2C, 0x6BC, 0]
	Local $lBuffer
	$aHeroNumber = GetHeroID($aHeroNumber)
	For $i = 0 To GetHeroCount()
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] = $aHeroNumber Then
			$lOffset[4] += 4
			If $aSecondary Then $lOffset[4] += 4
			$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
			Return $lBuffer[1]
		EndIf
		$lOffset[4] += 0x14
	Next
EndFunc   ;==>GetHeroProfession

;~ Description: Tests if a hero's skill slot is disabled.
Func GetIsHeroSkillSlotDisabled($aHeroNumber, $aSkillSlot)
	Return BitAND(2 ^ ($aSkillSlot - 1), DllStructGetData(GetSkillbar($aHeroNumber), 'Disabled')) > 0
EndFunc   ;==>GetIsHeroSkillSlotDisabled
#EndRegion H&H

#Region Agent
;~ Description: Returns an agent struct.
Func GetAgentByID($aAgentID = -2)
	;returns dll struct if successful
	Local $lAgentPtr = GetAgentPtr($aAgentID)
	If $lAgentPtr = 0 Then Return 0
	;Offsets: 0x2C=AgentID 0x9C=Type 0xF4=PlayerNumber 0114=Energy Pips
	Local $lAgentStruct = DllStructCreate('ptr vtable;byte unknown1[24];byte unknown2[4];ptr NextAgent;byte unknown3[8];long Id;float Z;byte unknown4[8];float BoxHoverWidth;float BoxHoverHeight;byte unknown5[8];float Rotation;byte unknown6[8];long NameProperties;byte unknown7[24];float X;float Y;byte unknown8[8];float NameTagX;float NameTagY;float NameTagZ;byte unknown9[12];long Type;float MoveX;float MoveY;byte unknown10[28];long Owner;byte unknown30[8];long ExtraType;byte unknown11[24];float AttackSpeed;float AttackSpeedModifier;word PlayerNumber;byte unknown12[6];ptr Equip;byte unknown13[10];byte Primary;byte Secondary;byte Level;byte Team;byte unknown14[6];float EnergyPips;byte unknown[4];float EnergyPercent;long MaxEnergy;byte unknown15[4];float HPPips;byte unknown16[4];float HP;long MaxHP;long Effects;byte unknown17[4];byte Hex;byte unknown18[18];long ModelState;long TypeMap;byte unknown19[16];long InSpiritRange;byte unknown20[16];long LoginNumber;float ModelMode;byte unknown21[4];long ModelAnimation;byte unknown22[32];byte LastStrike;byte Allegiance;word WeaponType;word Skill;byte unknown23[4];word WeaponItemId;word OffhandItemId')
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lAgentPtr, 'ptr', DllStructGetPtr($lAgentStruct), 'int', DllStructGetSize($lAgentStruct), 'int', '')
	Return $lAgentStruct
EndFunc   ;==>GetAgentByID

;~ Func GetAgentByID($aAgentID = -2)
;~     ; returns dll struct if successful
;~     Local $lAgentPtr = GetAgentPtr($aAgentID)
;~     If $lAgentPtr = 0 Then Return 0

;~     ; Create the agent struct template
;~     Local $lAgentStruct = DllStructCreate('ptr vtable;byte unknown1[24];byte unknown2[4];ptr NextAgent;byte unknown3[8];long Id;float Z;byte unknown4[8];float BoxHoverWidth;float BoxHoverHeight;byte unknown5[8];float Rotation;byte unknown6[8];long NameProperties;byte unknown7[24];float X;float Y;byte unknown8[8];float NameTagX;float NameTagY;float NameTagZ;byte unknown9[12];long Type;float MoveX;float MoveY;byte unknown10[28];long Owner;byte unknown30[8];long ExtraType;byte unknown11[24];float AttackSpeed;float AttackSpeedModifier;word PlayerNumber;byte unknown12[6];ptr Equip;byte unknown13[10];byte Primary;byte Secondary;byte Level;byte Team;byte unknown14[6];float EnergyPips;byte unknown[4];float EnergyPercent;long MaxEnergy;byte unknown15[4];float HPPips;byte unknown16[4];float HP;long MaxHP;long Effects;byte unknown17[4];byte Hex;byte unknown18[18];long ModelState;long TypeMap;byte unknown19[16];long InSpiritRange;byte unknown20[16];long LoginNumber;float ModelMode;byte unknown21[4];long ModelAnimation;byte unknown22[32];byte LastStrike;byte Allegiance;word WeaponType;word Skill;byte unknown23[4];word WeaponItemId;word OffhandItemId')

;~     ; Read the agent struct from memory
;~     DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lAgentPtr, 'ptr', DllStructGetPtr($lAgentStruct), 'int', DllStructGetSize($lAgentStruct), 'int', '')

;~     Return $lAgentStruct
;~ EndFunc   ;==>GetAgentByID


;~ Description: Internal use for GetAgentByID()
Func GetAgentPtr($aAgentID)
	Local $lOffset[3] = [0, 4 * ConvertID($aAgentID), 0]
	Local $lAgentStructAddress = MemoryReadPtr($mAgentBase, $lOffset)
	Return $lAgentStructAddress[0]
EndFunc   ;==>GetAgentPtr

;~ Description: Test if an agent exists.
Func GetAgentExists($aAgentID)
	Return (GetAgentPtr($aAgentID) > 0 And $aAgentID < GetMaxAgents())
EndFunc   ;==>GetAgentExists

;~ Description: Returns the target of an agent.
Func GetTarget($aAgent)
	Local $lAgentID

	If IsDllStruct($aAgent) = 0 Then
		$lAgentID = ConvertID($aAgent)
	Else
		$lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf

	Return MemoryRead(GetValue('TargetLogBase') + 4 * $lAgentID)
EndFunc   ;==>GetTarget

;~ Description: Returns agent by player name.
Func GetAgentByPlayerName($aPlayerName)
	For $i = 1 To GetMaxAgents()
		If GetPlayerName($i) = $aPlayerName Then
			Return GetAgentByID($i)
		EndIf
	Next
EndFunc   ;==>GetAgentByPlayerName

;~ Description: Returns agent by name.
Func GetAgentByName($aName)
	If $mUseStringLog = False Then Return

	Local $lName, $lAddress

	For $i = 1 To GetMaxAgents()
		$lAddress = $mStringLogBase + 256 * $i
		$lName = MemoryRead($lAddress, 'wchar [128]')
		$lName = StringRegExpReplace($lName, '[<]{1}([^>]+)[>]{1}', '')
		If StringInStr($lName, $aName) > 0 Then Return GetAgentByID($i)
	Next

	;update local names the lazy way
	DisplayAll(True)
	Sleep(100)
	DisplayAll(False)
	DisplayAll(True)
	Sleep(100)
	DisplayAll(False)

	For $i = 1 To GetMaxAgents()
		$lAddress = $mStringLogBase + 256 * $i
		$lName = MemoryRead($lAddress, 'wchar [128]')
		$lName = StringRegExpReplace($lName, '[<]{1}([^>]+)[>]{1}', '')
		If StringInStr($lName, $aName) > 0 Then Return GetAgentByID($i)
	Next
EndFunc   ;==>GetAgentByName

;~ Description: Returns agent by name.
;~ Func GetAgentByName($aName, $ACHANGETARGET = True)
;~     If $mUseStringLog = False Then Return
;~     ;MemoryWrite(GetValue('AgentNameLogCurrentSize'), 0, 'DWORD')
;~     ;MemoryWrite($mAgentNameLogBase, 0, 'byte[' & ( 256 * 200 ) &']')
;~     DisplayAll(True)
;~     Sleep(2000)
;~     Local $lName, $lAddress
;~     ;ConsoleWrite($aName & ' ' & GetMaxAgents())
;~     For $i = 1 To (GetMaxAgents() + 1)
;~         $lAddress = $mAgentNameLogBase + 256 * $i
;~         $agentID = MemoryRead($lAddress, 'WORD')
;~         $lName = StringMid(MemoryRead($lAddress + 0x2, 'wchar [126]'), 2, 125)
;~         $lName = StringRegExpReplace($lName, '[<]{1}([^>]+)[>]{1}', '')
;~         ;ConsoleWrite($I & ' ' & $lName & ' ' & @CRLF)
;~         If StringInStr($lName, $aName) > 0 Then
;~             DisplayAll(False)
;~             ConsoleWrite($i & ' ' & $lName & ' ' & @CRLF)
;~             If $ACHANGETARGET Then ChangeTarget(GetAgentByID($agentID))
;~             Return GetAgentByID($agentID)
;~         EndIf
;~         ;sleep(200)
;~     Next
;~     ;DISPLAYALL(True)
;~     DisplayAll(False)
;~     Sleep(300)
;~     DisplayAll(True)
;~     Sleep(2000)
;~     DisplayAll(False)
;~     For $i = 1 To (GetMaxAgents() + 1)
;~         $lAddress = $mAgentNameLogBase + 256 * $i
;~         $agentID = MemoryRead($lAddress, 'WORD')
;~         $lName = StringMid(MemoryRead($lAddress + 0x2, 'wchar [126]'), 2, 125)
;~         $lName = StringRegExpReplace($lName, '[<]{1}([^>]+)[>]{1}', '')
;~         ;ConsoleWrite($I & ' ' & $LNAME & ' ' & @CRLF)
;~         If StringInStr($lName, $aName) > 0 Then
;~             DisplayAll(False)
;~             If $ACHANGETARGET Then ChangeTarget(GetAgentByID($agentID))
;~             Return GetAgentByID($agentID)
;~         EndIf
;~     Next
;~     Return 0
;~ EndFunc   ;==>GetAgentByName


Func QuestMarkerX($aQuestID)
	Return MemoryRead(GetQuestPtr($aQuestID) + 24, "float")
EndFunc   ;==>QuestMarkerX

;~ Description: Returns the nearest agent to an agent.
Func GetNearestAgentToAgent($aAgent = -2)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance
	Local $lAgentArray = GetAgentArray()

	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)

	Local $lID = DllStructGetData($aAgent, 'ID')

	For $i = 1 To $lAgentArray[0]
		$lDistance = (DllStructGetData($aAgent, 'X') - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + (DllStructGetData($aAgent, 'Y') - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2

		If $lDistance < $lNearestDistance Then
			If DllStructGetData($lAgentArray[$i], 'ID') == $lID Then ContinueLoop
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestAgentToAgent

;~ Description: Returns the nearest enemy to an agent.
Func GetNearestEnemyToAgent($aAgent = -2)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance
	Local $lAgentArray = GetAgentArray(0xDB)

	If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)

	Local $lID = DllStructGetData($aAgent, 'ID')

	For $i = 1 To $lAgentArray[0]
		$lDistance = (DllStructGetData($aAgent, 'X') - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + (DllStructGetData($aAgent, 'Y') - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2
		If DllStructGetData($lAgentArray[$i], 'Allegiance') <> 3 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], 'HP') <= 0 Then ContinueLoop
		If BitAND(DllStructGetData($lAgentArray[$i], 'Effects'), 0x0010) > 0 Then ContinueLoop

		$lDistance = (DllStructGetData($aAgent, 'X') - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + (DllStructGetData($aAgent, 'Y') - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2
		If $lDistance < $lNearestDistance Then
			If DllStructGetData($lAgentArray[$i], 'ID') == $lID Then ContinueLoop
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestEnemyToAgent

;~ Description: Returns the nearest agent to a set of coordinates.
Func GetNearestAgentToCoords($aX, $aY)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance
	Local $lAgentArray = GetAgentArray()

	For $i = 1 To $lAgentArray[0]
		$lDistance = ($aX - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + ($aY - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2
		If $lDistance < $lNearestDistance Then
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestAgentToCoords

Func GetAgentByPlayerNumber($aPlayerNumber)
	Local $lAgentArray = GetAgentArray()
	If IsDllStruct($aPlayerNumber) Then Return DllStructGetData($aPlayerNumber, "PlayerNumber")
	For $i = 1 To $lAgentArray[0]
		If DllStructGetData($lAgentArray[$i], "PlayerNumber") == $aPlayerNumber Then Return $lAgentArray[$i]
	Next
EndFunc   ;==>GetAgentByPlayerNumber


;~ Description: Returns the nearest signpost to an agent.
Func GetNearestSignpostToAgent($aAgent = -2)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance
	Local $lAgentArray = GetAgentArray(0x200)

	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)

	Local $lID = DllStructGetData($aAgent, 'ID')

	For $i = 1 To $lAgentArray[0]
		$lDistance = (DllStructGetData($lAgentArray[$i], 'Y') - DllStructGetData($aAgent, 'Y')) ^ 2 + (DllStructGetData($lAgentArray[$i], 'X') - DllStructGetData($aAgent, 'X')) ^ 2
		If $lDistance < $lNearestDistance Then
			If DllStructGetData($lAgentArray[$i], 'ID') == $lID Then ContinueLoop
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestSignpostToAgent

;~ Description: Returns the nearest signpost to a set of coordinates.
Func GetNearestSignpostToCoords($aX, $aY)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance
	Local $lAgentArray = GetAgentArray(0x200)

	For $i = 1 To $lAgentArray[0]
		$lDistance = ($aX - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + ($aY - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2

		If $lDistance < $lNearestDistance Then
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestSignpostToCoords

;~ Description: Returns the nearest NPC to an agent.
Func GetNearestNPCToAgent($aAgent)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance
	Local $lAgentArray = GetAgentArray(0xDB)

	If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)

	Local $lID = DllStructGetData($aAgent, 'ID')

	For $i = 1 To $lAgentArray[0]
		If DllStructGetData($lAgentArray[$i], 'Allegiance') <> 6 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], 'HP') <= 0 Then ContinueLoop
		If BitAND(DllStructGetData($lAgentArray[$i], 'Effects'), 0x0010) > 0 Then ContinueLoop

		$lDistance = (DllStructGetData($aAgent, 'X') - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + (DllStructGetData($aAgent, 'Y') - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2
		If $lDistance < $lNearestDistance Then
			If DllStructGetData($lAgentArray[$i], 'ID') == $lID Then ContinueLoop
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestNPCToAgent

;~ Description: Returns the nearest NPC to a set of coordinates.
Func GetNearestNPCToCoords($aX, $aY)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance
	Local $lAgentArray = GetAgentArray(0xDB)

	For $i = 1 To $lAgentArray[0]
		If DllStructGetData($lAgentArray[$i], 'Allegiance') <> 6 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], 'HP') <= 0 Then ContinueLoop
		If BitAND(DllStructGetData($lAgentArray[$i], 'Effects'), 0x0010) > 0 Then ContinueLoop

		$lDistance = ($aX - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + ($aY - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2

		If $lDistance < $lNearestDistance Then
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestNPCToCoords

;~ Description: Returns the nearest item to an agent.
Func GetNearestItemToAgent($aAgent = -2, $aCanPickUp = True)
	Local $lNearestAgent, $lNearestDistance = 1000
	Local $lDistance
	Local $lAgentArray = GetAgentArray(0x400)

	If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)

	Local $lID = DllStructGetData($aAgent, 'ID')

	For $i = 1 To $lAgentArray[0]

		If $aCanPickUp And Not GetCanPickUp($lAgentArray[$i]) Then ContinueLoop
		$lDistance = (DllStructGetData($aAgent, 'X') - DllStructGetData($lAgentArray[$i], 'X')) ^ 2 + (DllStructGetData($aAgent, 'Y') - DllStructGetData($lAgentArray[$i], 'Y')) ^ 2
		If $lDistance < $lNearestDistance Then
			If DllStructGetData($lAgentArray[$i], 'ID') == $lID Then ContinueLoop
			$lNearestAgent = $lAgentArray[$i]
			$lNearestDistance = $lDistance
		EndIf
	Next

	SetExtended(Sqrt($lNearestDistance))
	Return $lNearestAgent
EndFunc   ;==>GetNearestItemToAgent

;~ Description: Returns array of party members
;~ Param: an array returned by GetAgentArray. This is totally optional, but can greatly improve script speed.
Func GetParty($aAgentArray = 0)
	Local $lReturnArray[1] = [0]
	If $aAgentArray == 0 Then $aAgentArray = GetAgentArray(0xDB)
	For $i = 1 To $aAgentArray[0]
		If DllStructGetData($aAgentArray[$i], 'Allegiance') == 1 Then
			If BitAND(DllStructGetData($aAgentArray[$i], 'TypeMap'), 131072) Then
				$lReturnArray[0] += 1
				ReDim $lReturnArray[$lReturnArray[0] + 1]
				$lReturnArray[$lReturnArray[0]] = $aAgentArray[$i]
			EndIf
		EndIf
	Next
	Return $lReturnArray
EndFunc   ;==>GetParty

;~ Description: Quickly creates an array of agents of a given type
Func GetAgentArray($aType = 0)
	Local $lStruct
	Local $lCount
	Local $lBuffer = ''
	DllStructSetData($mMakeAgentArray, 2, $aType)
	MemoryWrite($mAgentCopyCount, -1, 'long')
	Enqueue($mMakeAgentArrayPtr, 8)
	Local $lDeadlock = TimerInit()
	Do
		Sleep(1)
		$lCount = MemoryRead($mAgentCopyCount, 'long')
	Until $lCount >= 0 Or TimerDiff($lDeadlock) > 5000
	If $lCount < 0 Then $lCount = 0
	For $i = 1 To $lCount
		$lBuffer &= 'Byte[448];'
	Next
	$lBuffer = DllStructCreate($lBuffer)
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $mAgentCopyBase, 'ptr', DllStructGetPtr($lBuffer), 'int', DllStructGetSize($lBuffer), 'int', '')
	Local $lReturnArray[$lCount + 1] = [$lCount]
	For $i = 1 To $lCount
		$lReturnArray[$i] = DllStructCreate('ptr vtable;byte unknown1[24];byte unknown2[4];ptr NextAgent;byte unknown3[8];long Id;float Z;byte unknown4[8];float BoxHoverWidth;float BoxHoverHeight;byte unknown5[8];float Rotation;byte unknown6[8];long NameProperties;byte unknown7[24];float X;float Y;byte unknown8[8];float NameTagX;float NameTagY;float NameTagZ;byte unknown9[12];long Type;float MoveX;float MoveY;byte unknown10[28];long Owner;byte unknown30[8];long ExtraType;byte unknown11[24];float AttackSpeed;float AttackSpeedModifier;word PlayerNumber;byte unknown12[6];ptr Equip;byte unknown13[10];byte Primary;byte Secondary;byte Level;byte Team;byte unknown14[6];float EnergyPips;byte unknown[4];float EnergyPercent;long MaxEnergy;byte unknown15[4];float HPPips;byte unknown16[4];float HP;long MaxHP;long Effects;byte unknown17[4];byte Hex;byte unknown18[18];long ModelState;long TypeMap;byte unknown19[16];long InSpiritRange;byte unknown20[16];long LoginNumber;float ModelMode;byte unknown21[4];long ModelAnimation;byte unknown22[32];byte LastStrike;byte Allegiance;word WeaponType;word Skill;byte unknown23[4];word WeaponItemId;word OffhandItemId')
		$lStruct = DllStructCreate('byte[448]', DllStructGetPtr($lReturnArray[$i]))
		DllStructSetData($lStruct, 1, DllStructGetData($lBuffer, $i))
	Next
	Return $lReturnArray
EndFunc   ;==>GetAgentArray

;~ Description Returns the "danger level" of each party member
;~ Param1: an array returned by GetAgentArray(). This is totally optional, but can greatly improve script speed.
;~ Param2: an array returned by GetParty() This is totally optional, but can greatly improve script speed.
Func GetPartyDanger($aAgentArray = 0, $aParty = 0)
	If $aAgentArray == 0 Then $aAgentArray = GetAgentArray(0xDB)
	If $aParty == 0 Then $aParty = GetParty($aAgentArray)

	Local $lReturnArray[$aParty[0] + 1]
	$lReturnArray[0] = $aParty[0]
	For $i = 1 To $lReturnArray[0]
		$lReturnArray[$i] = 0
	Next

	For $i = 1 To $aAgentArray[0]
		If BitAND(DllStructGetData($aAgentArray[$i], 'Effects'), 0x0010) > 0 Then ContinueLoop
		If DllStructGetData($aAgentArray[$i], 'HP') <= 0 Then ContinueLoop
		If Not GetIsLiving($aAgentArray[$i]) Then ContinueLoop
		If DllStructGetData($aAgentArray[$i], "Allegiance") > 3 Then ContinueLoop ; ignore NPCs, spirits, minions, pets

		For $j = 1 To $aParty[0]
			If GetTarget(DllStructGetData($aAgentArray[$i], "ID")) == DllStructGetData($aParty[$j], "ID") Then
				If GetDistance($aAgentArray[$i], $aParty[$j]) < 5000 Then
					If DllStructGetData($aAgentArray[$i], "Team") <> 0 Then
						If DllStructGetData($aAgentArray[$i], "Team") <> DllStructGetData($aParty[$j], "Team") Then
							$lReturnArray[$j] += 1
						EndIf
					ElseIf DllStructGetData($aAgentArray[$i], "Allegiance") <> DllStructGetData($aParty[$j], "Allegiance") Then
						$lReturnArray[$j] += 1
					EndIf
				EndIf
			EndIf
		Next
	Next
	Return $lReturnArray
EndFunc   ;==>GetPartyDanger
;~ Description: Return the number of enemy agents targeting the given agent.
Func GetAgentDanger($aAgent, $aAgentArray = 0)
	If IsDllStruct($aAgent) = 0 Then
		$aAgent = GetAgentByID($aAgent)
	EndIf

	Local $lCount = 0

	If $aAgentArray == 0 Then $aAgentArray = GetAgentArray(0xDB)

	For $i = 1 To $aAgentArray[0]
		If BitAND(DllStructGetData($aAgentArray[$i], 'Effects'), 0x0010) > 0 Then ContinueLoop
		If DllStructGetData($aAgentArray[$i], 'HP') <= 0 Then ContinueLoop
		If Not GetIsLiving($aAgentArray[$i]) Then ContinueLoop
		If DllStructGetData($aAgentArray[$i], "Allegiance") > 3 Then ContinueLoop ; ignore NPCs, spirits, minions, pets
		If GetTarget(DllStructGetData($aAgentArray[$i], "ID")) == DllStructGetData($aAgent, "ID") Then
			If GetDistance($aAgentArray[$i], $aAgent) < 5000 Then
				If DllStructGetData($aAgentArray[$i], "Team") <> 0 Then
					If DllStructGetData($aAgentArray[$i], "Team") <> DllStructGetData($aAgent, "Team") Then
						$lCount += 1
					EndIf
				ElseIf DllStructGetData($aAgentArray[$i], "Allegiance") <> DllStructGetData($aAgent, "Allegiance") Then
					$lCount += 1
				EndIf
			EndIf
		EndIf
	Next
	Return $lCount
EndFunc   ;==>GetAgentDanger
#EndRegion Agent

#Region AgentInfo
;~ Description: Tests if an agent is living.
Func GetIsLiving($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return DllStructGetData($aAgent, 'Type') = 0xDB
EndFunc   ;==>GetIsLiving

;~ Description: Tests if an agent is a signpost/chest/etc.
Func GetIsStatic($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return DllStructGetData($aAgent, 'Type') = 0x200
EndFunc   ;==>GetIsStatic

;~ Description: Tests if an agent is an item.
Func GetIsMovable($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return DllStructGetData($aAgent, 'Type') = 0x400
EndFunc   ;==>GetIsMovable

;~ Description: Returns energy of an agent. (Only self/heroes)
Func GetEnergy($aAgent = -2)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return DllStructGetData($aAgent, 'EnergyPercent') * DllStructGetData($aAgent, 'MaxEnergy')
EndFunc   ;==>GetEnergy

;~ Description: Returns health of an agent. (Must have caused numerical change in health)
Func GetHealth($aAgent = -2)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return DllStructGetData($aAgent, 'HP') * DllStructGetData($aAgent, 'MaxHP')
EndFunc   ;==>GetHealth

;~ Description: Tests if an agent is moving.
Func GetIsMoving($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	If DllStructGetData($aAgent, 'MoveX') <> 0 Or DllStructGetData($aAgent, 'MoveY') <> 0 Then Return True
	Return False
EndFunc   ;==>GetIsMoving

;~ Description: Tests if an agent is knocked down.
Func GetIsKnocked($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return DllStructGetData($aAgent, 'ModelState') = 0x450
EndFunc   ;==>GetIsKnocked

;~ Description: Tests if an agent is attacking.
Func GetIsAttacking($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Switch DllStructGetData($aAgent, 'ModelState')
		Case 0x60 ; Is Attacking
			Return True
		Case 0x440 ; Is Attacking
			Return True
		Case 0x460 ; Is Attacking
			Return True
		Case Else
			Return False
	EndSwitch
EndFunc   ;==>GetIsAttacking

;~ Description: Tests if an agent is casting.
Func GetIsCasting($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return DllStructGetData($aAgent, 'Skill') <> 0
EndFunc   ;==>GetIsCasting

;~ Description: Tests if an agent is bleeding.
Func GetIsBleeding($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0001) > 0
EndFunc   ;==>GetIsBleeding

;~ Description: Tests if an agent has a condition.
Func GetHasCondition($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0002) > 0
EndFunc   ;==>GetHasCondition

;~ Description: Tests if an agent is dead.
Func GetIsDead($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0010) > 0
EndFunc   ;==>GetIsDead

;~ Description: Tests if an agent has a deep wound.
Func GetHasDeepWound($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0020) > 0
EndFunc   ;==>GetHasDeepWound

;~ Description: Tests if an agent is poisoned.
Func GetIsPoisoned($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0040) > 0
EndFunc   ;==>GetIsPoisoned

;~ Description: Tests if an agent is enchanted.
Func GetIsEnchanted($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0080) > 0
EndFunc   ;==>GetIsEnchanted

;~ Description: Tests if an agent has a degen hex.
Func GetHasDegenHex($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0400) > 0
EndFunc   ;==>GetHasDegenHex

;~ Description: Tests if an agent is hexed.
Func GetHasHex($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x0800) > 0
EndFunc   ;==>GetHasHex

;~ Description: Tests if an agent has a weapon spell.
Func GetHasWeaponSpell($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'Effects'), 0x8000) > 0
EndFunc   ;==>GetHasWeaponSpell

;~ Description: Tests if an agent is a boss.
Func GetIsBoss($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Return BitAND(DllStructGetData($aAgent, 'TypeMap'), 1024) > 0
EndFunc   ;==>GetIsBoss

;~ Description: Returns a player's name.
Func GetPlayerName($aAgent)
	If IsDllStruct($aAgent) = 0 Then $aAgent = GetAgentByID($aAgent)
	Local $lLogin = DllStructGetData($aAgent, 'LoginNumber')
	Local $lOffset[6] = [0, 0x18, 0x2C, 0x80C, 76 * $lLogin + 0x28, 0]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset, 'wchar[30]')
	Return $lReturn[1]
EndFunc   ;==>GetPlayerName

;~ Description: Returns the name of an agent.
Func GetAgentName($aAgent)
	If $mUseStringLog = False Then Return

	If IsDllStruct($aAgent) = 0 Then
		Local $lAgentID = ConvertID($aAgent)
		If $lAgentID = 0 Then Return ''
	Else
		Local $lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf

	Local $lAddress = $mStringLogBase + 256 * $lAgentID
	Local $lName = MemoryRead($lAddress, 'wchar [128]')

	If $lName = '' Then
		DisplayAll(True)
		Sleep(100)
		DisplayAll(False)
	EndIf

	Local $lName = MemoryRead($lAddress, 'wchar [128]')
	$lName = StringRegExpReplace($lName, '[<]{1}([^>]+)[>]{1}', '')
	Return $lName
EndFunc   ;==>GetAgentName
#EndRegion AgentInfo

#Region Buff
;~ Description: Returns current number of buffs being maintained.
Func GetBuffCount($aHeroNumber = 0)
	Local $lOffset[4]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x510
	Local $lCount = MemoryReadPtr($mBasePointer, $lOffset)
	ReDim $lOffset[5]
	$lOffset[3] = 0x508
	Local $lBuffer
	For $i = 0 To $lCount[1] - 1
		$lOffset[4] = 0x24 * $i
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] == GetHeroID($aHeroNumber) Then
			Return MemoryRead($lBuffer[0] + 0xC)
		EndIf
	Next
	Return 0
EndFunc   ;==>GetBuffCount

;~ Description: Tests if you are currently maintaining buff on target.
Func GetIsTargetBuffed($aSkillID, $aAgentID, $aHeroNumber = 0)
	Local $lBuffStruct = DllStructCreate('long SkillId;byte unknown1[4];long BuffId;long TargetId')
	Local $lBuffCount = GetBuffCount($aHeroNumber)
	Local $lBuffStructAddress
	Local $lOffset[4]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x510
	Local $lCount = MemoryReadPtr($mBasePointer, $lOffset)
	ReDim $lOffset[5]
	$lOffset[3] = 0x508
	Local $lBuffer
	For $i = 0 To $lCount[1] - 1
		$lOffset[4] = 0x24 * $i
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] == GetHeroID($aHeroNumber) Then
			$lOffset[4] = 0x4 + 0x24 * $i
			ReDim $lOffset[6]
			For $j = 0 To $lBuffCount - 1
				$lOffset[5] = 0 + 0x10 * $j
				$lBuffStructAddress = MemoryReadPtr($mBasePointer, $lOffset)
				DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lBuffStructAddress[0], 'ptr', DllStructGetPtr($lBuffStruct), 'int', DllStructGetSize($lBuffStruct), 'int', '')
				If (DllStructGetData($lBuffStruct, 'SkillID') == $aSkillID) And (DllStructGetData($lBuffStruct, 'TargetId') == ConvertID($aAgentID)) Then
					Return $j + 1
				EndIf
			Next
		EndIf
	Next
	Return 0
EndFunc   ;==>GetIsTargetBuffed

;~ Description: Returns buff struct.
Func GetBuffByIndex($aBuffNumber, $aHeroNumber = 0)
	Local $lBuffStruct = DllStructCreate('long SkillId;byte unknown1[4];long BuffId;long TargetId')
	Local $lOffset[4]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x510
	Local $lCount = MemoryReadPtr($mBasePointer, $lOffset)
	ReDim $lOffset[5]
	$lOffset[3] = 0x508
	Local $lBuffer
	For $i = 0 To $lCount[1] - 1
		$lOffset[4] = 0x24 * $i
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] == GetHeroID($aHeroNumber) Then
			$lOffset[4] = 0x4 + 0x24 * $i
			ReDim $lOffset[6]
			$lOffset[5] = 0 + 0x10 * ($aBuffNumber - 1)
			$lBuffStructAddress = MemoryReadPtr($mBasePointer, $lOffset)
			DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lBuffStructAddress[0], 'ptr', DllStructGetPtr($lBuffStruct), 'int', DllStructGetSize($lBuffStruct), 'int', '')
			Return $lBuffStruct
		EndIf
	Next
	Return 0
EndFunc   ;==>GetBuffByIndex
#EndRegion Buff

#Region Misc
;~ Description: Returns skillbar struct.
Func GetSkillbar($aHeroNumber = 0)
	Local $lSkillbarStruct = DllStructCreate('long AgentId;long AdrenalineA1;long AdrenalineB1;dword Recharge1;dword Id1;dword Event1;long AdrenalineA2;long AdrenalineB2;dword Recharge2;dword Id2;dword Event2;long AdrenalineA3;long AdrenalineB3;dword Recharge3;dword Id3;dword Event3;long AdrenalineA4;long AdrenalineB4;dword Recharge4;dword Id4;dword Event4;long AdrenalineA5;long AdrenalineB5;dword Recharge5;dword Id5;dword Event5;long AdrenalineA6;long AdrenalineB6;dword Recharge6;dword Id6;dword Event6;long AdrenalineA7;long AdrenalineB7;dword Recharge7;dword Id7;dword Event7;long AdrenalineA8;long AdrenalineB8;dword Recharge8;dword Id8;dword Event8;dword disabled;byte unknown[8];dword Casting')
	Local $lOffset[5]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x6F0
	For $i = 0 To GetHeroCount()
		$lOffset[4] = $i * 0xBC
		Local $lSkillbarStructAddress = MemoryReadPtr($mBasePointer, $lOffset)
		DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lSkillbarStructAddress[0], 'ptr', DllStructGetPtr($lSkillbarStruct), 'int', DllStructGetSize($lSkillbarStruct), 'int', '')
		If DllStructGetData($lSkillbarStruct, 'AgentId') == GetHeroID($aHeroNumber) Then Return $lSkillbarStruct
	Next
EndFunc   ;==>GetSkillbar

;~ Description: Returns the skill ID of an equipped skill.
Func GetSkillbarSkillID($aSkillSlot, $aHeroNumber = 0)
	Return DllStructGetData(GetSkillbar($aHeroNumber), 'ID' & $aSkillSlot)
EndFunc   ;==>GetSkillbarSkillID

;~ Description: Returns the adrenaline charge of an equipped skill.
Func GetSkillbarSkillAdrenaline($aSkillSlot, $aHeroNumber = 0)
	Return DllStructGetData(GetSkillbar($aHeroNumber), 'AdrenalineA' & $aSkillSlot)
EndFunc   ;==>GetSkillbarSkillAdrenaline

;~ Description: Returns the recharge time remaining of an equipped skill in milliseconds.
Func GetSkillbarSkillRecharge($aSkillSlot, $aHeroNumber = 0)
	Local $lTimestamp = DllStructGetData(GetSkillbar($aHeroNumber), 'Recharge' & $aSkillSlot)
	If $lTimestamp == 0 Then Return 0
	Return $lTimestamp - GetSkillTimer()
EndFunc   ;==>GetSkillbarSkillRecharge

;~ Description: Returns skill struct.
Func GetSkillByID($aSkillID)
	Local $lSkillStruct = DllStructCreate('long ID;byte Unknown1[4];long campaign;long Type;long Special;long ComboReq;long Effect1;long Condition;long Effect2;long WeaponReq;byte Profession;byte Attribute;byte Unknown2[2];long PvPID;byte Combo;byte Target;byte unknown3;byte EquipType;byte Unknown4[4];dword Adrenaline;float Activation;float Aftercast;long Duration0;long Duration15;long Recharge;byte Unknown5[12];long Scale0;long Scale15;long BonusScale0;long BonusScale15;float AoERange;float ConstEffect;byte unknown6[44]')
	Local $lSkillStructAddress = $mSkillBase + 160 * $aSkillID
	DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lSkillStructAddress, 'ptr', DllStructGetPtr($lSkillStruct), 'int', DllStructGetSize($lSkillStruct), 'int', '')
	Return $lSkillStruct
EndFunc   ;==>GetSkillByID

;~ Description: Returns current morale.
Func GetMorale($aHeroNumber = 0)
	Local $lAgentID = GetHeroID($aHeroNumber)
	Local $lOffset[4]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x638
	Local $lIndex = MemoryReadPtr($mBasePointer, $lOffset)
	ReDim $lOffset[6]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x62C
	$lOffset[4] = 8 + 0xC * BitAND($lAgentID, $lIndex[1])
	$lOffset[5] = 0x18
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1] - 100
EndFunc   ;==>GetMorale

;~ Description: Returns effect struct or array of effects.
Func GetEffect($aSkillID = 0, $aHeroNumber = 0)
	Local $lEffectCount, $lEffectStructAddress
	Local $lReturnArray[1] = [0]

	Local $lOffset[4]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0x510
	Local $lCount = MemoryReadPtr($mBasePointer, $lOffset)
	ReDim $lOffset[5]
	$lOffset[3] = 0x508
	Local $lBuffer
	For $i = 0 To $lCount[1] - 1
		$lOffset[4] = 0x24 * $i
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] == GetHeroID($aHeroNumber) Then
			$lOffset[4] = 0x1C + 0x24 * $i
			$lEffectCount = MemoryReadPtr($mBasePointer, $lOffset)
			ReDim $lOffset[6]
			$lOffset[4] = 0x14 + 0x24 * $i
			$lOffset[5] = 0
			$lEffectStructAddress = MemoryReadPtr($mBasePointer, $lOffset)

			If $aSkillID = 0 Then
				ReDim $lReturnArray[$lEffectCount[1] + 1]
				$lReturnArray[0] = $lEffectCount[1]

				For $i = 0 To $lEffectCount[1] - 1
					$lReturnArray[$i + 1] = DllStructCreate('long SkillId;long EffectType;long EffectId;long AgentId;float Duration;long TimeStamp')
					$lEffectStructAddress[1] = $lEffectStructAddress[0] + 24 * $i
					DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lEffectStructAddress[1], 'ptr', DllStructGetPtr($lReturnArray[$i + 1]), 'int', 24, 'int', '')
				Next

				ExitLoop
			Else
				Local $lReturn = DllStructCreate('long SkillId;long EffectType;long EffectId;long AgentId;float Duration;long TimeStamp')

				For $i = 0 To $lEffectCount[1] - 1
					DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lEffectStructAddress[0] + 24 * $i, 'ptr', DllStructGetPtr($lReturn), 'int', 24, 'int', '')
					If DllStructGetData($lReturn, 'SkillID') = $aSkillID Then Return $lReturn
				Next
			EndIf
		EndIf
	Next
	Return $lReturnArray
EndFunc   ;==>GetEffect

;~ Description: Returns time remaining before an effect expires, in milliseconds.
Func GetEffectTimeRemaining($aEffect)
	If Not IsDllStruct($aEffect) Then $aEffect = GetEffect($aEffect)
	If IsArray($aEffect) Then Return 0
	Return DllStructGetData($aEffect, 'Duration') * 1000
;~ 	Return DllStructGetData($aEffect, 'Duration') * 1000 - (GetSkillTimer() - DllStructGetData($aEffect, 'TimeStamp'))
EndFunc   ;==>GetEffectTimeRemaining

;~ Description: Returns the timestamp used for effects and skills (milliseconds).
Func GetSkillTimer()
	Return MemoryRead($mSkillTimer, "long")
EndFunc   ;==>GetSkillTimer

;~ Description: Returns level of an attribute.
Func GetAttributeByID($aAttributeID, $aWithRunes = False, $aHeroNumber = 0)
	Local $lAgentID = GetHeroID($aHeroNumber)
	Local $lBuffer
	Local $lOffset[5]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x2C
	$lOffset[3] = 0xAC
	For $i = 0 To GetHeroCount()
		$lOffset[4] = 0x3D8 * $i
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] == $lAgentID Then
			If $aWithRunes Then
				$lOffset[4] = 0x3D8 * $i + 0x14 * $aAttributeID + 0xC
			Else
				$lOffset[4] = 0x3D8 * $i + 0x14 * $aAttributeID + 0x8
			EndIf
			$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
			Return $lBuffer[1]
		EndIf
	Next
EndFunc   ;==>GetAttributeByID

;~ Description: Returns amount of experience.
Func GetExperience()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x740]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetExperience

;~ Description: Tests if an area has been vanquished.
Func GetAreaVanquished()
	If GetFoesToKill() = 0 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>GetAreaVanquished

;~ Description: Returns number of foes that have been killed so far.
Func GetFoesKilled()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x84C]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetFoesKilled

;~ Description: Returns number of enemies left to kill for vanquish.
Func GetFoesToKill()
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x850]
	Local $lReturn = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lReturn[1]
EndFunc   ;==>GetFoesToKill

;~ Description: Returns number of agents currently loaded.
Func GetMaxAgents()
	Return MemoryRead($mMaxAgents)
EndFunc   ;==>GetMaxAgents

;~ Description: Returns your agent ID.
Func GetMyID()
	Return MemoryRead($mMyID)
EndFunc   ;==>GetMyID

;~ Description: Returns current target.
Func GetCurrentTarget()
	Return GetAgentByID(GetCurrentTargetID())
EndFunc   ;==>GetCurrentTarget

;~ Description: Returns current target ID.
Func GetCurrentTargetID()
	Return MemoryRead($mCurrentTarget)
EndFunc   ;==>GetCurrentTargetID

;~ Description: Returns current ping.
Func GetPing()
	Return MemoryRead($mPing)
EndFunc   ;==>GetPing

;~ Description: Returns current map ID.
Func GetMapID()
	Return MemoryRead($mMapID)
EndFunc   ;==>GetMapID

;~ Description: Returns current load-state.
Func GetMapLoading()
	Return MemoryRead($mMapLoading)
EndFunc   ;==>GetMapLoading

;~ Description: Returns if map has been loaded. Reset with InitMapLoad().
Func GetMapIsLoaded()
;~ 	Return MemoryRead($mMapIsLoaded) And GetAgentExists(-2)
	Return GetAgentExists(-2)
EndFunc   ;==>GetMapIsLoaded

;~ Description: Returns current district
Func GetDistrict()
	Local $lOffset[4] = [0, 0x18, 0x44, 0x1B4]
	Local $lResult = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lResult[1]
EndFunc   ;==>GetDistrict

;~ Description: Internal use for travel functions.
Func GetRegion()
	Return MemoryRead($mRegion)
EndFunc   ;==>GetRegion

;~ Description: Internal use for travel functions.
Func GetLanguage()
	Return MemoryRead($mLanguage)
EndFunc   ;==>GetLanguage

;~ Description: Request quest data.
Func UpdateQuestToggle()
	ToggleQuestWindow()
	ToggleQuestWindow()
EndFunc   ;==>UpdateQuestToggle

#Region New Quest (From discord)
;~ Description: Request quest status information without NPC dialog (use RequestQuestInformation($lQuestId) + DllStructGetData(GetQuestByID($lQuestId), "LogState")
Func RequestQuestInformation($aQuestID)
	Return SendPacket(0x8, $HEADER_QUEST_REQUEST_INFOS, $aQuestID)
EndFunc   ;==>RequestQuestInformation

Func CheckQuestStatus($aQuestID)
	RequestQuestInformation($aQuestID)
	Local $lLogstate = QuestLogState($aQuestID)
	Switch $lLogstate
		Case 0
			Return False
		Case 2, 3, 19, 32, 34, 35, 79
			Return True
		Case 32, 33
			Return False
		Case 1
			Return False
	EndSwitch
EndFunc   ;==>CheckQuestStatus

;~ Description: Returns quest struct.
Func GetQuestByID($aQuestID = 0)
	Local $lQuestStruct = DllStructCreate('long id;long LogState;byte unknown1[12];long MapFrom;float X;float Y;byte unknown2[8];long MapTo;long Reward;long Objective')
	Local $lQuestPtr, $lQuestLogSize, $lQuestID
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x534]

	$lQuestLogSize = MemoryReadPtr($mBasePointer, $lOffset)

	If $aQuestID = 0 Then
		$lOffset[1] = 0x18
		$lOffset[2] = 0x2C
		$lOffset[3] = 0x528
		$lQuestID = MemoryReadPtr($mBasePointer, $lOffset)
		$lQuestID = $lQuestID[1]
	Else
		$lQuestID = $aQuestID
	EndIf

	Local $lOffset[5] = [0, 0x18, 0x2C, 0x52C, 0]
	For $i = 0 To $lQuestLogSize[1]
		$lOffset[4] = 0x34 * $i
		$lQuestPtr = MemoryReadPtr($mBasePointer, $lOffset)
		DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $lQuestPtr[0], 'ptr', DllStructGetPtr($lQuestStruct), 'int', DllStructGetSize($lQuestStruct), 'int', '')
		If DllStructGetData($lQuestStruct, 'ID') = $lQuestID Then Return $lQuestStruct
	Next
EndFunc   ;==>GetQuestByID

;~ Returns the pointer variable for the specified Quest ID
Func GetQuestPtr($aQuestID)
;~ 	UpdateQuestToggle()
	Sleep(200)
	Local $lQuestLogSize
	Local $lQuestPtr
	Local $lOffset[4] = [0, 24, 44, 1332]
	$lQuestLogSize = MemoryReadPtr($mBasePointer, $lOffset)
	Local $lQuestID
	Local $lOffset[5] = [0, 24, 44, 1324, 0]
	If $aQuestID = 0 Then
		$lOffset[3] = 1220
		$lQuestID = MemoryReadPtr($mBasePointer, $lOffset)
		Return Ptr($lQuestID[0])
	EndIf
	For $i = 0 To $lQuestLogSize[1]
		$lOffset[4] = 52 * $i
		$lQuestPtr = MemoryReadPtr($mBasePointer, $lOffset, "long")
		If $lQuestPtr[1] = $aQuestID Then Return Ptr($lQuestPtr[0])
	Next
EndFunc   ;==>GetQuestPtr

;~ Returns the pointer variable for the quest at the specified log number
Func GetQuestPtrByLogNumber($aLogNumber)
	Local $lQuestPtr
	$aLogNumber -= 1
	Local $lOffset[5] = [0, 24, 44, 1324, 52 * $aLogNumber]
	$lQuestPtr = MemoryReadPtr($mBasePointer, $lOffset, "Ptr")
	Return $lQuestPtr[0]
EndFunc   ;==>GetQuestPtrByLogNumber

;~ Returns the quest ID based on its pointer variable
Func QuestID($aQuestID)
	Return MemoryRead(GetQuestPtr($aQuestID), "Long")
EndFunc   ;==>QuestID

;~ Returns the quest Log State based its pointer variable
Func QuestLogState($aQuestID)
	Return MemoryRead(GetQuestPtr($aQuestID) + 4, "Long")
EndFunc   ;==>QuestLogState

;~ Returns the current map ID for a quest based its pointer variable
Func QuestMapFrom($aQuestID)
	Return MemoryRead(GetQuestPtr($aQuestID) + 20, "Long")
EndFunc   ;==>QuestMapFrom


;~ Returns the Y coord of the green star for a quest based its pointer variable
Func QuestMarkerY($aQuestID)
	Return MemoryRead(GetQuestPtr($aQuestID) + 28, "byte")
EndFunc   ;==>QuestMarkerY

;~ Returns the next map ID for a quest based its pointer variable
Func QuestMapTo($aQuestID)
	Return MemoryRead(GetQuestPtr($aQuestID) + 40, "Long")
EndFunc   ;==>QuestMapTo

Func QuestRewardByPtr($aQuestID)
	;long Reward        ;
	Return MemoryRead(GetQuestPtr($aQuestID) + 44, "long")
EndFunc   ;==>QuestRewardByPtr

Func QuestObjectiveByPtr($aQuestID)
	;long Objective')   ;
	Return MemoryRead(GetQuestPtr($aQuestID) + 48, "long")
EndFunc   ;==>QuestObjectiveByPtr

;~ Description: Abandon a quest.
Func SetActiveQuest($aQuestID)
	SendPacket(0xC, $HEADER_QUEST_SET_ACTIVE, $aQuestID)
	pingSleep(500)
EndFunc   ;==>SetActiveQuest

#EndRegion New Quest (From discord)
;~ Description: Returns your characters name.
Func GetCharname()
	Return MemoryRead($mCharname, 'wchar[30]')
EndFunc   ;==>GetCharname

;~ Description: Returns if you're logged in.
Func GetLoggedIn()
	Return MemoryRead($mLoggedIn)
EndFunc   ;==>GetLoggedIn

;~ Description: Returns language currently being used.
Func GetDisplayLanguage()
	Local $lOffset[6] = [0, 0x18, 0x18, 0x194, 0x4C, 0x40]
	Local $lResult = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lResult[1]
EndFunc   ;==>GetDisplayLanguage

;~ Returns how long the current instance has been active, in milliseconds.
Func GetInstanceUpTime()
	Local $lOffset[4]
	$lOffset[0] = 0
	$lOffset[1] = 0x18
	$lOffset[2] = 0x8
	$lOffset[3] = 0x1AC
	Local $lTimer = MemoryReadPtr($mBasePointer, $lOffset)
	Return $lTimer[1]
EndFunc   ;==>GetInstanceUpTime

;~ Returns the game client's build number
Func GetBuildNumber()
	Return $mBuildNumber
EndFunc   ;==>GetBuildNumber

Func GetProfPrimaryAttribute($aProfession)
	Switch $aProfession
		Case 1
			Return 17
		Case 2
			Return 23
		Case 3
			Return 16
		Case 4
			Return 6
		Case 5
			Return 0
		Case 6
			Return 12
		Case 7
			Return 35
		Case 8
			Return 36
		Case 9
			Return 40
		Case 10
			Return 44
	EndSwitch
EndFunc   ;==>GetProfPrimaryAttribute
#EndRegion Misc
#EndRegion Queries

#Region Other Functions
#Region Misc
;~ Description: Sleep a random amount of time.
Func RndSleep($aAmount, $aRandom = 0.05)
	Local $lRandom = $aAmount * $aRandom
	Sleep(Random($aAmount - $lRandom, $aAmount + $lRandom))
EndFunc   ;==>RndSleep

;~ Description: Sleep a period of time, plus or minus a tolerance
Func TolSleep($aAmount = 150, $aTolerance = 50)
	Sleep(Random($aAmount - $aTolerance, $aAmount + $aTolerance))
EndFunc   ;==>TolSleep

;~ Description: Returns window handle of Guild Wars.
Func GetWindowHandle()
	Return $mGWWindowHandle
EndFunc   ;==>GetWindowHandle

;~ Description: Returns the distance between two coordinate pairs.
Func ComputeDistance($aX1, $aY1, $aX2, $aY2)
	Return Sqrt(($aX1 - $aX2) ^ 2 + ($aY1 - $aY2) ^ 2)
EndFunc   ;==>ComputeDistance

;~ Description: Returns the distance between two agents.
Func GetDistance($aAgent1 = -1, $aAgent2 = -2)
	If IsDllStruct($aAgent1) = 0 Then $aAgent1 = GetAgentByID($aAgent1)
	If IsDllStruct($aAgent2) = 0 Then $aAgent2 = GetAgentByID($aAgent2)
	Return Sqrt((DllStructGetData($aAgent1, 'X') - DllStructGetData($aAgent2, 'X')) ^ 2 + (DllStructGetData($aAgent1, 'Y') - DllStructGetData($aAgent2, 'Y')) ^ 2)
EndFunc   ;==>GetDistance

;~ Description: Return the square of the distance between two agents.
Func GetPseudoDistance($aAgent1, $aAgent2)
	Return (DllStructGetData($aAgent1, 'X') - DllStructGetData($aAgent2, 'X')) ^ 2 + (DllStructGetData($aAgent1, 'Y') - DllStructGetData($aAgent2, 'Y')) ^ 2
EndFunc   ;==>GetPseudoDistance

;~ Description: Checks if a point is within a polygon defined by an array
Func GetIsPointInPolygon($aAreaCoords, $aPosX = 0, $aPosY = 0)
	Local $lPosition
	Local $lEdges = UBound($aAreaCoords)
	Local $lOddNodes = False
	If $lEdges < 3 Then Return False
	If $aPosX = 0 Then
		Local $lAgent = GetAgentByID(-2)
		$aPosX = DllStructGetData($lAgent, 'X')
		$aPosY = DllStructGetData($lAgent, 'Y')
	EndIf
	$j = $lEdges - 1
	For $i = 0 To $lEdges - 1
		If (($aAreaCoords[$i][1] < $aPosY And $aAreaCoords[$j][1] >= $aPosY) _
				Or ($aAreaCoords[$j][1] < $aPosY And $aAreaCoords[$i][1] >= $aPosY)) _
				And ($aAreaCoords[$i][0] <= $aPosX Or $aAreaCoords[$j][0] <= $aPosX) Then
			If ($aAreaCoords[$i][0] + ($aPosY - $aAreaCoords[$i][1]) / ($aAreaCoords[$j][1] - $aAreaCoords[$i][1]) * ($aAreaCoords[$j][0] - $aAreaCoords[$i][0]) < $aPosX) Then
				$lOddNodes = Not $lOddNodes
			EndIf
		EndIf
		$j = $i
	Next
	Return $lOddNodes
EndFunc   ;==>GetIsPointInPolygon

;~ Description: Internal use for handing -1 and -2 agent IDs.
Func ConvertID($aID)
	If $aID = -2 Then
		Return GetMyID()
	ElseIf $aID = -1 Then
		Return GetCurrentTargetID()
	Else
		Return $aID
	EndIf
EndFunc   ;==>ConvertID

Func InviteGuild($charName)
	If GetAgentExists(-2) Then
		DllStructSetData($mInviteGuild, 1, GetValue('CommandPacketSend'))
		DllStructSetData($mInviteGuild, 2, 0x4C)
		DllStructSetData($mInviteGuild, 3, 0xBC)
		DllStructSetData($mInviteGuild, 4, 0x01)
		DllStructSetData($mInviteGuild, 5, $charName)
		DllStructSetData($mInviteGuild, 6, 0x02)
		Enqueue(DllStructGetPtr($mInviteGuild), DllStructGetSize($mInviteGuild))
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>InviteGuild

Func InviteGuest($charName)
	If GetAgentExists(-2) Then
		DllStructSetData($mInviteGuild, 1, GetValue('CommandPacketSend'))
		DllStructSetData($mInviteGuild, 2, 0x4C)
		DllStructSetData($mInviteGuild, 3, 0xBC)
		DllStructSetData($mInviteGuild, 4, 0x01)
		DllStructSetData($mInviteGuild, 5, $charName)
		DllStructSetData($mInviteGuild, 6, 0x01)
		Enqueue(DllStructGetPtr($mInviteGuild), DllStructGetSize($mInviteGuild))
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>InviteGuest

;~ Description: Internal use only.
Func SendPacket($aSize, $aHeader, $aParam1 = 0, $aParam2 = 0, $aParam3 = 0, $aParam4 = 0, $aParam5 = 0, $aParam6 = 0, $aParam7 = 0, $aParam8 = 0, $aParam9 = 0, $aParam10 = 0)
	If GetAgentExists(-2) Then
		DllStructSetData($mPacket, 2, $aSize)
		DllStructSetData($mPacket, 3, $aHeader)
		DllStructSetData($mPacket, 4, $aParam1)
		DllStructSetData($mPacket, 5, $aParam2)
		DllStructSetData($mPacket, 6, $aParam3)
		DllStructSetData($mPacket, 7, $aParam4)
		DllStructSetData($mPacket, 8, $aParam5)
		DllStructSetData($mPacket, 9, $aParam6)
		DllStructSetData($mPacket, 10, $aParam7)
		DllStructSetData($mPacket, 11, $aParam8)
		DllStructSetData($mPacket, 12, $aParam9)
		DllStructSetData($mPacket, 13, $aParam10)
		Enqueue($mPacketPtr, 52)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>SendPacket

;~ Description: Internal use only.
Func PerformAction($aAction, $aFlag)
	If GetAgentExists(-2) Then
		DllStructSetData($mAction, 2, $aAction)
		DllStructSetData($mAction, 3, $aFlag)
		Enqueue($mActionPtr, 12)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>PerformAction

;~ Description: Internal use only.
Func Bin64ToDec($aBinary)
	Local $lReturn = 0

	For $i = 1 To StringLen($aBinary)
		If StringMid($aBinary, $i, 1) == 1 Then $lReturn += 2 ^ ($i - 1)
	Next

	Return $lReturn
EndFunc   ;==>Bin64ToDec

;~ Description: Internal use only.
Func Base64ToBin64($aCharacter)
	Select
		Case $aCharacter == "A"
			Return "000000"
		Case $aCharacter == "B"
			Return "100000"
		Case $aCharacter == "C"
			Return "010000"
		Case $aCharacter == "D"
			Return "110000"
		Case $aCharacter == "E"
			Return "001000"
		Case $aCharacter == "F"
			Return "101000"
		Case $aCharacter == "G"
			Return "011000"
		Case $aCharacter == "H"
			Return "111000"
		Case $aCharacter == "I"
			Return "000100"
		Case $aCharacter == "J"
			Return "100100"
		Case $aCharacter == "K"
			Return "010100"
		Case $aCharacter == "L"
			Return "110100"
		Case $aCharacter == "M"
			Return "001100"
		Case $aCharacter == "N"
			Return "101100"
		Case $aCharacter == "O"
			Return "011100"
		Case $aCharacter == "P"
			Return "111100"
		Case $aCharacter == "Q"
			Return "000010"
		Case $aCharacter == "R"
			Return "100010"
		Case $aCharacter == "S"
			Return "010010"
		Case $aCharacter == "T"
			Return "110010"
		Case $aCharacter == "U"
			Return "001010"
		Case $aCharacter == "V"
			Return "101010"
		Case $aCharacter == "W"
			Return "011010"
		Case $aCharacter == "X"
			Return "111010"
		Case $aCharacter == "Y"
			Return "000110"
		Case $aCharacter == "Z"
			Return "100110"
		Case $aCharacter == "a"
			Return "010110"
		Case $aCharacter == "b"
			Return "110110"
		Case $aCharacter == "c"
			Return "001110"
		Case $aCharacter == "d"
			Return "101110"
		Case $aCharacter == "e"
			Return "011110"
		Case $aCharacter == "f"
			Return "111110"
		Case $aCharacter == "g"
			Return "000001"
		Case $aCharacter == "h"
			Return "100001"
		Case $aCharacter == "i"
			Return "010001"
		Case $aCharacter == "j"
			Return "110001"
		Case $aCharacter == "k"
			Return "001001"
		Case $aCharacter == "l"
			Return "101001"
		Case $aCharacter == "m"
			Return "011001"
		Case $aCharacter == "n"
			Return "111001"
		Case $aCharacter == "o"
			Return "000101"
		Case $aCharacter == "p"
			Return "100101"
		Case $aCharacter == "q"
			Return "010101"
		Case $aCharacter == "r"
			Return "110101"
		Case $aCharacter == "s"
			Return "001101"
		Case $aCharacter == "t"
			Return "101101"
		Case $aCharacter == "u"
			Return "011101"
		Case $aCharacter == "v"
			Return "111101"
		Case $aCharacter == "w"
			Return "000011"
		Case $aCharacter == "x"
			Return "100011"
		Case $aCharacter == "y"
			Return "010011"
		Case $aCharacter == "z"
			Return "110011"
		Case $aCharacter == "0"
			Return "001011"
		Case $aCharacter == "1"
			Return "101011"
		Case $aCharacter == "2"
			Return "011011"
		Case $aCharacter == "3"
			Return "111011"
		Case $aCharacter == "4"
			Return "000111"
		Case $aCharacter == "5"
			Return "100111"
		Case $aCharacter == "6"
			Return "010111"
		Case $aCharacter == "7"
			Return "110111"
		Case $aCharacter == "8"
			Return "001111"
		Case $aCharacter == "9"
			Return "101111"
		Case $aCharacter == "+"
			Return "011111"
		Case $aCharacter == "/"
			Return "111111"
	EndSelect
EndFunc   ;==>Base64ToBin64
#EndRegion Misc

#Region Callback
;~ Description: Controls Event System.
Func SetEvent($aSkillActivate = '', $aSkillCancel = '', $aSkillComplete = '', $aChatReceive = '', $aLoadFinished = '')
	If Not $mUseEventSystem Then Return
	If $aSkillActivate <> '' Then
		WriteDetour('SkillLogStart', 'SkillLogProc')
	Else
		$mASMString = ''
		_('inc eax')
		_('mov dword[esi+10],eax')
		_('pop esi')
		WriteBinary($mASMString, GetValue('SkillLogStart'))
	EndIf

	If $aSkillCancel <> '' Then
		WriteDetour('SkillCancelLogStart', 'SkillCancelLogProc')
	Else
		$mASMString = ''
		_('push 0')
		_('push 42')
		_('mov ecx,esi')
		WriteBinary($mASMString, GetValue('SkillCancelLogStart'))
	EndIf

	If $aSkillComplete <> '' Then
		WriteDetour('SkillCompleteLogStart', 'SkillCompleteLogProc')
	Else
		$mASMString = ''
		_('mov eax,dword[edi+4]')
		_('test eax,eax')
		WriteBinary($mASMString, GetValue('SkillCompleteLogStart'))
	EndIf

	If $aChatReceive <> '' Then
		WriteDetour('ChatLogStart', 'ChatLogProc')
	Else
		$mASMString = ''
		_('add edi,E')
		_('cmp eax,B')
		WriteBinary($mASMString, GetValue('ChatLogStart'))
	EndIf

	$mSkillActivate = $aSkillActivate
	$mSkillCancel = $aSkillCancel
	$mSkillComplete = $aSkillComplete
	$mChatReceive = $aChatReceive
	$mLoadFinished = $aLoadFinished
EndFunc   ;==>SetEvent

;~ Description: Internal use for event system.
;~ modified by gigi, avoid getagentbyid, just pass agent id to callback
Func Event($hwnd, $msg, $wparam, $lparam)
	Switch $lparam
		Case 0x1
			DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $wparam, 'ptr', $mSkillLogStructPtr, 'int', 16, 'int', '')
			Call($mSkillActivate, DllStructGetData($mSkillLogStruct, 1), DllStructGetData($mSkillLogStruct, 2), DllStructGetData($mSkillLogStruct, 3), DllStructGetData($mSkillLogStruct, 4))
		Case 0x2
			DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $wparam, 'ptr', $mSkillLogStructPtr, 'int', 16, 'int', '')
			Call($mSkillCancel, DllStructGetData($mSkillLogStruct, 1), DllStructGetData($mSkillLogStruct, 2), DllStructGetData($mSkillLogStruct, 3))
		Case 0x3
			DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $wparam, 'ptr', $mSkillLogStructPtr, 'int', 16, 'int', '')
			Call($mSkillComplete, DllStructGetData($mSkillLogStruct, 1), DllStructGetData($mSkillLogStruct, 2), DllStructGetData($mSkillLogStruct, 3))
		Case 0x4
			DllCall($mKernelHandle, 'int', 'ReadProcessMemory', 'int', $mGWProcHandle, 'int', $wparam, 'ptr', $mChatLogStructPtr, 'int', 512, 'int', '')
			Local $lMessage = DllStructGetData($mChatLogStruct, 2)
			Local $lChannel
			Local $lSender
			Switch DllStructGetData($mChatLogStruct, 1)
				Case 0
					$lChannel = "Alliance"
					$lSender = StringMid($lMessage, 6, StringInStr($lMessage, "</a>") - 6)
					$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
				Case 3
					$lChannel = "All"
					$lSender = StringMid($lMessage, 6, StringInStr($lMessage, "</a>") - 6)
					$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
				Case 9
					$lChannel = "Guild"
					$lSender = StringMid($lMessage, 6, StringInStr($lMessage, "</a>") - 6)
					$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
				Case 11
					$lChannel = "Team"
					$lSender = StringMid($lMessage, 6, StringInStr($lMessage, "</a>") - 6)
					$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
				Case 12
					$lChannel = "Trade"
					$lSender = StringMid($lMessage, 6, StringInStr($lMessage, "</a>") - 6)
					$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
				Case 10
					If StringLeft($lMessage, 3) == "-> " Then
						$lChannel = "Sent"
						$lSender = StringMid($lMessage, 10, StringInStr($lMessage, "</a>") - 10)
						$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
					Else
						$lChannel = "Global"
						$lSender = "Guild Wars"
					EndIf
				Case 13
					$lChannel = "Advisory"
					$lSender = "Guild Wars"
					$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
				Case 14
					$lChannel = "Whisper"
					$lSender = StringMid($lMessage, 7, StringInStr($lMessage, "</a>") - 7)
					$lMessage = StringTrimLeft($lMessage, StringInStr($lMessage, "<quote>") + 6)
				Case Else
					$lChannel = "Other"
					$lSender = "Other"
			EndSwitch
			Call($mChatReceive, $lChannel, $lSender, $lMessage)
		Case 0x5
			Call($mLoadFinished)
	EndSwitch
EndFunc   ;==>Event
#EndRegion Callback

#Region Modification
Func ModifyMemory()
	$mASMSize = 0
	$mASMCodeOffset = 0
	$mASMString = ''
	CreateData()
	CreateMain()
;~ 	CreateTargetLog()
;~ 	CreateSkillLog()
;~ 	CreateSkillCancelLog()
;~ 	CreateSkillCompleteLog()
;~ 	CreateChatLog()
	CreateTraderHook()
;~ 	CreateLoadFinished()
	CreateStringLog()
;~ 	CreateStringFilter1()
;~ 	CreateStringFilter2()
	CreateRenderingMod()
	CreateCommands()
	CreateDialogHook()
	$mMemory = MemoryRead(MemoryRead($mBase), 'ptr')

	Switch $mMemory
		Case 0
			$mMemory = DllCall($mKernelHandle, 'ptr', 'VirtualAllocEx', 'handle', $mGWProcHandle, 'ptr', 0, 'ulong_ptr', $mASMSize, 'dword', 0x1000, 'dword', 64)
			$mMemory = $mMemory[0]
			MemoryWrite(MemoryRead($mBase), $mMemory)
;~ 			MsgBox(1,1,$mASMString)
			CompleteASMCode()
			WriteBinary($mASMString, $mMemory + $mASMCodeOffset)
			$SecondInject = $mMemory + $mASMCodeOffset
;~ 			MsgBox(1,1,$mASMString)
;~ 			WriteBinary('83F8009090', GetValue('ClickToMoveFix'))
			MemoryWrite(GetValue('QueuePtr'), GetValue('QueueBase'))
;~ 			MemoryWrite(GetValue('SkillLogPtr'), GetValue('SkillLogBase'))
;~ 			MemoryWrite(GetValue('ChatRevAdr'), GetValue('ChatRevBase'))
;~ 			MemoryWrite(GetValue('ChatLogPtr'), GetValue('ChatLogBase'))
;~ 			MemoryWrite(GetValue('StringLogPtr'), GetValue('StringLogBase'))
		Case Else
			CompleteASMCode()
	EndSwitch
	WriteDetour('MainStart', 'MainProc')
;~ 	WriteDetour('TargetLogStart', 'TargetLogProc')
	WriteDetour('TraderHookStart', 'TraderHookProc')
;~ 	WriteDetour('LoadFinishedStart', 'LoadFinishedProc')
	WriteDetour('RenderingMod', 'RenderingModProc')
;~ 	WriteDetour('StringLogStart', 'StringLogProc')
;~ 	WriteDetour('StringFilter1Start', 'StringFilter1Proc')
;~ 	WriteDetour('StringFilter2Start', 'StringFilter2Proc')
	WriteDetour('DialogLogStart', 'DialogLogProc')
EndFunc   ;==>ModifyMemory

;~ Description: Internal use only.
Func WriteDetour($aFrom, $aTo)
	WriteBinary('E9' & SwapEndian(Hex(GetLabelInfo($aTo) - GetLabelInfo($aFrom) - 5)), GetLabelInfo($aFrom))
EndFunc   ;==>WriteDetour

;~ Description: Internal use only.
Func CreateData()
	_('CallbackHandle/4')
	_('QueueCounter/4')
	_('SkillLogCounter/4')
	_('ChatLogCounter/4')
	_('ChatLogLastMsg/4')
	_('MapIsLoaded/4')
	_('NextStringType/4')
	_('EnsureEnglish/4')
	_('TraderQuoteID/4')
	_('TraderCostID/4')
	_('TraderCostValue/4')
	_('DisableRendering/4')

	_('QueueBase/' & 256 * GetValue('QueueSize'))
	_('TargetLogBase/' & 4 * GetValue('TargetLogSize'))
	_('SkillLogBase/' & 16 * GetValue('SkillLogSize'))
	_('StringLogBase/' & 256 * GetValue('StringLogSize'))
	_('ChatLogBase/' & 512 * GetValue('ChatLogSize'))

	_('LastDialogID/4')

	_('AgentCopyCount/4')
	_('AgentCopyBase/' & 0x1C0 * 256)
EndFunc   ;==>CreateData

;~ Description: Internal use only.
Func CreateMain()
	_('MainProc:')
	_('nop x')
	_('pushad')
	_('mov eax,dword[EnsureEnglish]')
	_('test eax,eax')
	_('jz MainMain')
	_('mov ecx,dword[BasePointer]')
	_('mov ecx,dword[ecx+18]')
	_('mov ecx,dword[ecx+18]')
	_('mov ecx,dword[ecx+194]')
	_('mov al,byte[ecx+4f]')
	_('cmp al,f')
	_('ja MainMain')
	_('mov ecx,dword[ecx+4c]')
	_('mov al,byte[ecx+3f]')
	_('cmp al,f')
	_('ja MainMain')
	_('mov eax,dword[ecx+40]')
	_('test eax,eax')
	_('jz MainMain')
;~ 	_('mov ecx,dword[ActionBase]')
;~ 	_('mov ecx,dword[ecx+4]')
;~ 	_('mov ecx,dword[ecx+34]')
;~ 	_('add ecx,6C')
;~ 	_('push 0')
;~ 	_('push 0')
;~ 	_('push bb')
;~ 	_('mov edx,esp')
;~ 	_('push 0')
;~ 	_('push edx')
;~ 	_('push 18')
;~ 	_('call ActionFunction')
;~ 	_('pop eax')
;~ 	_('pop ebx')
;~ 	_('pop ecx')

	_('MainMain:')
	_('mov eax,dword[QueueCounter]')
	_('mov ecx,eax')
	_('shl eax,8')
	_('add eax,QueueBase')
	_('mov ebx,dword[eax]')
	_('test ebx,ebx')

	_('jz MainExit')
	_('push ecx')
	_('mov dword[eax],0')
	_('jmp ebx')
	_('CommandReturn:')
	_('pop eax')
	_('inc eax')
	_('cmp eax,QueueSize')
	_('jnz MainSkipReset')
	_('xor eax,eax')
	_('MainSkipReset:')
	_('mov dword[QueueCounter],eax')
	_('MainExit:')
	_('popad')

	_('mov ebp,esp')
	_('fld st(0),dword[ebp+8]')

	_('ljmp MainReturn')
EndFunc   ;==>CreateMain

Func CreateTargetLog()
	_('TargetLogProc:')
	_('cmp ecx,4')
	_('jz TargetLogMain')
	_('cmp ecx,32')
	_('jz TargetLogMain')
	_('cmp ecx,3C')
	_('jz TargetLogMain')
	_('jmp TargetLogExit')

	_('TargetLogMain:')
	_('pushad')
	_('mov ecx,dword[ebp+8]')
	_('test ecx,ecx')
	_('jnz TargetLogStore')
	_('mov ecx,edx')

	_('TargetLogStore:')
	_('lea eax,dword[edx*4+TargetLogBase]')
	_('mov dword[eax],ecx')
	_('popad')

	_('TargetLogExit:')
	_('push ebx')
	_('push esi')
	_('push edi')
	_('mov edi,edx')
	_('ljmp TargetLogReturn')
EndFunc   ;==>CreateTargetLog

;~ Description: Internal use only.
Func CreateSkillLog()
	_('SkillLogProc:')
	_('pushad')

	_('mov eax,dword[SkillLogCounter]')
	_('push eax')
	_('shl eax,4')
	_('add eax,SkillLogBase')

	_('mov ecx,dword[edi]')
	_('mov dword[eax],ecx')
	_('mov ecx,dword[ecx*4+TargetLogBase]')
	_('mov dword[eax+4],ecx')
	_('mov ecx,dword[edi+4]')
	_('mov dword[eax+8],ecx')
	_('mov ecx,dword[edi+8]')
	_('mov dword[eax+c],ecx')

	_('push 1')
	_('push eax')
	_('push CallbackEvent')
	_('push dword[CallbackHandle]')
	_('call dword[PostMessage]')

	_('pop eax')
	_('inc eax')
	_('cmp eax,SkillLogSize')
	_('jnz SkillLogSkipReset')
	_('xor eax,eax')
	_('SkillLogSkipReset:')
	_('mov dword[SkillLogCounter],eax')

	_('popad')
	_('inc eax')
	_('mov dword[esi+10],eax')
	_('pop esi')
	_('ljmp SkillLogReturn')
EndFunc   ;==>CreateSkillLog

;~ Description: Internal use only.
Func CreateSkillCancelLog()
	_('SkillCancelLogProc:')
	_('pushad')

	_('mov eax,dword[SkillLogCounter]')
	_('push eax')
	_('shl eax,4')
	_('add eax,SkillLogBase')

	_('mov ecx,dword[edi]')
	_('mov dword[eax],ecx')
	_('mov ecx,dword[ecx*4+TargetLogBase]')
	_('mov dword[eax+4],ecx')
	_('mov ecx,dword[edi+4]')
	_('mov dword[eax+8],ecx')

	_('push 2')
	_('push eax')
	_('push CallbackEvent')
	_('push dword[CallbackHandle]')
	_('call dword[PostMessage]')

	_('pop eax')
	_('inc eax')
	_('cmp eax,SkillLogSize')
	_('jnz SkillCancelLogSkipReset')
	_('xor eax,eax')
	_('SkillCancelLogSkipReset:')
	_('mov dword[SkillLogCounter],eax')

	_('popad')
	_('push 0')
	_('push 48')
	_('mov ecx,esi')
	_('ljmp SkillCancelLogReturn')
EndFunc   ;==>CreateSkillCancelLog

;~ Description: Internal use only.
Func CreateSkillCompleteLog()
	_('SkillCompleteLogProc:')
	_('pushad')

	_('mov eax,dword[SkillLogCounter]')
	_('push eax')
	_('shl eax,4')
	_('add eax,SkillLogBase')

	_('mov ecx,dword[edi]')
	_('mov dword[eax],ecx')
	_('mov ecx,dword[ecx*4+TargetLogBase]')
	_('mov dword[eax+4],ecx')
	_('mov ecx,dword[edi+4]')
	_('mov dword[eax+8],ecx')

	_('push 3')
	_('push eax')
	_('push CallbackEvent')
	_('push dword[CallbackHandle]')
	_('call dword[PostMessage]')

	_('pop eax')
	_('inc eax')
	_('cmp eax,SkillLogSize')
	_('jnz SkillCompleteLogSkipReset')
	_('xor eax,eax')
	_('SkillCompleteLogSkipReset:')
	_('mov dword[SkillLogCounter],eax')

	_('popad')
	_('mov eax,dword[edi+4]')
	_('test eax,eax')
	_('ljmp SkillCompleteLogReturn')
EndFunc   ;==>CreateSkillCompleteLog

;~ Description: Internal use only.
Func CreateChatLog()
	_('ChatLogProc:')

	_('pushad')
	_('mov ecx,dword[esp+1F4]')
	_('mov ebx,eax')
	_('mov eax,dword[ChatLogCounter]')
	_('push eax')
	_('shl eax,9')
	_('add eax,ChatLogBase')
	_('mov dword[eax],ebx')

	_('mov edi,eax')
	_('add eax,4')
	_('xor ebx,ebx')

	_('ChatLogCopyLoop:')
	_('mov dx,word[ecx]')
	_('mov word[eax],dx')
	_('add ecx,2')
	_('add eax,2')
	_('inc ebx')
	_('cmp ebx,FF')
	_('jz ChatLogCopyExit')
	_('test dx,dx')
	_('jnz ChatLogCopyLoop')

	_('ChatLogCopyExit:')
	_('push 4')
	_('push edi')
	_('push CallbackEvent')
	_('push dword[CallbackHandle]')
	_('call dword[PostMessage]')

	_('pop eax')
	_('inc eax')
	_('cmp eax,ChatLogSize')
	_('jnz ChatLogSkipReset')
	_('xor eax,eax')
	_('ChatLogSkipReset:')
	_('mov dword[ChatLogCounter],eax')
	_('popad')

	_('ChatLogExit:')
	_('add edi,E')
	_('cmp eax,B')
	_('ljmp ChatLogReturn')
EndFunc   ;==>CreateChatLog

;~ Description: Internal use only.
Func CreateTraderHook()
	_('TraderHookProc:')
	_('mov dword[TraderCostID],ecx')
	_('mov dword[TraderCostValue],edx')
	_('push eax')
	_('mov eax,dword[TraderQuoteID]')
	_('inc eax')
	_('cmp eax,200')
	_('jnz TraderSkipReset')
	_('xor eax,eax')
	_('TraderSkipReset:')
	_('mov dword[TraderQuoteID],eax')
	_('pop eax')
	_('mov ebp,esp')
	_('sub esp,8')
	_('ljmp TraderHookReturn')
EndFunc   ;==>CreateTraderHook

;~ Description: Internal use only.
Func CreateDialogHook()
	_('DialogLogProc:')
	_('push ecx')
	_('mov ecx,esp')
	_('add ecx,C')
	_('mov ecx,dword[ecx]')
	_('mov dword[LastDialogID],ecx')
	_('pop ecx')
	_('mov ebp,esp')
	_('sub esp,8')
	_('ljmp DialogLogReturn')
EndFunc   ;==>CreateDialogHook

;~ Description: Internal use only.
Func CreateLoadFinished()
	_('LoadFinishedProc:')
	_('pushad')

	_('mov eax,1')
	_('mov dword[MapIsLoaded],eax')

	_('xor ebx,ebx')
	_('mov eax,StringLogBase')
	_('LoadClearStringsLoop:')
	_('mov dword[eax],0')
	_('inc ebx')
	_('add eax,100')
	_('cmp ebx,StringLogSize')
	_('jnz LoadClearStringsLoop')

	_('xor ebx,ebx')
	_('mov eax,TargetLogBase')
	_('LoadClearTargetsLoop:')
	_('mov dword[eax],0')
	_('inc ebx')
	_('add eax,4')
	_('cmp ebx,TargetLogSize')
	_('jnz LoadClearTargetsLoop')

	_('push 5')
	_('push 0')
	_('push CallbackEvent')
	_('push dword[CallbackHandle]')
	_('call dword[PostMessage]')

	_('popad')
	_('mov edx,dword[esi+1C]')
	_('mov ecx,edi')
	_('ljmp LoadFinishedReturn')
EndFunc   ;==>CreateLoadFinished

;~ Description: Internal use only.
Func CreateStringLog()
	_('StringLogProc:')
	_('pushad')
	_('mov eax,dword[NextStringType]')
	_('test eax,eax')
	_('jz StringLogExit')

	_('cmp eax,1')
	_('jnz StringLogFilter2')
	_('mov eax,dword[ebp+37c]')
	_('jmp StringLogRangeCheck')

	_('StringLogFilter2:')
	_('cmp eax,2')
	_('jnz StringLogExit')
	_('mov eax,dword[ebp+338]')

	_('StringLogRangeCheck:')
	_('mov dword[NextStringType],0')
	_('cmp eax,0')
	_('jbe StringLogExit')
	_('cmp eax,StringLogSize')
	_('jae StringLogExit')

	_('shl eax,8')
	_('add eax,StringLogBase')

	_('xor ebx,ebx')
	_('StringLogCopyLoop:')
	_('mov dx,word[ecx]')
	_('mov word[eax],dx')
	_('add ecx,2')
	_('add eax,2')
	_('inc ebx')
	_('cmp ebx,80')
	_('jz StringLogExit')
	_('test dx,dx')
	_('jnz StringLogCopyLoop')

	_('StringLogExit:')
	_('popad')
	_('mov esp,ebp')
	_('pop ebp')
	_('retn 10')
EndFunc   ;==>CreateStringLog

;~ Description: Internal use only.
Func CreateStringFilter1()
	_('StringFilter1Proc:')
	_('mov dword[NextStringType],1')

	_('push ebp')
	_('mov ebp,esp')
	_('push ecx')
	_('push esi')
	_('ljmp StringFilter1Return')
EndFunc   ;==>CreateStringFilter1

;~ Description: Internal use only.
Func CreateStringFilter2()
	_('StringFilter2Proc:')
	_('mov dword[NextStringType],2')

	_('push ebp')
	_('mov ebp,esp')
	_('push ecx')
	_('push esi')
	_('ljmp StringFilter2Return')
EndFunc   ;==>CreateStringFilter2

;~ Description: Internal use only.
Func CreateRenderingMod()
;~ 	_('RenderingModProc:')
;~ 	_('cmp dword[DisableRendering],1')
;~ 	_('jz RenderingModSkipCompare')
;~ 	_('cmp eax,ebx')
;~ 	_('ljne RenderingModReturn')
;~ 	_('RenderingModSkipCompare:')

;~ 	$mASMSize += 17
;~ 	$mASMString &= StringTrimLeft(MemoryRead(GetValue("RenderingMod") + 4, "byte[17]"), 2)

;~ 	_('cmp dword[DisableRendering],1')
;~ 	_('jz DisableRenderingProc')
;~ 	_('retn')

;~ 	_('DisableRenderingProc:')
;~ 	_('push 1')
;~ 	_('call dword[Sleep]')
;~ 	_('retn')

	_("RenderingModProc:")
	_("add esp,4")
	_("cmp dword[DisableRendering],1")
	_("ljmp RenderingModReturn")
EndFunc   ;==>CreateRenderingMod

;~ Description: Internal use only.
Func CreateCommands()
	_('CommandUseSkill:')
	_('mov ecx,dword[eax+C]')
	_('push ecx')
	_('mov ebx,dword[eax+8]')
	_('push ebx')
	_('mov edx,dword[eax+4]')
	_('dec edx')
	_('push edx')
	_('mov eax,dword[MyID]')
	_('push eax')
	_('call UseSkillFunction')
	_('pop eax')
	_('pop edx')
	_('pop ebx')
	_('pop ecx')
	_('ljmp CommandReturn')

	_('CommandMove:')
	_('lea eax,dword[eax+4]')
	_('push eax')
	_('call MoveFunction')
	_('pop eax')
	_('ljmp CommandReturn')

	_('CommandChangeTarget:')
	_('xor edx,edx')
	_('push edx')
	_('mov eax,dword[eax+4]')
	_('push eax')
	_('call ChangeTargetFunction')
	_('pop eax')
	_('pop edx')
	_('ljmp CommandReturn')

	_('CommandPacketSend:')
	_('lea edx,dword[eax+8]')
	_('push edx')
	_('mov ebx,dword[eax+4]')
	_('push ebx')
	_('mov eax,dword[PacketLocation]')
	_('push eax')
	_('call PacketSendFunction')
	_('pop eax')
	_('pop ebx')
	_('pop edx')
	_('ljmp CommandReturn')

	_('CommandChangeStatus:')
	_('mov eax,dword[eax+4]')
	_('push eax')
	_('call ChangeStatusFunction')
	_('pop eax')
	_('ljmp CommandReturn')

;~ 	_('CommandWriteChat:')
;~ 	_('add eax,4')
;~ 	_('mov edx,eax')
;~ 	_('xor ecx,ecx')
;~ 	_('add eax,28')
;~ 	_('push eax')
;~ 	_('call WriteChatFunction')
;~ 	_('ljmp CommandReturn')

	_('CommandWriteChat:')
	_('add eax,4')
;~ 	_('mov edx,eax')
;~ 	_('xor ecx,ecx')
;~ 	_('add eax,28')
	_('push eax')
	_('call WriteChatFunction')
	_('pop eax')
	_('ljmp CommandReturn')

	_('CommandSellItem:')
	_('mov esi,eax')
	_('add esi,C') ;01239A20
	_('push 0')
	_('push 0')
	_('push 0')
	_('push dword[eax+4]')
	_('push 0')
	_('add eax,8')
	_('push eax')
	_('push 1')
	_('push 0')
	_('push B')
	_('call TransactionFunction')
	_('add esp,24')
	_('ljmp CommandReturn')

	_('CommandBuyItem:')
	_('mov esi,eax')
	_('add esi,10') ;01239A20
	_('mov ecx,eax')
	_('add ecx,4')
	_('push ecx')
	_('mov edx,eax')
	_('add edx,8')
	_('push edx')
	_('push 1')
	_('push 0')
	_('push 0')
	_('push 0')
	_('push 0')
	_('mov eax,dword[eax+C]')
	_('push eax')
	_('push 1')
	_('call TransactionFunction')
	_('add esp,24')
	_('ljmp CommandReturn')

;~ 	_('CommandCraftItemEx:')
;~ 	_('add eax,4')
;~ 	_('push eax')
;~ 	_('add eax,4')
;~ 	_('push eax')
;~ 	_('push 1')
;~ 	_('push 0')
;~ 	_('push 0')
;~ 	_('push dword[eax+4]')
;~ 	_('add eax,4')
;~ 	_('push dword[eax+4]')
;~ 	_('add eax,4')
;~ 	_('mov edx,esp')
;~ 	_('mov ecx,dword[E1D684]')
;~ 	_('mov dword[edx-0x70],ecx')
;~ 	_('mov ecx,dword[edx+0x1C]')
;~ 	_('mov dword[edx+0x54],ecx')
;~ 	_('mov ecx,dword[edx+4]')
;~ 	_('mov dword[edx-0x14],ecx')
;~ 	_('mov ecx,3')
;~ 	_('mov ebx,dword[eax]')
;~ 	_('mov edx,dword[eax+4]')
;~ 	_('call BuyItemFunction')
;~ 	_('ljmp CommandReturn')

	_('CommandAction:')
	_('mov ecx,dword[ActionBase]')
	_('mov ecx,dword[ecx+�]')
	_('add ecx,A0')
	_('push 0')
	_('add eax,4')
	_('push eax')
	_('push dword[eax+4]')
	_('mov edx,0')
	_('call ActionFunction')
	_('ljmp CommandReturn')

;~ 	_('CommandToggleLanguage:')
;~ 	_('mov ecx,dword[ActionBase]')
;~ 	_('mov ecx,dword[ecx+170]')
;~ 	_('mov ecx,dword[ecx+20]')
;~ 	_('mov ecx,dword[ecx]')
;~ 	_('push 0')
;~ 	_('push 0')
;~ 	_('push bb')
;~ 	_('mov edx,esp')
;~ 	_('push 0')
;~ 	_('push edx')
;~ 	_('push dword[eax+4]')
;~ 	_('call ActionFunction')
;~ 	_('pop eax')
;~ 	_('pop ebx')
;~ 	_('pop ecx')
;~ 	_('ljmp CommandReturn')

	_('CommandUseHeroSkill:')
	_('mov ecx,dword[eax+8]')
	_('push ecx')
	_('mov ecx,dword[eax+c]')
	_('push ecx')
	_('mov ecx,dword[eax+4]')
	_('push ecx')
	_('call UseHeroSkillFunction')
	_('add esp,C')
	_('ljmp CommandReturn')

	_('CommandSendChat:')
	_('lea edx,dword[eax+4]')
	_('push edx')
	_('mov ebx,11c')
	_('push ebx')
	_('mov eax,dword[PacketLocation]')
	_('push eax')
	_('call PacketSendFunction')
	_('pop eax')
	_('pop ebx')
	_('pop edx')
	_('ljmp CommandReturn')

	_('CommandRequestQuote:')
	_('mov dword[TraderCostID],0')
	_('mov dword[TraderCostValue],0')
	_('mov esi,eax')
	_('add esi,4')
	_('push esi')
	_('push 1')
	_('push 0')
	_('push 0')
	_('push 0')
	_('push 0')
	_('push 0')
	_('push C')
	_('xor edx,edx')
	_('call RequestQuoteFunction')
	_('add esp,20')
	_('ljmp CommandReturn')

;~ 	_('CommandRequestQuoteSell:')
;~ 	_('mov dword[TraderCostID],0')
;~ 	_('mov dword[TraderCostValue],0')
;~ 	_('push 0')
;~ 	_('push 0')
;~ 	_('push 0')
;~ 	_('add eax,4')
;~ 	_('push eax')
;~ 	_('push 1')
;~ 	_('push 0')
;~ 	_('mov ecx,d')
;~ 	_('xor edx,edx')
;~ 	_('call RequestQuoteFunction')
;~ 	_('ljmp CommandReturn')

	_('CommandTraderBuy:')
	_('push 0')
	_('push TraderCostID')
	_('push 1')
	_('push 0')
	_('push 0')
	_('push 0')
	_('push 0')
	_('mov ecx,c')
	_('mov edx,dword[TraderCostValue]')
	_('call TraderFunction')
	_('mov dword[TraderCostID],0')
	_('mov dword[TraderCostValue],0')
	_('ljmp CommandReturn')

	_('mov esi,eax')
	_('add esi,10') ;01239A20
	_('mov ecx,eax')
	_('add ecx,4')
	_('push ecx')
	_('mov edx,eax')
	_('add edx,8')
	_('push edx')
	_('push 1')
	_('push 0')
	_('push 0')
	_('push 0')
	_('push 0')
	_('mov eax,dword[eax+C]')
	_('push eax')
	_('push 1')
	_('call TransactionFunction')
	_('add esp,24')
	_('ljmp CommandReturn')

;~ 	_('CommandTraderSell:')
;~ 	_('push 0')
;~ 	_('push 0')
;~ 	_('push 0')
;~ 	_('push dword[TraderCostValue]')
;~ 	_('push 0')
;~ 	_('push TraderCostID')
;~ 	_('push 1')
;~ 	_('mov ecx,d')
;~ 	_('xor edx,edx')
;~ 	_('call TraderFunction')
;~ 	_('mov dword[TraderCostID],0')
;~ 	_('mov dword[TraderCostValue],0')
;~ 	_('ljmp CommandReturn')

;~ 	_('CommandSalvage:')
;~ 	_('mov ebx,SalvageGlobal')
;~ 	_('mov ecx,dword[eax+4]')
;~ 	_('mov dword[ebx],ecx')
;~ 	_('push ecx')
;~ 	_('mov ecx,dword[eax+8]')
;~ 	_('add ebx,4')
;~ 	_('mov dword[ebx],ecx')
;~ 	_('mov edx,dword[eax+c]')
;~ 	_('mov dword[ebx],ecx')
;~ 	_('call SalvageFunction')
;~ 	_('ljmp CommandReturn')

	_('CommandSalvage:')
	_('push eax')
	_('push ecx')
	_('push ebx')
	_('mov ebx,SalvageGlobal')
	_('mov ecx,dword[eax+4]')
	_('mov dword[ebx],ecx')
	_('add ebx,4')
	_('mov ecx,dword[eax+8]')
	_('mov dword[ebx],ecx')
	_('mov ebx,dword[eax+4]')
	_('push ebx')
	_('mov ebx,dword[eax+8]')
	_('push ebx')
	_('mov ebx,dword[eax+c]')
	_('push ebx')
	_('call SalvageFunction')
	_('add esp,C')
	_('pop ebx')
	_('pop ecx')
	_('pop eax')
	_('ljmp CommandReturn')

	_('CommandIncreaseAttribute:')
	_('mov edx,dword[eax+4]')
	_('push edx')
	_('mov ecx,dword[eax+8]')
	_('push ecx')
	_('call IncreaseAttributeFunction')
	_('pop ecx')
	_('pop edx')
	_('ljmp CommandReturn')

	_('CommandDecreaseAttribute:')
	_('mov edx,dword[eax+4]')
	_('push edx')
	_('mov ecx,dword[eax+8]')
	_('push ecx')
	_('call DecreaseAttributeFunction')
	_('pop ecx')
	_('pop edx')
	_('ljmp CommandReturn')

	_('CommandMakeAgentArray:')
	_('mov eax,dword[eax+4]')
	_('xor ebx,ebx')
	_('xor edx,edx')
	_('mov edi,AgentCopyBase')

	_('AgentCopyLoopStart:')
	_('inc ebx')
	_('cmp ebx,dword[MaxAgents]')
	_('jge AgentCopyLoopExit')

	_('mov esi,dword[AgentBase]')
	_('lea esi,dword[esi+ebx*4]')
	_('mov esi,dword[esi]')
	_('test esi,esi')
	_('jz AgentCopyLoopStart')

	_('cmp eax,0')
	_('jz CopyAgent')
	_('cmp eax,dword[esi+9C]')
	_('jnz AgentCopyLoopStart')

	_('CopyAgent:')
	_('mov ecx,1C0')
	_('clc')
	_('repe movsb')
	_('inc edx')
	_('jmp AgentCopyLoopStart')

	_('AgentCopyLoopExit:')
	_('mov dword[AgentCopyCount],edx')
	_('ljmp CommandReturn')
EndFunc   ;==>CreateCommands
#EndRegion Modification

#Region Online Status
Func SetPlayerStatus($iStatus)
	If (($iStatus >= 0 And $iStatus <= 3) And (GetPlayerStatus() <> $iStatus)) Then
		DllStructSetData($mChangeStatus, 2, $iStatus)

		Enqueue($mChangeStatusPtr, 8)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>SetPlayerStatus

Func GetPlayerStatus()
	Return MemoryRead($mCurrentStatus)
EndFunc   ;==>GetPlayerStatus
#EndRegion Online Status

#Region Assembler
;~ Description: Internal use only.
Func _($aASM)
	;quick and dirty x86assembler unit:
	;relative values stringregexp
	;static values hardcoded
	Local $lBuffer
	Select
		Case StringRight($aASM, 1) = ':'
			SetValue('Label_' & StringLeft($aASM, StringLen($aASM) - 1), $mASMSize)
		Case StringInStr($aASM, '/') > 0
			SetValue('Label_' & StringLeft($aASM, StringInStr($aASM, '/') - 1), $mASMSize)
			Local $lOffset = StringRight($aASM, StringLen($aASM) - StringInStr($aASM, '/'))
			$mASMSize += $lOffset
			$mASMCodeOffset += $lOffset
		Case StringLeft($aASM, 5) = 'nop x'
			$lBuffer = Int(Number(StringTrimLeft($aASM, 5)))
			$mASMSize += $lBuffer
			For $i = 1 To $lBuffer
				$mASMString &= '90'
			Next
		Case StringLeft($aASM, 5) = 'ljmp '
			$mASMSize += 5
			$mASMString &= 'E9{' & StringRight($aASM, StringLen($aASM) - 5) & '}'
		Case StringLeft($aASM, 5) = 'ljne '
			$mASMSize += 6
			$mASMString &= '0F85{' & StringRight($aASM, StringLen($aASM) - 5) & '}'
		Case StringLeft($aASM, 4) = 'jmp ' And StringLen($aASM) > 7
			$mASMSize += 2
			$mASMString &= 'EB(' & StringRight($aASM, StringLen($aASM) - 4) & ')'
		Case StringLeft($aASM, 4) = 'jae '
			$mASMSize += 2
			$mASMString &= '73(' & StringRight($aASM, StringLen($aASM) - 4) & ')'
		Case StringLeft($aASM, 3) = 'jz '
			$mASMSize += 2
			$mASMString &= '74(' & StringRight($aASM, StringLen($aASM) - 3) & ')'
		Case StringLeft($aASM, 4) = 'jnz '
			$mASMSize += 2
			$mASMString &= '75(' & StringRight($aASM, StringLen($aASM) - 4) & ')'
		Case StringLeft($aASM, 4) = 'jbe '
			$mASMSize += 2
			$mASMString &= '76(' & StringRight($aASM, StringLen($aASM) - 4) & ')'
		Case StringLeft($aASM, 3) = 'ja '
			$mASMSize += 2
			$mASMString &= '77(' & StringRight($aASM, StringLen($aASM) - 3) & ')'
		Case StringLeft($aASM, 3) = 'jl '
			$mASMSize += 2
			$mASMString &= '7C(' & StringRight($aASM, StringLen($aASM) - 3) & ')'
		Case StringLeft($aASM, 4) = 'jge '
			$mASMSize += 2
			$mASMString &= '7D(' & StringRight($aASM, StringLen($aASM) - 4) & ')'
		Case StringLeft($aASM, 4) = 'jle '
			$mASMSize += 2
			$mASMString &= '7E(' & StringRight($aASM, StringLen($aASM) - 4) & ')'
		Case StringRegExp($aASM, 'mov eax,dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 5
			$mASMString &= 'A1[' & StringMid($aASM, 15, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'mov ebx,dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= '8B1D[' & StringMid($aASM, 15, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'mov ecx,dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= '8B0D[' & StringMid($aASM, 15, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'mov edx,dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= '8B15[' & StringMid($aASM, 15, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'mov esi,dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= '8B35[' & StringMid($aASM, 15, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'mov edi,dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= '8B3D[' & StringMid($aASM, 15, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'cmp ebx,dword\[[a-z,A-Z]{4,}\]')
			$mASMSize += 6
			$mASMString &= '3B1D[' & StringMid($aASM, 15, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'lea eax,dword[[]ecx[*]8[+][a-z,A-Z]{4,}[]]')
			$mASMSize += 7
			$mASMString &= '8D04CD[' & StringMid($aASM, 21, StringLen($aASM) - 21) & ']'
		Case StringRegExp($aASM, 'lea edi,dword\[edx\+[a-z,A-Z]{4,}\]')
			$mASMSize += 7
			$mASMString &= '8D3C15[' & StringMid($aASM, 19, StringLen($aASM) - 19) & ']'
		Case StringRegExp($aASM, 'cmp dword[[][a-z,A-Z]{4,}[]],[-[:xdigit:]]')
			$lBuffer = StringInStr($aASM, ",")
			$lBuffer = ASMNumber(StringMid($aASM, $lBuffer + 1), True)
			If @extended Then
				$mASMSize += 7
				$mASMString &= '833D[' & StringMid($aASM, 11, StringInStr($aASM, ",") - 12) & ']' & $lBuffer
			Else
				$mASMSize += 10
				$mASMString &= '813D[' & StringMid($aASM, 11, StringInStr($aASM, ",") - 12) & ']' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'cmp ecx,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 6
			$mASMString &= '81F9[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'cmp ebx,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 6
			$mASMString &= '81FB[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'cmp eax,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= '3D[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'add eax,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= '05[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'mov eax,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= 'B8[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'mov ebx,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= 'BB[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'mov ecx,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= 'B9[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'mov esi,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= 'BE[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'mov edi,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= 'BF[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'mov edx,[a-z,A-Z]{4,}') And StringInStr($aASM, ',dword') = 0
			$mASMSize += 5
			$mASMString &= 'BA[' & StringRight($aASM, StringLen($aASM) - 8) & ']'
		Case StringRegExp($aASM, 'mov dword[[][a-z,A-Z]{4,}[]],ecx')
			$mASMSize += 6
			$mASMString &= '890D[' & StringMid($aASM, 11, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'fstp dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= 'D91D[' & StringMid($aASM, 12, StringLen($aASM) - 12) & ']'
		Case StringRegExp($aASM, 'mov dword[[][a-z,A-Z]{4,}[]],edx')
			$mASMSize += 6
			$mASMString &= '8915[' & StringMid($aASM, 11, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'mov dword[[][a-z,A-Z]{4,}[]],eax')
			$mASMSize += 5
			$mASMString &= 'A3[' & StringMid($aASM, 11, StringLen($aASM) - 15) & ']'
		Case StringRegExp($aASM, 'lea eax,dword[[]edx[*]4[+][a-z,A-Z]{4,}[]]')
			$mASMSize += 7
			$mASMString &= '8D0495[' & StringMid($aASM, 21, StringLen($aASM) - 21) & ']'
		Case StringRegExp($aASM, 'mov eax,dword[[]ecx[*]4[+][a-z,A-Z]{4,}[]]')
			$mASMSize += 7
			$mASMString &= '8B048D[' & StringMid($aASM, 21, StringLen($aASM) - 21) & ']'
		Case StringRegExp($aASM, 'mov ecx,dword[[]ecx[*]4[+][a-z,A-Z]{4,}[]]')
			$mASMSize += 7
			$mASMString &= '8B0C8D[' & StringMid($aASM, 21, StringLen($aASM) - 21) & ']'
		Case StringRegExp($aASM, 'push dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= 'FF35[' & StringMid($aASM, 12, StringLen($aASM) - 12) & ']'
		Case StringRegExp($aASM, 'push [a-z,A-Z]{4,}\z')
			$mASMSize += 5
			$mASMString &= '68[' & StringMid($aASM, 6, StringLen($aASM) - 5) & ']'
		Case StringRegExp($aASM, 'call dword[[][a-z,A-Z]{4,}[]]')
			$mASMSize += 6
			$mASMString &= 'FF15[' & StringMid($aASM, 12, StringLen($aASM) - 12) & ']'
		Case StringLeft($aASM, 5) = 'call ' And StringLen($aASM) > 8
			$mASMSize += 5
			$mASMString &= 'E8{' & StringMid($aASM, 6, StringLen($aASM) - 5) & '}'
		Case StringRegExp($aASM, 'mov dword\[[a-z,A-Z]{4,}\],[-[:xdigit:]]{1,8}\z')
			$lBuffer = StringInStr($aASM, ",")
			$mASMSize += 10
			$mASMString &= 'C705[' & StringMid($aASM, 11, $lBuffer - 12) & ']' & ASMNumber(StringMid($aASM, $lBuffer + 1))
		Case StringRegExp($aASM, 'push [-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 6), True)
			If @extended Then
				$mASMSize += 2
				$mASMString &= '6A' & $lBuffer
			Else
				$mASMSize += 5
				$mASMString &= '68' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'mov eax,[-[:xdigit:]]{1,8}\z')
			$mASMSize += 5
			$mASMString &= 'B8' & ASMNumber(StringMid($aASM, 9))
		Case StringRegExp($aASM, 'mov ebx,[-[:xdigit:]]{1,8}\z')
			$mASMSize += 5
			$mASMString &= 'BB' & ASMNumber(StringMid($aASM, 9))
		Case StringRegExp($aASM, 'mov ecx,[-[:xdigit:]]{1,8}\z')
			$mASMSize += 5
			$mASMString &= 'B9' & ASMNumber(StringMid($aASM, 9))
		Case StringRegExp($aASM, 'mov edx,[-[:xdigit:]]{1,8}\z')
			$mASMSize += 5
			$mASMString &= 'BA' & ASMNumber(StringMid($aASM, 9))
		Case StringRegExp($aASM, 'add eax,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83C0' & $lBuffer
			Else
				$mASMSize += 5
				$mASMString &= '05' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'add ebx,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83C3' & $lBuffer
			Else
				$mASMSize += 6
				$mASMString &= '81C3' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'add ecx,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83C1' & $lBuffer
			Else
				$mASMSize += 6
				$mASMString &= '81C1' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'add edx,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83C2' & $lBuffer
			Else
				$mASMSize += 6
				$mASMString &= '81C2' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'add edi,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83C7' & $lBuffer
			Else
				$mASMSize += 6
				$mASMString &= '81C7' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'add esi,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83C6' & $lBuffer
			Else
				$mASMSize += 6
				$mASMString &= '81C6' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'add esp,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83C4' & $lBuffer
			Else
				$mASMSize += 6
				$mASMString &= '81C4' & $lBuffer
			EndIf
		Case StringRegExp($aASM, 'cmp ebx,[-[:xdigit:]]{1,8}\z')
			$lBuffer = ASMNumber(StringMid($aASM, 9), True)
			If @extended Then
				$mASMSize += 3
				$mASMString &= '83FB' & $lBuffer
			Else
				$mASMSize += 6
				$mASMString &= '81FB' & $lBuffer
			EndIf
		Case StringLeft($aASM, 8) = 'cmp ecx,' And StringLen($aASM) > 10
			Local $lOpCode = '81F9' & StringMid($aASM, 9)
			$mASMSize += 0.5 * StringLen($lOpCode)
			$mASMString &= $lOpCode
		Case Else
			Local $lOpCode
			Switch $aASM
				Case 'nop'
					$lOpCode = '90'
				Case 'pushad'
					$lOpCode = '60'
				Case 'popad'
					$lOpCode = '61'
				Case 'mov ebx,dword[eax]'
					$lOpCode = '8B18'
				Case 'test eax,eax'
					$lOpCode = '85C0'
				Case 'test ebx,ebx'
					$lOpCode = '85DB'
				Case 'test ecx,ecx'
					$lOpCode = '85C9'
				Case 'mov dword[eax],0'
					$lOpCode = 'C70000000000'
				Case 'push eax'
					$lOpCode = '50'
				Case 'push ebx'
					$lOpCode = '53'
				Case 'push ecx'
					$lOpCode = '51'
				Case 'push edx'
					$lOpCode = '52'
				Case 'push ebp'
					$lOpCode = '55'
				Case 'push esi'
					$lOpCode = '56'
				Case 'push edi'
					$lOpCode = '57'
				Case 'jmp ebx'
					$lOpCode = 'FFE3'
				Case 'pop eax'
					$lOpCode = '58'
				Case 'pop ebx'
					$lOpCode = '5B'
				Case 'pop edx'
					$lOpCode = '5A'
				Case 'pop ecx'
					$lOpCode = '59'
				Case 'pop esi'
					$lOpCode = '5E'
				Case 'inc eax'
					$lOpCode = '40'
				Case 'inc ecx'
					$lOpCode = '41'
				Case 'inc ebx'
					$lOpCode = '43'
				Case 'dec edx'
					$lOpCode = '4A'
				Case 'mov edi,edx'
					$lOpCode = '8BFA'
				Case 'mov ecx,esi'
					$lOpCode = '8BCE'
				Case 'mov ecx,edi'
					$lOpCode = '8BCF'
				Case 'mov ecx,esp'
					$lOpCode = '8BCC'
				Case 'xor eax,eax'
					$lOpCode = '33C0'
				Case 'xor ecx,ecx'
					$lOpCode = '33C9'
				Case 'xor edx,edx'
					$lOpCode = '33D2'
				Case 'xor ebx,ebx'
					$lOpCode = '33DB'
				Case 'mov edx,eax'
					$lOpCode = '8BD0'
				Case 'mov edx,ecx'
					$lOpCode = '8BD1'
				Case 'mov ebp,esp'
					$lOpCode = '8BEC'
				Case 'sub esp,8'
					$lOpCode = '83EC08'
				Case 'sub esp,14'
					$lOpCode = '83EC14'
				Case 'cmp ecx,4'
					$lOpCode = '83F904'
				Case 'cmp ecx,32'
					$lOpCode = '83F932'
				Case 'cmp ecx,3C'
					$lOpCode = '83F93C'
				Case 'mov ecx,edx'
					$lOpCode = '8BCA'
				Case 'mov eax,ecx'
					$lOpCode = '8BC1'
				Case 'mov ecx,dword[ebp+8]'
					$lOpCode = '8B4D08'
				Case 'mov ecx,dword[esp+1F4]'
					$lOpCode = '8B8C24F4010000'
				Case 'mov ecx,dword[edi+4]'
					$lOpCode = '8B4F04'
				Case 'mov ecx,dword[edi+8]'
					$lOpCode = '8B4F08'
				Case 'mov eax,dword[edi+4]'
					$lOpCode = '8B4704'
				Case 'mov dword[eax+4],ecx'
					$lOpCode = '894804'
				Case 'mov dword[eax+8],ecx'
					$lOpCode = '894808'
				Case 'mov dword[eax+C],ecx'
					$lOpCode = '89480C'
				Case 'mov dword[esi+10],eax'
					$lOpCode = '894610'
				Case 'mov ecx,dword[edi]'
					$lOpCode = '8B0F'
				Case 'mov dword[eax],ecx'
					$lOpCode = '8908'
				Case 'mov dword[eax],ebx'
					$lOpCode = '8918'
				Case 'mov edx,dword[eax+4]'
					$lOpCode = '8B5004'
				Case 'mov edx,dword[eax+c]'
					$lOpCode = '8B500C'
				Case 'mov edx,dword[esi+1c]'
					$lOpCode = '8B561C'
				Case 'push dword[eax+8]'
					$lOpCode = 'FF7008'
				Case 'lea eax,dword[eax+18]'
					$lOpCode = '8D4018'
				Case 'lea ecx,dword[eax+4]'
					$lOpCode = '8D4804'
				Case 'lea ecx,dword[eax+C]'
					$lOpCode = '8D480C'
				Case 'lea eax,dword[eax+4]'
					$lOpCode = '8D4004'
				Case 'lea edx,dword[eax]'
					$lOpCode = '8D10'
				Case 'lea edx,dword[eax+4]'
					$lOpCode = '8D5004'
				Case 'lea edx,dword[eax+8]'
					$lOpCode = '8D5008'
				Case 'mov ecx,dword[eax+4]'
					$lOpCode = '8B4804'
				Case 'mov esi,dword[eax+4]'
					$lOpCode = '8B7004'
				Case 'mov esp,dword[eax+4]'
					$lOpCode = '8B6004'
				Case 'mov ecx,dword[eax+8]'
					$lOpCode = '8B4808'
				Case 'mov eax,dword[eax+8]'
					$lOpCode = '8B4008'
				Case 'mov eax,dword[eax+C]'
					$lOpCode = '8B400C'
				Case 'mov ebx,dword[eax+4]'
					$lOpCode = '8B5804'
				Case 'mov ebx,dword[eax]'
					$lOpCode = '8B10'
				Case 'mov ebx,dword[eax+8]'
					$lOpCode = '8B5808'
				Case 'mov ebx,dword[eax+C]'
					$lOpCode = '8B580C'
				Case 'mov ecx,dword[eax+C]'
					$lOpCode = '8B480C'
				Case 'mov eax,dword[eax+4]'
					$lOpCode = '8B4004'
				Case 'push dword[eax+4]'
					$lOpCode = 'FF7004'
				Case 'push dword[eax+c]'
					$lOpCode = 'FF700C'
				Case 'mov esp,ebp'
					$lOpCode = '8BE5'
				Case 'mov esp,ebp'
					$lOpCode = '8BE5'
				Case 'pop ebp'
					$lOpCode = '5D'
				Case 'retn 10'
					$lOpCode = 'C21000'
				Case 'cmp eax,2'
					$lOpCode = '83F802'
				Case 'cmp eax,0'
					$lOpCode = '83F800'
				Case 'cmp eax,B'
					$lOpCode = '83F80B'
				Case 'cmp eax,200'
					$lOpCode = '3D00020000'
				Case 'shl eax,4'
					$lOpCode = 'C1E004'
				Case 'shl eax,8'
					$lOpCode = 'C1E008'
				Case 'shl eax,6'
					$lOpCode = 'C1E006'
				Case 'shl eax,7'
					$lOpCode = 'C1E007'
				Case 'shl eax,8'
					$lOpCode = 'C1E008'
				Case 'shl eax,9'
					$lOpCode = 'C1E009'
				Case 'mov edi,eax'
					$lOpCode = '8BF8'
				Case 'mov dx,word[ecx]'
					$lOpCode = '668B11'
				Case 'mov dx,word[edx]'
					$lOpCode = '668B12'
				Case 'mov word[eax],dx'
					$lOpCode = '668910'
				Case 'test dx,dx'
					$lOpCode = '6685D2'
				Case 'cmp word[edx],0'
					$lOpCode = '66833A00'
				Case 'cmp eax,ebx'
					$lOpCode = '3BC3'
				Case 'cmp eax,ecx'
					$lOpCode = '3BC1'
				Case 'mov eax,dword[esi+8]'
					$lOpCode = '8B4608'
				Case 'mov ecx,dword[eax]'
					$lOpCode = '8B08'
				Case 'mov ebx,edi'
					$lOpCode = '8BDF'
				Case 'mov ebx,eax'
					$lOpCode = '8BD8'
				Case 'mov eax,edi'
					$lOpCode = '8BC7'
				Case 'mov al,byte[ebx]'
					$lOpCode = '8A03'
				Case 'test al,al'
					$lOpCode = '84C0'
				Case 'mov eax,dword[ecx]'
					$lOpCode = '8B01'
				Case 'lea ecx,dword[eax+180]'
					$lOpCode = '8D8880010000'
				Case 'mov ebx,dword[ecx+14]'
					$lOpCode = '8B5914'
				Case 'mov eax,dword[ebx+c]'
					$lOpCode = '8B430C'
				Case 'mov ecx,eax'
					$lOpCode = '8BC8'
				Case 'cmp eax,-1'
					$lOpCode = '83F8FF'
				Case 'mov al,byte[ecx]'
					$lOpCode = '8A01'
				Case 'mov ebx,dword[edx]'
					$lOpCode = '8B1A'
				Case 'lea edi,dword[edx+ebx]'
					$lOpCode = '8D3C1A'
				Case 'mov ah,byte[edi]'
					$lOpCode = '8A27'
				Case 'cmp al,ah'
					$lOpCode = '3AC4'
				Case 'mov dword[edx],0'
					$lOpCode = 'C70200000000'
				Case 'mov dword[ebx],ecx'
					$lOpCode = '890B'
				Case 'cmp edx,esi'
					$lOpCode = '3BD6'
				Case 'cmp ecx,1050000'
					$lOpCode = '81F900000501'
				Case 'mov edi,dword[edx+4]'
					$lOpCode = '8B7A04'
				Case 'mov edi,dword[eax+4]'
					$lOpCode = '8B7804'
				Case $aASM = 'mov ecx,dword[E1D684]'
					$lOpCode = '8B0D84D6E100'
				Case $aASM = 'mov dword[edx-0x70],ecx'
					$lOpCode = '894A90'
				Case $aASM = 'mov ecx,dword[edx+0x1C]'
					$lOpCode = '8B4A1C'
				Case $aASM = 'mov dword[edx+0x54],ecx'
					$lOpCode = '894A54'
				Case $aASM = 'mov ecx,dword[edx+4]'
					$lOpCode = '8B4A04'
				Case $aASM = 'mov dword[edx-0x14],ecx'
					$lOpCode = '894AEC'
				Case 'cmp ebx,edi'
					$lOpCode = '3BDF'
				Case 'mov dword[edx],ebx'
					$lOpCode = '891A'
				Case 'lea edi,dword[edx+8]'
					$lOpCode = '8D7A08'
				Case 'mov dword[edi],ecx'
					$lOpCode = '890F'
				Case 'retn'
					$lOpCode = 'C3'
				Case 'mov dword[edx],-1'
					$lOpCode = 'C702FFFFFFFF'
				Case 'cmp eax,1'
					$lOpCode = '83F801'
				Case 'mov eax,dword[ebp+37c]'
					$lOpCode = '8B857C030000'
				Case 'mov eax,dword[ebp+338]'
					$lOpCode = '8B8538030000'
				Case 'mov ecx,dword[ebx+250]'
					$lOpCode = '8B8B50020000'
				Case 'mov ecx,dword[ebx+194]'
					$lOpCode = '8B8B94010000'
				Case 'mov ecx,dword[ebx+18]'
					$lOpCode = '8B5918'
				Case 'mov ecx,dword[ebx+40]'
					$lOpCode = '8B5940'
				Case 'mov ebx,dword[ecx+10]'
					$lOpCode = '8B5910'
				Case 'mov ebx,dword[ecx+18]'
					$lOpCode = '8B5918'
				Case 'mov ebx,dword[ecx+4c]'
					$lOpCode = '8B594C'
				Case 'mov ecx,dword[ebx]'
					$lOpCode = '8B0B'
				Case 'mov edx,esp'
					$lOpCode = '8BD4'
				Case 'mov ecx,dword[ebx+170]'
					$lOpCode = '8B8B70010000'
				Case 'cmp eax,dword[esi+9C]'
					$lOpCode = '3B869C000000'
				Case 'mov ebx,dword[ecx+20]'
					$lOpCode = '8B5920'
				Case 'mov ecx,dword[ecx]'
					$lOpCode = '8B09'
				Case 'mov eax,dword[ecx+40]'
					$lOpCode = '8B4140'
				Case 'mov ecx,dword[ecx+4]'
					$lOpCode = '8B4904'
				Case 'mov ecx,dword[ecx+�]'
					$lOpCode = '8B490C'
				Case 'mov ecx,dword[ecx+8]'
					$lOpCode = '8B4908'
				Case 'mov ecx,dword[ecx+34]'
					$lOpCode = '8B4934'
				Case 'mov ecx,dword[ecx+C]'
					$lOpCode = '8B490C'
				Case 'mov ecx,dword[ecx+10]'
					$lOpCode = '8B4910'
				Case 'mov ecx,dword[ecx+18]'
					$lOpCode = '8B4918'
				Case 'mov ecx,dword[ecx+20]'
					$lOpCode = '8B4920'
				Case 'mov ecx,dword[ecx+4c]'
					$lOpCode = '8B494C'
				Case 'mov ecx,dword[ecx+50]'
					$lOpCode = '8B4950'
				Case 'mov ecx,dword[ecx+170]'
					$lOpCode = '8B8970010000'
				Case 'mov ecx,dword[ecx+194]'
					$lOpCode = '8B8994010000'
				Case 'mov ecx,dword[ecx+250]'
					$lOpCode = '8B8950020000'
				Case 'mov al,byte[ecx+4f]'
					$lOpCode = '8A414F'
				Case 'mov al,byte[ecx+3f]'
					$lOpCode = '8A413F'
				Case 'cmp al,f'
					$lOpCode = '3C0F'
				Case 'lea esi,dword[esi+ebx*4]'
					$lOpCode = '8D349E'
				Case 'mov esi,dword[esi]'
					$lOpCode = '8B36'
				Case 'test esi,esi'
					$lOpCode = '85F6'
				Case 'clc'
					$lOpCode = 'F8'
				Case 'repe movsb'
					$lOpCode = 'F3A4'
				Case 'inc edx'
					$lOpCode = '42'
				Case 'mov eax,dword[ebp+8]'
					$lOpCode = '8B4508'
				Case 'mov eax,dword[ecx+8]'
					$lOpCode = '8B4108'
				Case 'test al,1'
					$lOpCode = 'A801'
				Case $aASM = 'mov eax,[eax+2C]'
					$lOpCode = '8B402C'
				Case $aASM = 'mov eax,[eax+680]'
					$lOpCode = '8B8080060000'
				Case $aASM = 'fld st(0),dword[ebp+8]'
					$lOpCode = 'D94508'
				Case 'mov esi,eax'
					$lOpCode = '8BF0'
				Case Else
					MsgBox(0, 'ASM', 'Could not assemble: ' & $aASM)
					Exit
			EndSwitch
			$mASMSize += 0.5 * StringLen($lOpCode)
			$mASMString &= $lOpCode
	EndSelect
EndFunc   ;==>_

;~ Description: Internal use only.
Func CompleteASMCode()
	Local $lInExpression = False
	Local $lExpression
	Local $lTempASM = $mASMString
	Local $lCurrentOffset = Dec(Hex($mMemory)) + $mASMCodeOffset
	Local $lToken

	For $i = 1 To $mLabels[0][0]
		If StringLeft($mLabels[$i][0], 6) = 'Label_' Then
			$mLabels[$i][0] = StringTrimLeft($mLabels[$i][0], 6)
			$mLabels[$i][1] = $mMemory + $mLabels[$i][1]
		EndIf
	Next

	$mASMString = ''
	For $i = 1 To StringLen($lTempASM)
		$lToken = StringMid($lTempASM, $i, 1)
		Switch $lToken
			Case '(', '[', '{'
				$lInExpression = True
			Case ')'
				$mASMString &= Hex(GetLabelInfo($lExpression) - Int($lCurrentOffset) - 1, 2)
				$lCurrentOffset += 1
				$lInExpression = False
				$lExpression = ''
			Case ']'
				$mASMString &= SwapEndian(Hex(GetLabelInfo($lExpression), 8))
				$lCurrentOffset += 4
				$lInExpression = False
				$lExpression = ''
			Case '}'
				$mASMString &= SwapEndian(Hex(GetLabelInfo($lExpression) - Int($lCurrentOffset) - 4, 8))
				$lCurrentOffset += 4
				$lInExpression = False
				$lExpression = ''
			Case Else
				If $lInExpression Then
					$lExpression &= $lToken
				Else
					$mASMString &= $lToken
					$lCurrentOffset += 0.5
				EndIf
		EndSwitch
	Next
EndFunc   ;==>CompleteASMCode

;~ Description: Internal use only.
;~ Func GetLabelInfo($aLabel)
;~ 	Local $lValue = GetValue($aLabel)
;~ 	If $lValue = -1 Then Exit MsgBox(0, 'Label', 'Label: ' & $aLabel & ' not provided')
;~ 	Return $lValue ;Dec(StringRight($lValue, 8))
;~ EndFunc   ;==>GetLabelInfo

Func GetLabelInfo($aLab)
	Local Const $lVal = GetValue($aLab)
	Return $lVal
EndFunc   ;==>GetLabelInfo

;~ Description: Internal use only.
Func ASMNumber($aNumber, $aSmall = False)
	If $aNumber >= 0 Then
		$aNumber = Dec($aNumber)
	EndIf
	If $aSmall And $aNumber <= 127 And $aNumber >= -128 Then
		Return SetExtended(1, Hex($aNumber, 2))
	Else
		Return SetExtended(0, SwapEndian(Hex($aNumber, 8)))
	EndIf
EndFunc   ;==>ASMNumber
#EndRegion Assembler
#EndRegion Other Functions

; #FUNCTION# ====================================================================================================================
; Name...........: _ProcessGetName
; Description ...: Returns a string containing the process name that belongs to a given PID.
; Syntax.........: _ProcessGetName( $iPID )
; Parameters ....: $iPID - The PID of a currently running process
; Return values .: Success      - The name of the process
;                  Failure      - Blank string and sets @error
;                       1 - Process doesn't exist
;                       2 - Error getting process list
;                       3 - No processes found
; Author ........: Erifash <erifash [at] gmail [dot] com>, Wouter van Kesteren.
; Remarks .......: Supplementary to ProcessExists().
; ===============================================================================================================================
Func __ProcessGetName($i_PID)
	If Not ProcessExists($i_PID) Then Return SetError(1, 0, '')
	If Not @error Then
		Local $a_Processes = ProcessList()
		For $i = 1 To $a_Processes[0][0]
			If $a_Processes[$i][1] = $i_PID Then Return $a_Processes[$i][0]
		Next
	EndIf
	Return SetError(1, 0, '')
EndFunc   ;==>__ProcessGetName

;~ Func CheckArea($aX, $aY)
;~ 	Local $ret = False
;~ 	Local $pX = DllStructGetData(GetAgentByID(-2), "X")
;~ 	Local $pY = DllStructGetData(GetAgentByID(-2), "Y")

;~ 	If ($pX < $aX + 500) And ($pX > $aX - 500) And ($pY < $aY + 500) And ($pY > $aY - 500) Then
;~ 		$ret = True
;~ 	EndIf
;~ 	Return $ret
;~ EndFunc   ;==>CheckArea

Func CheckArea($aX, $aY, $aRange = 400, $aAgent = -2)
	Local $ret = False
	Local $pX = DllStructGetData(GetAgentByID($aAgent), "X")
	Local $pY = DllStructGetData(GetAgentByID($aAgent), "Y")

	If ($pX < $aX + $aRange) And ($pX > $aX - $aRange) And ($pY < $aY + $aRange) And ($pY > $aY - $aRange) Then
		$ret = True
	EndIf
	Return $ret
EndFunc   ;==>CheckArea

Func CountItemInBagsByModelID($ItemModelID)
	Local Enum $BAG_Backpack = 1, $BAG_BeltPouch, $BAG_Bag1, $BAG_Bag2, $BAG_EquipmentPack, $BAG_UnclaimedItems = 7, $BAG_Storage1, $BAG_Storage2, _
			$BAG_Storage3, $BAG_Storage4, $BAG_Storage5, $BAG_Storage6, $BAG_Storage7, $BAG_Storage8, $BAG_StorageAnniversary
	$count = 0
	For $i = $BAG_Backpack To $BAG_Bag2
		For $j = 1 To DllStructGetData(GetBag($i), 'Slots')
			$lItemInfo = GetItemBySlot($i, $j)
			If DllStructGetData($lItemInfo, 'ModelID') = $ItemModelID Then $count += DllStructGetData($lItemInfo, 'quantity')
		Next
	Next
	Return $count
EndFunc   ;==>CountItemInBagsByModelID

Func Disconnected()
	Local $lCheck = False
	Local $lDeadlock = TimerInit()
	Do
		Sleep(20)
		$lCheck = GetMapLoading() <> 2 And GetAgentExists(-2)
	Until $lCheck Or TimerDiff($lDeadlock) > 5000
	If $lCheck = False Then
;~ 		Out("Disconnected!")
;~ 		Out("Attempting to reconnect.")
		ControlSend(GetWindowHandle(), "", "", "{Enter}")
		$lDeadlock = TimerInit()
		Do
			Sleep(20)
			$lCheck = GetMapLoading() <> 2 And GetAgentExists(-2)
		Until $lCheck Or TimerDiff($lDeadlock) > 60000
		If $lCheck = False Then
			Out("Failed to Reconnect 1!")
			Out("Retrying.")
			ControlSend(GetWindowHandle(), "", "", "{Enter}")
			$lDeadlock = TimerInit()
			Do
				Sleep(20)
				$lCheck = GetMapLoading() <> 2 And GetAgentExists(-2)
			Until $lCheck Or TimerDiff($lDeadlock) > 60000
			If $lCheck = False Then
				Out("Failed to Reconnect 2!")
				Out("Retrying.")
				ControlSend(GetWindowHandle(), "", "", "{Enter}")
				$lDeadlock = TimerInit()
				Do
					Sleep(20)
					$lCheck = GetMapLoading() <> 2 And GetAgentExists(-2)
				Until $lCheck Or TimerDiff($lDeadlock) > 60000
				If $lCheck = False Then
					Out("Could not reconnect!")
					Out("Exiting.")
					EnableRendering()
					Exit 1
				EndIf
			EndIf
		EndIf
	EndIf
	Out("Reconnected!")
	Sleep(5000)
EndFunc   ;==>Disconnected

Func GetPartySize()
	Local $lOffset0[5] = [0, 0x18, 0x4C, 0x54, 0xC]
	Local $lplayersPtr = MemoryReadPtr($mBasePointer, $lOffset0)

	Local $lOffset1[5] = [0, 0x18, 0x4C, 0x54, 0x1C]
	Local $lhenchmenPtr = MemoryReadPtr($mBasePointer, $lOffset1)

	Local $lOffset2[5] = [0, 0x18, 0x4C, 0x54, 0x2C]
	Local $lheroesPtr = MemoryReadPtr($mBasePointer, $lOffset2)

	Local $Party1 = MemoryRead($lplayersPtr[0], 'long') ; players
	Local $Party2 = MemoryRead($lhenchmenPtr[0], 'long') ; henchmen
	Local $Party3 = MemoryRead($lheroesPtr[0], 'long') ; heroes

	Local $lReturn = $Party1 + $Party2 + $Party3
;~    If $lReturn > 12 or $lReturn < 1 Then $lReturn = 8
	Return $lReturn
EndFunc   ;==>GetPartySize

Func GetBestTarget($aRange = 1320)
	Local $lBestTarget, $lDistance, $lLowestSum = 100000000
	Local $lAgentArray = GetAgentArray(0xDB)
	For $i = 1 To $lAgentArray[0]
		Local $lSumDistances = 0
		If DllStructGetData($lAgentArray[$i], 'Allegiance') <> 3 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], 'HP') <= 0 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], 'ID') = GetMyID() Then ContinueLoop
		If GetDistance($lAgentArray[$i]) > $aRange Then ContinueLoop
		For $j = 1 To $lAgentArray[0]
			If DllStructGetData($lAgentArray[$j], 'Allegiance') <> 3 Then ContinueLoop
			If DllStructGetData($lAgentArray[$j], 'HP') <= 0 Then ContinueLoop
			If DllStructGetData($lAgentArray[$j], 'ID') = GetMyID() Then ContinueLoop
			If GetDistance($lAgentArray[$j]) > $aRange Then ContinueLoop
			$lDistance = GetDistance($lAgentArray[$i], $lAgentArray[$j])
			$lSumDistances += $lDistance
		Next
		If $lSumDistances < $lLowestSum Then
			$lLowestSum = $lSumDistances
			$lBestTarget = $lAgentArray[$i]
		EndIf
	Next
	Return $lBestTarget
EndFunc   ;==>GetBestTarget

Func WaitMapLoading($aMapID = 0, $aDeadlock = 10000)
;~ 	Waits $aDeadlock for load to start, and $aDeadLock for agent to load after map is loaded.
	Local $lMapLoading
	Local $lDeadlock = TimerInit()

	InitMapLoad()

	Do
		Sleep(200)
		$lMapLoading = GetMapLoading()
		If $lMapLoading == 2 Then $lDeadlock = TimerInit()
		If TimerDiff($lDeadlock) > $aDeadlock And $aDeadlock > 0 Then Return False
	Until $lMapLoading <> 2 And GetMapIsLoaded() And (GetMapID() = $aMapID Or $aMapID = 0)

	RndSleep(2000)

	Return True
EndFunc   ;==>WaitMapLoading

Func TradePlayer($aAgent)
	Local $lAgentID

	If IsDllStruct($aAgent) = 0 Then
		$lAgentID = ConvertID($aAgent)
	Else
		$lAgentID = DllStructGetData($aAgent, 'ID')
	EndIf
	SendPacket(0x08, $HEADER_TRADE_PLAYER, $lAgentID)
EndFunc   ;==>TradePlayer

Func AcceptTrade()
	Return SendPacket(0x4, $HEADER_TRADE_ACCEPT)
EndFunc   ;==>AcceptTrade

;~ Description: Like pressing the "Accept" button in a trade. Can only be used after both players have submitted their offer.
Func SubmitOffer($aGold = 0)
	Return SendPacket(0x8, $HEADER_TRADE_SUBMIT_OFFER, $aGold)
EndFunc   ;==>SubmitOffer

;~ Description: Like pressing the "Cancel" button in a trade.
Func CancelTrade()
	Return SendPacket(0x4, $HEADER_TRADE_CANCEL)
EndFunc   ;==>CancelTrade

;~ Description: Like pressing the "Change Offer" button.
Func ChangeOffer()
	Return SendPacket(0x4, $HEADER_TRADE_CHANGE_OFFER)
EndFunc   ;==>ChangeOffer

;~ $aItemID = ID of the item or item agent, $aQuantity = Quantity
Func OfferItem($lItemID, $aQuantity = 1)
;~ 	Local $lItemID
;~ 	$lItemID = GetBagItemIDByModelID($aModelID)
	Return SendPacket(0xC, $HEADER_TRADE_OFFER_ITEM, $lItemID, $aQuantity)
EndFunc   ;==>OfferItem

; Return 1 Trade windows exist; Return 3 Offer; Return 7 Accepted Trade
Func TradeWinExist()
	Local $lOffset = [0, 0x18, 0x58, 0]
	Return MemoryReadPtr($mBasePointer, $lOffset)[1]
EndFunc   ;==>TradeWinExist

Func TradeOfferItemExist()
	Local $lOffset = [0, 0x18, 0x58, 0x28, 0]
	Return MemoryReadPtr($mBasePointer, $lOffset)[1]
EndFunc   ;==>TradeOfferItemExist

Func TradeOfferMoneyExist()
	Local $lOffset = [0, 0x18, 0x58, 0x24]
	Return MemoryReadPtr($mBasePointer, $lOffset)[1]
EndFunc   ;==>TradeOfferMoneyExist

Func ToggleTradePatch($aEnable = True)
	If $aEnable Then
		MemoryWrite($MTradeHackAddress, 0xC3, "BYTE")
	Else
		MemoryWrite($MTradeHackAddress, 0x55, "BYTE")
	EndIf
EndFunc   ;==>ToggleTradePatch

Func GetLastDialogID()
	Return MemoryRead($mLastDialogID)
EndFunc   ;==>GetLastDialogID

Func GetLastDialogIDHex(Const ByRef $aID)
	If $aID Then Return '0x' & StringReplace(Hex($aID, 8), StringRegExpReplace(Hex($aID, 8), '[^0].*', ''), '')
EndFunc   ;==>GetLastDialogIDHex

;~ Description: Returns array with itemIDs of Items in Bags with correct ModelID.
Func GetBagItemIDByModelID($aModelID)
	Local $lRetArr[291][3]
	Local $lCount = 0
	For $bag = 1 To 17
		Local $lBagPtr = GetBagPtr($bag)
		Local $lSlots = MemoryRead($lBagPtr + 32, 'long')
		For $SLOT = 1 To $lSlots
			Local $lItemPtr = GetItemPtrBySlot($lBagPtr, $SLOT)
			Local $lItemMID = MemoryRead($lItemPtr + 44, 'long')
			If $lItemMID = $aModelID Then
				Local $lItemID = MemoryRead($lItemPtr, 'long')
				$lRetArr[$lCount][0] = $lItemID
				$lRetArr[$lCount][1] = $bag
				$lRetArr[$lCount][2] = $SLOT
				$lCount += 1
			EndIf
		Next
	Next
	ReDim $lRetArr[$lCount][3]
	Return $lItemID
EndFunc   ;==>GetBagItemIDByModelID

Func GetBagPtr2($aBagNumber)
	Local $lOffset[5] = [0, 0x18, 0x40, 0xF8, 0x4 * $aBagNumber]
	Local $lItemStructAddress = MemoryReadPtr($mBasePointer, $lOffset, 'ptr')
	Return $lItemStructAddress[1]
EndFunc   ;==>GetBagPtr2

Func GetItemPtrBySlot2($aBag, $aSlot)
	If IsPtr($aBag) Then
		$lBagPtr = $aBag
	Else
		If $aBag < 1 Or $aBag > 17 Then Return 0
		If $aSlot < 1 Or $aSlot > GetMaxSlots($aBag) Then Return 0
		Local $lBagPtr = GetBagPtr($aBag)
	EndIf
	Local $lItemArrayPtr = MemoryRead($lBagPtr + 24, 'ptr')
	Return MemoryRead($lItemArrayPtr + 4 * ($aSlot - 1), 'ptr')
EndFunc   ;==>GetItemPtrBySlot2

;~ Description: Returns amount of slots of bag.
Func GetMaxSlots($aBag)
	If IsPtr($aBag) Then
		Return MemoryRead($aBag + 32, 'long')
	Else
		Return MemoryRead(GetBagPtr($aBag) + 32, 'long')
	EndIf
EndFunc   ;==>GetMaxSlots


Func sellInventory($canSellGolds)
	For $i = 1 To 4
		For $j = 1 To $BAG_SLOT[$i - 1]
			Local $item = GetItemBySlot($i, $j)
			If CanSell($item) Then
				SellItem($item)
				pingSleep(Random(1000, 1500, 1))
			EndIf
		Next
	Next
EndFunc   ;==>sellInventory

Func CanSell($aItem)
	Local $lModelID = DllStructGetData(($aItem), 'ModelId')
	Local $aExtraID = DllStructGetData($aItem, 'ExtraId')
	Local $lRarity = GetRarity($aItem)
	Local $m = DllStructGetData($aItem, 'ModelID')
	Local $IsCaster = IsPerfectCaster($aItem)
	Local $IsStaff = IsPerfectStaff($aItem)
	Local $IsShield = IsPerfectShield($aItem)
	Local $IsRune = IsRareRune($aItem)
	Local $IsReq8 = IsReq8Max($aItem)
	Local $IsReq7 = IsReq7Max($aItem)
	Local $Type = DllStructGetData($aItem, "Type")
	Local $t = $Type
	Local $ModStruct = GetModStruct($aItem)
	Local $Forget = StringInStr($ModStruct, "22500142828", 0, 1)  ; Forget me not 20%
	Local $Measure = StringInStr($ModStruct, "8243E043", 0, 1) ; Measure for Measure
;~ 	Local $Measure = StringInStr($ModStruct, "8243E043 2251D", 0, 1) ; Measure for Measure
;~ 	Local $Measure = StringInStr($ModStruct, "2532043E", 0, 1) ; Measure for Measure sword
;~ 	Local $unded = StringInStr($ModStruct, "001448A2", 0, 1) ; bow unded


	If $Bool_Sell = False Then
		Out("Selling Disabled")
		Return False
	EndIf
	If DllStructGetData($aItem, 'value') <= 0 Then Return False ;If it has no value pack your shit up and leave
	If DllStructGetData($aItem, 'Customized') <> 0 Then Return False ;if it is customized leave it the fuck alone.
	If $t = 34 Then
		Out("Mini Pet: Cannot Sell")
		Return False ;minis
	ElseIf $BotName = "Vaettir" And $t = 29 Then
		Out("Kits: Cannot Sell")
		Return False ; id and salvage kits

	ElseIf $t = 21 Then
		out("Quest Item: Cannot Sell")
		Return False ; Quest Items

	ElseIf $t = 9 Then
		out("Consumable Item: Cannot Sell")
		Return False ; consumables

	ElseIf $t = 8 Then
		Out("Weapon Mods: Cannot Sell")
		Return False ; Mods

	ElseIf $m = 0 Then
		Out("No Data: Cannot Sell")
		Return False
	EndIf

	If $lModelID == 5899 Then  ;sup id kits
		out("Sup ID Kit: Cannot Sell")
		Return False
	ElseIf $lModelID == 2992 Then  ;salvage kits
		Out("Salvage Kits: Do Not Sell")
		Return False

	ElseIf $Measure = True And $Bool_M4M = True Then
		out("Saved M4M -- " & $Bool_M4M)
		Return False

	EndIf
	;=====TESTING TO SEE IF  WE CAN STORE AND USE SOME OF THESE DROPS FOUND IN VAETTIRS AND SNOWMEN FOR M4M====
;~ 		If exeption($aItem) Then Return False

	;====Salvage Weapons ====
	If ($m = 2415) And (DllStructGetData($aItem, 'value') > 370) And ($lRarity = $RARITY_Gold) And ($Bool_M4M = True) Then
		Out("Saved Good Conch -- " & $Bool_M4M)
		Return False
	ElseIf $m = 2415 Then
		Return False ;DO NOT EVER SELL A CONCH. ALWAYS SALVAGE.
	ElseIf ($lModelID == 2415) Then
		Return False ;great conch
	ElseIf $m = 2120 Or $m = 2415 Or $m = 2043 Or $m = 1774 Or $m = 2226 Or $m = 2218 Or $m = 2224 Or $m = 2051 Or $m = 2052 Or $m = 2220 Or $m = 2041 Then
		;Greater Sage blade, Great Conch, crude daggers, bronze daggers, golden daggers, butterfly knives, sai, greater glyphic maul, piranha hammer, dirks, arrowblade daggers
		Out("Saved known salvage weapon")
		Return False

		;====Green Weapons ====
	ElseIf ($lRarity == $RARITY_Green) Then
		Return False
		;====Salvagable Trophies ====
	ElseIf CheckArrayTrophies($lModelID) Then
		Return False
		; ====Pcons and event items====
	ElseIf CheckArrayPscon($lModelID) Then
		Return False
		;====Mats and rare Mats====
	ElseIf (CheckArrayMaterials($lModelID) Or CheckArrayRareMats($lModelID)) Then
		Return False
		; ==== Map Pieces ====
	ElseIf CheckArrayMapPieces($lModelID) Then
		Return False
		;====Tomes====
	ElseIf $lModelID > 21785 And $lModelID < 21806 Then
		Return False
		;====Black/White Dye====
	ElseIf ($lModelID == $ITEM_ID_Dyes) Then
		If (($aExtraID == $ITEM_ExtraID_Black_Dye) Or ($aExtraID == $ITEM_ExtraID_White_Dye)) Then ; only pick white and black ones
			out("Black/White Dye: Cannot Sell")
			Return False
		Else
			Return True
		EndIf
		;====Lockpicks====
	ElseIf ($lModelID == $ITEM_ID_Lockpick) Then
		out("Lockpicks: Cannot Sell")
		Return False ; Lockpicks
	ElseIf ($lModelID == 3746) Or ($lModelID == 22280) Then  ;Scroll UW, FoW
		Out("Rare Scroll: Cannot Sell")
		Return False
		;====PvP Rewards Weapons====
	ElseIf ($lRarity == $RARITY_Red) Then
		Out("PvP Reward: Cannot Sell")
		Return False

		;====Rare Drops/EndGame Drops====
	ElseIf CheckArrayZchestDrops($lModelID) Then
		Return False
	ElseIf CheckArrayRareItems($lModelID) Then
		Return False

	ElseIf $IsReq8 = True Then
		Return False ;is Req8 max weapon
	ElseIf $IsReq7 = True Then
		Return False ; Is Req7 Max
	ElseIf $IsRune = True Then
		Return False ;Is valueable rune

		;====RARE / UNIQUE DROPS====
		Switch $Type
			Case 12 ; Offhands
				If $IsCaster = True Then
					Return False ; Is perfect offhand
				Else
					Return True
				EndIf
			Case 22 ; Wands
				If $IsCaster = True Then
					Return False ; Is perfect wand
				Else
					Return True
				EndIf
			Case 26 ; Staves
				If $IsStaff = True Then
					Return False ; Is perfect Staff
				Else
					Return True
				EndIf
			Case 24 ; shields
				If $IsShield = True Then
					Return False ; Is perfect Shield
				Else
					Return True
				EndIf
		EndSwitch

	Else
		out("Not filtered: Selling")
		Return True        ;Sell everything else
	EndIf
EndFunc   ;==>CanSell

Func Exeptions_sell($item)
	Local $ModelID = DllStructGetData(($item), 'ModelID')
	If $ModelID = 21233 Then Return True
	If $ModelID = 5595 Then Return True
	If $ModelID = 5611 Then Return True
	If $ModelID = 5594 Then Return True
	If $ModelID = 5975 Then Return True
	If $ModelID = 5976 Then Return True
	If $ModelID = 5853 Then Return True
EndFunc   ;==>Exeptions_sell




; ----- SALVAGE ----- ;

#Region *SALVAGE*

Func salvage($canSalvageGolds, $restrictItems, $lastBag = 4)


	For $i = 1 To $lastBag
		For $j = 1 To $BAG_SLOT[$i - 1]
			If Not InventoryIsFull() Then
				Local $item = GetItemBySlot($i, $j)
				If checkSalvageKit() = 0 Then SalvageKit()
				If checkSalvageKit() > 0 Then
					If canSalvage($item, $canSalvageGolds, $restrictItems) Then

						StartSalvage($item)
						Out("StartSalvage") ;test
						If GetRarity($item) <> $RARITY_WHITE Then SalvageMaterials()
						pingSleep(1500)
						If DllStructGetData($item, 'Quantity') > 1 Then $j -= 1
					EndIf
				EndIf
			Else
				Return False
			EndIf
		Next
	Next
EndFunc   ;==>salvage

Func salvageoriginal($canSalvageGolds, $restrictItems, $lastBag = 4)


	For $i = 1 To $lastBag
		For $j = 1 To $BAG_SLOT[$i - 1]
			If Not InventoryIsFull() Then
				Local $item = GetItemBySlot($i, $j)
				If checkSalvageKit() > 0 Then
					If canSalvage($item, $canSalvageGolds, $restrictItems) Then
						;debug(DllStructGetData($item, 'id'))
						StartSalvage($item)
						Out("StartSalvage") ;test
						;If GetRarity($item) <> $RARITY_WHITE Then SalvageMaterials()
						SalvageMaterials()
						pingSleep(1500)
						If DllStructGetData($item, 'Quantity') > 1 Then $j -= 1
					EndIf
				EndIf
			Else
				Return False
			EndIf
		Next
	Next
EndFunc   ;==>salvageoriginal

Func SalvageKit()
	If FindSalvageKit() = 0 Then
		If GetGoldCharacter() < 100 Then
			WithdrawGold(100)
			out("Withdraw Gold: 100 for Salvage Kit")
			RndSleep(2000)
		EndIf
		BuyItem(2, 1, 100)
		RndSleep(1000)
	EndIf
EndFunc   ;==>SalvageKit

;~ Func Salvage2($lBag) ;ORIGINAL FROM SCRIPT
;~ 	Local $aBag
;~ 	If Not IsDllStruct($lBag) Then $aBag = GetBag($lBag)
;~ 	Local $lItem
;~ 	Local $lSalvageType
;~ 	Local $lSalvageCount
;~ 	Local $q = DllStructGetData($lItem, 'Quantity')
;~ 	Local $t = DllStructGetData($lItem, 'Type')
;~ 	Local $m = DllStructGetData($lItem, 'ModelID')
;~ 	For $i = 1 To DllStructGetData($aBag, 'Slots')

;~ 		$lItem = GetItemBySlot($aBag, $i)

;~ 		SalvageKit()

;~ 		$q = DllStructGetData($lItem, 'Quantity')
;~ 		$t = DllStructGetData($lItem, 'Type')
;~ 		$m = DllStructGetData($lItem, 'ModelID')

;~ 		If (DllStructGetData($lItem, 'ID') == 0) Then ContinueLoop

;~ 		If canSalvage2($lItem) and (Countslots()<>0) Then
;~ 			If $q >= 1 Then
;~ 				For $j = 1 To $q

;~ 					SalvageKit()

;~ 					StartSalvage($lItem)
;~ 					Sleep(GetPing() + Random(200, 300, 1))

;~ 					SalvageMaterials()

;~ 					While (GetPing() > 1250)
;~ 						RndSleep(250)
;~ 					WEnd

;~ 					Local $lDeadlock = TimerInit()
;~ 					Local $bItem
;~ 					Do
;~ 						Sleep(300)
;~ 						$bItem = GetItemBySlot($aBag, $i)
;~ 						If (TimerDiff($lDeadlock) > 20000) Then ExitLoop
;~ 					Until (DllStructGetData($bItem, 'Quantity') = $q - $j)
;~ 				Next
;~ 			EndIf
;~ 		EndIf
;~ 	Next
;~ 	Return True
;~ EndFunc   ;==>Salvage2

Func Salvage2($lBag) ;FROM COREY
	Local $aBag
	If Not IsDllStruct($lBag) Then $aBag = GetBag($lBag)
	Local $lItem
	Local $lSalvageType
	Local $lSalvageCount
	Local $q = DllStructGetData($lItem, 'Quantity')
	Local $t = DllStructGetData($lItem, 'Type')
	Local $m = DllStructGetData($lItem, 'ModelID')
	For $i = 1 To DllStructGetData($aBag, 'Slots')

		$lItem = GetItemBySlot($aBag, $i)

		SalvageKit()

		$q = DllStructGetData($lItem, 'Quantity')
		$t = DllStructGetData($lItem, 'Type')
		$m = DllStructGetData($lItem, 'ModelID')

		If (DllStructGetData($lItem, 'ID') == 0) Then ContinueLoop

		If canSalvage2($lItem) Then   ;$m = 819 Or (racines dragon)
			Do
			If $q >= 1 Then
				For $j = 1 To $q

					SalvageKit()

					StartSalvage($lItem)
					Sleep(GetPing() + Random(1000, 1500, 1))

					SalvageMaterials()

					While (GetPing() > 1250)
						RndSleep(250)
					WEnd

					Local $lDeadlock = TimerInit()
					Local $bItem
					Do
						Sleep(300)
						$bItem = GetItemBySlot($aBag, $i)
						If (TimerDiff($lDeadlock) > 15000) Then ExitLoop
					Until (DllStructGetData($bItem, 'Quantity') = $q - $j)

				Next
			EndIf
			Until GetItemBySlot($aBag,$i) = 0 or GetItemBySlot($aBag,$i) <> $lItem
		EndIf
	Next
	Return True
EndFunc   ;==>Salvage2


Global $HighlySalvageable[10]
$HighlySalvageable[0] = 2415 ;Great conch
$HighlySalvageable[1] = "Another value, yo"


Func canSalvage2($item) ; <<<< voir les exeptions
	Local $m = DllStructGetData($item, 'ModelID')
	Local $r = GetRarity($item)
	Local $t = DllStructGetData($item, 'Type')
	Local $ModStruct = GetModStruct($item)
	Local $aItem = $item
	Local $lRarity = GetRarity($aItem)
	Local $Forget = StringInStr($ModStruct, "22500142828", 0, 1)  ; Forget me not 20%
;~ 	Local $Measure = StringInStr($ModStruct, "8243E0432251D", 0, 1) ; Measure for Measure
;~ 	Local $Measure = StringInStr($ModStruct, "2532043E", 0, 1) ; Measure for Measure trial
	Local $Measure = StringInStr($ModStruct, "8243E043", 0, 1) ; Measure for Measure
;~ 	Local $unded = StringInStr($ModStruct, "001448A2", 0, 1) ; bow unded

	If DllStructGetData($aItem, "id") = 0 Then Return False ;If it is not ID'd get the hell outta here (LATER TURN INTO ID Func Chain)
	If DllStructGetData($aItem, 'value') <= 0 Then Return False ;If it has no value pack your shit up and leave
	If DllStructGetData($aItem, 'Customized') <> 0 Then Return False ;if it is customized leave it the fuck alone.

	If $m == 0 Then Return False
	If $Forget = True Then Return False
;~ 	If $unded = True Then Return False
	If $t = 34 Then Return False ;minis
	If $t = 18 Then Return False ;keys
	If $t = 31 Then Return False ; scrolls dont salvage
	If $t = 29 Then Return False ; id and salvage kits dont salvage
	If $t = 21 Then Return False ; Quest Items
	If $t = 11 Then Return False ; materials dont salvage
	If $t = 10 Then Return False ; dyes
	If $t = 9 Then Return False ; consumables
	If $t = 8 Then Return False ; Mods
	If $t = 5 Or $t = 2 Then Return False  ; leave bows and axe to sell
	If $Measure = True And $m = 2415 Then Return True

	If $Bool_M4M = True And $Measure = True And $m <> 2415 Then Return False
	;If $Measure = True and $t <> 5 or 26 Then Return True
	;If $Measure = True and $t = 5 or 26 Then Return False

;~ 	If salvageGoodRarity($r) And isWeapon($t) Then Return True


	;====Salvagable Trophies ====
	If CheckArrayTrophies($m) Then
		Return False
		; ====Pcons and event items====
	ElseIf CheckArrayPscon($m) Then
		Return False
		;====Mats and rare Mats====
	ElseIf ($Bool_SalvRareMats = True) Then
		Switch $m
			Case 926, 927, 928, 949, 950, 956, 952, 951, 944, 943, 942, 939, 922
				Return True
			Case Else
		EndSwitch
	ElseIf (CheckArrayMaterials($m) Or CheckArrayRareMats($m)) Then
		Return False


		;==== Salvage Items For Raptor Farmer ====
	ElseIf ($m = 2415) And (DllStructGetData($aItem, 'value') > 370) And ($r = $RARITY_Gold) And ($Bool_M4M = True) Then
		Return False
	ElseIf ($m = 2415) And ($Bool_Conches = True) And ($r <> $RARITY_White) Then
		Out("Preserving Conch -- use M4M on this")
		If ($r = $RARITY_PURPLE) And (DllStructGetData($aItem, 'value') > 120) Then
			Return False
		ElseIf ($r = $RARITY_BLUE) And (DllStructGetData($aItem, 'value') > 60) Then
			Return False
		Else
			Return False
		EndIf
	ElseIf ($m = 2120) And ($Bool_SageBlade = True) And ($r <> $RARITY_White) Then
		Out("Preserving Blade -- Use M4M on this")
		Return False

	ElseIf $m == 2120 Or $m == 2415 Or $m == 2043 Or $m == 1774 Or $m == 2226 Or $m == 2218 Or $m == 2224 Or $m == 2051 Or $m == 2052 Or $m == 2220 Or $m == 2041 Then
		;Greater Sage blade, Great Conch, crude daggers, bronze daggers, golden daggers, butterfly knives, sai, greater glyphic maul, piranha hammer, dirks, arrowblade daggers
		Return True

		;=====TESTING TO SEE IF  WE CAN STORE AND USE SOME OF THESE DROPS FOUND IN VAETTIRS AND SNOWMEN FOR M4M====
		If exeption($item) Then Return False


		;====Zchest Rare Drops====
	ElseIf CheckArrayZchestDrops($m) Then
		Return False
	ElseIf CheckArrayRareItems($m) Then
		Return False
		; ==== Map Pieces ====
	ElseIf CheckArrayMapPieces($m) Then
		Return False
		;====Tomes====
	ElseIf $m > 21785 And $m < 21806 Then
		Return False
		;====Dyes====
	ElseIf ($m == $ITEM_ID_Dyes) Then
		Return False
		;====Lockpicks====
	ElseIf ($m == $ITEM_ID_Lockpick) Then
		Return False ; Lockpicks
		;====PvP Rewards Weapons====
	ElseIf ($lRarity == $RARITY_Red) Then
		Return False
		;====Scrolls====
;~ 	ElseIf $m == 3746 Or $m == 22280 Or $m == 5594 Or $m == 5595 Or $m == 5611 Or $m == 5853 Or $m == 5975 Or $m == 5976 Or $m == 21233 Then
;~ 		Return False
		;====Rare Drops/EndGame Drops====
	ElseIf $m > 1952 And $m < 1976 Then
		Return False ;Frog Scepters
	ElseIf $m > 1986 And $m < 2008 Then
		Return False ;BDS
	ElseIf $m = 399 Or $m = 2039 Or $m = 2058 Then
		Return False ;Crystalline Sword, Silverwing, Bonecage Scythe
	ElseIf $m = 1055 Or $m = 1058 Or $m = 1060 Or $m = 1064 Or $m = 1752 Or $m = 1065 Or $m = 1066 Or $m = 1067 Or $m = 1768 Or $m = 1769 Or $m = 1770 Or $m = 1771 Or $m = 1772 Or $m = 1773 Or $m = 1870 Or $m = 1879 Or $m = 1880 Or $m = 1881 Or $m = 1883 Or $m = 1884 Or $m = 1885 Then ;Celestial Compass
		Return False ;celestial compass
	ElseIf $m > 2369 And $m < 2375 Then
		Return False ;Topaz Scepters
	ElseIf $m > 2374 And $m < 2380 Then
		Return False ;Ancient Moss Staves
	ElseIf $m = 2071 Then
		Return False ;voltiac Spear
	ElseIf $m = 31168 Then
		Return False ;IDS
	ElseIf $m = 2124 Then
		Return False ;Aureate Blade
	ElseIf $m = 2048 Then
		Return False ;Wingcrest Maul


		;====Anything Else====
	Else
		Return True
	EndIf

;~ 	If exeption($item) Then Return True
;~ 	Return False
EndFunc   ;==>canSalvage2

Func exeption($item)
	Local $ModelID = DllStructGetData(($item), 'ModelID')
	;Local $ModStruct = GetModStruct($item)
	;Local $Forget  = StringInStr($ModStruct, "22500142828", 0, 1) ; Forget me not 20%
	;Local $Measure = StringInStr($ModStruct, "8243E", 0, 1) ; Measure for Measure


;~ debug($ModelID)_________________________, TEST
;~ If $ModelID = 27047 Then Return True
;~ If $ModelID = 146 Then Return False
;~ If $ModelID = 22751 Then Return False
;~ If $ModelID = 2991 Then Return False
;~ If $ModelID = 2989 Then Return False
;~ If $ModelID = 5899 Then Return False
	;add
	;If $Forget = True Then Return False
	;If $Measure = True Then Return False
	If $ModelID = 257 Then Return True  ;cane illusion2
	If $ModelID = 1829 Then Return True ;$ITEM_ID_CaneDom3
	If $ModelID = 1834 Then Return True ;$ITEM_ID_CaneIllu4
;~ 	If $ModelID = 131 Then Return True ;composite bow?
;~ 	If $ModelID = 1761 Then Return True ;Caged shortbow
	If $ModelID = 1833 Then Return True ;$ITEM_ID_CrystalWand
	If $ModelID = 353 Then Return True ;$ITEM_ID_JewelledStaff2
	If $ModelID = 251 Then Return True ;$ITEM_ID_CaneDom1
;~ 	If $ModelID = 126 Then Return True ;$ITEM_ID_SpikedAxe
;~ 	If $ModelID = 1766 Then Return True ;$ITEM_ID_CompositeShortbow
	If $ModelID = 155 Then Return True ;$ITEM_ID_JeweledChalice
	If $ModelID = 2344 Then Return True
	If $ModelID = 2310 Then Return True
	If $ModelID = 255 Then Return True ;$ITEM_ID_CaneIllu1
	If $ModelID = 254 Then Return True ;$ITEM_ID_CaneDom2
	If $ModelID = 1869 Then Return True
	If $ModelID = 151 Then Return True ;$ITEM_ID_JeweledChakram
	If $ModelID = 5976 Then Return True ;$ITEM_ID_Hunters_Insight_Scroll
;~ 	If $ModelID = 1767 Then Return True ;$ITEM_ID_SpikedRecurveBow
;~ 	If $ModelID = 1784 Then Return True ;$ITEM_ID_WoodenChakram
	If $ModelID = 1911 Then Return True ;$ITEM_ID_EnsorcellingStaff2
	If $ModelID = 1916 Then Return True ;$ITEM_ID_IllusoryStaff
	If $ModelID = 1865 Then Return True
	If $ModelID = 1914 Then Return True ;$ITEM_ID_HypnoticStaff
	If $ModelID = 1793 Then Return True ;$ITEM_ID_Butterflymirror
	If $ModelID = 1910 Then Return True ;$ITEM_ID_ClairvoyantStaff
	If $ModelID = 1785 Then Return True ;$ITEM_ID_OminousEidolon iron
	If $ModelID = 2089 Then Return True ; $ITEM_ID_FuchsiaStaff
	If $ModelID = 1830 Then Return True ;$ITEM_ID_GazingSpecter
	If $ModelID = 157 Then Return True ;$ITEM_ID_JeweledChalice2 IRON DUST GRANITE
;~ 	If $ModelID = 1786 Then Return True ;$ITEM_ID_MajesticFocus DUST AND WOOD
	;Parchos
;~ 	If $ModelID = 21233 Then Return False ;$ITEM_ID_Scroll_of_the_Lightbringer
;~ 	If $ModelID = 5595 Then Return False ;$ITEM_ID_Berserkers_Insight_Scroll
;~ 	If $ModelID = 5611 Then Return False
;~ 	If $ModelID = 5594 Then Return False
;~ 	If $ModelID = 5975 Then Return False
;~ 	If $ModelID = 5976 Then Return False
;~ 	If $ModelID = 5853 Then Return False


	Return False
EndFunc   ;==>exeption

Func isWeapon($t)
	If $t == 2 Then Return True ; Axe
	If $t == 5 Then Return True ; Bow
	If $t == 12 Then Return True ; OffHand  (ex : Chalice)
	If $t == 15 Then Return True ; Hammer
	If $t == 22 Then Return True ; Wand (ex : scepter, cane)
	If $t == 24 Then Return True ; Shield
	If $t == 26 Then Return True ; Staff
	If $t == 27 Then Return True ; Sword
	If $t == 32 Then Return True ; Daggers
	If $t == 35 Then Return True ; Scyth
	If $t == 36 Then Return True ; Spear
	Return False
EndFunc   ;==>isWeapon

Global $canSalvageGolds = True
Global $restrictItems = False

Func canSalvage($item, $canSalvageGolds, $restrictItems) ; <<<< voir les exeptions
	Local $m = DllStructGetData($item, 'ModelID')
	Local $r = GetRarity($item)
	Local $t = DllStructGetData($item, 'Type')
	If $m == 0 Then Return False

	If Not $canSalvageGolds And $r == $RARITY_GOLD Then
		Return False
	EndIf

	If $restrictItems Then
		If salvageGoodRarity($r) And salvageGoodTypeWeap($t) Then Return True
	Else
		If salvageGoodRarity($r) And isWeapon($t) Then Return True
	EndIf

	If exeption($item) Then Return True
	Return False
EndFunc   ;==>canSalvage

Func salvageGoodRarity($r)
	If $r == $RARITY_GOLD Then Return True
	If $r == $RARITY_PURPLE Then Return True
	If $r == $RARITY_BLUE Then Return True
	If $r == $RARITY_WHITE Then Return True
	Return False
EndFunc   ;==>salvageGoodRarity

Func salvageGoodTypeWeap($t)
	If $t == 2 Then Return True ; Axe
	If $t == 15 Then Return True ; Hammer
	If $t == 24 Then Return True ; Shield
	If $t == 27 Then Return True ; Sword
	If $t == 32 Then Return True ; Daggers
	If $t == 35 Then Return True ; Scythe
	If $t == 36 Then Return True ; Spear
	Return False
EndFunc   ;==>salvageGoodTypeWeap

Func checkSalvageKit($lastBag = 4)
	Local $count = 0
	;Local $salvageKitModId = 5900
	Local $salvageKitModId = 2992
	For $i = 1 To $lastBag
		For $j = 1 To $BAG_SLOT[$i - 1]
			Local $item = GetItemBySlot($i, $j)
			If DllStructGetData($item, 'ModelID') = $salvageKitModId Then $count += 1
		Next
	Next
	Return $count
EndFunc   ;==>checkSalvageKit

;~ Func buySalvageKitoriginal($quantity)
;~ 	Local $price = 2000
;~ 	If $price = 0 Or $quantity = 0 Then Return False
;~ 	WithdrawGold($price * $quantity)
;~ 	pingSleep(Random(1000, 1500, 1))
;~ 	For $i = 1 To $quantity
;~ 		BuyItem($salvageKit, 1, $price)
;~ 		pingSleep(Random(1000, 1500, 1))
;~ 	Next
;~ 	pingSleep(250)
;~ EndFunc   ;==>buySalvageKitoriginal

#EndRegion *SALVAGE*

; ---- IDENTIFY ---- ;

#Region *IDENTIFY*

Func identify($doIdGolds, $bag = 0)
	If $bag = 0 Then
		IdentifyBag(1, False, $doIdGolds)
		IdentifyBag(2, False, $doIdGolds)
		IdentifyBag(3, False, $doIdGolds)
		IdentifyBag(4, False, $doIdGolds)
	Else
		IdentifyBag($bag, False, $doIdGolds)
	EndIf
EndFunc   ;==>identify

Func checkIdentifyKit()
	Local $count = 0
	Local $idKit = $ITEM_ID_ID_Kit
	Local $SupIdKit = $ITEM_ID_SUP_ID_Kit
	For $i = 1 To 4
		For $j = 1 To $BAG_SLOT[$i - 1]
			Local $item = GetItemBySlot($i, $j)
			If DllStructGetData($item, 'ModelID') = $idKit Or DllStructGetData($item, 'ModelID') = $SupIdKit Then
				$count += 1
			EndIf
		Next
	Next
	Return $count
EndFunc   ;==>checkIdentifyKit

Func buyIdentifyKit($quantity)
	Local $i = 1
	If $IdentPrice = 0 Or $quantity = 0 Then Return False
	WithdrawGold($IdentPrice * $quantity)
	out("Withdraw Gold: " & ($IdentPrice * $quantity) & " for Ident Kit")
	pingSleep(Random(1000, 1500, 1))
	For $i = 1 To $quantity
		BuyItem($identifyKitnum, 1, $IdentPrice)
		pingSleep(Random(1000, 1500, 1))
	Next
	pingSleep(250)
EndFunc   ;==>buyIdentifyKit

Func buySalvageKit($quantity)
	Local $price = 100
	If FindSalvageKit() = 0 Then
		If GetGoldCharacter() < 100 Then
			WithdrawGold(1000)
			out("Withdraw Gold: 1000 for Salvage Kit")
			RndSleep(2000)
		EndIf
	EndIf
	If $price = 0 Or $quantity = 0 Then Return False
	For $i = 1 To $quantity
		BuyItem(2, 1, 100)
		pingSleep(Random(1000, 1500, 1))
	Next
	RndSleep(1000)
	;EndIf
EndFunc   ;==>buySalvageKit


#EndRegion *IDENTIFY*

; ---- FIND NPC ---- ;

#Region *FIND NPC*

Func findXunlai()
	Return GetAgentByName("Coffre Xunlai")
EndFunc   ;==>findXunlai

Func findMerchant()
	Return GetAgentByName("Marchand")
EndFunc   ;==>findMerchant

Func pingSleep($time)
	Sleep(GetPing() + $time)
EndFunc   ;==>pingSleep

#EndRegion *FIND NPC*

; ---- PICK-UP ---- ;

#Region *PICK-UP*

Func CanPickUp($aItem)
	Local $lModelID = DllStructGetData(($aItem), 'ModelId')
	Local $t = DllStructGetData($aItem, 'Type')
	Local $aExtraID = DllStructGetData($aItem, 'ExtraId')
	Local $lRarity = GetRarity($aItem)

	;====Dungeon Key/keys====
	If ($t == $TYPE_KEY) Or ($lModelID = 25413) Or ($lModelID = 25410) Then Return True
	If $lModelID = 24628 Then Return True ;Vine Seed (oolas lab)
	If $lModelID = 22782 Then Return True ;FluxMatrix(oolas lab)
	If $lModelID = 24350 And (HasEffect(2429) = False) Then Return True ;Asuran Flame Staff(Arachnis)
	If GetCanPickUp($aItem) = False Then Return False ; Abort if not an item that is able to be picked up.

	;====Abort If Not Picking Up Drops====


	;====DON'T PICK UPS====
	If ($lModelID == 493 And $Title = "Zchest") Then
		Return False
	ElseIf ($lModelID == 494 And $Title = "Zchest") Then
		Return False
	ElseIf $lModelID = 22262 Then
		Return False ;Charr explosive
	ElseIf ($lModelID == 24629 Or $lModelID == 24630 Or $lModelID == 24631 Or $lModelID == 24632) Then
		Return False ;Map pieces
	ElseIf $lModelID = 2994 Then
		Return False ;red iris flower
	ElseIf $lModelID = 27982 Then
		Return False ;Claws of The BroodMother
	ElseIf $lModelID = 27133 Then
		Return False ;Jar of Invigoration
	ElseIf ($t == 5) And ($lRarity == $RARITY_White) Then ; bows White items
		Return False
;~     ElseIf ($t == 5) and ($lRarity == $RARITY_Purple) Then
;~         Return False
;~     ElseIf ($t == 5) and ($lRarity == $RARITY_Blue) Then
;~         Return False
	ElseIf ($t == 2) And ($lRarity == $RARITY_White) Then ; axes White items
		Return False
;~     ElseIf ($t == 2) and ($lRarity == $RARITY_Purple) Then
;~         Return False
;~     ElseIf ($t == 2) and ($lRarity == $RARITY_Blue) Then
;~         Return False

	EndIf

	;========JUNK SORT==========
	;====Lockpicks====
	If ($lModelID == $ITEM_ID_Lockpick) Then
		Return True ; Lockpicks

		;ElseIf ($lModelID == 2511) Then
		;	If (GetGoldCharacter() < 99000) Then
		;		Return True	; gold coins (only pick if character has less than 99k in inventory)
		;	Else
		;		Return False
		;	EndIf

		;====Black/White Dye====
	ElseIf ($lModelID == $ITEM_ID_Dyes) Then
		If (($aExtraID == $ITEM_ExtraID_Black_Dye) Or ($aExtraID == $ITEM_ExtraID_White_Dye)) Then ; only pick white and black ones
			Return True
		Else
			Return False
		EndIf
		;====Tomes====
	ElseIf $lModelID > 21785 And $lModelID < 21806 Then
		Return True
	ElseIf ($lModelID == 2511) Then
		Return False
		; ====Pcons and event items====
	ElseIf CheckArrayPscon($lModelID) Then
		Return $Bool_EventMode
		;====Pick Up All Toggle====
	ElseIf $Bool_PickUpAll = True Then
		Return True


		;====Rarity Check (Gold/Green)
	ElseIf ($lRarity == $RARITY_Gold And $Bool_PickUpGolds <> False) Then
		Return True
	ElseIf ($lRarity == $RARITY_Green) Then
		Return False

		;====Rune Unids (Blue/Purple) ====
	ElseIf $t == 0 And $Bool_PickUpArmor Then ;
		If ($lRarity <> $RARITY_White) Then
			Return True
		EndIf
		;====Salvagable Trophies ====
	ElseIf CheckArrayTrophies($lModelID) Then
		Return True

		;====Mats and rare Mats====
	ElseIf (CheckArrayMaterials($lModelID) Or CheckArrayRareMats($lModelID)) Then
		Return True
		;====Rare Drops====
	ElseIf CheckArrayZchestDrops($lModelID) Then
		Return True
	ElseIf CheckArrayRareItems($lModelID) Then
		Return True
		;====RareScrolls====
	ElseIf $lModelID == 3746 Or $lModelID == 22280 Or $lModelID == 5594 Or $lModelID == 5595 Or $lModelID == 5611 Or $lModelID == 5853 Or $lModelID == 5975 Or $lModelID == 5976 Or $lModelID == 21233 Then
		Return True

	ElseIf CheckArrayBadges($lModelID) Then ;
		Return True
		;====Pick Up All Toggle====
	ElseIf $Bool_PickUpAll = True Then
		Return True

	Else
		Return False
	EndIf
EndFunc   ;==>CanPickUp

Func PickUpRarity($lRarity)
	If $lRarity == $RARITY_PURPLE Then Return True
	If $lRarity == $RARITY_BLUE Then Return True
	If $lRarity == $RARITY_WHITE Then Return True
	If $lRarity == $RARITY_GOLD Then Return True
	Return False
EndFunc   ;==>PickUpRarity

Func PickUpType($t)
	If $t = 2 Then Return True
	If $t = 15 Then Return True
	If $t = 24 Then Return True
	If $t = 27 Then Return True
	If $t = 32 Then Return True
	If $t = 35 Then Return True
	If $t = 36 Then Return True
	Return False
EndFunc   ;==>PickUpType

#EndRegion *PICK-UP*

; ---- UTILITY ---- ;

#Region *UTILITY*

Func freeSlot()
	Local $count = 0
	For $i = 1 To 4
		For $j = 1 To $BAG_SLOT[$i - 1]
			If DllStructGetData(GetItemBySlot($i, $j), 'ModelID') == 0 Then $count = $count + 1
		Next
	Next
	Return $count
EndFunc   ;==>freeSlot

Func debug($txt)
;~ 	MsgBox(0, "", "Debug : " & $txt)
	SendChat($txt, '#')
EndFunc   ;==>debug

Func CheckInventory()
	If freeSlot() > 5 Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>CheckInventory

Func InventoryIsFull()
	If freeSlot() > 0 Then
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>InventoryIsFull

#EndRegion *UTILITY*


Func CountSlots()
	Local $bag
	Local $temp = 0
	$bag = GetBag(1)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(2)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(3)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(4)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	Return $temp
EndFunc   ;==>CountSlots


;goes to the nearest NPC to coordinates and talks to them
Func GoNearestNPCToCoords($x, $y)
	Local $guy, $Me
	Do
		RndSleep(250)
		$guy = GetNearestNPCToCoords($x, $y)
	Until DllStructGetData($guy, 'Id') <> 0
	ChangeTarget($guy)
	RndSleep(250)
	GoNPC($guy)
	RndSleep(250)
	Do
		RndSleep(500)
		Move(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 40)
		RndSleep(500)
		GoNPC($guy)
		RndSleep(250)
		$Me = GetAgentByID(-2)
	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
	RndSleep(500)
EndFunc   ;==>GoNearestNPCToCoords

Func IDENTold($bagIndex)
	Local $bag = GetBag($bagIndex)
	For $i = 1 To DllStructGetData($bag, 'slots')
		If FindIDKit() = 0 Then
			If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
				WithdrawGold(500)
				out("Withdraw Gold: 500 for Ident Kit")
				Sleep(Random(100, 150))
			EndIf
			Local $j = 0
			Do
				BuySuperiorIDKit() ; changed
				RndSleep(500)
				$j = $j + 1
			Until FindIDKit() <> 0 Or $j = 3
			If $j = 3 Then ExitLoop
			RndSleep(100)
		EndIf
		Local $aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, 'ID') = 0 Then ContinueLoop
		IdentifyItem($aItem)
		Sleep(Random(100, 150))
	Next
EndFunc   ;==>IDENTold

Func IDENT($bagIndex)
	Local $bag = GetBag($bagIndex)
	For $i = 1 To DllStructGetData($bag, 'slots')
		If FindIDKit() = 0 Then
			If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
				WithdrawGold(500)
				out("Withdraw Gold: 500 for IDENT Kit")
				Sleep(Random(100, 150))
			EndIf
			Local $j = 0
			Do
				buyIdentifyKit($maxIdentyfyKit - checkIdentifyKit())
				RndSleep(500)
				$j = $j + 1
			Until FindIDKit() <> 0 Or $j = 3
			If $j = 3 Then ExitLoop
			RndSleep(100)
		EndIf
		Local $aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, 'ID') = 0 Then ContinueLoop
		IdentifyItem($aItem)
		Sleep(Random(100, 150))
	Next
EndFunc   ;==>IDENT

Func Sell($bagIndex)
	Local $aItem
	Local $bag = GetBag($bagIndex)
	Local $NUMOFSLOTS = DllStructGetData($bag, "slots")
	For $i = 1 To $NUMOFSLOTS
		If GetGoldCharacter() > 50000 Then
			Out("Depositing 50k to Storage")
			DepositGold(50000)
		EndIf
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "Id") == 0 Then ContinueLoop
		If CanSell($aItem) Then
			SellItem($aItem)
		EndIf
		Sleep(GetPing() + 100)
	Next
EndFunc   ;==>Sell

Func GetBagPtr($aBagNumber)
	Local $lOffset[5] = [0, 0x18, 0x40, 0xF8, 0x4 * $aBagNumber]
	Local $lItemStructAddress = MemoryReadPtr($mBasePointer, $lOffset, 'ptr')
	Return $lItemStructAddress[1]
EndFunc   ;==>GetBagPtr

Func GetItemPtrBySlot($aBag, $aSlot)
	Local $lBagPtr
	If IsPtr($aBag) Then
		$lBagPtr = $aBag
	Else
		If $aBag < 1 Or $aBag > 17 Then Return 0
		If $aSlot < 1 Or $aSlot > GetMaxSlots($aBag) Then Return 0
		$lBagPtr = GetBagPtr($aBag)
	EndIf
	Local $lItemArrayPtr = MemoryRead($lBagPtr + 24, 'ptr')
	Return MemoryRead($lItemArrayPtr + 4 * ($aSlot - 1), 'ptr')
EndFunc   ;==>GetItemPtrBySlot


#Region Arrays
Func CheckArrayPscon($lModelID)
	For $p = 0 To (UBound($Array_pscon) - 1)
		If ($lModelID == $Array_pscon[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayPscon

Func CheckArrayZchestDrops($lModelID)
	For $p = 0 To (UBound($Array_Zchest) - 1)
		If ($lModelID == $Array_Zchest[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayZchestDrops

Func CheckArrayGeneralItems($lModelID)
	For $p = 0 To (UBound($General_Items_Array) - 1)
		If ($lModelID == $General_Items_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayGeneralItems

Func CheckArrayWeaponMods($lModelID)
	For $p = 0 To (UBound($Weapon_Mod_Array) - 1)
		If ($lModelID == $Weapon_Mod_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayWeaponMods

Func CheckArrayTomes($lModelID)
	For $p = 0 To (UBound($All_Tome_Array) - 1)
		If ($lModelID == $All_Tome_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayTomes

Func CheckArrayMaterials($lModelID)
	For $p = 0 To (UBound($All_Materials_Array) - 1)
		If ($lModelID == $All_Materials_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayMaterials

Func CheckArrayMapPieces($lModelID)
	For $p = 0 To (UBound($Map_Pieces_Array) - 1)
		If ($lModelID == $Map_Pieces_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayMapPieces

Func CheckArrayTrophies($lModelID)
	For $p = 0 To (UBound($Array_Trophies) - 1)
		If ($lModelID == $Array_Trophies[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayTrophies

Func CheckArrayRareMats($lModelID)
	For $p = 0 To (UBound($Rare_Materials_Array) - 1)
		If ($lModelID == $Rare_Materials_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayRareMats

Func CheckArraySpamSweets($lModelID)
	For $p = 0 To (UBound($Spam_Sweet_Array) - 1)
		If ($lModelID == $Spam_Sweet_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArraySpamSweets

Func CheckArraySpamParty($lModelID)
	For $p = 0 To (UBound($Spam_Party_Array) - 1)
		If ($lModelID == $Spam_Party_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArraySpamParty

Func CheckArraySpamAlc($lModelID)
	For $p = 0 To (UBound($Alcohol_Array) - 1)
		If ($lModelID == $Alcohol_Array[$p]) Then Return True
	Next
EndFunc   ;==>CheckArraySpamAlc

Func CheckArrayRareItems($lModelID)
	For $p = 0 To (UBound($RareItemArray) - 1)
		If ($lModelID == $RareItemArray[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayRareItems

Func CheckArrayArmors($lModelID)
	For $p = 0 To (UBound($Array_Armors) - 1)
		If ($lModelID == $Array_Armors[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayArmors

Func CheckArrayBadges($lModelID)
	For $p = 0 To (UBound($Array_Badges) - 1)
		If ($lModelID == $Array_Badges[$p]) Then Return True
	Next
EndFunc   ;==>CheckArrayBadges


#EndRegion Arrays

; Description: Returns True if you're under the effect of $aEffectSkillID.
Func HasEffect($aEffectSkillID, $aHeroNumber = 0, $aHeroId = GetHeroID($aHeroNumber))
	Return GetSkillEffectPtr($aEffectSkillID, $aHeroNumber, $aHeroId) <> 0
EndFunc   ;==>HasEffect


Func GetSkillEffectPtr($aSkillID, $aHeroNumber = 0, $aHeroId = GetHeroID($aHeroNumber))
	Local $lEffectCount
	Local $lEffectStructAddress
	Local $lEffectSkillID
	Local $lOffset[4] = [0, 24, 44, 1296]
	Local $lCount = MemoryReadPtr($mBasePointer, $lOffset)
	ReDim $lOffset[5]
	$lOffset[3] = 1288
	Local $lBuffer
	For $i = 0 To $lCount[1] - 1
		$lOffset[4] = 36 * $i
		$lBuffer = MemoryReadPtr($mBasePointer, $lOffset)
		If $lBuffer[1] = $aHeroId Then
			$lOffset[4] = 28 + 36 * $i
			$lEffectCount = MemoryReadPtr($mBasePointer, $lOffset)
			$lOffset[4] = 20 + 36 * $i
			$lEffectStructAddress = MemoryReadPtr($mBasePointer, $lOffset, 'ptr')
			For $j = 0 To $lEffectCount[1] - 1
				$lEffectSkillID = MemoryRead($lEffectStructAddress[1] + 24 * $j, 'long')
				If $lEffectSkillID = $aSkillID Then Return Ptr($lEffectStructAddress[1] + 24 * $j)
			Next
		EndIf
	Next
EndFunc   ;==>GetSkillEffectPtr

;~ Description: Toggle rendering and also hide or show the gw window

Func ToggleRendering()
	$RenderingEnabled = Not $RenderingEnabled
	If $RenderingEnabled Then
		EnableRendering()
		WinSetState(GetWindowHandle(), "", @SW_SHOW)
	Else
		DisableRendering()
		WinSetState(GetWindowHandle(), "", @SW_HIDE)
		ClearMemory()
	EndIf
EndFunc   ;==>ToggleRendering

;~ No Title              |  0x00  |
;~ Tyrian Cartographer   |  0x01  |
;~ Canthan Cartographer  |  0x02  |
;~ Gladiator Title       |  0x03  |
;~ Champion Title        |  0x04  |
;~ Kurzick Title         |  0x05  |
;~ Luxon Title           |  0x06  |
;~ Drunkard Title        |  0x07  |
;~ Survivor Title        |  0x09  |
;~ Kind of a Big Deal    |  0x0A  |
;~ __________________________________________________________________________
;~ Tyrian Protector      |  0x0D  |
;~ Canthan Protector     |  0x0E  |
;~ Luck Title            |  0x0F  |
;~ Unluck Title          |  0x10  |
;~ Sunspear Title        |  0x11  |
;~ Elonian Cartographer  |  0x12  |
;~ Elonian Protector     |  0x13  |
;~ Lightbringer Title    |  0x14  |
;~ Ldoa Title            |  0x15  |
;~ Commander Title       |  0x16  |
;~ __________________________________________________________________________
;~ Skillz Title          |  0x17  |
;~ Tyrian Skill Hutner   |  0x18  |
;~ Tyrian Vanquisher     |  0x19  |
;~ Canthan Skill Hutner  |  0x1A  |
;~ Canthan Vanquisher    |  0x1B  |
;~ Elonian Skill Hunter  |  0x1C  |
;~ Elonian Vanquisher    |  0x1D  |
;~ Legendary Cartographer|  0x1E  |
;~ Legendary Guardian    |  0x1F  |
;~ Legendary Skil Hunter |  0x20  |
;~ __________________________________________________________________________
;~ Legendary Vanquisher  |  0x21  |
;~ Sweet Tooth Title     |  0x22  |
;~ Tyrian Guardian       |  0x23  |
;~ Canthan Guardian      |  0x24  |
;~ Elonian Guardian      |  0x25  |
;~ Asuran Title          |  0x26  |
;~ Deldrimor Title       |  0x27  |
;~ Ebon Vanguard Title   |  0x28  |
;~ Norn Title            |  0x29  |
;~ Master of the North   |  0x2A  |
;~ __________________________________________________________________________
;~ Party Title           |  0x2B  |
;~ Zaishen Title         |  0x2C  |
;~ Treasure Hunter Tilte |  0x2D  |
;~ Wisdom Title          |  0x2E  |
;~ Codex Title           |  0x2F  |
;~ Hero Title            |  0x00, 0x0F |
Func SetDisplayedTitle($aTitle = 0)
	If $aTitle Then
		Return SendPacket(0x8, $HEADER_TITLE_DISPLAY, $aTitle)
	Else
		Return SendPacket(0x4, $HEADER_TITLE_HIDE)
	EndIf
EndFunc   ;==>SetDisplayedTitle

Func UseSkillEx($lSkill, $lTgt = -2, $aTimeout = 3000)
	If GetIsDead(-2) Then Return
	If Not IsRecharged($lSkill) Then Return
	Local $Skill = GetSkillByID(GetSkillbarSkillID($lSkill, 0))
	Local $Energy = StringReplace(StringReplace(StringReplace(StringMid(DllStructGetData($Skill, 'Unknown4'), 6, 1), 'C', '25'), 'B', '15'), 'A', '10')
	If GetEnergy(-2) < $Energy Then Return
	Local $lAftercast = DllStructGetData($Skill, 'Aftercast')
	Local $lDeadlock = TimerInit()
	UseSkill($lSkill, $lTgt)
	Do
		Sleep(50)
		If GetIsDead(-2) = 1 Then Return
	Until (Not IsRecharged($lSkill)) Or (TimerDiff($lDeadlock) > $aTimeout)
	Sleep($lAftercast * 1000)
EndFunc   ;==>UseSkillEx

;Scans loot on the ground to see if you can pick it up.
Func PickUpLoot()
	Local $lAgent
	Local $lItem
	Local $lDeadlock
	For $i = 1 To GetMaxAgents()
		If CountSlots() < 1 Then Return ;full inventory dont try to pick up
		If GetIsDead(-2) Then Return
		$lAgent = GetAgentByID($i)
		If DllStructGetData($lAgent, 'Type') <> 0x400 Then ContinueLoop
		$lItem = GetItemByAgentID($i)
;~ 		If GetDistance($lItem, -2) > 2000 then ContinueLoop
		If CanPickUp($lItem) Then
			PickUpItem($lItem)
			$lDeadlock = TimerInit()
			While GetAgentExists($i)
				Sleep(100)
				If GetIsDead(-2) Then Return

				If TimerDiff($lDeadlock) > 10000 Then ExitLoop
			WEnd
		EndIf
	Next
EndFunc   ;==>PickUpLoot

Func GetItemCountInventory($aModelID, $aExtraID = 0)
	Local $aAmount
	Local $aBag
	Local $aItem
	Local $i
	For $i = 1 To 4
		$aBag = GetBag($i)
		For $j = 1 To DllStructGetData($aBag, "Slots")
			$aItem = GetItemBySlot($aBag, $j)
			If DllStructGetData($aItem, "ModelID") == $aModelID Then
				If $aExtraID <> 0 Then
					If $aExtraID = DllStructGetData($aItem, "ExtraID") Then $aAmount += DllStructGetData($aItem, "Quantity")
				Else
					$aAmount += DllStructGetData($aItem, "Quantity")
				EndIf
			Else
				ContinueLoop
			EndIf
		Next
	Next
	Return $aAmount
EndFunc   ;==>GetItemCountInventory

Func FindEmptySlot($aBag)
	Local $lBagPtr
	Local $lSlots
	If IsPtr($aBag) <> 0 Then
		$lBagPtr = $aBag
		$lSlots = MemoryRead($aBag + 32, 'long')
	ElseIf IsDllStruct($aBag) <> 0 Then
		$lBagPtr = GetBagPtr(DllStructGetData($aBag, 'index') + 1)
		$lSlots = DllStructGetData($aBag, 'slots')
	Else
		$lBagPtr = GetBagPtr($aBag)
		$lSlots = MemoryRead($lBagPtr + 32, 'long')
	EndIf
	Local $lItemArrayPtr = MemoryRead($lBagPtr + 24, 'ptr')
	Local $lItemPtr
	For $i = 0 To $lSlots - 1
		$lItemPtr = MemoryRead($lItemArrayPtr + 4 * $i, 'ptr')
		If $lItemPtr = 0 Then Return $i + 1
	Next
EndFunc   ;==>FindEmptySlot


Func GetAgentPtrArray($aMode = 0, $aType = 0xDB, $aAllegiance = 3, $aRange = 1320, $aAgent = GetAgentPtr(-2), $aEffect = 0, $x = X($aAgent), $y = Y($aAgent))
	Local $lMaxAgents = GetMaxAgents()
	Local $lAgentPtrStruct = DllStructCreate("PTR[" & $lMaxAgents & "]")
	DllCall($mKernelHandle, "BOOL", "ReadProcessMemory", "HANDLE", $mGWProcHandle, "PTR", MemoryRead($mAgentBase), "STRUCT*", $lAgentPtrStruct, "ULONG_PTR", $lMaxAgents * 4, "ULONG_PTR*", 0)
	Local $lTemp
	Local $lAgentArray[$lMaxAgents + 1]
	Switch $aMode
		Case 0
			For $i = 1 To $lMaxAgents
				$lTemp = DllStructGetData($lAgentPtrStruct, 1, $i)
				If $lTemp = 0 Then ContinueLoop
				$lAgentArray[0] += 1
				$lAgentArray[$lAgentArray[0]] = $lTemp
			Next
		Case 1
			For $i = 1 To $lMaxAgents
				$lTemp = DllStructGetData($lAgentPtrStruct, 1, $i)
				If $lTemp = 0 Then ContinueLoop
				If MemoryRead($lTemp + 156, "long") <> $aType Then ContinueLoop
				$lAgentArray[0] += 1
				$lAgentArray[$lAgentArray[0]] = $lTemp
			Next
		Case 2    ; returns all agents of a particular allegiance (enemies by default)
			For $i = 1 To $lMaxAgents
				$lTemp = DllStructGetData($lAgentPtrStruct, 1, $i)
				If $lTemp = 0 Then ContinueLoop
				If MemoryRead($lTemp + 156, "long") <> $aType Then ContinueLoop
				If MemoryRead($lTemp + 433, "byte") <> $aAllegiance Then ContinueLoop
				$lAgentArray[0] += 1
				$lAgentArray[$lAgentArray[0]] = $lTemp
			Next
		Case 3    ; returns all living agents of a particular allegiance (enemies by default)
			$lLowestHP = 1
			For $i = 1 To $lMaxAgents
				$lTemp = DllStructGetData($lAgentPtrStruct, 1, $i)
				If $lTemp = 0 Then ContinueLoop
				If MemoryRead($lTemp + 156, 'long') <> $aType Then ContinueLoop
				If MemoryRead($lTemp + 433, 'byte') <> $aAllegiance Then ContinueLoop
				If $aAllegiance = 3 And (IsMinionAgent($lTemp) Or IsSpiritAgent($lTemp)) Then ContinueLoop
				If GetIsDead($lTemp) Then ContinueLoop
				If GetDistanceToXY($x, $y, $lTemp) > $aRange Then ContinueLoop

				; If BitAND(MemoryRead($lTemp + 312, "long"), 0x0014) Then ContinueLoop	; excludes creatures that spawn new creatures upon death (e.g., Worms, Nettle spores, Shambling Horror)
				$lAgentArray[0] += 1
				$lAgentArray[$lAgentArray[0]] = $lTemp
			Next
		Case 4 ; returns all living agents of a particular allegiance with a particular effect within the specified range (long bow range by default)
			For $i = 1 To $lMaxAgents
				$lTemp = DllStructGetData($lAgentPtrStruct, 1, $i)
				If $lTemp = 0 Then ContinueLoop
				Local $lHP = GetHealth($lTemp), $lDistance = GetDistance($lTemp)
				If MemoryRead($lTemp + 156, 'long') <> $aType Then ContinueLoop
				If MemoryRead($lTemp + 433, 'byte') <> $aAllegiance Then ContinueLoop
				If $aEffect <> 0x0010 And GetIsDead($lTemp) Then ContinueLoop
				If $aEffect <> 0 And Not BitAND(MemoryRead($lTemp + 312, 'long'), $aEffect) Then ContinueLoop
				If $aAllegiance = 3 And (IsMinionAgent($lTemp) Or IsSpiritAgent($lTemp)) Then ContinueLoop
				If GetDistanceToXY($x, $y, $lTemp) > $aRange Then ContinueLoop
				$lAgentArray[0] += 1
				$lAgentArray[$lAgentArray[0]] = $lTemp
			Next

		Case 5 ; returns all living agents NOT of a particular allegiance with a particular effect within the specified range (long bow range by default)
			For $i = 1 To $lMaxAgents
				$lTemp = DllStructGetData($lAgentPtrStruct, 1, $i)
				If $lTemp = 0 Then ContinueLoop
				Local $lHP = GetHealth($lTemp), $lDistance = GetDistance($lTemp)
				If MemoryRead($lTemp + 156, 'long') <> $aType Then ContinueLoop
				If MemoryRead($lTemp + 433, 'byte') = $aAllegiance Then ContinueLoop
				If $aEffect <> 0x0010 And GetIsDead($lTemp) Then ContinueLoop
				If $aEffect <> 0 And Not BitAND(MemoryRead($lTemp + 312, 'long'), $aEffect) Then ContinueLoop
				If $aAllegiance = 3 And (IsMinionAgent($lTemp) Or IsSpiritAgent($lTemp)) Then ContinueLoop
				If GetDistanceToXY($x, $y, $lTemp) > $aRange Then ContinueLoop

				$lAgentArray[0] += 1
				$lAgentArray[$lAgentArray[0]] = $lTemp
			Next
	EndSwitch
	ReDim $lAgentArray[$lAgentArray[0] + 1]
	;_ArrayDisplay($lAgentArray)
	Return $lAgentArray
EndFunc   ;==>GetAgentPtrArray

;~ Description: Returns the distance of agent from a waypoint.
Func GetDistanceToXY($x, $y, $aAgent = -2)
	Return Sqrt(($x - X($aAgent)) ^ 2 + ($y - Y($aAgent)) ^ 2)
EndFunc   ;==>GetDistanceToXY

Func GetBoss($aRange = 5000)
	If GetMapLoading() == 0 Then Return
	If GetIsDead(-2) Then Return
	Local $lAgent, $lDistance
	Local $lAgentArray = GetAgentArray(0xDB)
	For $i = 1 To $lAgentArray[0]
		$lAgent = $lAgentArray[$i]
		If GetDistance($lAgent, GetMyID()) > $aRange Then ContinueLoop
		If DllStructGetData($lAgent, 'typeMap') = 3072 Or DllStructGetData($lAgent, 'typeMap') = 3073 Then Return DllStructGetData($lAgentArray[$i], 'ID')
	Next
	Return 0
EndFunc   ;==>GetBoss

Func GetAgentByLevel($aLevel = 30)
	If GetMapLoading() == 0 Then Return
	If GetIsDead(-2) Then Return
	Local $lAgent
	Local $lAgentArray = GetAgentArray(0xDB)
	For $i = 1 To $lAgentArray[0]
		$lAgent = $lAgentArray[$i]
		If GetIsDead($lAgent) Then ContinueLoop
		If DllStructGetData($lAgent, 'Level') = $aLevel Then Return DllStructGetData($lAgentArray[$i], 'ID')
	Next
	Return 0
EndFunc   ;==>GetAgentByLevel

;~Returns whether a player ID corresponds to a ritual
Func IsSpiritAgent($aAgent)
	Local $lPlayerNumber = MemoryRead(GetAgentPtr($aAgent) + 244, "word")
	Switch $lPlayerNumber
		Case 2870 To 2888, 4230 To 4239, 5711 To 5719, 5776 ; nature rituals
			Return True
		Case 4209 To 4231, 5720, 5721, 5723, 5853, 5854 ; binding rituals
			Return True
		Case 5848 To 5850 ; EVA, spirits
			Return True
	EndSwitch
	Return False
EndFunc   ;==>IsSpiritAgent

;~Returns whether a player ID corresponds to a minion
Func IsMinionAgent($aAgent)
	Local $lPlayerNumber = MemoryRead(GetAgentPtr($aAgent) + 244, "word")
	Switch $lPlayerNumber
		Case 2226 To 2228 ; bone minions
			Return True
		Case 3962, 3963, 4205, 4206 ; corrupted scale, corrupted spore, flesh golem, vampiric horror
			Return True
		Case 5709, 5710 ; shambling horror, jagged horror
			Return True
	EndSwitch
	Return False
EndFunc   ;==>IsMinionAgent

;~Returns whether a player ID corresponds to a frost worm
Func IsWormAgent($aAgent)
	Local $lPlayerNumber = MemoryRead(GetAgentPtr($aAgent) + 244, "word")
	Switch $lPlayerNumber
		Case 4323, 6491 To 6492, 6929 To 6932, 6852, 6850, 6848, 2547 ; Desert Worm, Frost Worms
			Return True
		Case 2325 ;2325 is smite in uw, to avoid damage from shield of judgment
			Return True
	EndSwitch
	Return False
EndFunc   ;==>IsWormAgent

;~ Description: Agents X Location
Func X($aAgent = -2)
	Return MemoryRead(GetAgentPtr($aAgent) + 116, 'float')
EndFunc   ;==>X

;~ Description: Agents Movevement on the X axis
Func MoveX($aAgent = GetAgentPtr(-2))
	Return MemoryRead(GetAgentPtr($aAgent) + 160, 'float')
EndFunc   ;==>MoveX

;~ Description: Agents Y Location
Func Y($aAgent = -2)
	Return MemoryRead(GetAgentPtr($aAgent) + 120, 'float')
EndFunc   ;==>Y

;~ Description: Agents Movevement on the Y axis
Func MoveY($aAgent = GetAgentPtr(-2))
	Return MemoryRead(GetAgentPtr($aAgent) + 164, 'float')
EndFunc   ;==>MoveY

;~ Description: Agents Z Location
Func Z($aAgent = -2)
	Return MemoryRead(GetAgentPtr($aAgent) + 48, 'float')
EndFunc   ;==>Z


#Region GetNumber Enemies
; Returns the number of living enemies in range of an agent excluding spawned creatures
Func GetNumberOfEnemies($aRange = 3000)
	Return UBound(GetAgentPtrArray(4, 0xDB, 3, $aRange)) - 1
EndFunc   ;==>GetNumberOfEnemies

; Returns the total number of anemies in range of an agent
Func GetNumberOfEnemiesNearAgent($aRange = 3000, $aAgent = -2)
	Return UBound(GetAgentPtrArray(4, 0xDB, 3, $aRange, $aAgent)) - 1
EndFunc   ;==>GetNumberOfEnemiesNearAgent



; Returns the number of moving enemies in range of an agent
Func GetNumberOfMovingEnemies($aAgent = -2, $aRange = 3000)
	Local $lCount = 0, $lAgentPtrArray = GetAgentPtrArray(4, 0xDB, 3, $aRange, $aAgent)
	For $i = 1 To $lAgentPtrArray[0]
		If Not GetIsMoving($lAgentPtrArray[$i]) Then ContinueLoop
		$lCount += 1
	Next
	Return $lCount
EndFunc   ;==>GetNumberOfMovingEnemies


; Returns the number of living bosses in range of an agent
Func GetNumberOfBosses($aRange = 3000)
	Local $lCount = 0
	Local $lAgentPtrArray = GetAgentPtrArray(4, 0xDB, 3, $aRange)
	For $i = 1 To $lAgentPtrArray[0]
		If BitAND(MemoryRead($lAgentPtrArray[$i] + 344, "long"), 1024) > 0 Then $lCount += 1
	Next
	Return $lCount
EndFunc   ;==>GetNumberOfBosses

; Returns the number of dead bosses in range of an agent
Func GetNumberOfDeadBosses($aRange = 3000)
	Local $lCount = 0
	Local $lAgentPtrArray = GetAgentPtrArray(4, 0xDB, 3, $aRange, GetAgentPtr(-2), 0x0010)
	For $i = 1 To $lAgentPtrArray[0]
		If MemoryRead($lAgentPtrArray[$i] + 344, "long") = 3080 Then $lCount += 1
	Next
	Return $lCount
EndFunc   ;==>GetNumberOfDeadBosses
#EndRegion GetNumber Enemies



;~ Func MoveAggroing($lDestX, $lDestY, $lRandom=0, $CheckTarget=0)
;~ 	If GetIsDead(-2) Then Return

;~ 	Local $lMe
;~ 	Local $ChatStuckTimer
;~ 	Local $lBlocked
;~ 	Local $RANGE_ADJACENT_2 = 156 ^ 2
;~ 	Local $lAdjacentCount, $lDistance
;~ 	Local $lAgentArray


;~ 	Move($lDestX, $lDestY, $lRandom)

;~ 	$lAgentArray = GetAgentArray(0xDB)

;~ 	For $i = 1 To $lAgentArray[0]
;~ 		$lDistance = GetPseudoDistance($lMe, $lAgentArray[$i])
;~ 		If $lDistance < $RANGE_ADJACENT_2 Then
;~ 			$lAdjacentCount += 1
;~ 		EndIf
;~ 	Next

;~ 	If $lAdjacentCount > 10 Then
;~ 		$Return += 1
;~ 	EndIf

;~ 	Do
;~ 		Sleep(50)

;~ 		$lMe = GetAgentByID(-2)

;~ 		If GetIsDead($lMe) Then Return

;~ 		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
;~ 			$lBlocked += 1
;~ 			Move($lDestX, $lDestY, $lRandom)
;~ 		EndIf

;~ 		If $lBlocked > 3 Then
;~ 			If TimerDiff($ChatStuckTimer) > 2500 Then    ; use a timer to avoid spamming /stuck
;~ 				SendChat("stuck", "/")
;~ 				$ChatStuckTimer = TimerInit()
;~ 				$Return += 1
;~ 			EndIf
;~ 		EndIf

;~ 		If GetDistance() > 1500 Then ; target is far, we probably got stuck.
;~ 			If TimerDiff($ChatStuckTimer) > 2500 Then ; dont spam
;~ 				SendChat("stuck", "/")
;~ 				$ChatStuckTimer = TimerInit()
;~ 				RndSleep(GetPing())
;~ 				if $CheckTarget <> 0 then Attack($CheckTarget)
;~ 				$Return += 1
;~ 			EndIf
;~ 		EndIf

;~ 		If $Return > 0 Then Return

;~ 	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < $lRandom * 1.5
;~ EndFunc   ;==>MoveAggroing

;~ Description: standard pickup function, only modified to increment a custom counter when taking stuff with a particular ModelID
Func CustomPickUpLoot()
	Local $lAgent
	Local $lItem
	Local $lDeadlock
	For $i = 1 To GetMaxAgents()
		If CountSlots() < 1 Then Return ;full inventory dont try to pick up
		If GetIsDead(-2) Then Return
		$lAgent = GetAgentByID($i)
		If DllStructGetData($lAgent, 'Type') <> 0x400 Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If CanPickUp($lItem) Then
			PickUpItem($lItem)
			$lDeadlock = TimerInit()
			While GetAgentExists($i)
				Sleep(Random(50, 100))
				If GetIsDead(-2) Then Return
				If TimerDiff($lDeadlock) > 10000 Then ExitLoop
			WEnd
		EndIf
	Next
EndFunc   ;==>CustomPickUpLoot
Func CheckGold()
	Local $GCHARACTER = GetGoldCharacter()
	Local $GSTORAGE = GetGoldStorage()
	Local $GDIFFERENCE = ($GSTORAGE - $GCHARACTER)
	If $GCHARACTER <= 1000 Then
		Switch $GSTORAGE
			Case 100000 To 1000000
				WithdrawGold(80000 - $GCHARACTER)
				out("Withdraw Gold: CheckGold")
				Sleep(500 + 3 * GetPing())
			Case 1 To 99999
				WithdrawGold($GDIFFERENCE)
				out("Withdraw Gold: CheckGold")
				Sleep(500 + 3 * GetPing())
			Case 0
				Out("Out of cash, beginning farm")
				Return False
		EndSwitch
	EndIf
	Return True
EndFunc   ;==>CheckGold

;~ Description: guess what?
Func _Exit()
	Exit
EndFunc   ;==>_Exit


;~ Func MoveRunning($lDestX, $lDestY)
;~ 	Local $Skill1 = 1
;~ 	Local $Skill2 = 2
;~ 	Local $Skill3 = 3
;~ 	Local $Skill6 = 6

;~ 	If GetIsDead(-2) Then Return False

;~ 	Local $lMe, $lTgt
;~ 	Local $lBlocked

;~ 	Move($lDestX, $lDestY)

;~ 	Do
;~ 		RndSleep(500)

;~ 		TargetNearestEnemy()

;~ 		$lMe = GetAgentByID(-2)
;~ 		$lTgt = GetAgentByID(-1)
;~ 		If GetIsCrippled() = True Then
;~ 			UseSkill(4, -2) ;IAU
;~ 		EndIf

;~ 		If GetIsDead($lMe) Then Return False

;~ 		If GetDistance($lMe, $lTgt) < 1300 And GetEnergy($lMe) > 20 And IsRecharged($Skill1) And IsRecharged($Skill2) Then
;~ 			ConsoleWrite("Using skills" & @CRLF)

;~ 			UseSkill(1, -2)
;~ 			pingSleep(1000)
;~ 			UseSkill(2, -2)
;~ 			pingSleep(1000)
;~ 		EndIf

;~ 		If DllStructGetData($lMe, "HP") < 0.9 And GetEnergy($lMe) > 10 And IsRecharged($Skill3) Then UseSkillEx($Skill3)

;~ 		If DllStructGetData($lMe, "HP") < 0.5 And GetDistance($lMe, $lTgt) < 500 And GetEnergy($lMe) > 5 And IsRecharged($Skill6) Then UseSkillEx($Skill6, -1)

;~ 		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
;~ 			$lBlocked += 1
;~ 			Move($lDestX, $lDestY)
;~ 		EndIf

;~ 	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 250 Or GetIsDead(-2)
;~ 	Return True
;~ EndFunc   ;==>MoveRunning

;~ Func GetIsCrippled($aHeroNumber = 0)
;~ 	Return HasEffect($SKILLID_Crippled, $aHeroNumber)
;~ EndFunc   ;==>GetIsCrippled


;Moves to a location and fights enemies if encountered along the way, then continues moving
; $x, $y = desired end coordinates.
; $S will update the Out() command to update UI
; $z is the permitted aggro range. Higher will be more aggressive, lower will attempt to ignore enemies.
; $oldcheck will only execute the command if aggromovetoex successfully reached its location the last time it was called. use parameter "RESET" to reset it back to 0.
Func AggroMoveToEx($x, $y, $s = "", $z = 1450)
	Local $random = Random(-25, 25)
	Local $iBlocked = 0
	Local $lMe
	Local $coordsX
	Local $coordsY
	Local $oldCoordsX
	Local $oldCoordsY
	Local $nearestenemy
	Local $lDistance

	Move($x, $y, $random)

	If GetIsDead(-2) = False Then
		$lMe = GetAgentByID(-2)
		$coordsX = DllStructGetData($lMe, "X")
		$coordsY = DllStructGetData($lMe, "Y")
		Do
			If GetIsDead(-2) = True Then Return False



			$oldCoordsX = $coordsX
			$oldCoordsY = $coordsY
			$nearestenemy = GetNearestEnemyToAgent(-2)
			$lDistance = GetDistance($nearestenemy, -2)
			If GetIsDead(-2) = True Then ExitLoop
			If $lDistance < $z And DllStructGetData($nearestenemy, 'ID') <> 0 And GetIsDead(-2) = False Then

				Fight($z, $s)

			EndIf

			$lMe = GetAgentByID(-2)
			$coordsX = DllStructGetData($lMe, "X")
			$coordsY = DllStructGetData($lMe, "Y")
			If $oldCoordsX = $coordsX And $oldCoordsY = $coordsY Then
				$iBlocked += 1
				If GetIsDead(-2) = False Then Move($coordsX, $coordsY, 500)
				If GetIsDead(-2) = False Then Sleep(350)
				If GetIsDead(-2) = False Then Move($x, $y, $random)
			EndIf
		Until ComputeDistanceEx($coordsX, $coordsY, $x, $y) < 250 Or $iBlocked > 20 Or GetIsDead(-2) = True
	EndIf
	$AggroOldX = $x
	$AggroOldY = $y
EndFunc   ;==>AggroMoveToEx

Func Fight($x, $s = "")
	Local $nearestenemy
	Local $useSkill
	Local $target
	Local $Distance
	Local $targetHP
	Local $Energy
	Local $recharge
	Local $adrenaline
	Local $CheckSkillID

;~ 	Out($s)

	Do
		Sleep(50)
		$nearestenemy = GetNearestEnemyToAgent(-2)
	Until DllStructGetData($nearestenemy, 'ID') <> 0

	Do
		If DllStructGetData($target, 'ModelID') = 6852 Then ExitLoop
		$useSkill = -1
		$target = GetNearestEnemyToAgent(-2)
		$Distance = GetDistance($target, -2)
		If DllStructGetData($target, 'ID') <> 0 And $Distance < $x Then
			Sleep(50)
			If DllStructGetData($target, 'ModelID') = 6852 Then ExitLoop
			ChangeTarget($target)
			Sleep(50)
			ActionInteract()
		ElseIf DllStructGetData($target, 'ID') = 0 Or $Distance > $x Then
			ExitLoop
		EndIf

		For $i = 0 To 7
			Sleep(100)
			$target = GetNearestEnemyToAgent(-2)
			$Distance = GetDistance($target, -2)


			If DllStructGetData($target, 'Allegiance') <> 3 Then ExitLoop
			If DllStructGetData($target, 'ModelID') = 6852 Then ExitLoop
			$targetHP = DllStructGetData($target, 'HP')

			If $targetHP = 0 Then ExitLoop
			If GetIsDead(-2) Then ExitLoop 2

			$Distance = GetDistance($target, -2)
			If $Distance > $x Then ExitLoop

			$Energy = GetEnergy(-2)
			$recharge = DllStructGetData(GetSkillbar(), "Recharge" & $i + 1)
			$adrenaline = DllStructGetData(GetSkillbar(), "Adrenaline" & $i + 1)

			If $recharge = 0 And $Energy >= $skillCost[$i] And $adrenaline >= ($intSkillAdrenaline[$i] * 25 - 25) Then
				$useSkill = $i + 1
				Sleep(50)
				$Distance = GetDistance($target, -2)
				If $Distance > $x Then ExitLoop
;~ 				If $i=7 and HasEffect(242) Then ExitLoop
				$CheckSkillID = GetSkillbarSkillID($useSkill, -2)
				If HasEffect($CheckSkillID) And $CheckSkillID <> 0 Then ExitLoop ;test
				ConsoleWrite($CheckSkillID & @CRLF)

				UseSkill($useSkill, $target)
				Sleep($intSkillCastTime[$i])
			EndIf
;~ 			If $i = $totalskills Then $i = 0
		Next

	Until DllStructGetData($target, 'ID') = 0 Or $Distance > $x Or DllStructGetData($target, 'Allegiance') <> 3
	pingSleep(500)
	PickUpLoot()
EndFunc   ;==>Fight

;Determines distance between 2 agents
Func ComputeDistanceEx($x1, $y1, $x2, $y2)
	Return Sqrt(($y2 - $y1) ^ 2 + ($x2 - $x1) ^ 2)
	Local $dist = Sqrt(($y2 - $y1) ^ 2 + ($x2 - $x1) ^ 2)
	ConsoleWrite("Distance: " & $dist & @CRLF)

EndFunc   ;==>ComputeDistanceEx


Func GetNumberOfFoesInRangeOfAgent($aAgent = -2, $aRange = 1250)
	Local $lAgent, $lDistance
	Local $lCount = 0

	If Not IsDllStruct($aAgent) Then $aAgent = GetAgentByID($aAgent)

	For $i = 1 To GetMaxAgents()
		$lAgent = GetAgentByID($i)
		If BitAND(DllStructGetData($lAgent, 'typemap'), 262144) Then ContinueLoop
		If DllStructGetData($lAgent, 'Type') <> 0xDB Then ContinueLoop
		If DllStructGetData($lAgent, 'Allegiance') <> 3 Then ContinueLoop

		If DllStructGetData($lAgent, 'HP') <= 0 Then ContinueLoop
		If BitAND(DllStructGetData($lAgent, 'Effects'), 0x0010) > 0 Then ContinueLoop
		$lDistance = GetDistance($lAgent)

		If $lDistance > $aRange Then ContinueLoop
		$lCount += 1
	Next
	Return $lCount
EndFunc   ;==>GetNumberOfFoesInRangeOfAgent


Func DisableHeroSkills()
	For $i = 1 To 8
		DisableHeroSkillSlot(1, $i)
	Next
EndFunc   ;==>DisableHeroSkills


Func Storearmors()
	ArmorIs(1, 20)
	ArmorIs(2, 10)
	ArmorIs(3, 15)
	ArmorIs(4, 15)
EndFunc   ;==>Storearmors


Func ArmorIs($bagIndex, $NUMOFSLOTS) ; store should save all m4m blues pureples and golds wont store tomes and scrolls might not store consumables think they are type 9
	;$m = DllStructGetData($aitem, 'ModelID')
	;$q = DllStructGetData($aitem, 'quantity')
	Local $aItem
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	Local $t
	For $i = 1 To $NUMOFSLOTS
		ConsoleWrite("Checking items: " & $bagIndex & ", " & $i & @CRLF)
		$aItem = GetItemBySlot($bagIndex, $i)
		;if $aitem = 1159 or 1156 Then
		;If $m = 1159 or $m = 1156 or $m = 1154 or $m = 1167 or $m = 697 or $m = 1166 Then
		If DllStructGetData($aItem, 'ID') <> 0 And GetRarity($aItem) <> $RARITY_White And DllStructGetData($aItem, 'Type') <> 9 And DllStructGetData($aItem, 'Type') <> 31 Then  ;  tomes 9 scrolls 31
			Do
				For $bag = 8 To 11 ; 6 To 16 are all storage bags
					$SLOT = FindEmptySlot($bag)
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2 ; finding first empty $slot in $bag and jump out
					Else
						$FULL = True ; no empty slots :(
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				ConsoleWrite("Armor item moved ...." & @CRLF)
				pingSleep(1000)
			EndIf
		EndIf
	Next
EndFunc   ;==>ArmorIs

Func ConsetMaterials($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, 'ID') = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, 'ModelID')
		$q = DllStructGetData($aItem, 'quantity')
		If ($m = 929 Or $m = 921 Or $m = 948 Or $m = 933 Or $m = 934 Or $m = $ITEM_ID_ToT Or $m = $ITEM_ID_Wintersday_Gift Or $m = $ITEM_ID_Frosty_Tonic Or CheckArrayPscon($m)) And $q = 250 Then  ; dust bone iron feather and fiber ;m441 shadoy remnats
			Do
				For $bag = 8 To 11 ; 6 To 16 are all storage bags
					$SLOT = FindEmptySlot($bag)
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2 ; finding first empty $slot in $bag and jump out
					Else
						$FULL = True ; no empty slots :(
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(Random(450, 550))
			EndIf
		EndIf
	Next
EndFunc   ;==>ConsetMaterials


#Region Inventory
#CS

#CE
Func Inventory($aBags = 4)
	$SetUpComplete = False
	Out("Initiating Merch Sequence ")
	Out("Randomizing District")
	Sleep(1000)
	RndTravel($MerchTown)     ;marketplace
	WaitMapLoading($MerchTown)
	Sleep(3000)     ; test
	If $BotName = "Vaettir" Then
		MoveTo(-24446, 15031)
		GoNearestNPCToCoords(-23096, 15012)
	EndIf
	If $BotName = "DervCoF" Then
		GoNearestNPCToCoords(-19166, 17980)
		Sleep(100)
		Dialog(0x7F)
		Sleep(100)
	EndIf
	If $BotName = "EleFeatherFarmer" Then GoNearestNPCToCoords(13681, 16084) ;marketplace merch
	If $BotName = "WarRaptors" Then
		MoveTo(19275, 14726)
		GoNearestNPCToCoords(19575, 14751) ;Rata merch
	EndIf
	If $BotName = "Fastfoot" Then GoNearestNPCToCoords(-15005, 11392) ;Rilohn merch
	If $BotName = "Snowman" Then
		MoveTo(-22143, 11828) ;center of outpost
		GoNearestNPCToCoords(-20976, 10930) ;umbral merch
	EndIf
	; If GUICtrlRead($StoreGolds) = $GUI_CHECKED Then
	; StoreUNIDGolds()
	; EndIf
	If CountSlots() < 2 And $Bool_Sell = False Then
		MsgBox("WARNING", "OUT OF INVENTORY SPACE", "YOU NO LONGER HAVE ANY INVENTORY SPACE, AND THE BOT IS NOT PERMITTED TO SELL.", 0)
;~ 		GuiButtonHandler()
		Out("Bags are full. Cannot Sell")
		Return False
	EndIf

	If $Bool_Salvage = True Or $Bool_Sell = True Then buyIdentifyKit($maxIdentyfyKit - checkIdentifyKit())
	If $Bool_Salvage = True Then buySalvageKit($maxSalvageKit - checkSalvageKit())
	If $Bool_StoreGoodies Or $Bool_Salvage Or $Bool_Sell Then
		Out("Identifying 1")
		IDENT(1)
		Out("Identifying 2")
		IDENT(2)
		Out("Identifying 3")
		IDENT(3)
		Out("Identifying 4")
		IDENT(4)
	EndIf
	If $Bool_Salvage Then
		Out("Salvage bag 1")
		Salvage2(1)
		Out("Salvage bag 2")
		Salvage2(2)
		Out("Salvage bag 3")
		Salvage2(3)
		Out("Salvage bag 4")
		Salvage2(4)
	EndIf
	If GetGoldCharacter() > 50000 Then
		Out("Depositing 50k to Storage")
		DepositGold(50000)
	EndIf

	If $Bool_Sell Then
		Out("Selling 1")
		Sell(1)
		Out("Selling 2")
		Sell(2)
		Out("Selling 3")
		Sell(3)
		Out("Selling 4")
		Sell(4)
	EndIf

	Out("Store Conset Materials")
	If $Bool_StoreGoodies = True Then
		out("Storing Bag 1")
		ConsetMaterials(1, 20)
		out("Storing Bag 2")
		ConsetMaterials(2, 10)
		out("Storing Bag 3")
		ConsetMaterials(3, 15)
		out("Storing Bag 4")
		ConsetMaterials(4, 15)
		Storearmors()
	EndIf
	If CountSlots() < 2 And $Bool_Sell = False Then
		Out("Inventory is full. Selling not permitted.")
;~ 		GuiButtonHandler()
		Sleep(1000)
	EndIf
	If GetGoldCharacter() > 50000 Then
		Out("Depositing 50k to Storage")
		DepositGold(GetGoldCharacter())
	EndIf
	$BotRunning = True
	$BotInitialized = True
	If $BotName = "WarRaptors" Then
		MoveTo(19275, 14726)
		Move(19734, 16426)
	EndIf
	If $BotName = "Vaettir" Then
		GoNearestNPCToCoords(-23096, 15012)
		buyIdentifyKit($maxIdentyfyKit - checkIdentifyKit())
		buySalvageKit($maxSalvageKit - checkSalvageKit())
		MoveTo(-24446, 15031)
	EndIf
	If GetGoldCharacter() > 1 Then
		Out("Depositing all gold to storage")
		DepositGold(GetGoldCharacter())
	EndIf
EndFunc   ;==>Inventory


#Region Storing Stuff
; Big function that calls the smaller functions below
Func StoreItems()
	StackableDrops(1, 20)
	StackableDrops(2, 5)
	StackableDrops(3, 10)
	StackableDrops(4, 10)
	Alcohol(1, 20)
	Alcohol(2, 5)
	Alcohol(3, 10)
	Alcohol(4, 10)
	Party(1, 20)
	Party(2, 5)
	Party(3, 10)
	Party(4, 10)
	Sweets(1, 20)
	Sweets(2, 5)
	Sweets(3, 10)
	Sweets(4, 10)
	Scrolls(1, 20)
	Scrolls(2, 5)
	Scrolls(3, 10)
	Scrolls(4, 10)
	EliteTomes(1, 20)
	EliteTomes(2, 5)
	EliteTomes(3, 10)
	EliteTomes(4, 10)
	Tomes(1, 20)
	Tomes(2, 5)
	Tomes(3, 10)
	Tomes(4, 10)
	DPRemoval(1, 20)
	DPRemoval(2, 5)
	DPRemoval(3, 10)
	DPRemoval(4, 10)
	SpecialDrops(1, 20)
	SpecialDrops(2, 5)
	SpecialDrops(3, 10)
	SpecialDrops(4, 10)
EndFunc   ;==>StoreItems

Func StoreMaterials()
	Materials(1, 20)
	Materials(2, 5)
	Materials(3, 10)
	Materials(4, 10)
EndFunc   ;==>StoreMaterials

Func StoreUNIDGolds()
	UNIDGolds(1, 20)
	UNIDGolds(2, 5)
	UNIDGolds(3, 10)
	UNIDGolds(4, 10)
EndFunc   ;==>StoreUNIDGolds

Func StoreMods()
	Mods(1, 20)
	Mods(2, 5)
	Mods(3, 10)
	Mods(4, 10)
EndFunc   ;==>StoreMods

Func StoreWeapons()
	Weapons(1, 20)
	Weapons(2, 5)
	Weapons(3, 10)
	Weapons(4, 10)
EndFunc   ;==>StoreWeapons

Func Weapons($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		Local $aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		Local $ModStruct = GetModStruct($aItem)
		Local $Energy = StringInStr($ModStruct, "0500D822", 0, 1) ;~String for +5e mod
		Switch DllStructGetData($aItem, "Type")
			Case 2, 5, 15, 27, 32, 35, 36
				If $Energy > 0 Then
					Do
						For $bag = 8 To 12
							$SLOT = FindEmptySlot($bag)
							$SLOT = @extended
							If $SLOT <> 0 Then
								$FULL = False
								$NSLOT = $SLOT
								ExitLoop 2
							Else
								$FULL = True
							EndIf
							Sleep(400)
						Next
					Until $FULL = True
					If $FULL = False Then
						MoveItem($aItem, $bag, $NSLOT)
						Sleep(Random(450, 550))
					EndIf
				EndIf
		EndSwitch
	Next
EndFunc   ;==>Weapons

Func StackableDrops($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 460 Or $m = 474 Or $m = 476 Or $m = 486 Or $m = 522 Or $m = 525 Or $m = 811 Or $m = 819 Or $m = 822 Or $m = 835 Or $m = 1610 Or $m = 2994 Or $m = 19185 Or $m = 22751 Or $m = 24629 Or $m = 24630 Or $m = 24631 Or $m = 24632 Or $m = 27033 Or $m = 27035 Or $m = 27044 Or $m = 27046 Or $m = 27047 Or $m = 27052 Or $m = 35123 Or $m = 37765 Or $m = 27035) And $q = 250 Then ;last one is saurian bones
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>StackableDrops

Func EliteTomes($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 21796 Or $m = 21797 Or $m = 21798 Or $m = 21799 Or $m = 21800 Or $m = 21801 Or $m = 21802 Or $m = 21803 Or $m = 21804 Or $m = 21805) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>EliteTomes

Func Tomes($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 21796 Or $m = 21797 Or $m = 21798 Or $m = 21799 Or $m = 21800 Or $m = 21801 Or $m = 21802 Or $m = 21803 Or $m = 21804 Or $m = 21805) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>Tomes

Func Alcohol($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 910 Or $m = 2513 Or $m = 5585 Or $m = 6049 Or $m = 6366 Or $m = 6367 Or $m = 6375 Or $m = 15477 Or $m = 19171 Or $m = 22190 Or $m = 24593 Or $m = 28435 Or $m = 30855 Or $m = 31145 Or $m = 31146 Or $m = 35124 Or $m = 36682) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>Alcohol

Func Party($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 6376 Or $m = 6368 Or $m = 6369 Or $m = 21809 Or $m = 21810 Or $m = 21813 Or $m = 29436 Or $m = 29543 Or $m = 36683 Or $m = 4730 Or $m = 15837 Or $m = 21490 Or $m = 22192 Or $m = 30626 Or $m = 30630 Or $m = 30638 Or $m = 30642 Or $m = 30646 Or $m = 30648 Or $m = 31020 Or $m = 31141 Or $m = 31142 Or $m = 31144 Or $m = 31172) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>Party

Func Sweets($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 15528 Or $m = 15479 Or $m = 19170 Or $m = 21492 Or $m = 21812 Or $m = 22269 Or $m = 22644 Or $m = 22752 Or $m = 28431 Or $m = 28432 Or $m = 28436 Or $m = 31150 Or $m = 35125 Or $m = 36681) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>Sweets

Func Scrolls($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 3746 Or $m = 765 Or $m = 767 Or $m = 768 Or $m = 1887 Or $m = 857 Or $m = 894 Or $m = 895 Or $m = 22280) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>Scrolls

Func DPRemoval($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 6370 Or $m = 21488 Or $m = 21489 Or $m = 22191 Or $m = 35127 Or $m = 26784 Or $m = 28433) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>DPRemoval

Func SpecialDrops($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 18345 Or $m = 21491 Or $m = 21833 Or $m = 28434 Or $m = 35121) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>SpecialDrops

Func Materials($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "Id") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelId")
		$q = DllStructGetData($aItem, "Quantity")
		If ($m = 921 Or $m = 922 Or $m = 923 Or $m = 925 Or $m = 926 Or $m = 927 Or $m = 928 Or $m = 929 Or $m = 930 Or $m = 931 Or $m = 932 Or $m = 933 Or $m = 934 Or $m = 935 Or $m = 936 Or $m = 937 Or $m = 938 Or $m = 939 Or $m = 940 Or $m = 941 Or $m = 942 Or $m = 943 Or $m = 944 Or $m = 945 Or $m = 946 Or $m = 948 Or $m = 949 Or $m = 950 Or $m = 951 Or $m = 952 Or $m = 953 Or $m = 954 Or $m = 955 Or $m = 956 Or $m = 6532 Or $m = 6533) And $q = 250 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>Materials

; Keeps all Golds
Func UNIDGolds($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $r
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$r = GetRarity($aItem)
		$m = DllStructGetData($aItem, "ModelID")
		If $r = 2624 Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>UNIDGolds

; Stores the mods that I am salvaging out to keep for Hero weapons
Func Mods($bagIndex, $NUMOFSLOTS)
	Local $aItem
	Local $m
	Local $q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $i = 1 To $NUMOFSLOTS
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, "ID") = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, "ModelID")
		$q = DllStructGetData($aItem, "quantity")
		If ($m = 896 Or $m = 908 Or $m = 15554 Or $m = 15551 Or $m = 15552 Or $m = 894 Or $m = 906 Or $m = 897 Or $m = 909 Or $m = 893 Or $m = 905 Or $m = 6323 Or $m = 6331 Or $m = 895 Or $m = 907 Or $m = 15543 Or $m = 15553 Or $m = 15544 Or $m = 15555 Or $m = 15540 Or $m = 15541 Or $m = 15542 Or $m = 17059 Or $m = 19122 Or $m = 19123) Then
			Do
				For $bag = 8 To 12
					$SLOT = FindEmptySlot($bag)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $NSLOT)
				Sleep(GetPing() + 500)
			EndIf
		EndIf
	Next
EndFunc   ;==>Mods

;~ ; This searches for empty slots in your storage
;~ Func FindEmptySlot($BAGINDEX)
;~ 	Local $LITEMINFO, $ASLOT
;~ 	For $ASLOT = 1 To DllStructGetData(GETBAG($BAGINDEX), "Slots")
;~ 		Sleep(40)
;~ 		$LITEMINFO = GETITEMBYSLOT($BAGINDEX, $ASLOT)
;~ 		If DllStructGetData($LITEMINFO, "ID") = 0 Then
;~ 			SetExtended($ASLOT)
;~ 			ExitLoop
;~ 		EndIf
;~ 	Next
;~ 	Return 0
;~ EndFunc
#EndRegion Storing Stuff


#Region Pcons

;~ Any pcons you want to use during a run
Global $pconsEgg_slot[0]
Global $useEgg = True ; set it on true and he use it


Func UseEgg()
	If $useEgg Then
		pconsScanInventory()
		If (GetMapLoading() == 1) And (GetIsDead(-2) == False) Then
			If $pconsEgg_slot[0] > 0 And $pconsEgg_slot[1] > 0 Then
				If DllStructGetData(GetItemBySlot($pconsEgg_slot[0], $pconsEgg_slot[1]), "ModelID") == 22752 Then
					UseItemBySlot($pconsEgg_slot[0], $pconsEgg_slot[1])
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc   ;==>UseEgg
;~ This searches the bags for the specific pcon you wish to use.
Func pconsScanInventory()
	Local $bag
	Local $size
	Local $SLOT
	Local $item
	Local $ModelID
	$pconsEgg_slot[0] = $pconsEgg_slot[1] = 0
	For $bag = 1 To 4 Step 1
		If $bag == 1 Then $size = 20
		If $bag == 2 Then $size = 5
		If $bag == 3 Then $size = 10
		If $bag == 4 Then $size = 10
		For $SLOT = 1 To $size Step 1
			$item = GetItemBySlot($bag, $SLOT)
			$ModelID = DllStructGetData($item, "ModelID")
			Switch $ModelID
				Case 0
					ContinueLoop
				Case 22752
					$pconsEgg_slot[0] = $bag
					$pconsEgg_slot[1] = $SLOT
			EndSwitch
		Next
	Next
EndFunc   ;==>pconsScanInventory
;~ Uses the Item from UseEgg()
Func UseItemBySlot($aBag, $aSlot)
	Local $item = GetItemBySlot($aBag, $aSlot)
	SendPacket(8, $HEADER_ITEM_USE, DllStructGetData($item, "ID"))
EndFunc   ;==>UseItemBySlot

Func arrayContains($array, $item)
	For $i = 1 To $array[0]
		If $array[$i] == $item Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>arrayContains
#EndRegion Pcons


Func GenericRandomPath($aPosX, $aPosY, $aRandom = 50, $STOPSMIN = 1, $STOPSMAX = 5, $NUMBEROFSTOPS = -1)
	If $NUMBEROFSTOPS = -1 Then $NUMBEROFSTOPS = Random($STOPSMIN, $STOPSMAX, 1)
	Local $lAgent = GetAgentByID(-2)
	Local $MYPOSX = DllStructGetData($lAgent, "X")
	Local $MYPOSY = DllStructGetData($lAgent, "Y")
	Local $Distance = ComputeDistance($MYPOSX, $MYPOSY, $aPosX, $aPosY)
	If $NUMBEROFSTOPS = 0 Or $Distance < 200 Then
		MoveTo($aPosX, $aPosY, $aRandom)
	Else
		Local $m = Random(0, 1)
		Local $N = $NUMBEROFSTOPS - $m
		Local $STEPX = (($m * $aPosX) + ($N * $MYPOSX)) / ($m + $N)
		Local $STEPY = (($m * $aPosY) + ($N * $MYPOSY)) / ($m + $N)
		MoveTo($STEPX, $STEPY, $aRandom)
		GenericRandomPath($aPosX, $aPosY, $aRandom, $STOPSMIN, $STOPSMAX, $NUMBEROFSTOPS - 1)
	EndIf
EndFunc   ;==>GenericRandomPath


#Region GUI Toggle Functions
Func TogglePickUpAll()
	$Bool_PickUpAll = Not $Bool_PickUpAll
	If $Bool_PickUpAll = True Then
		Out("[[ENABLED]]--Pick Up All Loot")
	Else
		Out("[[DISABLED]]--Pick Up All Loot")
	EndIf
EndFunc   ;==>TogglePickUpAll

Func ToggleGolds()
	$Bool_PickUpGolds = Not $Bool_PickUpGolds
	If $Bool_PickUpGolds = True Then
		Out("[[ENABLED]]--Pick Up Golds " & $Bool_PickUpGolds)
	Else
		Out("[[DISABLED]]--Pick Up Golds" & $Bool_PickUpGolds)
	EndIf
EndFunc   ;==>ToggleGolds
Func ToggleM4M()
	$Bool_M4M = Not $Bool_M4M
	If $Bool_M4M = True Then
		Out("[[ENABLED]]--Save M4M " & $Bool_M4M)
	Else
		Out("[[DISABLED]]--Save M4M " & $Bool_M4M)
	EndIf
EndFunc   ;==>ToggleM4M
Func ToggleSell()
	$Bool_Sell = Not $Bool_Sell
	If $Bool_Sell = True Then
		Out("[[ENABLED]]--Sell/Merch")
	Else
		Out("[[DISABLED]]--Sell/Merch")
	EndIf
EndFunc   ;==>ToggleSell
Func ToggleSalvage()
	$Bool_Salvage = Not $Bool_Salvage
	If $Bool_Salvage = True Then
		Out("[[ENABLED]]--Salvage")
	Else
		Out("[[DISABLED]]--Salvage")
	EndIf
EndFunc   ;==>ToggleSalvage
Func ToggleConches()
	$Bool_Conches = Not $Bool_Conches
	If $Bool_Conches = True Then
		Out("[[ENABLED]]--Save Conches " & $Bool_Conches)
	Else
		Out("[[DISABLED]]--Save Conches " & $Bool_Conches)
	EndIf
EndFunc   ;==>ToggleConches
Func ToggleSageBlades()
	$Bool_SageBlade = Not $Bool_SageBlade
	If $Bool_SageBlade = True Then
		Out("[[ENABLED]]--Save Greater Sage Blades " & $Bool_SageBlade)
	Else
		Out("[[DISABLED]]--Save Greater Sage Blades " & $Bool_SageBlade)
	EndIf
EndFunc   ;==>ToggleSageBlades
Func ToggleStorage()
	$Bool_StoreGoodies = Not $Bool_StoreGoodies
	If $Bool_StoreGoodies = True Then
		Out("[[ENABLED]]--Store Goodies")
	Else
		Out("[[DISABLED]]--Store Goodies")
	EndIf
EndFunc   ;==>ToggleStorage
Func ToggleArmor()
	$Bool_PickUpArmor = Not $Bool_PickUpArmor
	If $Bool_PickUpArmor = True Then
		Out("[[ENABLED]]--Pick Up Runed Armor")
	Else
		Out("[[DISABLED]]--Pick Up Runed Armor")
	EndIf
EndFunc   ;==>ToggleArmor
Func ToggleEventMode()
	$Bool_EventMode = Not $Bool_EventMode
	If $Bool_EventMode = True Then
		Out("[[ENABLED]]--Pick Up Event Drops ")
	Else
		Out("[[DISABLED]]--Pick Up Event Drops")
	EndIf
EndFunc   ;==>ToggleEventMode
Func ToggleLeech()
	$Bool_Leech = Not $Bool_Leech
	If $Bool_Leech = True Then
		Out("[[ENABLED]]-- THIS ACCOUNT WILL BE A LEECH")
	Else
		Out("[[DISABLED]]--THIS ACCOUNT IS NO LONGER LEECHING")
	EndIf
EndFunc   ;==>ToggleLeech
Func ToggleCount()
	$Bool_DisplayCounts = Not $Bool_DisplayCounts
	If $Bool_DisplayCounts = True Then
		Out("[[ENABLED]]-- COUNTS DISPLAYED")
	Else
		Out("[[DISABLED]]-- COUNTS NOT DISPLAYED")
	EndIf
EndFunc   ;==>ToggleCount


#EndRegion GUI Toggle Functions

Func CountFoesInRange($aAgent = -2, $aDistance = 1250)
	Local $lAgentArray = GetAgentArray(0xDB)
	Local $lCount = 0

	For $i = 1 To $lAgentArray[0]
		Local $lDistance = GetPseudoDistance($aAgent, $lAgentArray[$i])
		If $lDistance < $aDistance Then
			$lCount += 1
		EndIf
	Next

	Return $lCount
EndFunc   ;==>CountFoesInRange



Func MoveAggroing($lDestX, $lDestY, $lRandom = 150)
	If GetIsDead(-2) Then Return

	Local $lMe, $lAgentArray
	Local $lBlocked
	Local $lHosCount
	Local $lAngle
	Local $stuckTimer = TimerInit()

	Move($lDestX, $lDestY, $lRandom)

	Do
		RndSleep(50)

		$lMe = GetAgentByID(-2)

		$lAgentArray = GetAgentArray(0xDB)

		If GetIsDead($lMe) Then Return False

		StayAlive($lAgentArray)

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			If $lHosCount > 6 Then
				Do    ; suicide
					Sleep(100)
				Until GetIsDead(-2)
				Return False
			EndIf

			$lBlocked += 1
			If $lBlocked < 5 Then
				Move($lDestX, $lDestY, $lRandom)
			ElseIf $lBlocked < 10 Then
				$lAngle += 40
				Move(DllStructGetData($lMe, 'X') + 300 * Sin($lAngle), DllStructGetData($lMe, 'Y') + 300 * Cos($lAngle))
			ElseIf IsRecharged(5) Then
				If $lHosCount == 0 And GetDistance() < 1000 Then
					UseSkillEx(5, -1)
				Else
					UseSkillEx(5, -2)
				EndIf
				$lBlocked = 0
				$lHosCount += 1
			EndIf
		Else
			If $lBlocked > 0 Then
				If TimerDiff($ChatStuckTimer) > 3000 Then    ; use a timer to avoid spamming /stuck
					SendChat("stuck", "/")
					$ChatStuckTimer = TimerInit()
				EndIf
				$lBlocked = 0
				$lHosCount = 0
			EndIf

			If GetDistance() > 1100 Then ; target is far, we probably got stuck.
				If TimerDiff($ChatStuckTimer) > 3000 Then ; dont spam
					SendChat("stuck", "/")
					$ChatStuckTimer = TimerInit()
					RndSleep(GetPing())
					If GetDistance() > 1100 Then ; we werent stuck, but target broke aggro. select a new one.
						TargetNearestEnemy()
					EndIf
				EndIf
			EndIf
		EndIf

	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < $lRandom * 1.5
	Return True
EndFunc   ;==>MoveAggroing

Func MoveRunning($lDestX, $lDestY)
	If GetIsDead(-2) Then Return False

	Local $lMe, $lTgt
	Local $lBlocked

	Move($lDestX, $lDestY)

	Do
		RndSleep(500)

		TargetNearestEnemy()
		$lMe = GetAgentByID(-2)
		$lTgt = GetAgentByID(-1)

		If GetIsDead($lMe) Then Return False

		If GetDistance($lMe, $lTgt) < 1300 And GetEnergy($lMe) > 20 And IsRecharged(1) And IsRecharged(2) Then
			UseSkillEx(1)
			UseSkillEx(2)
		EndIf

		If DllStructGetData($lMe, "HP") < 0.9 And GetEnergy($lMe) > 10 And IsRecharged(3) Then UseSkillEx(3)

		If DllStructGetData($lMe, "HP") < 0.5 And GetDistance($lMe, $lTgt) < 500 And GetEnergy($lMe) > 5 And IsRecharged(5) Then UseSkillEx(5, -1)

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			Move($lDestX, $lDestY)
		EndIf

	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 250
	Return True
EndFunc   ;==>MoveRunning

Func WaitUntilAllFoesAreInRange($lRange)
	Local $lAgentArray
	Local $lAdjCount, $lSpellCastCount
	Local $lMe
	Local $lDistance
	Local $lShouldExit = False
	While Not $lShouldExit
		Sleep(100)
		$lMe = GetAgentByID(-2)
		If GetIsDead($lMe) Then Return
		$lAgentArray = GetAgentArray(0xDB)
		StayAlive($lAgentArray)
		$lShouldExit = False
		For $i = 1 To $lAgentArray[0]
			$lDistance = GetPseudoDistance($lMe, $lAgentArray[$i])
			If $lDistance < $RANGE_SPELLCAST_2 And $lDistance > $lRange ^ 2 Then
				$lShouldExit = True
				ExitLoop
			EndIf
		Next
	WEnd
EndFunc   ;==>WaitUntilAllFoesAreInRange

Func WaitFor($lMs)
	If GetIsDead(-2) Then Return
	Local $lAgentArray
	Local $lTimer = TimerInit()
	Do
		Sleep(100)
		If GetIsDead(-2) Then Return
		$lAgentArray = GetAgentArray(0xDB)
		StayAlive($lAgentArray)
	Until TimerDiff($lTimer) > $lMs
EndFunc   ;==>WaitFor


Func StayAlive(Const ByRef $lAgentArray)
	If IsRecharged(2) Then
		UseSkillEx(1)
		UseSkillEx(2)
	EndIf

	Local $lMe = GetAgentByID(-2)
	Local $lEnergy = GetEnergy($lMe)
	Local $lAdjCount, $lAreaCount, $lSpellCastCount, $lProximityCount
	Local $lDistance
	For $i = 1 To $lAgentArray[0]
		If DllStructGetData($lAgentArray[$i], "Allegiance") <> 0x3 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], "HP") <= 0 Then ContinueLoop
		$lDistance = GetPseudoDistance($lMe, $lAgentArray[$i])
		If $lDistance < 1200 * 1200 Then
			$lProximityCount += 1
			If $lDistance < $RANGE_SPELLCAST_2 Then
				$lSpellCastCount += 1
				If $lDistance < $RANGE_AREA_2 Then
					$lAreaCount += 1
					If $lDistance < $RANGE_ADJACENT_2 Then
						$lAdjCount += 1
					EndIf
				EndIf
			EndIf
		EndIf
	Next

	UseSF($lProximityCount)

	If IsRecharged(3) Then
		If $lSpellCastCount > 0 And DllStructGetData(GetEffect($SKILLID_Shroud_of_Distress), "SkillID") == 0 Then
			UseSkillEx(3)
		ElseIf DllStructGetData($lMe, "HP") < 0.6 Then
			UseSkillEx(3)
		ElseIf $lAdjCount > 20 Then
			UseSkillEx(3)
		EndIf
	EndIf

	UseSF($lProximityCount)

	If IsRecharged(4) Then
		If DllStructGetData($lMe, "HP") < 0.5 Then
			UseSkillEx(4)
		ElseIf $lAdjCount > 20 Then
			UseSkillEx(4)
		EndIf
	EndIf

	UseSF($lProximityCount)

	If IsRecharged(8) Then
		If $lAreaCount > 5 And GetEffectTimeRemaining($SKILLID_Channeling) < 2000 Then
			UseSkillEx(8)
		EndIf
	EndIf

	UseSF($lProximityCount)
EndFunc   ;==>StayAlive

Func UseSF($lProximityCount)
	If IsRecharged(2) And $lProximityCount > 0 Then
		UseSkillEx(1)
		UseSkillEx(2)
	EndIf
EndFunc   ;==>UseSF

Func useInventoryItemByModelID($ModelID, $UseEquipmentPack = False)
	Return UseItem(GetInventoryItemByModelID($ModelID, $UseEquipmentPack))
EndFunc   ;==>useInventoryItemByModelID


; Description: Returns item in inventory by modelID
Func GetInventoryItemByModelID($ModelID, $UseEquipmentPack = False)
	Local $lItem
	Local $bags = 4
	If $UseEquipmentPack Then $bags = 5
	For $i = 1 To $bags
		For $j = 1 To DllStructGetData(GetBag($i), 'Slots')
			$lItem = GetItemBySlot($i, $j)
			If DllStructGetData($lItem, 'ModelID') <> $ModelID Then ContinueLoop
			Return $lItem
		Next
	Next
	Return 0
EndFunc   ;==>GetInventoryItemByModelID


Func GetAgentByModelID($aModelID, $lDistance = 5000)
	Local $lNearestAgent
	Local $lAgentStructToCompare
	Local $NameTest = "0x8101 0x4D76 0xABEE 0xD0CD 0x22FE"
	Local $m

;~ 	ConsoleWrite(GetMaxAgents() & " max agents" & @CRLF)

	For $i = 1 To GetMaxAgents()
		$lAgentStructToCompare = GetAgentByID($i)
;~ 		ConsoleWrite($lAgentStructToCompare & @CRLF)

		If $lAgentStructToCompare = 0 Then ContinueLoop
		$m = DllStructGetData($lAgentStructToCompare, 'PlayerNumber')
		If (GetIsDead($lAgentStructToCompare)) Or (GetDistance($i, -2) > $lDistance) Then ContinueLoop
		If $aModelID = $m Then
			$lNearestAgent = $lAgentStructToCompare
			Return $lNearestAgent
			ExitLoop
		EndIf
	Next

	If $lNearestAgent = 0 Then
		ConsoleWrite("didn't find" & @CRLF)

	EndIf

	Return GetAgentByID($i)
EndFunc   ;==>GetAgentByModelID


Func CheckPartyDead($aFullPartyWipe = False)
	Local $lDeadParty
	Local $i
	Local $PartyArray = GetParty()
	Local $lCheck = GetMapLoading() <> 2 And GetAgentExists(-2)
	Local $partySize = GetPartySize()
	If GetAgentExists(-2) = False Then Return
	If GetAgentExists(-2) = True Then

		If $partySize = 1 And GetIsDead(-2) Then
			$DeadOnTheRun = 1
;~ 		ConsoleWrite("Wiped solo" & $DeadOnTheRun & @CRLF)
			Return True ;save time and in solo instances just check if you're dead.
		EndIf
		For $i = 0 To $PartyArray[0] ;changed from $partysize
			If GetIsDead($PartyArray[$i]) = True Then
				$lDeadParty += 1
				Sleep(5)
			EndIf
		Next
		ConsoleWrite($lDeadParty & @CRLF)
		If $lCheck = False Then
;~ 		CurrentAction("Alive Check: " & $lCheck)
			$bPauseFunction = True
			Disconnected()
			Sleep(3000)
			$lCheck = GetMapLoading() <> 2 And GetAgentExists(-2)
;~ 		ConsoleWrite("Wipe Check False" & @CRLF)
			$DeadOnTheRun = 0
			Return False

		ElseIf $lCheck = True Then
			$bPauseFunction = False
			If $aFullPartyWipe = False Then
				If $lDeadParty >= ($partySize / 2 - 1) And GetIsDead(-2) Then
					$DeadOnTheRun = 1
;~ 				Out("Wiped...resetting")
					ConsoleWrite("Wiped " & $DeadOnTheRun & @CRLF)
					Return True
				Else
					$DeadOnTheRun = 0
					Return False
				EndIf
			ElseIf $aFullPartyWipe = True Then
				If $lDeadParty >= $partySize And GetIsDead(-2) Then
					$DeadOnTheRun = 1
;~ 				Out("Wiped...resetting")
					ConsoleWrite("Wiped " & $DeadOnTheRun & @CRLF)
					Return True
				Else
					$DeadOnTheRun = 0
;~ 				ConsoleWrite($DeadOnTheRun & @CRLF)
					Return False
;~ 	ConsoleWrite("Wipe Check else False" & @CRLF)
				EndIf
			EndIf
		EndIf
	EndIf
;~ 	$lDeadParty = 0
;~ 	return False
EndFunc   ;==>CheckPartyDead

;Waits for your entity to exist in the map
Func WaitForLoad()
	InitMapLoad()
	Local $deadlock = 0
	Local $load
	Local $lMe
	Do
		Sleep(100)
		$deadlock += 100


		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)
		If $deadlock > 3000 Then ExitLoop
	Until $load = 2 And DllStructGetData($lMe, 'X') = 0 And DllStructGetData($lMe, 'Y') = 0

	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)
;~ 		ConsoleWrite($load & @CRLF)
;~ 		ConsoleWrite("R" & DllStructGetData($lMe, 'X') & @CRLF)
;~ 		ConsoleWrite("R" & DllStructGetData($lMe, 'Y') & @CRLF & @CRLF)
		If $deadlock > 15000 Then ExitLoop
	Until $load <> 2 And DllStructGetData($lMe, 'X') <> 0 And DllStructGetData($lMe, 'Y') <> 0
	Sleep(1000)
EndFunc   ;==>WaitForLoad
