local AddOnName, ns = ...;
local K, C, L = unpack(ns);

-- = G E N E R A L = ----------------------------------------------------------------
C["classColor"] = true;			--	[true\false]  - On\Off;
C["statusbarOn"] = true;		--	[true\false]  - On\Off;
C["statusbarTexture"] = "Interface\\Addons\\"..AddOnName.."\\Media\\Statusbar\\whoa";
C["statusbarBackdrop"] = true;	--	[true\false]  - On\Off;
C["statusbarBackdropColor"] = {0, 0 , 0, 0.8};	--	RGB(0.0 - 1.0); red[ 0 to 1], green[ 0 to 1], blue[ 0 to 1], alpha[ 0 to 1. Optional. (Transparent to Opaque)]; https://colorscheme.ru/html-colors.html (example: IndianRed[205, 92, 92] -> 205/255, 92/255, 92/255 or 0.8, 0.36, 0.36);
C["darkFrames"] = true;			--	[true\false]  - On\Off;
C["SetPositions"] = false;		--	[true\false]  - On\Off;	-- Сustom FramePosition [On\Off];

-- = PlayerFrame = ------------------------------------------------------------------
C["PlayerFramePoint"] = {"TOPLEFT", UIParent, "TOPLEFT", 239, -4};	--	PlayerFrame position (Only if SetPositions is On);
C["PlayerNameOffset"] = {0, 0};										--	PlayerName Offset;

-- = TargetFrame = ------------------------------------------------------------------
C["TargetFramePoint"] = {"TOPLEFT", UIParent, "TOPLEFT", 509, -4};	--	TargetFrame position (Only if SetPositions is On);
C["TargetNameOffset"] = {0, 0};										--	TargetName Offset;

-- = FocusFrame = ------------------------------------------------------------------
C["FocusScale"] = 0.8;
C["FocusSpellBarScale"] = 1.2;
C["FocusAuraLimit"] = false;	--	[true\false]  - On\Off;
C["Focus_maxDebuffs"] = 0;	-- Default: 32;
C["Focus_maxBuffs"] = 0;	-- Default: 32;

-- = PartyFrame = ------------------------------------------------------------------
C["PartyFrameOn"] = true;													--	Enable partyframe mod [true/false];
C["PartyMemberFramePoint"] = {"TOPLEFT", UIParent, "TOPLEFT", 10, -160};	--	PartyFrame position (Only if SetPositions is On);
C["PartyMemberFrameSpacing"] = 0;											--	Spacing between PartyMemberFrames;
C["PartyFrameScale"] = 1.0;													--	PartyFrame Scale;
C["PartyFrameFont"] = {"Fonts\\FRIZQT__.TTF", 9, "OUTLINE"};				--	Font;

-- = BossFrame = ------------------------------------------------------------------
C["BossTargetFramePoint"] = {"TOPLEFT", UIParent, 1300, -220};	--	BossFrame position (Only if SetPositions is On);
C["BossTargetFrameSpacing"] = 0;								--	Spacing between BossFrames;

-- = ArenaFrame = -----------------------------------------------------------------
C["ArenaFrameOn"] = false;													--	Enable arenaframe mod [true/false];
C["ArenaFramePoint"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -33, -200};		--	ArenaFrame position (Only if SetPositions is On);
C["ArenaFrameScale"] = 1.0;													--	ArenaFrame Scale;
C["ArenaFrameFont"] = {"Fonts\\FRIZQT__.TTF", 7, "OUTLINE"};				--	Font (Health & Resource);


-- = Modules = -----------------------------------------------------------------
C["HealthPercentage"] = false;
C["ArenaFrame_Trinkets"] = false;	--	ArenaFrame Trinkets (Only if ArenaFrameOn is On);
C["ArenaFrame_Trinket_Voice"] = false;
