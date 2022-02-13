local AddOnName, ns = ...;
local K, C, L = unpack(ns);

local ArenaFrameOn = C.ArenaFrameOn;
local darkFrames = C.darkFrames;
local SetPositions = C.SetPositions;
local Font = C.ArenaFrameFont;
local statusbarOn = C.statusbarOn;
local statusbarTexture = C.statusbarTexture;
local ArenaFramePoint = C.ArenaFramePoint;
--------------------------------------------------------------------------------------------------------------------------------
local hooksecurefunc = hooksecurefunc;
local _G, unpack = _G, unpack;
--------------------------------------------------------------------------------------------------------------------------------

local EprastArenaEnemyFrames;

local function ArenaFramesSettings(Obj)
	if ( C.SetPositions ) then
		Obj:ClearAllPoints();
		Obj:SetPoint("TOPRIGHT", EprastArenaEnemyFrames, "TOPRIGHT", 0, 0);
	end;
	ArenaEnemyFrames:SetScale(C.ArenaFrameScale);
end;

local Path;
do
	if ( darkFrames ) then
		Path = "Interface\\Addons\\"..AddOnName.."\\Media\\Dark\\UI-TargetingFrame";
	else
		Path = "Interface\\Addons\\"..AddOnName.."\\Media\\Light\\UI-TargetingFrame";
	end;
end;

local function ArenaFrames_OnLoad()
	local arenaFrame;
	ArenaFramesSettings(ArenaEnemyFrame1);
	for i = 1, MAX_ARENA_ENEMIES do
		arenaFrame = _G["ArenaEnemyFrame"..i];
		_G["ArenaEnemyFrame"..i.."Texture"]:SetTexture(Path);
		_G["ArenaEnemyFrame"..i.."Texture"]:ClearAllPoints();
		_G["ArenaEnemyFrame"..i.."Texture"]:SetPoint("TOPLEFT", _G["ArenaEnemyFrame"..i], "TOPLEFT", 0, 5);
		_G["ArenaEnemyFrame"..i.."Texture"]:SetTexCoord(0.09375, 1.0, 0, 0.78125)
		_G["ArenaEnemyFrame"..i.."Texture"]:SetSize(124, 48);
		arenaFrame.healthbar:SetPoint("TOPLEFT", arenaFrame, "TOPLEFT", 4, -6);
		arenaFrame.healthbar:SetSize(62, 14);
		arenaFrame.name:ClearAllPoints();
		arenaFrame.name:SetPoint("BOTTOM", arenaFrame.healthbar, "TOP", 0, 1);
		arenaFrame.manabar:SetSize(62, 6);
		arenaFrame.healthbar.TextString:SetPoint("CENTER", arenaFrame.healthbar);
		arenaFrame.manabar.TextString:SetPoint("CENTER", arenaFrame.manabar);
		arenaFrame.healthbar.TextString:SetFont(unpack(Font));
		arenaFrame.manabar.TextString:SetFont(unpack(Font));
		
		arenaFrame.classPortrait:SetSize(34,34);
		arenaFrame.classPortrait:ClearAllPoints();
		arenaFrame.classPortrait:SetPoint("RIGHT", arenaFrame, "RIGHT", 0, 0);
		
		--Trinket.icon:SetTexture("Interface\\TARGETINGFRAME\\UI-TargetingFrame-Skull");
	end;
	if ( statusbarOn ) then 
		arenaFrame.healthbar:SetStatusBarTexture(statusbarTexture);
		arenaFrame.manabar:SetStatusBarTexture(statusbarTexture);
	end;
end;

if ( ArenaFrameOn ) then
	if ( SetPositions ) then
		EprastArenaEnemyFrames = CreateFrame("Frame", nil, UIParent);
		EprastArenaEnemyFrames:SetPoint(unpack(ArenaFramePoint));
		EprastArenaEnemyFrames:SetSize(10, 10);
	end;
	K.ArenaFrames_OnLoad = ArenaFrames_OnLoad;
	hooksecurefunc("Arena_LoadUI", ArenaFrames_OnLoad);
end;