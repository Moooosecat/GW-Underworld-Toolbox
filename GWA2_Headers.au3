;###########################
;#  by rheek               #
;#  modified by mhaendler  #
;###########################
; v1.6, source: github.com/rheek123/GwBotApiPatcher
;
; This file contains all headers that gwa2 uses to communicate with the gameservers directly.
;
; The headers are named variables. The names should indicate what the header is about.
; The comments give a litte more detail about what the header does.
;
; This makes the source code of gwa2 a little better readable. Also it allows to update headers more easily, as they
; are all now in a small separate place as a list to work yourself through.
; If you need to update the headers, the comments give hints about what action to trigger while recording CtoGS packets..

#include-once
;=QUEST=
;GAME_SMSG_QUEST_ADD
Global Const $HEADER_QUEST_ACCEPT = 0x39	;Accepts a quest from the NPC
Global Const $HEADER_QUEST_REWARD = 0x39	;Retrieves Quest reward from NPC
;GAME_CMSG_QUEST_ABANDON 0x10 or GAME_SMSG_QUEST_REMOVE 0x52
Global Const $HEADER_QUEST_ABANDON = 0x0F ;Abandons the quest

;=HERO=
;GAME_CMSG_HERO_BEHAVIOR
Global Const $HEADER_HERO_AGGRESSION = 0x13	;Sets the heroes aggression level
;GAME_CMSG_HERO_LOCK_TARGET
Global Const $HEADER_HERO_LOCK = 0x14	;Locks the heroes target
;GAME_CMSG_HERO_SKILL_TOGGLE
Global Const $HEADER_HERO_TOGGLE_SKILL = 0x17	;Enables or disables the heroes skill
;GAME_CMSG_HERO_FLAG_SINGLE
Global Const $HEADER_HERO_PLACE_FLAG = 0x18	;Sets the heroes position flag, hero runs to position
Global Const $HEADER_HERO_CLEAR_FLAG = 0x18	;Clears the heroes position flag
;GAME_CMSG_HERO_ADD 0x1D or GAME_SMSG_PARTY_HERO_ADD 0x1C8
Global Const $HEADER_HERO_ADD = 0x1C	;Adds hero to party
;GAME_CMSG_HERO_KICK 0x1E or GAME_SMSG_PARTY_HERO_REMOVE 0x1C9
Global Const $HEADER_HERO_KICK = 0x1D	;Kicks hero from party
Global Const $HEADER_HEROES_KICK = 0x1D	;Kicks ALL heroes from party
Global Const $HEADER_USE_HERO_SKILL = 0x1A ;For use with UseHeroSkillByPacket() only

;=PARTY=
;GAME_CMSG_HERO_FLAG_ALL
Global Const $HEADER_PARTY_PLACE_FLAG = 0x19	;Sets the party position flag, all party-npcs runs to position
Global Const $HEADER_PARTY_CLEAR_FLAG = 0x19	;Clears the party position flag
;GAME_CMSG_PARTY_INVITE_NPC 0x9E or GAME_SMSG_PARTY_HENCHMAN_ADD 0x1C5
Global Const $HEADER_HENCHMAN_ADD = 0x9D	;Adds henchman to party
;GAME_CMSG_PARTY_LEAVE_GROUP
Global Const $HEADER_PARTY_LEAVE = 0xA0	;Leaves the party
;GAME_CMSG_PARTY_KICK_NPC 0xA7 or GAME_SMSG_PARTY_HENCHMAN_REMOVE 0x1C6
Global Const $HEADER_HENCHMAN_KICK = 0xA6	;Kicks a henchman from party
;GAME_CMSG_PARTY_INVITE_PLAYER 0x9F or GAME_SMSG_PARTY_INVITE_ADD 0x01CA
Global Const $HEADER_INVITE_TARGET = 0x9E	;Invite target player to party
;GAME_CMSG_PARTY_ACCEPT_CANCEL 0x9C or GAME_SMSG_PARTY_INVITE_CANCEL 0x01CC
Global Const $HEADER_INVITE_CANCEL = 0x9B	;Cancel invitation of player
;GAME_CMSG_PARTY_ACCEPT_INVITE 0x9B or GAME_SMSG_PARTY_JOIN_REQUEST 0x01CB
Global Const $HEADER_INVITE_ACCEPT = 0x9A	;Accept invitation to party

;=TARGET (Enemies or NPC)=
;GAME_CMSG_TARGET_CALL 0x22
Global Const $HEADER_CALL_TARGET = 0x21	;Calls the target without attacking (Ctrl+Shift+Space)
;GAME_CMSG_ATTACK_AGENT 0x25
Global Const $HEADER_ATTACK_AGENT = 0x24	;Attacks agent (Space IIRC)
;GAME_CMSG_CANCEL_MOVEMENT 0x27 or GAME_SMSG_SKILL_CANCEL 0xE4
Global Const $HEADER_CANCEL_ACTION = 0x26	;Cancels the current action
;GAME_CMSG_INTERACT_PLAYER 0x32
Global Const $HEADER_AGENT_FOLLOW = 0x31	;Follows the agent/npc. Ctrl+Click triggers "I am following Person" in chat
;GAME_CMSG_INTERACT_LIVING
Global Const $HEADER_NPC_TALK = 0x37	;talks/goes to npc
;GAME_CMSG_INTERACT_ITEM 0x3E or GAME_CMSG_INTERACT_GADGET 0x50
Global Const $HEADER_SIGNPOST_RUN = 0x4F	;Runs to signpost

;=DROP=
;GAME_CMSG_DROP_ITEM 0x2B
Global Const $HEADER_ITEM_DROP = 0x2A	;Drops item from inventory to ground
;GAME_CMSG_DROP_GOLD
Global Const $HEADER_GOLD_DROP = 0x2D	;Drops gold from inventory to ground

;=BUFFS=
;GAME_CMSG_DROP_BUFF
Global Const $HEADER_STOP_MAINTAIN_ENCH = 0x27	;Drops buff, cancel enchantmant, whatever you call it

;=ITEMS=
;GAME_CMSG_EQUIP_ITEM
Global Const $HEADER_ITEM_EQUIP = 0x2E	;Equips item from inventory/chest/no idea
;GAME_CMSG_INTERACT_ITEM
Global Const $HEADER_ITEM_PICKUP = 0x3D	;Picks up an item from ground
;GAME_CMSG_ITEM_DESTROY
Global Const $HEADER_ITEM_DESTROY = 0x67	;Destroys the item
;GAME_CMSG_ITEM_IDENTIFY
Global Const $HEADER_ITEM_ID = 0x6A	;Identifies item in inventory
;GAME_CMSG_ITEM_MOVE
Global Const $HEADER_ITEM_MOVE = 0x70	;Moves item in inventory
;GAME_CMSG_ITEM_ACCEPT_ALL
Global Const $HEADER_ITEMS_ACCEPT_UNCLAIMED = 0x71	;Accepts ITEMS not picked up in missions
;GAME_CMSG_ITEM_MOVE
Global Const $HEADER_ITEM_MOVE_EX = 0x73	;Moves an item, with amount to be moved.
;GAME_CMSG_ITEM_SALVAGE_MATERIALS
Global Const $HEADER_SALVAGE_MATS = 0x78	;Salvages materials from item
;GAME_CMSG_ITEM_SALVAGE_UPGRADE
Global Const $HEADER_SALVAGE_MODS = 0x79	;Salvages mods from item
;GAME_CMSG_ITEM_SALVAGE_UPGRADE
Global Const $HEADER_SALVAGE_SESSION = 0x75	;Salvages mods from item
;GAME_CMSG_ITEM_USE
Global Const $HEADER_ITEM_USE = 0x7C	;Uses item from inventory/chest
;GAME_CMSG_UNEQUIP_ITEM
Global Const $HEADER_ITEM_UNEQUIP = 0x4D	;Unequip item
Global Const $HEADER_UPGRADE = 0x86	;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_UPGRADE_ARMOR_1 = 0x83	;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_UPGRADE_ARMOR_2 = 0x86	;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_EQUIP_BAG = 0x70
;Global Const $HEADER_USE_ITEM = 0x85

;=TRADE=
;GAME_SMSG_TRADE_REQUEST
Global Const $HEADER_TRADE_PLAYER = 0x47	;Send trade request to player
;GAME_SMSG_TRADE_ADD_ITEM
Global Const $HEADER_TRADE_OFFER_ITEM = 0x02	;Add item to trade window
;GAME_CMSG_TRADE_SEND_OFFER
Global Const $HEADER_TRADE_SUBMIT_OFFER = 0x03	;Submit offer
;GAME_SMSG_TRADE_CHANGE_OFFER
Global Const $HEADER_TRADE_CHANGE_OFFER = 0x06	;Change offer
;GAME_CMSG_TRADE_CANCEL
Global Const $HEADER_TRADE_CANCEL = 0x01	;Cancel trade
;GAME_CMSG_TRADE_ACCEPT
Global Const $HEADER_TRADE_ACCEPT = 0x07	;Accept trade

;=TRAVEL=
;GAME_CMSG_PARTY_TRAVEL
Global Const $HEADER_MAP_TRAVEL = 0xAF	;Travels to outpost via worldmap
;GAME_CMSG_PARTY_ENTER_GUILD_HALL
Global Const $HEADER_GUILDHALL_TRAVEL = 0xAE	;Travels to guild hall
;GAME_CMSG_PARTY_LEAVE_GUILD_HALL
Global Const $HEADER_GUILDHALL_LEAVE = 0xB0	;Leaves Guildhall

;=FACTION=
;GAME_CMSG_DEPOSIT_FACTION
Global Const $HEADER_FACTION_DONATE = 0x33	;Donates kurzick/luxon faction to ally

;=TITLE=
;GAME_CMSG_TITLE_DISPLAY 0x57 or GAME_SMSG_TITLE_RANK_DISPLAY 0xF5
Global Const $HEADER_TITLE_DISPLAY = 0x56	;Displays title
;GAME_CMSG_TITLE_HIDE
Global Const $HEADER_TITLE_CLEAR = 0x57	;Hides title

;=DIALOG=
;GAME_CMSG_SEND_DIALOG
Global Const $HEADER_DIALOG = 0x39	;Sends a dialog to NPC
;GAME_CMSG_SKIP_CINEMATIC
Global Const $HEADER_CINEMATIC_SKIP = 0x61	;Skips the cinematic
Global Const $HEADER_HOM_DIALOG = 0x58

;=SKILL / BUILD=
;GAME_CMSG_SKILLBAR_SKILL_SET
Global Const $HEADER_SET_SKILLBAR_SKILL = 0x5C	;Changes a skill on the skillbar
;GAME_CMSG_SKILLBAR_LOAD
Global Const $HEADER_LOAD_SKILLBAR = 0x5B	;Loads a complete build
;GAME_CMSG_CHANGE_SECOND_PROFESSION
Global Const $HEADER_CHANGE_SECONDARY = 0x48	;Changes Secondary class (from Build window, not class changer)
Global Const $HEADER_SKILL_USE_ALLY = 0x4B	;used by gwapi. appears to have changed
Global Const $HEADER_SKILL_USE_FOE = 0x4B	;used by gwapi. appears to have changed
Global Const $HEADER_SKILL_USE_ID = 0x4B	;
Global Const $HEADER_SET_ATTRIBUTES = 0x0E	;hidden in init stuff like sendchat
Global Const $HEADER_OPEN_SKILLS = 0x40
;GAME_CMSG_USE_SKILL
Global Const $HEADER_USE_SKILL = 0x44
Global Const $HEADER_PROFESSION_ULOCK = 0x40

;=CHEST=
;GAME_CMSG_OPEN_CHEST
Global Const $HEADER_CHEST_OPEN = 0x51	;Opens a chest (with key AFAIK)
;GAME_CMSG_ITEM_CHANGE_GOLD
Global Const $HEADER_CHANGE_GOLD = 0x7A	;Moves Gold (from chest to inventory, and otherway around IIRC)

;=MISSION=
;GAME_CMSG_PARTY_SET_DIFFICULTY
Global Const $HEADER_MODE_SWITCH = 0x99	;Toggles hard- and normal mode
;GAME_CMSG_PARTY_ENTER_CHALLENGE
Global Const $HEADER_MISSION_ENTER = 0xA3	;Enter a mission/challenge
Global Const $HEADER_MISSION_FOREIGN_ENTER = 0xAE	;Enters a foreign mission/challenge (no idea honestly)
;GAME_CMSG_PARTY_RETURN_TO_OUTPOST
Global Const $HEADER_OUTPOST_RETURN = 0xA5	;Returns to outpost after /resign

;=CHAT=
;GAME_CMSG_SEND_CHAT_MESSAGE
Global Const $HEADER_SEND_CHAT = 0x62	;Needed for sending messages in chat

;=MOVEMENT=
;GAME_SMSG_AGENT_MOVEMENT_TICK
Global Const $HEADER_MOVEMENT_TICK = 0x1E

;=OTHER CONSTANTS=
Global Const $HEADER_MAX_ATTRIBUTES_CONST_5 = 0x03	;constant at word 5 of max attrib packet. Changed from 3 to four in most recent update
Global Const $HEADER_MAX_ATTRIBUTES_CONST_22	= 0x03	;constant at word 22 of max attrib packet. Changed from 3 to four in most recent update
Global Const $HEADER_OPEN_GB_WINDOW = 0x9E
Global Const $HEADER_CLOSE_GB_WINDOW = 0x9F
Global Const $HEADER_START_RATING_GVG = 0xA8
Global Const $HEADER_TITLE_HIDE = 0x57
Global Const $HEADER_TRADE_ACKNOWLEDGE = 0x00
Global Const $HEADER_TRADE_ADD_ITEM = 0x02
Global Const $HEADER_TRADE_SEND_OFFER = 0x03
Global Const $HEADER_MAX_ATTRIBUTES_CONST = 0x04
Global Const $HEADER_TRADE_REMOVE_ITEM = 0x05
Global Const $HEADER_TRADE_CANCEL_OFFER = 0x06
Global Const $HEADER_DISCONNECT = 0x08
Global Const $HEADER_PING_REPLY = 0x09
Global Const $HEADER_HEARTBEAT = 0x0A
Global Const $HEADER_PING_REQUEST = 0x0B
Global Const $HEADER_ATTRIBUTE_DECREASE = 0x0C
Global Const $HEADER_ATTRIBUTE_INCREASE = 0x0D
Global Const $HEADER_ATTRIBUTE_LOAD = 0x0E
Global Const $HEADER_QUEST_REQUEST_INFOS = 0x10
Global Const $HEADER_QUEST_SET_ACTIVE = 0x12
Global Const $HEADER_HERO_BEHAVIOR = 0x13
Global Const $HEADER_HERO_LOCK_TARGET = 0x14
Global Const $HEADER_HERO_SKILL_TOGGLE = 0x17
Global Const $HEADER_HERO_FLAG_SINGLE = 0x18
Global Const $HEADER_HERO_FLAG_ALL = 0x19
Global Const $HEADER_HERO_USE_SKILL = 0x1A
Global Const $HEADER_TARGET_CALL = 0x21
Global Const $HEADER_PING_WEAPON_SET = 0x23
Global Const $HEADER_CANCEL_MOVEMENT = 0x26
Global Const $HEADER_DROP_BUFF = 0x27
Global Const $HEADER_DRAW_MAP = 0x29
Global Const $HEADER_DROP_ITEM = 0x2A
Global Const $HEADER_DROP_GOLD = 0x2D
Global Const $HEADER_EQUIP_ITEM = 0x2E
Global Const $HEADER_INTERACT_PLAYER = 0x31
Global Const $HEADER_DEPOSIT_FACTION = 0x33
Global Const $HEADER_INTERACT_LIVING = 0x37
Global Const $HEADER_SEND_DIALOG = 0x39
Global Const $HEADER_MOVE_TO_COORD = 0x3C
Global Const $HEADER_INTERACT_ITEM = 0x3D
Global Const $HEADER_ROTATE_PLAYER = 0x3E
Global Const $HEADER_CHANGE_SECOND_PROFESSION = 0x3F
Global Const $HEADER_TRADE_INITIATE = 0x47
Global Const $HEADER_BUY_MATERIALS = 0x48
Global Const $HEADER_REQUEST_QUOTE = 0x4A
Global Const $HEADER_TRANSACT_ITEMS = 0x4B
Global Const $HEADER_UNEQUIP_ITEM = 0x4D
Global Const $HEADER_INTERACT_GADGET = 0x4F
Global Const $HEADER_OPEN_CHEST = 0x51
Global Const $HEADER_EQUIP_VISIBILITY = 0x55
Global Const $HEADER_SKILLBAR_SKILL_SET = 0x5A
Global Const $HEADER_SKILLBAR_LOAD = 0x5B
Global Const $HEADER_SKILLBAR_SKILL_REPLACE = 0x5C
Global Const $HEADER_SKIP_CINEMATIC = 0x61
Global Const $HEADER_SEND_CHAT_MESSAGE = 0x62
Global Const $HEADER_ITEM_IDENTIFY = 0x6A
Global Const $HEADER_TOME_UNLOCK_SKILL = 0x6B
Global Const $HEADER_ITEM_ACCEPT_ALL = 0x71
Global Const $HEADER_ITEM_SPLIT_STACK = 0x73
Global Const $HEADER_ITEM_SALVAGE_SESSION_OPEN = 0x75
Global Const $HEADER_ITEM_SALVAGE_SESSION_CANCEL = 0x76
Global Const $HEADER_ITEM_SALVAGE_SESSION_DONE = 0x77
Global Const $HEADER_ITEM_SALVAGE_MATERIALS = 0x78
Global Const $HEADER_ITEM_SALVAGE_UPGRADE = 0x79
Global Const $HEADER_ITEM_CHANGE_GOLD = 0x7A
Global Const $HEADER_INSTANCE_LOAD_REQUEST_SPAWN = 0x86
Global Const $HEADER_INSTANCE_LOAD_REQUEST_PLAYERS = 0x8E
Global Const $HEADER_INSTANCE_LOAD_REQUEST_ITEMS = 0x8F
Global Const $HEADER_PARTY_SET_DIFFICULTY = 0x99
Global Const $HEADER_PARTY_ACCEPT_INVITE = 0x9A
Global Const $HEADER_PARTY_ACCEPT_CANCEL = 0x9B
Global Const $HEADER_PARTY_ACCEPT_REFUSE = 0x9C
Global Const $HEADER_PARTY_INVITE_NPC = 0x9D
Global Const $HEADER_PARTY_INVITE_PLAYER = 0x9E
Global Const $HEADER_PARTY_INVITE_PLAYER_NAME = 0x9F
Global Const $HEADER_PARTY_LEAVE_GROUP = 0xA0
Global Const $HEADER_PARTY_CANCEL_ENTER_CHALLENGE = 0xA1
Global Const $HEADER_PARTY_ENTER_CHALLENGE = 0xA3
Global Const $HEADER_PARTY_RETURN_TO_OUTPOST = 0xA5
Global Const $HEADER_PARTY_KICK_NPC = 0xA6
Global Const $HEADER_PARTY_KICK_PLAYER = 0xA7
Global Const $HEADER_PARTY_SEARCH_SEEK = 0xA8
Global Const $HEADER_PARTY_SEARCH_CANCEL = 0xA9
Global Const $HEADER_PARTY_SEARCH_REQUEST_JOIN = 0xAA
Global Const $HEADER_PARTY_SEARCH_REQUEST_REPLY = 0xAB
Global Const $HEADER_PARTY_SEARCH_TYPE = 0xAC
Global Const $HEADER_PARTY_READY_STATUS = 0xAD
Global Const $HEADER_PARTY_ENTER_GUILD_HALL = 0xAE
Global Const $HEADER_PARTY_TRAVEL = 0xAF
Global Const $HEADER_PARTY_LEAVE_GUILD_HALL = 0xB0