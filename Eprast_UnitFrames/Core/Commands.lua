local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local ArenaFrameOn = C.ArenaFrameOn;
local ArenaFrame_Trinkets = C.ArenaFrame_Trinkets;
local ArenaFrames_OnLoad = K.ArenaFrames_OnLoad;

--------------------------------------------------------------------------------------------------------------------------------
local _G, string_lower, UnitName, print, unpack = _G, string.lower, UnitName, print, unpack;
local IsAddOnLoaded, LoadAddOn, CLASS_ICON_TCOORDS = IsAddOnLoaded, LoadAddOn, CLASS_ICON_TCOORDS;
local CooldownFrame_SetTimer, GetTime = CooldownFrame_SetTimer, GetTime;
local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES;
--------------------------------------------------------------------------------------------------------------------------------

local function PrintHelpInfo()
	print("|cffFF0000EUF|r: Slash commands:\n|cff00FFFFHelp|r - Help\n|cff00FFFFBoss|r - Show\\Hide BossFrames\n|cff00FFFFArena|r - Show\\Hide ArenaFrames");
end;

local IsBossFramesShown;
local function ShowBossFrames()
	if not IsBossFramesShown then
		for i = 1, MAX_BOSS_FRAMES do
			_G["Boss"..i.."TargetFrame"]:Show();
			_G["Boss"..i.."TargetFrame"].name:SetText("Boss"..i);
			_G["Boss"..i.."TargetFrame"].deadText:Hide();
		end;
		IsBossFramesShown = true;
		print("|cffFF0000EUF|r:|cff00FFFFBossFrames|r Shown");
	else
		for i = 1, MAX_BOSS_FRAMES do
			_G["Boss"..i.."TargetFrame"]:Hide();
			_G["Boss"..i.."TargetFrame"].deadText:Show();
		end;
		IsBossFramesShown = false;
		print("|cffFF0000EUF|r:|cff00FFFFBossFrames|r Hidden");
	end;
end;

local PlayerName = UnitName("player");
local IsArenaFramesShown;
local function ShowArenaFrames()
	if ( not ArenaFrameOn ) then
		print('|cffFF0000EUF|r:|cff00FFFFArenaFrames Off|r (set ..Config \\Settings.lua --> C["ArenaFrameOn"] to true)');
		return;
	end;
	if not IsAddOnLoaded("Blizzard_ArenaUI") then LoadAddOn("Blizzard_ArenaUI") end 
	if not IsArenaFramesShown then
		ArenaEnemyFrames:Show();
		ArenaFrames_OnLoad();
		local arenaFrame;
		for i = 1, 3 do  
			arenaFrame = _G["ArenaEnemyFrame"..i];
			arenaFrame.classPortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
			arenaFrame.classPortrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS["MAGE"]));
			arenaFrame.name:SetText(PlayerName);
			arenaFrame:Show();
			if ( ArenaFrame_Trinkets ) then 
				CooldownFrame_SetTimer(ns.ArenaFrame_Trinkets["arena"..i], GetTime(), 120, 1);
			end;
		end;
		IsArenaFramesShown = true;
		print("|cffFF0000EUF|r:|cff00FFFFArenaFrames|r Shown");
	else
		ArenaEnemyFrames:Hide();
		local arenaFrame;
		for i = 1, 3 do
			arenaFrame = _G["ArenaEnemyFrame"..i];
			arenaFrame:Hide();
		end;
		IsArenaFramesShown = false;
		print("|cffFF0000EUF|r:|cff00FFFFArenaFrames|r Hidden");
	end;
end;

SLASH_EUF1 = "/euf"  
SlashCmdList["EUF"] = function(msg)
	if( not msg or msg == "" or string_lower(msg) == "help" ) then
		PrintHelpInfo();
	elseif string_lower(msg) == "boss" then
		ShowBossFrames();
	elseif string_lower(msg) == "arena" then
		ShowArenaFrames();
	end;
end;